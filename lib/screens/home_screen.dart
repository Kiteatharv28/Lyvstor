import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'favourites_screen.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';
import '../models/product_model.dart';
import '../providers/favorites_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> featuredProducts;

  @override
  void initState() {
    super.initState();
    _initializeFeaturedProducts();
  }

  void _initializeFeaturedProducts() {
    featuredProducts = [
      Product(
        id: '1',
        title: 'Featured Kurti 1',
        description: 'Premium Collection',
        price: '1299',
        originalPrice: '1599',
        discount: '18%',
        category: 'Gown',
        inStock: true,
        createdAt: DateTime.now(),
        image: 'assets/card1.png',
      ),
      Product(
        id: '2',
        title: 'Featured Kurti 2',
        description: 'Exclusive Design',
        price: '999',
        originalPrice: '1299',
        discount: '23%',
        category: 'Kurti Sets',
        inStock: true,
        createdAt: DateTime.now(),
        image: 'assets/card2.png',
      ),
      Product(
        id: '3',
        title: 'Featured Kurti 3',
        description: 'Limited Edition',
        price: '1499',
        originalPrice: '1899',
        discount: '21%',
        category: 'Kurta Sets',
        inStock: true,
        createdAt: DateTime.now(),
        image: 'assets/card1.png',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFEF1F1), Color(0xFFFEDFDF), Color(0xFFFED3D3)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: Colors.transparent,
          leading: Image.asset("assets/menu_open.png"),
          title: Text(
            "Lyvstor",
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          actions: [
            Image.asset("assets/search.png"),
            const SizedBox(width: 10),
            Image.asset("assets/bell.png"),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavouritesScreen(),
                  ),
                );
              },
              child: Image.asset("assets/favorite.png"),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              child: Image.asset("assets/shopping_bag.png"),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Watch Live Header
                Text(
                  'Watch Live',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),

                // Live Cards Row
                SizedBox(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildLiveCard('Influencer X', '1234'),
                      const SizedBox(width: 12),
                      _buildLiveCard('Influencer X', '1234'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Flash Sale Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flash Sale',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Closed in:',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildTimeBox('02'),
                          const SizedBox(width: 8),
                          _buildTimeBox('15'),
                          const SizedBox(width: 8),
                          _buildTimeBox('50'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Discover Collections Section
                SizedBox(
                  height: 250,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9999),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Discover our\nCollections',
                                    style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Curated for you, inspired\nby your lifestyle',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontStyle: FontStyle.italic,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xFFFF9999),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Explore',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFFF9999),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          SizedBox(
                            height: 200,
                            child: Row(
                              children: [
                                _buildCollectionCard('assets/card1.png'),
                                const SizedBox(width: 12),
                                _buildCollectionCard('assets/card2.png'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Featured Products Section
                Text(
                  'Featured Products',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _buildFeaturedProductCard(
                            featuredProducts[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProductCard(Product product) {
    final heroTag = 'featured_${product.id}';
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, _) {
        final isFavorite = favoritesProvider.favorites.contains(product.id);
        
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  title: product.title,
                  price: product.price,
                  originalPrice: product.originalPrice,
                  discount: product.discount,
                  inStock: product.inStock,
                  stockQuantity: product.inStock ? 15 : 0,
                  heroTag: heroTag,
                ),
              ),
            );
          },
          child: Container(
            width: 160,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: heroTag,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: AssetImage(product.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Like button
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          favoritesProvider.toggleFavorite(product.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${product.price}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${product.discount} OFF',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildLiveCard(String name, String views) {
  return Container(
    width: 200,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.red, width: 3),
      borderRadius: BorderRadius.circular(16),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        color: Colors.grey[300],
        child: Stack(
          children: [
            Image.asset(
              "assets/live image.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              top: 8,
              right: 5,
              left: 5,
              child: Row(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.visibility, size: 12, color: Colors.black),
                  const SizedBox(width: 4),
                  Text(
                    views,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 3,
              right: 5,
              child: Container(
                height: 20,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    "Join Live",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildTimeBox(String time) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: const Color(0xFFF57F84),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        time,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _buildCollectionCard(String imagePath) {
  return Container(
    width: 200,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.3),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
