import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart' as order_model;

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser?.uid ?? '';

  // Place order
  Future<String> placeOrder({
    required List<order_model.OrderItem> items,
    required Map<String, dynamic> totals,
    required Map<String, dynamic> address,
  }) async {
    try {
      // Re-check stock before creating order
      for (var item in items) {
        final productDoc =
            await _firestore.collection('products').doc(item.productId).get();

        if (!productDoc.exists) {
          throw Exception('Product ${item.title} no longer exists');
        }

        int stockQty = productDoc['stockQty'] ?? 0;
        if (stockQty < item.quantity) {
          throw Exception(
              '${item.title} has insufficient stock. Available: $stockQty');
        }
      }

      // Create order document
      final orderRef = _firestore.collection('orders').doc();

      final order = order_model.Order(
        id: orderRef.id,
        userId: _userId,
        items: items,
        totals: totals,
        address: address,
        status: 'PLACED',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Write order in a transaction
      await _firestore.runTransaction((transaction) async {
        transaction.set(orderRef, order.toMap());

        // Update user's orders subcollection
        await _firestore
            .collection('users')
            .doc(_userId)
            .collection('orders')
            .doc(orderRef.id)
            .set(order.toMap());
      });

      return orderRef.id;
    } catch (e) {
      throw Exception('Failed to place order: $e');
    }
  }

  // Get user orders
  Future<List<order_model.Order>> getUserOrders() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => order_model.Order.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  // Get order details
  Future<order_model.Order?> getOrderDetails(String orderId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('orders')
          .doc(orderId)
          .get();

      if (!doc.exists) return null;

      return order_model.Order.fromMap(doc.id, doc.data()!);
    } catch (e) {
      throw Exception('Failed to get order details: $e');
    }
  }

  // Cancel order
  Future<void> cancelOrder(String orderId) async {
    try {
      final order = await getOrderDetails(orderId);

      if (order == null) {
        throw Exception('Order not found');
      }

      if (!order.canCancel()) {
        throw Exception('Order can only be cancelled within 5 minutes');
      }

      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('orders')
          .doc(orderId)
          .update({
        'status': 'CANCELLED',
        'updatedAt': DateTime.now().toIso8601String(),
      });

      // Also update in main orders collection
      await _firestore.collection('orders').doc(orderId).update({
        'status': 'CANCELLED',
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }
}
