import 'package:flutter/material.dart';
import '../models/order_model.dart' as order_model;
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService();

  List<order_model.Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<order_model.Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await _orderService.getUserOrders();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> placeOrder({
    required List<order_model.OrderItem> items,
    required Map<String, dynamic> totals,
    required Map<String, dynamic> address,
  }) async {
    _error = null;
    notifyListeners();

    try {
      final orderId = await _orderService.placeOrder(
        items: items,
        totals: totals,
        address: address,
      );
      await loadOrders();
      return orderId;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return null;
    }
  }

  Future<order_model.Order?> getOrderDetails(String orderId) async {
    try {
      return await _orderService.getOrderDetails(orderId);
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return null;
    }
  }

  Future<bool> cancelOrder(String orderId) async {
    _error = null;
    notifyListeners();

    try {
      await _orderService.cancelOrder(orderId);
      await loadOrders();
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
