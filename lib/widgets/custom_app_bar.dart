import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppConstants.textColor),
        onPressed: () => Navigator.of(context).pop(),
      )
          : null,
      title: Text(title, style: Styles.appBarTitleStyle),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}