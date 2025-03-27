import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screens/auth/login_screen.dart';
import '/screens/auth/otp_verification_screen.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateInputs);
    _phoneController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim();
    setState(() {
      _isButtonEnabled = name.isNotEmpty && phone.length == 10;
    });
  }

  void _navigateToOTPVerification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(
          phoneNumber: _phoneController.text,
          verificationId: 'dummy_verification_id',
          isSignUp: true, // This is the key difference
        ),
      ),
    );  }

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
                  "Create Account",
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
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: _nameController.text.isNotEmpty &&
                              !RegExp(r'^[a-zA-Z ]+$').hasMatch(_nameController.text)
                              ? "Only alphabets and spaces allowed"
                              : null,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Mobile Number (+91)",
                          prefixText: "+91 ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: _phoneController.text.isNotEmpty &&
                              _phoneController.text.length != 10
                              ? "Enter valid 10-digit number"
                              : null,
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
                          onPressed: _isButtonEnabled ? _navigateToOTPVerification : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Verify OTP",
                            style: Styles.buttonTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppConstants.darkGray)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR",
                        style: Styles.captionStyle.copyWith(color: AppConstants.darkGray),
                      ),
                    ),
                    Expanded(child: Divider(color: AppConstants.darkGray)),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Already have an account?",
                  style: Styles.bodyStyle,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    "Login with Phone",
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