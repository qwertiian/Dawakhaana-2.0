import 'package:flutter/material.dart';
import '/screens/profile_screen.dart';
import '/screens/symptom_checker_screen.dart';
import '/screens/skin_disease_scanner.dart';
import '/screens/telemedicine_screen.dart';
import '/screens/medicine_finder_screen.dart';
import '/screens/emergency_guide_screen.dart';
import '/screens/health_awareness_screen.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import 'ngo_join_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            ).toList(),
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
          MaterialPageRoute(builder: (context) => service['screen']),
        );
        return;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No service found for command: $command')),
    );
  }

  Widget _buildAppName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor.withOpacity(0.2),
            Colors.white.withOpacity(0.3),
            AppConstants.primaryColor.withOpacity(0.2),
          ],
        ),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.3),
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
          color: AppConstants.primaryColor,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.account_circle, size: 32),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
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
              style: Styles.buttonTextStyle.copyWith(color: AppConstants.primaryColor),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'AI-Powered Healthcare',
                      style: Styles.headingStyle.copyWith(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Access quality healthcare services using AI-powered tools and expert guidance.',
                      style: Styles.bodyStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: Text(
                  'Health Services',
                  style: Styles.headingStyle.copyWith(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: healthServices.length,
                itemBuilder: (context, index) {
                  final service = healthServices[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => service['screen']),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(service['icon'], size: 36, color: service['color']),
                            const SizedBox(height: 6),
                            Text(
                              service['title'],
                              style: Styles.subheadingStyle.copyWith(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Flexible(
                              child: Text(
                                service['description'],
                                style: Styles.captionStyle.copyWith(fontSize: 12),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              Center(
                child: Text(
                  'How It Works',
                  style: Styles.headingStyle.copyWith(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              const StepItem(
                number: 1,
                title: 'Select Service',
                description: 'Choose a healthcare service to use.',
              ),
              const StepItem(
                number: 2,
                title: 'Follow Guidance',
                description: 'Provide symptoms or use AI tools.',
              ),
              const StepItem(
                number: 3,
                title: 'Get Results',
                description: 'Receive AI analysis or expert advice.',
              ),
              const SizedBox(height: 24),

              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final int number;
  final String title;
  final String description;

  const StepItem({
    super.key,
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppConstants.primaryColor,
            child: Text(number.toString(), style: Styles.headingStyle.copyWith(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Styles.subheadingStyle),
                Text(description, style: Styles.bodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 10),
        Text('Dawakhaana - Your AI-Powered Health Companion',
            style: Styles.subheadingStyle, textAlign: TextAlign.center),
        const SizedBox(height: 5),
        Text('Contact: support@dawakhaana.com | Privacy Policy', style: Styles.captionStyle),
        const SizedBox(height: 5),
        Text('Disclaimer: This app does not replace professional medical advice.', style: Styles.captionStyle),
        const SizedBox(height: 10),
      ],
    );
  }
}