import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class TelemedicineScreen extends StatefulWidget {
  const TelemedicineScreen({super.key});

  @override
  _TelemedicineScreenState createState() => _TelemedicineScreenState();
}

class _TelemedicineScreenState extends State<TelemedicineScreen> {
  int _currentStep = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _gender;
  final TextEditingController _concernsController = TextEditingController();
  String? _consultationType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telemedicine'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            // Submit consultation request
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: const Text('Patient Information'),
            content: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    hintText: 'Enter your age',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender', style: Styles.bodyStyle),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        const Text('Male'),
                        Radio<String>(
                          value: 'Female',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        const Text('Female'),
                        Radio<String>(
                          value: 'Other',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        const Text('Other'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _concernsController,
                  decoration: const InputDecoration(
                    labelText: 'Health Concerns',
                    hintText: 'Describe your symptoms or health concerns',
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Consultation Type'),
            content: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Video Call'),
                  value: 'Video',
                  groupValue: _consultationType,
                  onChanged: (value) {
                    setState(() {
                      _consultationType = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Phone Call'),
                  value: 'Phone',
                  groupValue: _consultationType,
                  onChanged: (value) {
                    setState(() {
                      _consultationType = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Confirmation'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${_nameController.text}', style: Styles.bodyStyle),
                const SizedBox(height: 8),
                Text('Age: ${_ageController.text}', style: Styles.bodyStyle),
                const SizedBox(height: 8),
                Text('Gender: $_gender', style: Styles.bodyStyle),
                const SizedBox(height: 8),
                Text('Concerns: ${_concernsController.text}', style: Styles.bodyStyle),
                const SizedBox(height: 8),
                Text('Consultation Type: $_consultationType', style: Styles.bodyStyle),
                const SizedBox(height: 16),
                const Text(
                  'A doctor will contact you shortly at your selected consultation method.',
                  style: Styles.captionStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}