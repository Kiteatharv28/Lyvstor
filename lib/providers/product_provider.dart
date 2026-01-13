import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = '';
  String _searchQuery = '';
  String _sortBy = 'newest';

  List<Product> get products => _filteredProducts.isEmpty ? _products : _filteredProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String get sortBy => _sortBy;

  Future<void> loadCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await _firestore.collection('categories').get();
      debugPrint('📊 ProductProvider: Loaded ${snapshot.docs.length} categories');
      if (snapshot.docs.isEmpty) {
        debugPrint('⚠️ ProductProvider: No categories found in Firestore');
        _categories = [];
      } else {
        _categories = snapshot.docs.map((doc) {
          final name = doc['name'] as String;
          debugPrint('📌 Category: $name');
          return name;
        }).toList();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('❌ ProductProvider: Error loading categories: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await _firestore.collection('products').get();
      debugPrint('📦 ProductProvider: Loaded ${snapshot.docs.length} products');
      _products = snapshot.docs
          .map((doc) {
            final product = Product.fromMap(doc.data(), doc.id);
            debugPrint('📦 Product: ${product.title} (${product.category})');
            return product;
          })
          .toList();
      _applyFiltersAndSort();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('❌ ProductProvider: Error loading products: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Product?> getProductById(String productId) async {
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        return Product.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void sort(String sortOption) {
    _sortBy = sortOption;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void _applyFiltersAndSort() {
    _filteredProducts = _products;

    // Apply category filter
    if (_selectedCategory.isNotEmpty) {
      _filteredProducts = _filteredProducts
          .where((p) => p.category == _selectedCategory)
          .toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredProducts = _filteredProducts
          .where((p) =>
              p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case 'price_low':
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'newest':
      default:
        _filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
  }

  void clearFilters() {
    _selectedCategory = '';
    _searchQuery = '';
    _sortBy = 'newest';
    _filteredProducts = [];
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
