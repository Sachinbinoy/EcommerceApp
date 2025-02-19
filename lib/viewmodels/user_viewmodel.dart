// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:testapp/models/OTPresponse_model.dart';

// class LoginViewModel {
//   Future<OTPResponse?> verifyUser(String phoneNumber) async {
//     final response = await http.post(
//       Uri.parse("https://admin.kushinirestaurant.com/api/verify/"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"phone_number": phoneNumber}),
//     );

//     if (response.statusCode == 200) {
//       return OTPResponse.fromJson(jsonDecode(response.body));
//     }
//     return null;
//   }

//   Future<bool> registerUser(String firstName, String phoneNumber) async {
//     final response = await http.post(
//       Uri.parse("https://admin.kushinirestaurant.com/api/login-register/"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"first_name": firstName, "phone_number": phoneNumber}),
//     );

//     return response.statusCode == 200;
//   }
// }
