import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testapp/models/product_model.dart';
import 'package:http/http.dart' as http;

class WishlistProvider with ChangeNotifier {
  final String baseUrl = 'https://admin.kushinirestaurant.com/api';
  List<Product> _wishlistProducts = [];
  String? _token;

  List<Product> get wishlistProducts => _wishlistProducts;

  void setToken(String token) {
    _token = token;
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    if (_token == null) return;

    final response = await http.get(
      Uri.parse('$baseUrl/wishlist/'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _wishlistProducts =
          data
              .map(
                (product) => Product(
                  id: product['id'],
                  name: product['name'],
                  inWishlist: product['in_wishlist'],
                  isActive: product['is_active'],
                  salePrice: product['sale_price'],
                  featuredImage: product["featured_image"],
                  avgRating: product["avg_rating"],
                  mrp: product["mrp"],
                ),
              )
              .toList();
      notifyListeners();
    }
  }

  Future<void> toggleWishlist(
    int productId,
    Product product,
    bool existing,
  ) async {
    try {
      if (existing) {
        print("removeWhere");

        _wishlistProducts.removeWhere((product) => product.id == productId);
      } else {
        print("adding");

        _wishlistProducts.add(product);
        print(_wishlistProducts.toString());
      }
      notifyListeners();
      if (_token == null) return;

      final response = await http.post(
        Uri.parse('$baseUrl/add-remove-wishlist/'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'product_id': productId}),
      );

      if (response.statusCode == 200) {
        await fetchWishlist();
      } else {
        print("api failed");
        if (existing) {
          _wishlistProducts.add(product);
        } else {
          _wishlistProducts.removeWhere((product) => product.id == productId);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool isInWishlist(int productId) {
    return _wishlistProducts.any((product) => product.id == productId);
  }
}
