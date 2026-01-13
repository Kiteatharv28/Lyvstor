import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'screens/auth_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/address_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'providers/favorites_provider.dart';
import 'services/seed_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✅ Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Lvystor",
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _hasSeeded = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<AuthProvider>().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          // Seed data once after user is authenticated
          if (!_hasSeeded) {
            _hasSeeded = true;
            _seedDataAfterAuth();
          }

          // Load cart and favorites when user is authenticated
          Future.microtask(() {
            context.read<CartProvider>().loadCart();
            context.read<FavoritesProvider>().loadFavorites();
            context.read<ProductProvider>().loadProducts();
            context.read<ProductProvider>().loadCategories();
          });
          return const BottomNavBar();
        }

        return const AuthScreen();
      },
    );
  }

  Future<void> _seedDataAfterAuth() async {
    try {
      final seedService = SeedDataService();
      
      // Check if products already exist
      final productsSnapshot = await seedService.firestore.collection('products').limit(1).get();
      
      if (productsSnapshot.docs.isEmpty) {
        debugPrint('🌱 No products found. Seeding data...');
        await seedService.seedAllData();
        debugPrint('✅ Seed data completed!');
      } else {
        debugPrint('✅ Products already exist. Skipping seed.');
      }
    } catch (e) {
      debugPrint('❌ Error seeding data: $e');
    }
  }
}

