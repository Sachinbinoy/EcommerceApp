// lib/repositories/product_repository.dart

import 'package:dio/dio.dart';
import 'package:testapp/models/product_model.dart';


class ProductRepository {
  final Dio _dio = Dio();
  final String baseUrl = 'https://admin.kushinirestaurant.com/api';

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('$baseUrl/products/');
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await _dio.post(
        '$baseUrl/search/',
        data: {'query': query},
      );
      
      if (response.statusCode == 200) {
        if (response.data is Map && response.data.containsKey('message')) {
          return [];
        }
        final List<dynamic> productsJson = response.data;
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search products');
      }
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }
}