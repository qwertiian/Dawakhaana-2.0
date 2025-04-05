import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import 'home_screen.dart';
import 'ngo_join_screen.dart';

class SkinDiseaseScannerScreen extends StatefulWidget {
  const SkinDiseaseScannerScreen({super.key});

  @override
  _SkinDiseaseScannerScreenState createState() => _SkinDiseaseScannerScreenState();
}

class _SkinDiseaseScannerScreenState extends State<SkinDiseaseScannerScreen> {
  String? _imagePath;
  bool _isAnalyzing = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
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
                'Skin Disease Scanner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Upload a photo of your skin condition for AI analysis',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // AI Analysis section
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
                      const Icon(Icons.camera_alt, color: Colors.green, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        'AI Skin Condition Analysis',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Upload a clear, well-lit photo of the affected skin area',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Upload section with dotted border
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.cloud_upload, size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 8),
                        const Text(
                          'Upload Image',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Click to upload or drag and drop an image of your skin condition',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Image preview or select button
                        _imagePath == null
                            ? ElevatedButton(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Select Image'),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            _imagePath!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _clearImage,
                  child: const Text(
                    'Clear Image',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: _imagePath != null ? _analyzeImage : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: _isAnalyzing
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text('Analyze Skin Condition'),
                ),
              ],
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
                    'This skin scanner is for informational purposes only and does not replace professional medical diagnosis. Always consult with a qualified healthcare provider for skin concerns, especially for persistent, painful, or concerning skin conditions.',
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
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Available voice commands:'),
            SizedBox(height: 10),
            Text('- skin scanner', style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            Text('Tap the mic and say a command', style: TextStyle(fontStyle: FontStyle.italic)),
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
              // Handle voice command
            },
          ),
        ],
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

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isAnalyzing = false;
      });

      // Show analysis results popup
      _showAnalysisResults();
    });
  }

  void _showAnalysisResults() {
    final resultText = '''
Possible Skin Conditions:
- Eczema (Atopic Dermatitis) (Confidence: 78%)
- Psoriasis (Confidence: 65%)
- Contact Dermatitis (Confidence: 52%)

Recommended Actions:
1. Keep the affected area moisturized
2. Avoid scratching
3. Consult a dermatologist for persistent symptoms
''';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Analysis Results'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    _imagePath!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Possible Skin Conditions:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.medical_services, color: Colors.blue),
                title: Text('Eczema (Atopic Dermatitis)'),
                subtitle: Text('Confidence: 78%'),
              ),
              const ListTile(
                leading: Icon(Icons.medical_services, color: Colors.blue),
                title: Text('Psoriasis'),
                subtitle: Text('Confidence: 65%'),
              ),
              const ListTile(
                leading: Icon(Icons.medical_services, color: Colors.blue),
                title: Text('Contact Dermatitis'),
                subtitle: Text('Confidence: 52%'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Recommended Actions:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '1. Keep the affected area moisturized\n'
                    '2. Avoid scratching\n'
                    '3. Consult a dermatologist for persistent symptoms',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: resultText));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Results copied to clipboard')),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.copy, size: 18),
                SizedBox(width: 4),
                Text('Copy Result'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}