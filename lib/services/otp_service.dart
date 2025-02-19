import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> verifyUser(String phoneNumber) async {
  final url = Uri.parse('https://admin.kushinirestaurant.com/api/verify/');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'phone_number': phoneNumber}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to verify user');
  }
}
