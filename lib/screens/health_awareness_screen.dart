import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class HealthAwarenessScreen extends StatefulWidget {
  const HealthAwarenessScreen({super.key});

  @override
  _HealthAwarenessScreenState createState() => _HealthAwarenessScreenState();
}

class _HealthAwarenessScreenState extends State<HealthAwarenessScreen> {
  final List<Map<String, dynamic>> _healthTopics = [
    {
      'title': 'Preventive Health',
      'subtitle': 'Prevent disease before it starts',
      'count': 2,
      'icon': Icons.health_and_safety,
    },
    {
      'title': 'Nutrition Health',
      'subtitle': 'Healthy eating for better health',
      'count': 1,
      'icon': Icons.restaurant,
    },
    {
      'title': 'Mental Health',
      'subtitle': 'Caring for your emotional wellbeing',
      'count': 1,
      'icon': Icons.psychology,
    },
    {
      'title': 'Hygiene Health',
      'subtitle': 'Clean habits for disease prevention',
      'count': 1,
      'icon': Icons.clean_hands,
    },
    {
      'title': 'Maternal Health',
      'subtitle': 'Care for mothers and babies',
      'count': 1,
      'icon': Icons.family_restroom,
    },
  ];

  final List<Map<String, dynamic>> _featuredArticles = [
    {
      'title': 'Maternal and Newborn Care',
      'content':
      'Proper care during pregnancy and after birth is crucial for both mother and baby. During pregnancy: Attend antenatal check-ups, take iron and folic acid supplements as prescribed, eat nutritious foods, rest adequately, and know the...',
      'tags': ['pregnancy', 'childcare', 'health'],
    },
    {
      'title': 'Importance of Vaccination',
      'content':
      'Vaccines are one of public health\'s greatest achievements. They protect against serious, sometimes deadly, diseases by stimulating the immune system to recognize and fight pathogens. All children should receive the basic childhood...',
      'tags': ['vaccines', 'immunization', 'disease prevention'],
    },
    {
      'title': 'Mental Health Awareness',
      'content':
      'Mental health is just as important as physical health. Common mental health issues include depression, anxiety, and stress-related disorders. Signs that someone might be struggling include: persistent sadness or worry, withdrawal...',
      'tags': ['mental health', 'wellbeing', 'stress management'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Awareness'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search health topics, events or keywords...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Health Articles',
              style: Styles.headingStyle,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _healthTopics.length,
                itemBuilder: (context, index) {
                  final topic = _healthTopics[index];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 16),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(topic['icon'], size: 32, color: AppConstants.primaryColor),
                            const SizedBox(height: 12),
                            Text(
                              topic['title'],
                              style: Styles.subheadingStyle,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              topic['subtitle'],
                              style: Styles.captionStyle,
                            ),
                            const Spacer(),
                            Text(
                              '${topic['count']} article${topic['count'] > 1 ? 's' : ''}',
                              style: Styles.captionStyle.copyWith(color: AppConstants.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Featured Articles',
              style: Styles.headingStyle,
            ),
            const SizedBox(height: 16),
            ..._featuredArticles.map((article) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['title'],
                        style: Styles.subheadingStyle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article['content'],
                        style: Styles.bodyStyle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: (article['tags'] as List).map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: Colors.grey[200],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Read Article'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Colors.amber),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preventive Health Tip',
                            style: Styles.subheadingStyle,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Small changes in daily habits can significantly improve your health. Stay hydrated, wash hands regularly, eat a balanced diet with local vegetables and fruits, stay active with daily physical work or exercise, and get adequate sleep.',
                            style: Styles.captionStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Get Daily Health Tips'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}