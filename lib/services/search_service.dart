import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testapp/models/product_model.dart';


class SearchService {
  static const String baseUrl = 'https://admin.kushinirestaurant.com/api';

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/search/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'query': query}),
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        
        if (data is List) {
          return data.map((item) => Product.fromJson(item)).toList();
        } else if (data is Map<String, dynamic> && data.containsKey('message')) {
          return [];
        }
      }
      throw Exception('Failed to search products');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}