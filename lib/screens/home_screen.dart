import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screens/profile_screen.dart';
import '/screens/search_screen.dart';
import '/screens/symptom_checker_screen.dart';
import '/screens/skin_disease_scanner.dart';
import '/screens/telemedicine_screen.dart';
import '/screens/medicine_finder_screen.dart';
import '/screens/emergency_guide_screen.dart';
import '/screens/health_awareness_screen.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedLanguage = 'English';

  final List<Map<String, dynamic>> healthServices = [
    {
      'title': 'Symptom Checker',
      'description': 'Use AI to check your symptoms and get guidance on potential health issues.',
      'icon': Icons.medical_services,
      'color': Colors.blue,
      'screen': const SymptomCheckerScreen(),
    },
    {
      'title': 'Skin Disease Scanner',
      'description': 'Scan skin conditions and get AI analysis for potential skin diseases.',
      'icon': Icons.camera_alt,
      'color': Colors.green,
      'screen': const SkinDiseaseScannerScreen(),
    },
    {
      'title': 'Telemedicine',
      'description': 'Connect with healthcare professionals remotely for consultations.',
      'icon': Icons.video_call,
      'color': Colors.purple,
      'screen': const TelemedicineScreen(),
    },
    {
      'title': 'Medicine Finder',
      'description': 'Find available medicines and treatments in your nearby area.',
      'icon': Icons.local_pharmacy,
      'color': Colors.orange,
      'screen': const MedicineFinderScreen(),
    },
    {
      'title': 'Emergency Guide',
      'description': 'Access emergency and first aid guidance when you need it most.',
      'icon': Icons.emergency,
      'color': Colors.red,
      'screen': const EmergencyGuideScreen(),
    },
    {
      'title': 'Health Awareness',
      'description': 'Learn about preventive care and improve your health awareness.',
      'icon': Icons.health_and_safety,
      'color': Colors.teal,
      'screen': const HealthAwarenessScreen(),
    },
  ];

  final List<Map<String, dynamic>> languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'Hindi', 'code': 'hi'},
    {'name': 'Marathi', 'code': 'mr'},
    {'name': 'Kannada', 'code': 'kn'},
    {'name': 'Bengali', 'code': 'bn'},
    {'name': 'Tamil', 'code': 'ta'},
  ];

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
        title: const SearchBar(),
        actions: [
          DropdownButton<String>(
            value: _selectedLanguage,
            icon: const Icon(Icons.language),
            underline: Container(),
            items: languages.map((language) {
              return DropdownMenuItem<String>(
                value: language['name'],
                child: Text(language['name']),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
                // TODO: Implement language change logic
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/ai_medical_logo.png'),
                  alignment: Alignment.centerRight,
                  opacity: 0.3,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'AI-Powered Healthcare For Rural Communities',
                      style: Styles.bodyStyle.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome to Your Health Assistant',
                    style: Styles.headingStyle.copyWith(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Access quality healthcare services regardless of your location. Get AI symptom analysis, connect with doctors remotely, and find treatments available near you.',
                    style: Styles.bodyStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SymptomCheckerScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text('Symptom Checker', style: Styles.buttonTextStyle),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EmergencyGuideScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text('Emergency Guide', style: Styles.buttonTextStyle.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Health Services Section
            Text(
              'Health Services',
              style: Styles.headingStyle.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
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
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(service['icon'], size: 40, color: service['color']),
                          const SizedBox(height: 8),
                          Text(
                            service['title'],
                            style: Styles.subheadingStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service['description'],
                            style: Styles.captionStyle,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // How It Works Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              color: Colors.grey[50],
              child: Column(
                children: [
                  Text(
                    'How It Works',
                    style: Styles.headingStyle.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 24),
                  const StepItem(
                    number: 1,
                    title: 'Select Service',
                    description: 'Choose from symptom checker, skin scanner, telemedicine, or other services.',
                  ),
                  const StepItem(
                    number: 2,
                    title: 'Follow Guidance',
                    description: 'Enter symptoms, upload images, or connect with healthcare providers as needed.',
                  ),
                  const StepItem(
                    number: 3,
                    title: 'Get Results',
                    description: 'Receive AI analysis, doctor consultations, or nearby treatment information.',
                  ),
                ],
              ),
            ),
          ],
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
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: Styles.headingStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Styles.subheadingStyle),
                const SizedBox(height: 4),
                Text(description, style: Styles.bodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              // TODO: Implement voice search
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}