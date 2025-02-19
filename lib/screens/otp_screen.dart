// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:testapp/constant/colors.dart';
// import 'package:testapp/screens/name_screen.dart';

// class OTPScreen extends StatefulWidget {
//   final String phoneNumber;

//   const OTPScreen({super.key, required this.phoneNumber});

//   @override
//   State<OTPScreen> createState() => _OTPVerificationScreenState();
// }

// class _OTPVerificationScreenState extends State<OTPScreen> {
//   final List<TextEditingController> _controllers = List.generate(
//     4,
//     (_) => TextEditingController(),
//   );

//   Timer? _timer;
//   int _timeLeft = 120;

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_timeLeft > 0) {
//         setState(() {
//           _timeLeft--;
//         });
//       } else {
//         _timer?.cancel();
//       }
//     });
//   }

//   String get formattedTime {
//     int minutes = _timeLeft ~/ 60;
//     int seconds = _timeLeft % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} Sec';
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
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
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color.fromARGB(152, 100, 99, 99),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: grey),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),

//               const SizedBox(height: 32),

//               // Title
//               const Text(
//                 'OTP VERIFICATION',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Phone number text
//               Row(
//                 children: [
//                   Text(
//                     'Enter the OTP sent to ',
//                     style: const TextStyle(fontSize: 14, color: grey),
//                   ),
//                   Text(
//                     '- +91-${widget.phoneNumber}',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               // OTP display (for demo purposes)
//               Row(
//                 children: [
//                   const Text(
//                     'OTP is',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const Text(
//                     ' 4749',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: primaryColor,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(
//                   4,
//                   (index) => Padding(
//                     padding: const EdgeInsets.only(right: 9),
//                     child: Container(
//                       width: 69,
//                       height: 53,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(59, 150, 148, 148),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: TextField(
//                         controller: _controllers[index],
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         maxLength: 1,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           border: InputBorder.none,
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty && index < 3) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // Timer and Resend
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       formattedTime,
//                       style: const TextStyle(
//                         color: Colors.black54,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 13),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Don't receive code ? ",
//                           style: TextStyle(color: Colors.black54, fontSize: 14),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             if (_timeLeft == 0) {
//                               setState(() {
//                                 _timeLeft = 120;
//                               });
//                               startTimer();
//                             }
//                           },
//                           child: const Text(
//                             'Re-send',
//                             style: TextStyle(
//                               color: Color(0xFF22C55E), // Green color
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 32),

//               // Submit Button
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const NameScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF6C63FF),
//                   minimumSize: const Size(double.infinity, 56),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:testapp/constant/colors.dart';
// import 'package:testapp/screens/name_screen.dart';

// class OTPScreen extends StatefulWidget {
//   final String phoneNumber;
//   final String otp; // Add this to pass the OTP from the previous screen

//   const OTPScreen({
//     super.key,
//     required this.phoneNumber,
//     required this.otp, // Pass the OTP here
//   });

//   @override
//   State<OTPScreen> createState() => _OTPVerificationScreenState();
// }

// class _OTPVerificationScreenState extends State<OTPScreen> {
//   final List<TextEditingController> _controllers = List.generate(
//     4,
//     (_) => TextEditingController(),
//   );

//   Timer? _timer;
//   int _timeLeft = 120;

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_timeLeft > 0) {
//         setState(() {
//           _timeLeft--;
//         });
//       } else {
//         _timer?.cancel();
//       }
//     });
//   }

//   String get formattedTime {
//     int minutes = _timeLeft ~/ 60;
//     int seconds = _timeLeft % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} Sec';
//   }

//   // Function to validate the OTP
//   void validateOTP() {
//     String enteredOTP = '';
//     for (var controller in _controllers) {
//       enteredOTP += controller.text;
//     }

//     if (enteredOTP == widget.otp) {
//       // OTP is valid, navigate to the next screen
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) =>  NameScreen(phoneNumber: widget.phoneNumber,)),
//       );
//     } else {
//       // Show an error message if OTP is invalid
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid OTP. Please try again.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
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
//               // Back button
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color.fromARGB(152, 100, 99, 99),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                       offset: const Offset(0, 1),
//                     )
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: grey),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),

//               const SizedBox(height: 32),

//               // Title
//               const Text(
//                 'OTP VERIFICATION',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Phone number text
//               Row(
//                 children: [
//                   const Text(
//                     'Enter the OTP sent to ',
//                     style: TextStyle(fontSize: 14, color: grey),
//                   ),
//                   Text(
//                     '- +91-${widget.phoneNumber}',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               // OTP display (for demo purposes)
//               Row(
//                 children: [
//                   const Text(
//                     'OTP is',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Text(
//                     ' ${widget.otp}', // Display the OTP passed from the previous screen
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: primaryColor,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               // OTP input fields
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(
//                   4,
//                   (index) => Padding(
//                     padding: const EdgeInsets.only(right: 9),
//                     child: Container(
//                       width: 69,
//                       height: 53,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(59, 150, 148, 148),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: TextField(
//                         controller: _controllers[index],
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         maxLength: 1,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           border: InputBorder.none,
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty && index < 3) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // Timer and Resend
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       formattedTime,
//                       style: const TextStyle(
//                         color: Colors.black54,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 13),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Don't receive code? ",
//                           style: TextStyle(color: Colors.black54, fontSize: 14),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             if (_timeLeft == 0) {
//                               setState(() {
//                                 _timeLeft = 120;
//                               });
//                               startTimer();
//                             }
//                           },
//                           child: const Text(
//                             'Re-send',
//                             style: TextStyle(
//                               color: Color(0xFF22C55E), // Green color
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 32),

//               // Submit Button
//               ElevatedButton(
//                 onPressed: validateOTP, // Call the OTP validation function
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF6C63FF),
//                   minimumSize: const Size(double.infinity, 56),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:testapp/constant/colors.dart';
import 'package:testapp/screens/name_screen.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String otp;
  final String token;

  const OTPScreen({
    super.key,
    required this.phoneNumber,
    required this.otp, // Pass the OTP here
    required this.token
  });

  @override
  State<OTPScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  Timer? _timer;
  int _timeLeft = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String get formattedTime {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} Sec';
  }

  // Function to validate the OTP
  void validateOTP() {
    String enteredOTP = '';
    for (var controller in _controllers) {
      enteredOTP += controller.text;
    }

    if (enteredOTP == widget.otp) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NameScreen(phoneNumber: widget.phoneNumber,token: widget.token,),
        ),
      );
    } else {
      // Show an error message if OTP is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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

              // Title
              const Text(
                'OTP VERIFICATION',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              // Phone number text
              Row(
                children: [
                  const Text(
                    'Enter the OTP sent to ',
                    style: TextStyle(fontSize: 14, color: grey),
                  ),
                  Text(
                    '- +91-${widget.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // OTP display (for demo purposes)
              Row(
                children: [
                  const Text(
                    'OTP is',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    ' ${widget.otp}', // Display the OTP passed from the previous screen
                    style: const TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 9),
                    child: Container(
                      width: 69,
                      height: 53,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(59, 150, 148, 148),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Timer and Resend
              Center(
                child: Column(
                  children: [
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't receive code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_timeLeft == 0) {
                              setState(() {
                                _timeLeft = 120;
                              });
                              startTimer();
                            }
                          },
                          child: const Text(
                            'Re-send',
                            style: TextStyle(
                              color: Color(0xFF22C55E), // Green color
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: validateOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  minimumSize: const Size(double.infinity, 56),
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
