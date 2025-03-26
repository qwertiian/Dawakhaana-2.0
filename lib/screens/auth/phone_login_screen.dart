import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'otp_verification_screen.dart';
import 'register_screen.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import '/widgets/custom_app_bar.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _isButtonEnabled = false;
  String? _errorMessage;

  void _validatePhoneInput() {
    setState(() {
      _isButtonEnabled = _phoneController.text.length == 10;
      if (_isButtonEnabled) _errorMessage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneInput);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _navigateToOTPVerification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(
          phoneNumber: _phoneController.text,
          verificationId: 'dummy_verification_id', // For testing without backend
          isSignUp: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Login with Phone",
                  style: Styles.headingStyle.copyWith(
                    fontSize: 32,
                    color: AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Mobile Number (+91)",
                          prefixText: "+91 ",
                          errorText: _errorMessage,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _isButtonEnabled ? _navigateToOTPVerification : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isButtonEnabled && !_isLoading
                                ? AppConstants.primaryColor
                                : Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                            "Send OTP",
                            style: Styles.buttonTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: Styles.linkStyle.copyWith(fontSize: 16),
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