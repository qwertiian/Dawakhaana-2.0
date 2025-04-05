import 'package:flutter/material.dart';
import 'dart:ui'; // For blur effect
import '/utils/styles.dart';
import 'package:dawakhaana/screens/home_screen.dart'; // Make sure this import is correct
import 'package:dawakhaana/screens/ngo_join_screen.dart';

class MedicineFinderScreen extends StatefulWidget {
  const MedicineFinderScreen({super.key});

  @override
  _MedicineFinderScreenState createState() => _MedicineFinderScreenState();
}

class _MedicineFinderScreenState extends State<MedicineFinderScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isSearching = false;
  bool _searchEnabled = false;

  @override
  void initState() {
    super.initState();
    _medicineController.addListener(_updateSearchButton);
    _locationController.addListener(_updateSearchButton);
  }

  @override
  void dispose() {
    _medicineController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _updateSearchButton() {
    setState(() {
      _searchEnabled = _medicineController.text.isNotEmpty &&
          _locationController.text.isNotEmpty;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 32, color: Colors.blue),
          onPressed: () => Navigator.pop(context), // Changed to simple pop
        ),
        title: _buildAppName(),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.mic, size: 28, color: Colors.redAccent),
            onPressed: () {}, // Add voice command functionality if needed
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
            // Header section
            const Center(
              child: Text(
                'Medicine Finder',
                style: TextStyle( // Changed from 'Telemedicine' to 'Medicine Finder'
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Find medicines in nearby pharmacies',
                style: TextStyle( // Updated description
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Rest of your existing body content...
            // Search section
            const Text(
              'Search for Medicines',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter a medicine name or generic compound to find available options in pharmacies near your location.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Medicine search field
            TextField(
              controller: _medicineController,
              decoration: InputDecoration(
                labelText: 'Search for medicine',
                hintText: 'e.g., Paracetamol',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),

            // Location field with detect button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Enter your location',
                      hintText: 'City or area',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _detectLocation,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  child: const Text('Detect'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Search button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _searchEnabled ? _searchMedicine : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: _searchEnabled ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isSearching
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Search', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 32),

            // Results section (blurred for MVP)
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
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
                    textAlign: TextAlign.center,
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

  void _searchMedicine() {
    if (!_searchEnabled) return;

    setState(() {
      _isSearching = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSearching = false;
      });
    });
  }

  void _detectLocation() {
    // Simulate location detection
    setState(() {
      _locationController.text = 'Current Location';
    });
  }
}