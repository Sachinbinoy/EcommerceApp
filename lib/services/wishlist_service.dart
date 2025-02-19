import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/models/product_model.dart';

class WishlistService {
  final String baseUrl = "https://admin.kushinirestaurant.com/api";

  Future<String> toggleWishlist(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return "User not logged in";
    }

    final response = await http.post(
      Uri.parse("$baseUrl/add-remove-wishlist/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"product_id": productId}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["message"];
    } else {
      return "Failed to update wishlist";
    }
  }

  Future<List<Product>> fetchWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return [];
    }

    final response = await http.get(
      Uri.parse("$baseUrl/wishlist/"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
