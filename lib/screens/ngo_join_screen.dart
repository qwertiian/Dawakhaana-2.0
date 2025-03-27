import 'package:dawakhaana/utils/constants.dart' show AppConstants;
import 'package:flutter/material.dart';
import '/utils/styles.dart';

class NGOJoinScreen extends StatelessWidget {
  const NGOJoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Join as NGO'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Partner with Us',
              style: Styles.headingStyle.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Organization Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Contact Person',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Location/Region',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Brief Description',
                border: OutlineInputBorder(),
                hintText: 'Tell us about your organization and how you want to collaborate',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle submission
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Application submitted successfully!')),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Submit Application',
                style: Styles.buttonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}