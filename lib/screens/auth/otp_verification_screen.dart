import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../location_access_screen.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final bool isSignUp;

  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.isSignUp,
  });

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isOTPEntered = false;
  bool _isResendEnabled = true;
  int _resendCooldown = 60;
  int _resendAttempts = 0;
  bool _isOTPExpired = false;
  int _otpTimer = 60;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _otpController.addListener(() {
      setState(() {
        _isOTPEntered = _otpController.text.length == 6;
      });
    });
    _startOTPTimer();
  }

  void _navigateToLocationScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LocationAccessScreen(isLoginFlow: !widget.isSignUp),
      ),
    );
  }

  void _verifyOTP() {
    _navigateToLocationScreen();
  }

  void _startOTPTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        if (_otpTimer > 0) {
          setState(() {
            _otpTimer--;
          });
          _startOTPTimer();
        } else {
          setState(() {
            _isOTPExpired = true;
          });
        }
      }
    });
  }

  void _resendOTP() {
    if (!_isResendEnabled) return;

    setState(() {
      _isResendEnabled = false;
      _resendAttempts++;
      _resendCooldown = 60 + (_resendAttempts * 30);
      _otpTimer = 60;
      _isOTPExpired = false;
      _otpController.clear();
      _errorMessage = null;
    });

    _startOTPTimer();

    Future.delayed(Duration(seconds: _resendCooldown), () {
      if (mounted) {
        setState(() {
          _isResendEnabled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppConstants.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(''), // Empty title
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Verify OTP",
                    style: Styles.headingStyle.copyWith(
                      fontSize: 32,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Enter OTP sent to +91${widget.phoneNumber}",
                    style: Styles.bodyStyle.copyWith(color: AppConstants.darkGray),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Time remaining: ${_otpTimer ~/ 60}:${(_otpTimer % 60).toString().padLeft(2, '0')}",
                    style: Styles.captionStyle.copyWith(
                      color: _isOTPExpired ? Colors.red : AppConstants.darkGray,
                    ),
                  ),
                  const SizedBox(height: 30),
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
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: "OTP",
                            errorText: _errorMessage,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            counterText: "",
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (_isOTPEntered && !_isOTPExpired && !_isLoading)
                                ? _verifyOTP
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (_isOTPEntered && !_isOTPExpired && !_isLoading)
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
                              "Verify",
                              style: Styles.buttonTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: _isResendEnabled ? _resendOTP : null,
                          child: Text(
                            _isResendEnabled
                                ? "Resend OTP"
                                : "Resend OTP in ${_resendCooldown ~/ 60}:${(_resendCooldown % 60).toString().padLeft(2, '0')}",
                            style: Styles.linkStyle.copyWith(
                              color: _isResendEnabled
                                  ? AppConstants.primaryColor
                                  : AppConstants.darkGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}