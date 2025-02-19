import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userName;
  String? _userPhone;

  String? get token => _token;
  String? get userName => _userName;
  String? get userPhone => _userPhone;

  // Store the token after login
  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  // Fetch user profile data
  Future<void> fetchUserProfile() async {
    if (_token == null) {
      throw Exception('No token found');
    }
    final url = Uri.parse('https://admin.kushinirestaurant.com/api/user-data/');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _userName = data['name'];
      _userPhone = data['phone_number'];
      notifyListeners();
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }
}
