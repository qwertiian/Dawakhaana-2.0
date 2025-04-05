import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/styles.dart';
import 'home_screen.dart';
import 'ngo_join_screen.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final TextEditingController _symptomController = TextEditingController();
  final List<String> _enteredSymptoms = [];
  bool _isLoading = false;
  String _selectedLanguage = 'English'; // Default language

  // Language options
  final List<Map<String, String>> _languageOptions = [
    {'value': 'English', 'label': 'English'},
    {'value': 'Hindi', 'label': 'हिंदी'},
    {'value': 'Marathi', 'label': 'मराठी'},
  ];

  // Health services with screen references replaced with strings to avoid dependency errors
  final List<Map<String, dynamic>> healthServices = [
    {
      'title': 'Symptom Checker',
      'description': 'Check symptoms using AI & get guidance.',
      'icon': Icons.medical_services,
      'color': Colors.blue,
      'screen': 'symptom_checker',
      'voiceCommand': 'symptom checker',
    },
    {
      'title': 'Skin Scanner',
      'description': 'Scan skin conditions & get AI analysis.',
      'icon': Icons.camera_alt,
      'color': Colors.green,
      'screen': 'skin_scanner',
      'voiceCommand': 'skin scanner',
    },
    {
      'title': 'Telemedicine',
      'description': 'Connect with doctors remotely.',
      'icon': Icons.video_call,
      'color': Colors.purple,
      'screen': 'telemedicine',
      'voiceCommand': 'telemedicine',
    },
    {
      'title': 'Medicine Finder',
      'description': 'Find medicines in nearby stores.',
      'icon': Icons.local_pharmacy,
      'color': Colors.orange,
      'screen': 'medicine_finder',
      'voiceCommand': 'medicine finder',
    },
    {
      'title': 'Emergency Guide',
      'description': 'Get first aid & emergency help.',
      'icon': Icons.emergency,
      'color': Colors.red,
      'screen': 'emergency_guide',
      'voiceCommand': 'emergency guide',
    },
    {
      'title': 'Health Awareness',
      'description': 'Learn preventive healthcare tips.',
      'icon': Icons.health_and_safety,
      'color': Colors.teal,
      'screen': 'health_awareness',
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
      ),
    );
  }

  void _navigateToScreen(String screenName) {
    // This is a placeholder - in your actual app, you would implement proper navigation
    // to each screen based on the screenName
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Would navigate to $screenName screen')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home, size: 32, color: Colors.blue),
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
              style: Styles.buttonTextStyle.copyWith(color: AppConstants.primaryColor),
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
                'AI Symptom Checker',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Enter your symptoms for AI analysis and health guidance',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Symptom input section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.medical_services, color: Colors.blue, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        'AI Symptom Analysis',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add all your symptoms for more accurate analysis',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _symptomController,
                          decoration: InputDecoration(
                            hintText: 'Enter a symptom (e.g., headache)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.mic, color: Colors.blue),
                        onPressed: () {
                          _showVoiceInputDialog();
                        },
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_symptomController.text.trim().isNotEmpty) {
                            setState(() {
                              _enteredSymptoms.add(_symptomController.text.trim());
                              _symptomController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                        child: const Text('+ Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Language selection dropdown
            if (_enteredSymptoms.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Output Language',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedLanguage,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                      ),
                      items: _languageOptions.map((language) {
                        return DropdownMenuItem<String>(
                          value: language['value'],
                          child: Text(language['label']!),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            if (_enteredSymptoms.isNotEmpty) const SizedBox(height: 16),

            // Symptoms list section
            if (_enteredSymptoms.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Added Symptoms',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _enteredSymptoms
                          .map((symptom) => Chip(
                        label: Text(symptom),
                        onDeleted: () {
                          setState(() {
                            _enteredSymptoms.remove(symptom);
                          });
                        },
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _enteredSymptoms.clear();
                            });
                          },
                          child: const Text(
                            'Clear All',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _enteredSymptoms.isEmpty
                              ? null
                              : () {
                            _analyzeSymptoms();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Check Symptoms'),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (_enteredSymptoms.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'No symptoms added yet. Please add at least one symptom.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // Important notice section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Important Notice',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This symptom checker is for informational purposes only and does not provide medical advice, diagnosis, or treatment. Always consult with a qualified healthcare provider for medical concerns.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
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
        _navigateToScreen(service['screen'] as String);
        return;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No service found for command: $command')),
    );
  }

  void _showVoiceInputDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Input'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mic, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text('Speak your symptom now...'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.red),
            onPressed: () {
              // Simulate voice input
              Navigator.pop(context);
              setState(() {
                _symptomController.text = 'headache'; // Example voice input
              });
            },
          ),
        ],
      ),
    );
  }

  void _analyzeSymptoms() {
    setState(() {
      _isLoading = true;
    });

    // Show a message about the selected language
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Results will be shown in $_selectedLanguage'),
        duration: const Duration(seconds: 2),
      ),
    );

    // Simulate API call with language parameter
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      // Show results in the selected language
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(_selectedLanguage == 'English'
              ? 'Possible Conditions'
              : _selectedLanguage == 'Hindi'
              ? 'संभावित स्थितियाँ'
              : 'संभावित परिस्थिती'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.medical_services),
                  title: Text(_selectedLanguage == 'English'
                      ? 'Common Cold'
                      : _selectedLanguage == 'Hindi'
                      ? 'सामान्य सर्दी'
                      : 'सामान्य सर्दी'),
                  subtitle: Text(_selectedLanguage == 'English'
                      ? 'Likely match: 75%'
                      : _selectedLanguage == 'Hindi'
                      ? 'संभावित मिलान: 75%'
                      : 'संभावित जुळणी: 75%'),
                ),
                ListTile(
                  leading: const Icon(Icons.medical_services),
                  title: Text(_selectedLanguage == 'English'
                      ? 'Migraine'
                      : _selectedLanguage == 'Hindi'
                      ? 'माइग्रेन'
                      : 'माइग्रेन'),
                  subtitle: Text(_selectedLanguage == 'English'
                      ? 'Likely match: 60%'
                      : _selectedLanguage == 'Hindi'
                      ? 'संभावित मिलान: 60%'
                      : 'संभावित जुळणी: 60%'),
                ),
                ListTile(
                  leading: const Icon(Icons.medical_services),
                  title: Text(_selectedLanguage == 'English'
                      ? 'Sinusitis'
                      : _selectedLanguage == 'Hindi'
                      ? 'साइनसाइटिस'
                      : 'सायनसाइटिस'),
                  subtitle: Text(_selectedLanguage == 'English'
                      ? 'Likely match: 45%'
                      : _selectedLanguage == 'Hindi'
                      ? 'संभावित मिलान: 45%'
                      : 'संभावित जुळणी: 45%'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(_selectedLanguage == 'English'
                  ? 'Close'
                  : _selectedLanguage == 'Hindi'
                  ? 'बंद करें'
                  : 'बंद करा'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _symptomController.dispose();
    super.dispose();
  }
}