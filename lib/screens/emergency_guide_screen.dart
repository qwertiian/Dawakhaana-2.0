import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import 'package:dawakhaana/screens/home_screen.dart';
import 'package:dawakhaana/screens/ngo_join_screen.dart';
import 'package:dawakhaana/screens/symptom_checker_screen.dart';
import 'package:dawakhaana/screens/skin_disease_scanner.dart';
import 'package:dawakhaana/screens/telemedicine_screen.dart';
import 'package:dawakhaana/screens/medicine_finder_screen.dart';
import 'package:dawakhaana/screens/health_awareness_screen.dart';

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
        {
          'name': 'Burns and Scalds',
          'icon': Icons.fireplace,
          'content': '''
What to do:
1. Remove the person from the source of the burn.
2. Cool the burn with cool (not cold) running water for 10-15 minutes.
3. Don't apply ice directly to the burn as it can cause further damage.
4. Remove jewelry or tight items from the burned area before swelling occurs.
5. Cover the burn with a clean, non-stick bandage or clean cloth.
6. Don't apply butter, oil, or ointments to the burn.
7. Take over-the-counter pain relievers if needed.

Warning:
Seek immediate medical attention for severe burns, burns covering large areas, or burns on the face, hands, feet, genitals, or major joints.
'''
        },
        {
          'name': 'Severe Bleeding',
          'icon': Icons.bloodtype,
          'content': '''
What to do:
1. Apply direct pressure to the wound using a clean cloth, bandage, or your hand if nothing else is available.
2. If possible, elevate the injured area above the level of the heart.
3. If blood soaks through, add more material on top - don't remove the soaked bandage.
4. If bleeding continues and is life-threatening, apply pressure to the artery supplying the area.
5. Use a tourniquet only as a last resort for life-threatening bleeding that cannot be controlled by other means.
6. Keep the person warm and calm.
7. Call for emergency help immediately.

Warning:
Severe bleeding can be life-threatening. Seek immediate medical attention while controlling the bleeding.
'''
        },
        {
          'name': 'Broken Bones (Fractures)',
          'icon': Icons.broken_image,
          'content': '''
What to do:
1. Keep the injured person still and calm.
2. Immobilize the injured area in the position you found it - don't try to realign the bone.
3. Apply ice packs wrapped in cloth to reduce swelling and pain.
4. For an arm or shoulder injury, a simple sling can provide support.
5. For a leg fracture, you can splint it by tying the injured leg to the uninjured leg with broad bandages.
6. Elevate the injured limb if possible.
7. Give pain relievers like paracetamol if available.

Warning:
Seek immediate medical attention. Improper movement can cause further damage to surrounding nerves, blood vessels, and tissue.
'''
        },
      ],
    },
    {
      'title': 'Emergency First Aid',
      'items': [
        {
          'name': 'Choking',
          'icon': Icons.warning,
          'content': '''
What to do:
1. Encourage the person to cough forcefully if they can.
2. If they cannot cough, speak, or breathe, stand behind them and place one foot between their feet for stability.
3. Place one hand slightly above their navel, then grasp that fist with your other hand.
4. Pull inward and upward with quick thrusts (Heimlich maneuver).
5. Continue until the object is expelled or the person becomes unconscious.
6. If the person becomes unconscious, lower them to the ground and begin CPR if you are trained.
7. Call for emergency help immediately.

Warning:
For babies under one year, do not use the Heimlich maneuver. Instead, place the baby face down along your forearm, support their head, and give five back slaps followed by five chest thrusts if needed.
'''
        },
        {
          'name': 'Snakebite',
          'icon': Icons.pest_control,
          'content': '''
What to do:
1. Move the person away from the snake's striking distance.
2. Keep the bitten area below the level of the heart to slow venom spread.
3. Remove any jewelry or tight clothing near the bite site before swelling starts.
4. Clean the wound gently with soap and water if available.
5. Cover the wound with a clean, dry bandage.
6. Keep the person still and calm to reduce venom spread.
7. Do NOT cut the wound, suck out the venom, apply ice, or apply a tourniquet.
8. Try to remember the snake's appearance for identification.
9. Get the person to medical help as quickly as possible.

Warning:
All snakebites should be treated as medical emergencies. Try to reach healthcare facilities as soon as possible. Different snakes require different antivenom treatments.
'''
        },
      ],
    },
    {
      'title': 'Illness First Aid',
      'items': [
        {
          'name': 'High Fever Management',
          'icon': Icons.thermostat,
          'content': '''
What to do:
1. Take temperature regularly to monitor fever (normal is about 98.6°F or 37°C).
2. Encourage rest and plenty of fluids to prevent dehydration.
3. Keep clothing and room temperature comfortable, not too hot or too cold.
4. Use a cool, damp cloth on the forehead, wrists, and calves to help reduce temperature.
5. For adults and children over 6 months, consider appropriate dose of fever-reducing medication like paracetamol.
6. Do not use aspirin for children or teenagers with fever.
7. Sponge with lukewarm (not cold) water if fever is very high.

Warning:
Seek immediate medical care for: fever above 103°F (39.4°C), fever with confusion, stiff neck, severe headache, difficulty breathing, or for any fever in infants under 3 months.
'''
        },
        {
          'name': 'Heat Exhaustion & Heatstroke',
          'icon': Icons.wb_sunny,
          'content': '''
What to do:
1. Move the person to a cooler place, preferably air-conditioned.
2. Remove unnecessary clothing and loosen tight clothing.
3. Fan air over the patient while wetting their skin with water.
4. Apply cold, wet towels to the head, neck, armpits, and groin.
5. If the person is alert, give cool water or sports drinks containing salt and sugar.
6. If there are signs of heatstroke (hot, dry skin, severe confusion, seizures), treat as a medical emergency.
7. Monitor body temperature and continue cooling efforts until it drops to 101-102°F (38.3-38.9°C).

Warning:
Heatstroke is a life-threatening emergency. If a person has hot, dry skin, confusion, or unconsciousness along with high body temperature, seek immediate medical attention while cooling them.
'''
        },
      ],
    },
  ];

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
            const Text('Tap the mic and say a command',
                style: TextStyle(fontStyle: FontStyle.italic)),
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
          onPressed: () => Navigator.pop(context),
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
            const Center(
              child: Text(
                'First aid instructions for common emergencies',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning_amber, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          'Important Notice',
                          style: Styles.subheadingStyle.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'This guide provides basic first aid information only. In case of serious emergency, call for medical help immediately. While waiting for professional help, these steps may help stabilize the situation.',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.emergency, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          'Emergency: Call 108',
                          style: Styles.bodyStyle.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search first aid guides...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...(category['items'] as List).map((item) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          _showFirstAidDetails(context, item['name'], item['content']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(item['icon'], color: AppConstants.primaryColor, size: 28),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],
              );
            }),
            const SizedBox(height: 16),
            Card(
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Remember',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'In any emergency situation, your safety is also important. Assess the situation for dangers before providing help. Call for emergency medical services as soon as possible, and only provide first aid that you are trained or comfortable performing.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFirstAidDetails(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.9,
          initialChildSize: 0.7,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Text(
                        content,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}