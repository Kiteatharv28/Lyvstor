import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser?.uid ?? '';

  // Add to favorites
  Future<void> addToFavorites(String productId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(productId)
          .set({
        'productId': productId,
        'addedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }

  // Remove from favorites
  Future<void> removeFromFavorites(String productId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from favorites: $e');
    }
  }

  // Get all favorites
  Future<List<String>> getFavorites() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .get();

      return snapshot.docs.map((doc) => doc['productId'] as String).toList();
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }

  // Check if product is favorite
  Future<bool> isFavorite(String productId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(productId)
          .get();

      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check favorite: $e');
    }
  }

  // Clear all favorites
  Future<void> clearFavorites() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to clear favorites: $e');
    }
  }
}
