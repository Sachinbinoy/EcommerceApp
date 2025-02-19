import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: const TextStyle(
                    color: Color.fromRGBO(29, 35, 72, 1),
                    fontFamily: 'Heebo',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Name',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(146, 146, 146, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    authProvider.userName ?? 'Loading...',
                    style: const TextStyle(
                      color: Color.fromRGBO(29, 35, 72, 1),
                      fontFamily: 'Oxygen',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Phone',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(146, 146, 146, 1),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  authProvider.userPhone ?? 'Loading...',
                  style: const TextStyle(
                    color: Color.fromRGBO(29, 35, 72, 1),
                    fontFamily: 'Oxygen',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}