import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constant/colors.dart';
import 'package:testapp/providers/auth_provider.dart';
import 'package:testapp/providers/wishlist_provider.dart';
import 'package:testapp/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NameScreen extends StatelessWidget {
  final String phoneNumber;
  final String token;

  const NameScreen({super.key, required this.phoneNumber, required this.token});

  // Function to call the Login/Register API
  Future<void> _registerUser(String firstName, String phoneNumber) async {
    final url = Uri.parse(
      'https://admin.kushinirestaurant.com/api/login-register/',
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'first_name': firstName, 'phone_number': phoneNumber}),
    );

    if (response.statusCode == 200) {
      // Success: Navigate to HomeScreen
      return;
    } else {
      // Handle API errors
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(152, 100, 99, 99),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 32),

              // Name input field
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Full Name',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Submit button
              ElevatedButton(
                onPressed: () async {
                  final firstName = nameController.text.trim();
                  if (firstName.isEmpty) {
                    // Show error if name is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter your full name'),
                      ),
                    );
                    return;
                  }

                  try {
                    // Call the Login/Register API
                    await _registerUser(firstName, phoneNumber);
                    final authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    final wishlistProvider = Provider.of<WishlistProvider>(
                      context,
                      listen: false,
                    );
                    wishlistProvider.setToken(token);
                    authProvider.setToken(token);
                    await authProvider.fetchUserProfile();
                    // Navigate to HomeScreen after successful registration
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  } catch (e) {
                    // Show error if API call fails
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
