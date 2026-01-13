import 'package:flutter/material.dart';
import '../models/address_model.dart';
import '../services/address_service.dart';

class AddressProvider extends ChangeNotifier {
  final AddressService _addressService = AddressService();

  List<Address> _addresses = [];
  Address? _selectedAddress;
  bool _isLoading = false;
  String? _error;

  List<Address> get addresses => _addresses;
  Address? get selectedAddress => _selectedAddress;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAddresses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _addresses = await _addressService.getAddresses();
      if (_addresses.isNotEmpty) {
        _selectedAddress = _addresses.firstWhere(
          (addr) => addr.isDefault,
          orElse: () => _addresses.first,
        );
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addAddress({
    required String name,
    required String phone,
    required String line1,
    required String city,
    required String pincode,
  }) async {
    _error = null;
    notifyListeners();

    try {
      final address = Address(
        id: '',
        name: name,
        phone: phone,
        line1: line1,
        city: city,
        pincode: pincode,
        isDefault: _addresses.isEmpty,
      );
      await _addressService.addAddress(address);
      await loadAddresses();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateAddress({
    required String addressId,
    required String name,
    required String phone,
    required String line1,
    required String city,
    required String pincode,
  }) async {
    _error = null;
    notifyListeners();

    try {
      final address = Address(
        id: addressId,
        name: name,
        phone: phone,
        line1: line1,
        city: city,
        pincode: pincode,
        isDefault: false,
      );
      await _addressService.updateAddress(addressId, address);
      await loadAddresses();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteAddress(String addressId) async {
    _error = null;
    notifyListeners();

    try {
      await _addressService.deleteAddress(addressId);
      await loadAddresses();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> setDefaultAddress(String addressId) async {
    _error = null;
    notifyListeners();

    try {
      await _addressService.setDefaultAddress(addressId);
      await loadAddresses();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  void selectAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }

  Future<bool> addDemoAddresses() async {
    _error = null;
    notifyListeners();

    try {
      final demoAddresses = [
        {
          'name': 'Home',
          'phone': '9876543210',
          'line1': '123 Main Street, Apartment 4B',
          'city': 'Mumbai',
          'pincode': '400001',
        },
        {
          'name': 'Office',
          'phone': '9876543211',
          'line1': '456 Business Park, Suite 200',
          'city': 'Bangalore',
          'pincode': '560001',
        },
        {
          'name': 'Parents House',
          'phone': '9876543212',
          'line1': '789 Residential Colony, House No. 42',
          'city': 'Delhi',
          'pincode': '110001',
        },
      ];

      for (int i = 0; i < demoAddresses.length; i++) {
        final addr = demoAddresses[i];
        await addAddress(
          name: addr['name']!,
          phone: addr['phone']!,
          line1: addr['line1']!,
          city: addr['city']!,
          pincode: addr['pincode']!,
        );
      }

      await loadAddresses();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
