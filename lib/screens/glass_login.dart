import 'package:day_challenge_100/widgets/appColor.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class MeditationApp extends StatefulWidget {
  const MeditationApp({Key? key}) : super(key: key);

  @override
  State<MeditationApp> createState() => _MeditationAppState();
}

class _MeditationAppState extends State<MeditationApp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.l1,
              AppColor.l2,
            ],
          ),
        ),
        child: Stack(
          children: [
            buildAnimatedCircles(),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: GlassContainer(

                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          buildLogo(),
                          SizedBox(height: 32,),
                          buildWelcomeText(),
                          SizedBox(height: 40,),
                          buildEmailField(),
                          SizedBox(height: 20,),
                          buildPasswordField(),
                          SizedBox(height: 26,),
                          buildRememberForgot(),
                          SizedBox(height: 32,),
                          GlassButton(
                            onPressed: (){

                            },
                            text: "Login",
                            isPrimary: true,
                          ),
                          SizedBox(height: 24,),
                          buildDivider(),
                          SizedBox(height: 40,),
                          GlassButton(text: "Sign In With Google",
                              isPrimary: false,
                              imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png",
                              onPressed: (){
                          }),
                          SizedBox(height: 24,),
                          buildSignUpText()

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Sub-widgets (modular sections) ----------
  Widget buildAnimatedCircles() => Stack(
    children: [
      Positioned(
        top: -100,
        right: -100,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: -150,
        left: -100,
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget buildLogo() => Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withOpacity(0.3),
        width: 2,
      ),
    ),
    child: const Icon(
      Icons.self_improvement,
      size: 40,
      color: Colors.white,
    ),
  );

  Widget buildWelcomeText() => Column(
    children: [
      const Text(
        'Welcome back!',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w300,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        'Sign in to access your guided meditations,\ndaily practices, and personal journey',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(0.7),
          height: 1.5,
        ),
      ),
    ],
  );

  Widget buildEmailField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Email',
        style: TextStyle(
          fontSize: 13,
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 8),
      GlassTextField(
        controller: _emailController,
        hintText: 'Enter your email',
        keyboardType: TextInputType.emailAddress,
        prefixIcon: Icons.email_outlined,
      ),
    ],
  );

  Widget buildPasswordField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Password',
        style: TextStyle(
          fontSize: 13,
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 8),
      GlassTextField(
        controller: _passwordController,
        hintText: '••••••••',
        obscureText: _obscurePassword,
        prefixIcon: Icons.lock_outline,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.white.withOpacity(0.6),
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    ],
  );

  Widget buildRememberForgot() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () => setState(() => _rememberMe = !_rememberMe),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _rememberMe
                    ? const Color(0xFF8b5cf6)
                    : Colors.transparent,
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: _rememberMe
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              'Remember me',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    ],
  );

  Widget buildDivider() => Row(
    children: [
      Expanded(
        child: Container(
          height: 1,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Or',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 1,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
    ],
  );

  Widget buildSignUpText() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Don't have an account? ",
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}


class GlassContainer extends StatelessWidget {
  final Widget child;

  const GlassContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}


class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  const GlassTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(
                prefixIcon,
                color: Colors.white.withOpacity(0.6),
                size: 20,
              )
                  : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class GlassButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final String? imageUrl; // 👈 new: optional image

  const GlassButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
    this.icon,
    this.imageUrl, // 👈 added
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: isPrimary
                ? Colors.white.withOpacity(0.9)
                : Colors.white.withOpacity(0.1),
            child: InkWell(
              onTap: onPressed,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 👇 show image if provided
                      if (imageUrl != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl!,
                            width: 28,
                            height: 28,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image,
                                color: Colors.white70, size: 24),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],

                      // 👇 show icon if provided
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: isPrimary
                              ? const Color(0xFF1e3c72)
                              : Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                      ],

                      // 👇 text label
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isPrimary
                              ? const Color(0xFF1e3c72)
                              : Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
