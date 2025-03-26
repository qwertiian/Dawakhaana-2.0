import 'package:flutter/material.dart';
import '/models/condition.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class ConditionDetailScreen extends StatelessWidget {
  final Condition condition;

  const ConditionDetailScreen({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(condition.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              condition.name,
              style: Styles.headingStyle.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(condition.category),
              backgroundColor: AppConstants.lightGray,
            ),
            const SizedBox(height: 24),
            Text(
              'Description',
              style: Styles.subheadingStyle,
            ),
            const SizedBox(height: 8),
            Text(
              condition.description,
              style: Styles.bodyStyle,
            ),
            const SizedBox(height: 24),
            Text(
              'Common Symptoms',
              style: Styles.subheadingStyle,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: condition.symptoms
                  .map((symptom) => Chip(
                label: Text(symptom),
              ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Recommended Actions',
              style: Styles.subheadingStyle,
            ),
            const SizedBox(height: 8),
            ...condition.treatments.map((treatment) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.circle, size: 8),
                  const SizedBox(width: 8),
                  Expanded(child: Text(treatment)),
                ],
              ),
            )),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Important Notice',
              style: Styles.subheadingStyle.copyWith(color: Colors.red),
            ),
            const SizedBox(height: 8),
            Text(
              'This information is for educational purposes only and does not constitute medical advice. Always consult with a qualified healthcare professional for proper diagnosis and treatment.',
              style: Styles.captionStyle,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to telemedicine
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Consult a Doctor'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}