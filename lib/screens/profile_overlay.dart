import 'package:flutter/material.dart';
import '/utils/styles.dart';
import '/utils/constants.dart';

class ProfileOverlay extends StatelessWidget {
  final String displayName;
  final String email;
  final String? photoUrl;
  final VoidCallback onLogout;

  const ProfileOverlay({
    super.key,
    required this.displayName,
    required this.email,
    this.photoUrl,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppConstants.primaryColor.withOpacity(0.2),
                  child: Icon(Icons.person,
                      size: 30,
                      color: AppConstants.primaryColor),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: Styles.subheadingStyle.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      email,
                      style: Styles.captionStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  icon: Icons.edit,
                  title: 'Edit Profile',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit profile clicked')));
                  },
                ),
                _buildMenuItem(
                  icon: Icons.language,
                  title: 'Language',
                  trailing: DropdownButton<String>(
                    value: 'English',
                    underline: Container(),
                    items: const [
                      DropdownMenuItem(
                        value: 'English',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'Hindi',
                        child: Text('Hindi'),
                      ),
                      DropdownMenuItem(
                        value: 'Marathi',
                        child: Text('Marathi'),
                      ),
                    ],
                    onChanged: (value) {
                      // Handle language change
                    },
                  ),
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  title: 'App Settings',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings clicked')));
                  },
                ),
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Help clicked')));
                  },
                ),
                const Divider(height: 1),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: onLogout,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon,
          size: 28,
          color: color ?? AppConstants.primaryColor),
      title: Text(
        title,
        style: Styles.bodyStyle.copyWith(
          fontSize: 16,
          color: color,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}