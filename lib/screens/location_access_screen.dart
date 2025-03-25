import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '/screens/home_screen.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import '/widgets/custom_app_bar.dart';

class LocationAccessScreen extends StatelessWidget {
  final bool isLoginFlow;

  const LocationAccessScreen({super.key, this.isLoginFlow = false});

  Future<void> _getLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool enableService = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text('Please enable location services to use this feature.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Enable'),
            ),
          ],
        ),
      );

      if (enableService) {
        await Geolocator.openLocationSettings();
        return;
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied. Please enable them in app settings.')),
      );
      await Geolocator.openAppSettings();
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      print("Location: ${position.latitude}, ${position.longitude}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Location Access'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Location Access",
                  style: Styles.headingStyle.copyWith(
                    fontSize: 32,
                    color: AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "We need your location to provide better service.",
                  style: Styles.bodyStyle.copyWith(color: AppConstants.darkGray),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _getLocation(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppConstants.primaryColor),
                      ),
                    ),
                    child: Text(
                      "Allow Location Access",
                      style: Styles.buttonTextStyle.copyWith(color: AppConstants.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}