import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class EmergencyGuideScreen extends StatefulWidget {
  const EmergencyGuideScreen({super.key});

  @override
  _EmergencyGuideScreenState createState() => _EmergencyGuideScreenState();
}

class _EmergencyGuideScreenState extends State<EmergencyGuideScreen> {
  final List<Map<String, dynamic>> _firstAidCategories = [
    {
      'title': 'Injury First Aid',
      'items': [
        {'name': 'Burns and Scalds', 'icon': Icons.fireplace},
        {'name': 'Severe Bleeding', 'icon': Icons.bloodtype},
        {'name': 'Broken Bones (Fractures)', 'icon': Icons.broken_image},
      ],
    },
    {
      'title': 'Emergency First Aid',
      'items': [
        {'name': 'Choking', 'icon': Icons.warning},
        {'name': 'Snakebite', 'icon': Icons.pest_control},
      ],
    },
    {
      'title': 'Illness First Aid',
      'items': [
        {'name': 'High Fever Management', 'icon': Icons.thermostat},
        {'name': 'Heat Exhaustion & Heatstroke', 'icon': Icons.wb_sunny},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Guide'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'First aid instructions for common emergencies',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Important Notice',
                      style: Styles.subheadingStyle.copyWith(color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This guide provides basic first aid information only. In case of serious emergency, call for medical help immediately. While waiting for professional help, these steps may help stabilize the situation.',
                      style: Styles.captionStyle,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.emergency, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          'Emergency: Call 108',
                          style: Styles.bodyStyle.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search first aid guides...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ..._firstAidCategories.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['title'],
                    style: Styles.headingStyle,
                  ),
                  const SizedBox(height: 8),
                  ...(category['items'] as List).map((item) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(item['icon'], color: AppConstants.primaryColor),
                        title: Text(item['name']),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // Navigate to first aid detail
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}