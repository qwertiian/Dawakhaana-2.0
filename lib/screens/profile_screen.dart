import 'package:flutter/material.dart';
import 'profile_overlay.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Demo user data
    const demoUser = {
      'displayName': 'Health User',
      'email': 'user@healthapp.com',
      'photoUrl': null,
    };

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Semi-transparent background that closes when tapped
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          // Profile overlay taking 75% width
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: ProfileOverlay(
              displayName: demoUser['displayName']!,
              email: demoUser['email']!,
              photoUrl: demoUser['photoUrl'],
              onLogout: () {
                // Just close the profile screen when logout is pressed
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}