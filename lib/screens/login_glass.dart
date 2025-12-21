import 'dart:ui';

import 'package:flutter/material.dart';

class LoginScreenWithGlass extends StatefulWidget {
  const LoginScreenWithGlass({Key? key}) : super(key: key);

  @override
  State<LoginScreenWithGlass> createState() => _LoginScreenWithGlassState();
}

class _LoginScreenWithGlassState extends State<LoginScreenWithGlass>
    with TickerProviderStateMixin {
  bool isDarkMode = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  AnimationController? fadeController;
  AnimationController? slideController;
  Animation<double>? fadeAnimation;
  Animation<Offset>? slideAnimation;

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: fadeController!, curve: Curves.easeIn));

    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: slideController!, curve: Curves.easeOutCubic),
        );

    fadeController?.forward();
    slideController?.forward();
  }

  @override
  void dispose() {
    fadeController?.dispose();
    slideController?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [
                    const Color(0xFF0F2027),
                    const Color(0xFF203A43),
                    const Color(0xFF2C5364),
                  ]
                : [
                    const Color(0xFF667eea),
                    const Color(0xFF764ba2),
                    const Color(0xFFf093fb),
                  ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Animated floating circles
              ...List.generate(3, (index) => _buildFloatingCircle(index)),

              // Main content
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FadeTransition(
                      opacity: fadeAnimation!,
                      child: SlideTransition(
                        position: slideAnimation!,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildThemeToggle(),
                            SizedBox(height: 35),
                            buildLogo(),
                            SizedBox(height: 10),
                            buildWelcomeText(),
                            SizedBox(height: 20),
                            buildGlassCard(),
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
      ),
    );
  }

  Widget _buildFloatingCircle(int index) {
    final sizes = [200.0, 150.0, 180.0];
    final positions = [
      const Alignment(-0.8, -0.6),
      const Alignment(0.9, -0.4),
      const Alignment(0.6, 0.8),
    ];

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 2000 + (index * 500)),
      curve: Curves.easeInOut,
      builder: (context, double value, child) {
        return Align(
          alignment: positions[index],
          child: Transform.translate(
            offset: Offset(0, 20 * (index % 2 == 0 ? value : -value)),
            child: Container(
              width: sizes[index],
              height: sizes[index],
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.1), Colors.transparent],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildThemeToggle() {
    return Align(
      alignment: Alignment.topRight,
      child: GlassContainer(
        child: IconButton(
          icon: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isDarkMode = !isDarkMode;
            });
          },
        ),
      ),
    );
  }

  Widget buildLogo() {
    return GlassContainer(
      borderRadius: 30,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Icon(Icons.lock_outline, size: 50, color: Colors.white),
      ),
    );
  }

  Widget buildWelcomeText() {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Login to continue',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }

  Widget buildGlassCard() {
    return GlassContainer(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildTextField(
              controller: emailController,
              hint: "Email",
              icon: Icons.email_outlined,
              isPassword: false,
            ),
            SizedBox(height: 20),
            buildTextField(
              controller: passwordController,
              hint: "Password",
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            SizedBox(height: 12,),
            buildForgot(),
            SizedBox(height: 10,),
            buildLoginButton(),
            SizedBox(height: 30,),
            buildSocialButtons(),
            SizedBox(height: 20,),
            buildDivider(),
            SizedBox(height: 20,),
            buildSignup()
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isPassword,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.7)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(15),
          child: const Center(
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
        ),
      ],
    );
  }

  buildSignup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white.withOpacity(0.8)),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  buildForgot() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
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
          icon: Icons.g_mobiledata,
          label: 'Google',
          onTap: () {},
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: Icons.facebook,
          label: 'Facebook',
          onTap: () {},
        ),
        const SizedBox(width: 16),
        _buildSocialButton(icon: Icons.apple, label: 'Apple', onTap: () {}),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GlassContainer(
      borderRadius: 15,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}

// Custom Glassmorphism Container Widget
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;

  const GlassContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(borderRadius),
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
