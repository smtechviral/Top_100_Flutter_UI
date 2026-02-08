import 'package:day_challenge_100/widgets/appImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B9080),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildHeader(),
                  SizedBox(height: 8,),
                  buildSubHeader(),
                  SizedBox(height: 32,),
                  buildLabel("Name"),
                  SizedBox(height: 8,),
                  buildNameField(),
                  SizedBox(height: 20,),
                  buildLabel("Email"),
                  SizedBox(height: 8,),
                  buildEmailField(),
                  SizedBox(height: 20,),
                  buildLabel("Password"),
                  SizedBox(height: 8,),
                  buildPasswordField(),
                  SizedBox(height: 20,),
                  buildTermsCheckbox(),
                  SizedBox(height: 24,),
                  buildSignUpButton(),
                  SizedBox(height: 24,),
                  buildDivider(),
                  SizedBox(height: 24,),
                  buildSocialButtons(),
                  SizedBox(height: 24,),
                  buildSignInLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildHeader(){
    return const Text(
      'Create Account',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
      textAlign: TextAlign.center,
    );
  }

  buildSubHeader(){
    return const Text(
      'Fill your information below or register\nwith your social account',
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF9CA3AF),
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  buildNameField(){
    return buildTextField(
      controller: _nameController,
      hintText: 'Ex. John Doe',
    );
  }

  buildEmailField(){
    return  buildTextField(
      controller: _emailController,
      hintText: 'example@gmail.com',
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF374151),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF1F2937),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFBBBBBB),
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF1F2937),
        ),
        decoration: InputDecoration(
          hintText: '••••••••••••••••',
          hintStyle: const TextStyle(
            color: Color(0xFFBBBBBB),
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: const Color(0xFF6B7280),
              size: 22,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildTermsCheckbox() {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() {
                _agreeToTerms = value ?? false;
              });
            },
            activeColor: const Color(0xFF6B9080),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'Agree with ',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: 'Terms & Condition',
                  style: const TextStyle(
                    color: Color(0xFF6B9080),
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle terms click
                      print('Terms & Condition clicked');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSignUpButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B9080), Color(0xFF5A7A6B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B9080).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle sign up
          print('Sign Up pressed');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          imagePath: "assets/images/apple-logo.png",
          onTap: () => print('Apple login'),
        ),
        const SizedBox(width: 20),
        _buildSocialButton(
          imagePath: "assets/images/google.png",
          onTap: () => print('Google login'),
          isGoogle: true,
        ),
        const SizedBox(width: 20),
        _buildSocialButton(
          imagePath: "assets/images/facebook.png",
          onTap: () => print('Facebook login'),
          isFacebook: true,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String imagePath, // asset path
    required VoidCallback onTap,
    bool isGoogle = false,
    bool isFacebook = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  buildDivider(){
    return Row(
      children: const [
        Expanded(child: Divider(color: Color(0xFFE5E7EB))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or sign up with',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFE5E7EB))),
      ],
    );
  }


  Widget buildSignInLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'Already have an account? ',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(
                color: Color(0xFF6B9080),
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Sign In clicked');
                },
            ),
          ],
        ),
      ),
    );
  }
}