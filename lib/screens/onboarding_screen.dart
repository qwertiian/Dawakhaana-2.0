import 'package:flutter/material.dart';
import '/screens/auth/phone_login_screen.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingPages = [
    {
      'title': 'Understand Your Symptoms',
      'description': 'Get personalized insights about your health concerns',
      'image': AppConstants.onboarding1Path,
    },
    {
      'title': 'Discover Possible Conditions',
      'description': 'Learn about potential conditions related to your symptoms',
      'image': AppConstants.onboarding2Path,
    },
    {
      'title': 'Access Reliable Health Information',
      'description': 'Trusted articles and resources at your fingertips',
      'image': AppConstants.onboarding3Path,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    title: onboardingPages[index]['title']!,
                    description: onboardingPages[index]['description']!,
                    imagePath: onboardingPages[index]['image']!,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingPages.length,
                    (index) => buildDot(index: index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_currentPage == onboardingPages.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PhoneLoginScreen(),
                        ),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == onboardingPages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: Styles.buttonTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppConstants.primaryColor
            : AppConstants.mediumGray,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 250,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: Styles.headingStyle.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Styles.bodyStyle.copyWith(
              color: AppConstants.darkGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}