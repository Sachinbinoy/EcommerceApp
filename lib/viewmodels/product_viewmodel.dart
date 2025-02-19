// import 'package:flutter/foundation.dart';
// import 'package:testapp/services/product_service.dart';
// import '../models/product_model.dart';


// class ProductViewModel extends ChangeNotifier {
//   final ProductRepository _repository = ProductRepository();
  
//   List<Product> _products = [];
//   bool _isLoading = false;
//   String? _error;

//   List<Product> get products => _products;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchProducts() async {
//     try {
//       _isLoading = true;
//       _error = null;
//       notifyListeners();

//       _products = await _repository.getProducts();
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//     }
//   }
// }

// lib/viewmodels/product_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:testapp/services/product_service.dart';
import '../models/product_model.dart';


class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get all products
  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _products = await _repository.getProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Search products
  Future<void> searchProducts(String query) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _products = await _repository.searchProducts(query);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Filter active products
  List<Product> get activeProducts => 
      _products.where((product) => product.isActive).toList();

  // Filter products by category
  List<Product> getProductsByCategory(String category) =>
      _products.where((product) => product.category == category).toList();

  // Get products in wishlist
  List<Product> get wishlistProducts =>
      _products.where((product) => product.inWishlist).toList();
}