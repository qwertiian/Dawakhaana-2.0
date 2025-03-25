import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class ConditionCard extends StatelessWidget {
  final String name;
  final String category;
  final String prevalence;
  final VoidCallback onTap;

  const ConditionCard({
    super.key,
    required this.name,
    required this.category,
    required this.prevalence,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Styles.subheadingStyle.copyWith(
                  color: AppConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(
                      category,
                      style: Styles.captionStyle.copyWith(color: Colors.white),
                    ),
                    backgroundColor: AppConstants.secondaryColor,
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(
                      prevalence,
                      style: Styles.captionStyle.copyWith(color: Colors.white),
                    ),
                    backgroundColor: AppConstants.accentColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}