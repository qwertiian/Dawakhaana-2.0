import 'package:flutter/material.dart';
import '/utils/styles.dart';

class MedicineFinderScreen extends StatefulWidget {
  const MedicineFinderScreen({super.key});

  @override
  _MedicineFinderScreenState createState() => _MedicineFinderScreenState();
}

class _MedicineFinderScreenState extends State<MedicineFinderScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isSearching = false;
  List<String> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Finder'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find medicines and treatments available near you',
              style: Styles.bodyStyle,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _medicineController,
              decoration: InputDecoration(
                labelText: 'Search for medicine',
                hintText: 'e.g., Paracetamol',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchMedicine,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your location',
                      hintText: 'City or area',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _detectLocation,
                  child: const Text('Detect'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (_isSearching)
              const Center(child: CircularProgressIndicator())
            else if (_searchResults.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Medicines:',
                    style: Styles.subheadingStyle,
                  ),
                  const SizedBox(height: 8),
                  ..._searchResults.map((medicine) => Card(
                    child: ListTile(
                      title: Text(medicine),
                      subtitle: const Text('Available at 3 pharmacies nearby'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  )),
                ],
              )
            else
              Center(
                child: Column(
                  children: [
                    Icon(Icons.local_pharmacy, size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Search for medicines to see results',
                      style: Styles.bodyStyle,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _searchMedicine() {
    if (_medicineController.text.isEmpty) return;

    setState(() {
      _isSearching = true;
      _searchResults = [];
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isSearching = false;
        _searchResults = [
          '${_medicineController.text} 500mg Tablet',
          '${_medicineController.text} Syrup',
          'Generic ${_medicineController.text}',
        ];
      });
    });
  }

  void _detectLocation() {
    // TODO: Implement location detection
    setState(() {
      _locationController.text = 'Current Location';
    });
  }
}