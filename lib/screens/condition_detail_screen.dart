import 'package:flutter/material.dart';
import '/models/condition.dart';
import '/models/symptom.dart';
import '/services/api_service.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import '/widgets/custom_app_bar.dart';

class ConditionDetailScreen extends StatefulWidget {
  final Condition condition;

  const ConditionDetailScreen({super.key, required this.condition});

  @override
  _ConditionDetailScreenState createState() => _ConditionDetailScreenState();
}

class _ConditionDetailScreenState extends State<ConditionDetailScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Symptom>> _symptomsFuture;

  @override
  void initState() {
    super.initState();
    _symptomsFuture = _apiService.getSymptomsForCondition(widget.condition.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.condition.name,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.condition.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.condition.name,
              style: Styles.headingStyle,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.condition.category,
                    style: Styles.captionStyle.copyWith(color: Colors.white),
                  ),
                  backgroundColor: AppConstants.secondaryColor,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    widget.condition.prevalence,
                    style: Styles.captionStyle.copyWith(color: Colors.white),
                  ),
                  backgroundColor: AppConstants.accentColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: Styles.subheadingStyle,
            ),
            const SizedBox(height: 8),
            Text(
              widget.condition.description,
              style: Styles.bodyStyle,
            ),
            const SizedBox(height: 16),
            Text(
              'Common Symptoms',
              style: Styles.subheadingStyle,
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<Symptom>>(
              future: _symptomsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No symptoms found');
                } else {
                  return Column(
                    children: snapshot.data!
                        .map((symptom) => ListTile(
                      title: Text(symptom.name),
                      subtitle: Text(symptom.category),
                      trailing: Chip(
                        label: Text(
                          symptom.severity,
                          style: Styles.captionStyle.copyWith(
                              color: Colors.white),
                        ),
                        backgroundColor: _getSeverityColor(symptom.severity),
                      ),
                    ))
                        .toList(),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Treatment Options',
              style: Styles.subheadingStyle,
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.condition.treatments
                  .map((treatment) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle,
                        size: 16, color: AppConstants.secondaryColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        treatment,
                        style: Styles.bodyStyle,
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return AppConstants.darkGray;
    }
  }
}