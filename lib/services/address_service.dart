import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/address_model.dart';

class AddressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser?.uid ?? '';

  // Add address
  Future<void> addAddress(Address address) async {
    try {
      if (!address.isValid()) {
        throw Exception('Invalid address data');
      }

      final docRef = _firestore
          .collection('users')
          .doc(_userId)
          .collection('addresses')
          .doc();

      await docRef.set(address.toMap());
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  // Get all addresses
  Future<List<Address>> getAddresses() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('addresses')
          .orderBy('updatedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Address.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get addresses: $e');
    }
  }

  // Get default address
  Future<Address?> getDefaultAddress() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('addresses')
          .where('isDefault', isEqualTo: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return Address.fromMap(snapshot.docs.first.id, snapshot.docs.first.data());
    } catch (e) {
      throw Exception('Failed to get default address: $e');
    }
  }

  // Update address
  Future<void> updateAddress(String addressId, Address address) async {
    try {
      if (!address.isValid()) {
        throw Exception('Invalid address data');
      }

      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('addresses')
          .doc(addressId)
          .update(address.toMap());
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  // Delete address
  Future<void> deleteAddress(String addressId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }

  // Set default address
  Future<void> setDefaultAddress(String addressId) async {
    try {
      // Remove default from all addresses
      final addresses = await getAddresses();
      for (var addr in addresses) {
        if (addr.isDefault) {
          await _firestore
              .collection('users')
              .doc(_userId)
              .collection('addresses')
              .doc(addr.id)
              .update({'isDefault': false});
        }
      }

      // Set new default
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('addresses')
          .doc(addressId)
          .update({'isDefault': true});
    } catch (e) {
      throw Exception('Failed to set default address: $e');
    }
  }
}
