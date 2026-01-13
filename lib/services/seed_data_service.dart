import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SeedDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get firestore => _firestore;

  // Seed categories
  Future<void> seedCategories() async {
    try {
      final categories = [
        {'id': 'gown', 'name': 'Gown', 'createdAt': DateTime.now()},
        {'id': 'kurti_sets', 'name': 'Kurti Sets', 'createdAt': DateTime.now()},
        {'id': 'kurta_sets', 'name': 'Kurta Sets', 'createdAt': DateTime.now()},
        {'id': 'coord_sets', 'name': 'Coord Sets', 'createdAt': DateTime.now()},
      ];

      for (var category in categories) {
        await _firestore.collection('categories').doc(category['id'] as String).set({
          'name': category['name'],
          'createdAt': (category['createdAt'] as DateTime).toIso8601String(),
        });
        debugPrint('✅ Seeded category: ${category['name']}');
      }

      debugPrint('✅ Categories seeded successfully');
    } catch (e) {
      debugPrint('❌ Error seeding categories: $e');
      rethrow;
    }
  }

  // Seed products
  Future<void> seedProducts() async {
    try {
      final products = [
        {
          'title': 'Premium Gown',
          'description': 'Elegant premium gown for special occasions',
          'price': 1299,
          'originalPrice': 1599,
          'discount': '18%',
          'category': 'Gown',
          'categoryId': 'gown',
          'stockQty': 15,
          'inStock': true,
          'image': 'assets/card1.png',
        },
        {
          'title': 'Casual Kurti Set',
          'description': 'Comfortable casual kurti set for daily wear',
          'price': 799,
          'originalPrice': 999,
          'discount': '20%',
          'category': 'Kurti Sets',
          'categoryId': 'kurti_sets',
          'stockQty': 25,
          'inStock': true,
          'image': 'assets/card2.png',
        },
        {
          'title': 'Festive Kurta Set',
          'description': 'Beautiful festive kurta set with traditional design',
          'price': 1499,
          'originalPrice': 1899,
          'discount': '21%',
          'category': 'Kurta Sets',
          'categoryId': 'kurta_sets',
          'stockQty': 10,
          'inStock': true,
          'image': 'assets/card1.png',
        },
        {
          'title': 'Modern Coord Set',
          'description': 'Trendy modern coordinate set',
          'price': 899,
          'originalPrice': 1099,
          'discount': '18%',
          'category': 'Coord Sets',
          'categoryId': 'coord_sets',
          'stockQty': 20,
          'inStock': true,
          'image': 'assets/card2.png',
        },
        {
          'title': 'Luxury Gown',
          'description': 'Luxury designer gown for premium customers',
          'price': 1999,
          'originalPrice': 2499,
          'discount': '20%',
          'category': 'Gown',
          'categoryId': 'gown',
          'stockQty': 8,
          'inStock': true,
          'image': 'assets/card1.png',
        },
        {
          'title': 'Budget Kurti',
          'description': 'Affordable kurti set for budget-conscious buyers',
          'price': 499,
          'originalPrice': 699,
          'discount': '28%',
          'category': 'Kurti Sets',
          'categoryId': 'kurti_sets',
          'stockQty': 30,
          'inStock': true,
          'image': 'assets/card2.png',
        },
        {
          'title': 'Ethnic Kurta',
          'description': 'Traditional ethnic kurta with modern touch',
          'price': 1099,
          'originalPrice': 1399,
          'discount': '21%',
          'category': 'Kurta Sets',
          'categoryId': 'kurta_sets',
          'stockQty': 12,
          'inStock': true,
          'image': 'assets/card1.png',
        },
        {
          'title': 'Party Coord Set',
          'description': 'Glamorous coordinate set for parties',
          'price': 1199,
          'originalPrice': 1499,
          'discount': '20%',
          'category': 'Coord Sets',
          'categoryId': 'coord_sets',
          'stockQty': 5,
          'inStock': true,
          'image': 'assets/card2.png',
        },
        {
          'title': 'Summer Gown',
          'description': 'Light and breezy summer gown',
          'price': 999,
          'originalPrice': 1299,
          'discount': '23%',
          'category': 'Gown',
          'categoryId': 'gown',
          'stockQty': 18,
          'inStock': true,
          'image': 'assets/card1.png',
        },
        {
          'title': 'Office Kurti',
          'description': 'Professional office kurti set',
          'price': 749,
          'originalPrice': 999,
          'discount': '25%',
          'category': 'Kurti Sets',
          'categoryId': 'kurti_sets',
          'stockQty': 22,
          'inStock': true,
          'image': 'assets/card2.png',
        },
        {
          'title': 'Wedding Kurta',
          'description': 'Elegant wedding kurta set',
          'price': 1699,
          'originalPrice': 2099,
          'discount': '19%',
          'category': 'Kurta Sets',
          'categoryId': 'kurta_sets',
          'stockQty': 7,
          'inStock': true,
          'image': 'assets/card1.png',
        },
        {
          'title': 'Casual Coord',
          'description': 'Casual everyday coordinate set',
          'price': 649,
          'originalPrice': 899,
          'discount': '27%',
          'category': 'Coord Sets',
          'categoryId': 'coord_sets',
          'stockQty': 28,
          'inStock': true,
          'image': 'assets/card2.png',
        },
      ];

      for (int i = 0; i < products.length; i++) {
        final product = products[i];
        await _firestore.collection('products').doc('prod_${(i + 1).toString().padLeft(3, '0')}').set({
          'title': product['title'],
          'description': product['description'],
          'price': product['price'],
          'originalPrice': product['originalPrice'],
          'discount': product['discount'],
          'category': product['category'],
          'categoryId': product['categoryId'],
          'stockQty': product['stockQty'],
          'inStock': product['inStock'],
          'image': product['image'],
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        });
        debugPrint('✅ Seeded product: ${product['title']}');
      }

      debugPrint('✅ Products seeded successfully (${products.length} products)');
    } catch (e) {
      debugPrint('❌ Error seeding products: $e');
      rethrow;
    }
  }

  // Seed all data
  Future<void> seedAllData() async {
    try {
      print('🌱 Starting seed data process...');
      await seedCategories();
      await seedProducts();
      print('✅ All seed data completed successfully!');
    } catch (e) {
      print('❌ Error seeding data: $e');
      rethrow;
    }
  }

  // Clear all data (for testing)
  Future<void> clearAllData() async {
    try {
      debugPrint('🗑️ Clearing all data...');

      // Clear categories
      final categoriesSnapshot = await _firestore.collection('categories').get();
      for (var doc in categoriesSnapshot.docs) {
        await doc.reference.delete();
        debugPrint('🗑️ Deleted category: ${doc.id}');
      }

      // Clear products
      final productsSnapshot = await _firestore.collection('products').get();
      for (var doc in productsSnapshot.docs) {
        await doc.reference.delete();
        debugPrint('🗑️ Deleted product: ${doc.id}');
      }

      debugPrint('✅ All data cleared successfully!');
    } catch (e) {
      debugPrint('❌ Error clearing data: $e');
      rethrow;
    }
  }
}
