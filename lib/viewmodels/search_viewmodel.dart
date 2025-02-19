import 'package:flutter/foundation.dart';
import 'package:testapp/services/search_service.dart';
import '../models/product_model.dart';


class SearchViewModel extends ChangeNotifier {
  final SearchService _apiService;
  bool _isLoading = false;
  String? _error;
  List<Product>? _searchResults;

  SearchViewModel({SearchService? apiService}) 
      : _apiService = apiService ?? SearchService();

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Product>? get searchResults => _searchResults;

  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = null;
      _error = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await _apiService.searchProducts(query);
      _searchResults = results;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _searchResults = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}