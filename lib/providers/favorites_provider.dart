import 'package:flutter/material.dart';
import '../services/favorites_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesService _favoritesService = FavoritesService();

  List<String> _favorites = [];
  bool _isLoading = false;
  String? _error;

  List<String> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadFavorites() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _favorites = await _favoritesService.getFavorites();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToFavorites(String productId) async {
    _error = null;
    notifyListeners();

    try {
      await _favoritesService.addToFavorites(productId);
      if (!_favorites.contains(productId)) {
        _favorites.add(productId);
      }
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFromFavorites(String productId) async {
    _error = null;
    notifyListeners();

    try {
      await _favoritesService.removeFromFavorites(productId);
      _favorites.removeWhere((id) => id == productId);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> toggleFavorite(String productId) async {
    if (isFavorite(productId)) {
      return removeFromFavorites(productId);
    } else {
      return addToFavorites(productId);
    }
  }

  bool isFavorite(String productId) {
    return _favorites.contains(productId);
  }

  Future<bool> checkIsFavorite(String productId) async {
    try {
      return await _favoritesService.isFavorite(productId);
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> clearFavorites() async {
    _error = null;
    notifyListeners();

    try {
      await _favoritesService.clearFavorites();
      _favorites = [];
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
