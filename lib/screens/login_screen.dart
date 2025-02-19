import 'package:flutter/material.dart';
import 'package:testapp/constant/colors.dart';
import 'package:testapp/services/otp_service.dart';
import 'package:testapp/screens/otp_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _phoneController = TextEditingController();

  Future<void> _launchURL() async {
    const url = 'https://www.example.com/terms';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Let’s Connect with Lorem Ipsum..!',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromRGBO(78, 77, 77, 1),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '+91',
                          
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: grey,
                            
                          ),
                        ),
                        const SizedBox(height: 11),
                        Container(width: 40, height: 1, color: grey),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(fontFamily: 'Manrope'),
                            decoration: const InputDecoration(
                              hintText: 'Enter Phone',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintStyle: TextStyle(
                                fontFamily: 'Manrope',
                                color: grey,
                              ),
                            ),
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   height: 1,
                          //   color: grey,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final phoneNumber = _phoneController.text;
                  if (phoneNumber.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a phone number'),
                      ),
                    );
                    return;
                  }

                  try {
                    // Call the verifyUser function from otp_services.dart
                    final response = await verifyUser(phoneNumber);
                    final otp = response['otp'];
                    final token = response['token']['access'];

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => OTPScreen(
                              phoneNumber: phoneNumber,
                              otp: otp,
                              token: token,
                            ),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to verify user: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Oxygen',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 11,
                        fontFamily: 'Oxygen',
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: 'By continuing, you are accepting the ',
                        ),
                        TextSpan(
                          text: 'Terms & Privacy Policy',
                          style: const TextStyle(
                            fontFamily: 'Oxygen',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()..onTap = _launchURL,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:testapp/constant/colors.dart';
// import 'package:testapp/services/otp_services.dart'; // Ensure this import is correct
// import 'package:testapp/screens/otp_screen.dart'; // Ensure this import is correct
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/gestures.dart';
// import 'package:provider/provider.dart'; // Add this import
// import '../providers/auth_provider.dart'; // Add this import

// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key}) : super(key: key);

//   final _phoneController = TextEditingController();

//   Future<void> _launchURL() async {
//     const url = 'https://www.example.com/terms';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 80),
//               const Text(
//                 'Login',
//                 style: TextStyle(
//                   fontFamily: 'Manrope',
//                   fontSize: 35,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Let’s Connect with Lorem Ipsum..!',
//                 style: TextStyle(
//                   fontFamily: 'Manrope',
//                   color: Color.fromRGBO(78, 77, 77, 1),
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           '+91',
//                           style: TextStyle(
//                             fontFamily: 'Manrope',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: grey,
//                           ),
//                         ),
//                         const SizedBox(height: 11),
//                         Container(width: 40, height: 1, color: grey),
//                       ],
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextField(
//                             controller: _phoneController,
//                             keyboardType: TextInputType.phone,
//                             style: const TextStyle(fontFamily: 'Manrope'),
//                             decoration: const InputDecoration(
//                               hintText: 'Enter Phone',
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                 fontFamily: 'Manrope',
//                                 color: grey,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: double.infinity,
//                             height: 1,
//                             color: grey,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () async {
//                   final phoneNumber = _phoneController.text;
//                   if (phoneNumber.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Please enter a phone number')),
//                     );
//                     return;
//                   }

//                   try {
//                     // Call the verifyUser function from otp_services.dart
//                     final response = await verifyUser(phoneNumber);
//                     final otp = response['otp']; // Extract OTP from the response
//                     final token = response['token']['access']; // Extract JWT token

//                     // Store the token in AuthProvider
//                     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//                     authProvider.setToken(token);

//                     // Navigate to OTPScreen with phoneNumber and OTP
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => OTPScreen(
//                           phoneNumber: phoneNumber,
//                           otp: otp, // Pass the OTP here
//                         ),
//                       ),
//                     );
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Failed to verify user: $e')),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Continue',
//                   style: TextStyle(
//                     fontFamily: 'Oxygen',
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50),
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       style: const TextStyle(
//                         fontSize: 11,
//                         fontFamily: 'Oxygen',
//                         color: Colors.black,
//                       ),
//                       children: [
//                         const TextSpan(
//                           text: 'By continuing, you are accepting the ',
//                         ),
//                         TextSpan(
//                           text: 'Terms & Privacy Policy',
//                           style: const TextStyle(
//                             fontFamily: 'Oxygen',
//                             color: Colors.black,
//                             fontWeight: FontWeight.w500,
//                             decoration: TextDecoration.underline,
//                           ),
//                           recognizer: TapGestureRecognizer()..onTap = _launchURL,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
