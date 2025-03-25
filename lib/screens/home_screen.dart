import 'package:flutter/material.dart';
import '/screens/profile_screen.dart';
import '/screens/search_screen.dart';
import '/screens/symptom_checker_screen.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const SymptomCheckerScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'SympCheck Navigator'),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: AppConstants.darkGray,
        selectedLabelStyle: Styles.captionStyle,
        unselectedLabelStyle: Styles.captionStyle,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Checker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key}); 

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          SearchBar(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            //readOnly: true,
          ),
          const SizedBox(height: 24),
          Text(
            'Common Symptoms',
            style: Styles.headingStyle,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildSymptomCard('Fever', Icons.thermostat, Colors.red),
                _buildSymptomCard('Headache', Icons.sick, Colors.orange),
                _buildSymptomCard('Cough', Icons.coronavirus, Colors.blue),
                _buildSymptomCard('Fatigue', Icons.bedtime, Colors.purple),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Health Articles',
            style: Styles.headingStyle,
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildArticleCard(
                'Understanding COVID-19 Symptoms',
                'Dr. Sarah Johnson',
                'May 15, 2023',
                'https://example.com/covid-article.jpg',
              ),
              _buildArticleCard(
                'Managing Seasonal Allergies',
                'Dr. Michael Chen',
                'April 28, 2023',
                'https://example.com/allergies-article.jpg',
              ),
              _buildArticleCard(
                'The Importance of Regular Check-ups',
                'Dr. Emily Wilson',
                'March 10, 2023',
                'https://example.com/checkups-article.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomCard(String name, IconData icon, Color color) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Navigate to symptom detail
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: Styles.subheadingStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(
      String title, String author, String date, String imageUrl) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to article detail
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Styles.subheadingStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By $author • $date',
                    style: Styles.captionStyle,
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