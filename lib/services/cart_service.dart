import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_item_model.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser?.uid ?? '';

  // Add item to cart
  Future<void> addToCart({
    required String productId,
    required String title,
    required String price,
    required int maxStock,
    String image = 'assets/live image.png',
  }) async {
    try {
      final cartRef = _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .doc(productId);

      final doc = await cartRef.get();

      if (doc.exists) {
        int currentQty = doc['quantity'] ?? 1;
        if (currentQty < maxStock) {
          await cartRef.update({
            'quantity': currentQty + 1,
            'updatedAt': DateTime.now().toIso8601String(),
          });
        }
      } else {
        await cartRef.set({
          'productId': productId,
          'title': title,
          'price': price,
          'quantity': 1,
          'maxStock': maxStock,
          'image': image,
          'updatedAt': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  // Get cart items
  Future<List<CartItem>> getCartItems() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .get();

      return snapshot.docs
          .map((doc) => CartItem.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  // Update quantity
  Future<void> updateQuantity(String productId, int newQuantity) async {
    try {
      if (newQuantity <= 0) {
        await removeFromCart(productId);
      } else {
        await _firestore
            .collection('users')
            .doc(_userId)
            .collection('cart')
            .doc(productId)
            .update({
          'quantity': newQuantity,
          'updatedAt': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  // Remove from cart
  Future<void> removeFromCart(String productId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  // Clear cart
  Future<void> clearCart() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  // Get cart summary
  Future<Map<String, dynamic>> getCartSummary() async {
    try {
      final items = await getCartItems();

      int subtotal = 0;
      for (var item in items) {
        subtotal += item.totalPrice;
      }

      const int shipping = 50; // Fixed shipping
      const double taxPercent = 0.0; // 0% tax
      int tax = (subtotal * taxPercent).toInt();
      int grandTotal = subtotal + shipping + tax;

      return {
        'subtotal': subtotal,
        'shipping': shipping,
        'tax': tax,
        'grandTotal': grandTotal,
        'itemCount': items.length,
      };
    } catch (e) {
      throw Exception('Failed to get cart summary: $e');
    }
  }
}
