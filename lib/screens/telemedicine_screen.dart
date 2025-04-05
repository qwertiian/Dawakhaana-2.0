import 'dart:ui';

import 'package:flutter/material.dart';
import '/utils/styles.dart';
import 'package:dawakhaana/screens/ngo_join_screen.dart';
import 'package:dawakhaana/screens/home_screen.dart';
import 'package:dawakhaana/screens/symptom_checker_screen.dart';
import 'package:dawakhaana/screens/skin_disease_scanner.dart';
import 'package:dawakhaana/screens/medicine_finder_screen.dart';
import 'package:dawakhaana/screens/emergency_guide_screen.dart';
import 'package:dawakhaana/screens/health_awareness_screen.dart';

class TelemedicineScreen extends StatefulWidget {
  const TelemedicineScreen({super.key});

  @override
  State<TelemedicineScreen> createState() => _TelemedicineScreenState();
}

class _TelemedicineScreenState extends State<TelemedicineScreen> {
  int _currentStep = 0;

  final List<Map<String, dynamic>> healthServices = [
    {
      'title': 'Symptom Checker',
      'description': 'Check symptoms using AI & get guidance.',
      'icon': Icons.medical_services,
      'color': Colors.blue,
      'screen': const SymptomCheckerScreen(),
      'voiceCommand': 'symptom checker',
    },
    {
      'title': 'Skin Scanner',
      'description': 'Scan skin conditions & get AI analysis.',
      'icon': Icons.camera_alt,
      'color': Colors.green,
      'screen': const SkinDiseaseScannerScreen(),
      'voiceCommand': 'skin scanner',
    },
    {
      'title': 'Telemedicine',
      'description': 'Connect with doctors remotely.',
      'icon': Icons.video_call,
      'color': Colors.purple,
      'screen': const TelemedicineScreen(),
      'voiceCommand': 'telemedicine',
    },
    {
      'title': 'Medicine Finder',
      'description': 'Find medicines in nearby stores.',
      'icon': Icons.local_pharmacy,
      'color': Colors.orange,
      'screen': const MedicineFinderScreen(),
      'voiceCommand': 'medicine finder',
    },
    {
      'title': 'Emergency Guide',
      'description': 'Get first aid & emergency help.',
      'icon': Icons.emergency,
      'color': Colors.red,
      'screen': const EmergencyGuideScreen(),
      'voiceCommand': 'emergency guide',
    },
    {
      'title': 'Health Awareness',
      'description': 'Learn preventive healthcare tips.',
      'icon': Icons.health_and_safety,
      'color': Colors.teal,
      'screen': const HealthAwarenessScreen(),
      'voiceCommand': 'health awareness',
    },
  ];

  Widget _buildAppName() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.white.withOpacity(0.3),
              Colors.blue.withOpacity(0.2),
            ],
          ),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          'Dawakhaana',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.blue,
            letterSpacing: 1.1,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVoiceCommandDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Assistant'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Available voice commands:'),
            const SizedBox(height: 10),
            ...healthServices.map((service) =>
                Text('- ${service['voiceCommand']}', style: Styles.bodyStyle)
            ),
            const SizedBox(height: 20),
            const Text('Tap the mic and say a command', style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.redAccent),
            onPressed: () {
              Navigator.pop(context);
              _simulateVoiceCommandSelection(context);
            },
          ),
        ],
      ),
    );
  }

  void _simulateVoiceCommandSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select a voice command to simulate'),
        children: healthServices.map((service) =>
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                _handleVoiceCommand(service['voiceCommand']);
              },
              child: Text(service['title']),
            )
        ).toList(),
      ),
    );
  }

  void _handleVoiceCommand(String command) {
    for (var service in healthServices) {
      if (service['voiceCommand'].toLowerCase() == command.toLowerCase()) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => service['screen'] as Widget),
        );
        return;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No service found for command: $command')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 32, color: Colors.blue),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
            );
          },
        ),
        title: _buildAppName(),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.mic, size: 28, color: Colors.redAccent),
            onPressed: () => _showVoiceCommandDialog(context),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NGOJoinScreen()),
              );
            },
            child: Text(
              'Join',
              style: Styles.buttonTextStyle.copyWith(color: Colors.blue),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Title section
            const Center(
              child: Text(
                'Telemedicine',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Connect with healthcare professionals from anywhere',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Step indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepIndicator(1, 'Info', _currentStep >= 0),
                const SizedBox(width: 16),
                _buildStepIndicator(2, 'Doctor', _currentStep >= 1),
                const SizedBox(width: 16),
                _buildStepIndicator(3, 'Schedule', _currentStep >= 2),
              ],
            ),
            const SizedBox(height: 24),

            // Blurred content with "Will be updated" message
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Will be updated in the Prototype',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int number, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}