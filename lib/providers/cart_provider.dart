import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService = CartService();

  List<CartItem> _items = [];
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic> _summary = {
    'subtotal': 0,
    'shipping': 50,
    'tax': 0,
    'grandTotal': 0,
    'itemCount': 0,
  };

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic> get summary => _summary;
  int get itemCount => _items.length;

  Future<void> loadCart() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _items = await _cartService.getCartItems();
      await _loadSummary();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadSummary() async {
    try {
      _summary = await _cartService.getCartSummary();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<bool> addToCart({
    required String productId,
    required String title,
    required String price,
    required int maxStock,
    String image = 'assets/live image.png',
  }) async {
    _error = null;
    notifyListeners();

    try {
      await _cartService.addToCart(
        productId: productId,
        title: title,
        price: price,
        maxStock: maxStock,
        image: image,
      );
      await loadCart();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateQuantity(String productId, int newQuantity) async {
    _error = null;
    notifyListeners();

    try {
      await _cartService.updateQuantity(productId, newQuantity);
      await loadCart();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFromCart(String productId) async {
    _error = null;
    notifyListeners();

    try {
      await _cartService.removeFromCart(productId);
      await loadCart();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> clearCart() async {
    _error = null;
    notifyListeners();

    try {
      await _cartService.clearCart();
      _items = [];
      _summary = {
        'subtotal': 0,
        'shipping': 50,
        'tax': 0,
        'grandTotal': 0,
        'itemCount': 0,
      };
      notifyListeners();
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
