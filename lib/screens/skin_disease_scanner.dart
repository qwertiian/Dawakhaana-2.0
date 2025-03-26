import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class SkinDiseaseScannerScreen extends StatefulWidget {
  const SkinDiseaseScannerScreen({super.key});

  @override
  _SkinDiseaseScannerScreenState createState() => _SkinDiseaseScannerScreenState();
}

class _SkinDiseaseScannerScreenState extends State<SkinDiseaseScannerScreen> {
  String? _imagePath;
  bool _isAnalyzing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Disease Scanner'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload a photo of your skin condition for AI analysis',
              style: Styles.bodyStyle,
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    '3 AI Skin Condition Analysis',
                    style: Styles.subheadingStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Upload a clear, well-lit photo of the affected skin area',
                    style: Styles.captionStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: _imagePath == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Click to upload or drag and drop an image',
                      style: Styles.bodyStyle,
                    ),
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(_imagePath!, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo),
                  label: const Text('Select Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _clearImage,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _imagePath != null ? _analyzeImage : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isAnalyzing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Analyze Skin Condition'),
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Important Notice',
              style: Styles.subheadingStyle.copyWith(color: Colors.red),
            ),
            const SizedBox(height: 8),
            Text(
              'This skin scanner is for informational purposes only and does not replace professional medical diagnosis. Always consult with a qualified healthcare provider for skin concerns, especially for persistent, painful, or concerning skin conditions.',
              style: Styles.captionStyle,
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() {
    // TODO: Implement image picking logic
    setState(() {
      _imagePath = 'assets/sample_skin.jpg'; // For demo purposes
    });
  }

  void _clearImage() {
    setState(() {
      _imagePath = null;
    });
  }

  void _analyzeImage() {
    setState(() {
      _isAnalyzing = true;
    });
    // TODO: Implement image analysis logic
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isAnalyzing = false;
      });
      // Navigate to results screen
    });
  }
}