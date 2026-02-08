import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({
    super.key,
    this.email = 'sunnysingh@gmail.com',
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              buildBackButton(),
              SizedBox(height: 60,),
              buildHeader(),
              SizedBox(height: 60,),
              buildOtpFields(),
              SizedBox(height: 40,),
              buildResendSection(),
              SizedBox(height: 40,),
              buildVerifyButton()
            ],
          ),
        ),
      ),
    );
  }

  // Back Button
  Widget buildBackButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.5,
        ),
        color: Colors.white,
      ),
      child: IconButton(
        onPressed: () {

        },
        icon: const Icon(
          Icons.arrow_back,
          size: 20,
          color: Colors.black,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  // Header Section
  Widget buildHeader() {
    return Column(
      children: [
        Center(
          child: Text(
            'Verify Code',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 32,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Please enter the code we just sent to email\n',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: widget.email,
                  style: const TextStyle(
                    color: Color(0xFFE53935),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // OTP Input Fields
  Widget buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.only(
            right: index < 3 ? 16 : 0,
          ),
          child: _buildOtpBox(index),
        );
      }),
    );
  }

  // Individual OTP Box
  // Individual OTP Box - Updated
  Widget _buildOtpBox(int index) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center, // Added this
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center, // Added this
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero, // Removed padding
          isDense: true, // Added this
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  // Resend Code Section
  Widget buildResendSection() {
    return Center(
      child: Column(
        children: [
          Text(
            "Didn't receive OTP?",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // Handle resend code
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Code resent successfully'),
                  backgroundColor: Color(0xFFE53935),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Resend code',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFE53935),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Verify Button
  Widget buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          String otp = _otpControllers.map((c) => c.text).join();
          if (otp.length == 4) {
            // Handle verification
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign In successfully'),
                backgroundColor: Color(0xFFE53935),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please enter complete OTP'),
                backgroundColor: Color(0xFFE53935),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53935),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Verify',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}