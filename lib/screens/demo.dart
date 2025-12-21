import 'dart:ui';
import 'package:day_challenge_100/widgets/signup_link.dart';
import 'package:flutter/material.dart';

// Main Login Screen
class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key? key}) : super(key: key);

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      LoginLogo(),
                      SizedBox(height: 32,),
                      LoginHeader(),
                      SizedBox(height: 40,),
                      LoginFormFields(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        obscurePassword: _obscurePassword,
                      ),
                      SizedBox(height: 16,),
                      ForgotPasswordButton(),
                      SizedBox(height: 32,),
                      LoginButton(onPressed: _handleLogin),
                      SizedBox(height: 20,),
                      LoginDivider(),
                      SizedBox(height: 24,),
                      SocialLoginButtons(),
                      SizedBox(height: 32,),
                      SignUpLink()
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

// Login Logo Widget
class LoginLogo extends StatelessWidget {
  const LoginLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: 100,
      height: 100,
      borderRadius: 50,
      child: const Icon(
        Icons.lock_outline,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}

// Login Header Widget
class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AnimatedText(
          text: 'Welcome Back',
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 8),
        AnimatedText(
          text: 'Login to continue',
          fontSize: 16,
          color: Colors.white70,
        ),
      ],
    );
  }
}

// Login Form Fields Widget
class LoginFormFields extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final bool obscurePassword;
  final VoidCallback? onTogglePassword;

  const LoginFormFields({
    Key? key,
    this.emailController,
    this.passwordController,
    this.obscurePassword = true,
    this.onTogglePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: passwordController,
          hintText: 'Password',
          icon: Icons.lock_outline,
          obscureText: obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.white70,
            ),
            onPressed: onTogglePassword,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}

// Forgot Password Button Widget
class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomTextButton(
        text: 'Forgot Password?',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Forgot Password clicked')),
          );
        },
      ),
    );
  }
}

// Login Button Widget
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      text: 'Login',
      onPressed: onPressed,
      width: double.infinity,
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;

  const CustomButton({Key? key, required this.onPressed,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      text: text ?? "",
      onPressed: onPressed,
      width: double.infinity,
    );
  }
}

// Login Divider Widget
class LoginDivider extends StatelessWidget {
  const LoginDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomDivider(text: 'OR');
  }
}

// Social Login Buttons Widget
class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          icon: Icons.g_mobiledata,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Google login clicked')),
            );
          },
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: Icons.facebook,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Facebook login clicked')),
            );
          },
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: Icons.apple,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Apple login clicked')),
            );
          },
        ),
      ],
    );
  }
}

// Sign Up Prompt Widget
class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        CustomTextButton(
          text: 'Sign Up',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign Up clicked')),
            );
          },
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}

// Custom Glass Container Widget
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 40,
    this.padding,
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
          padding: padding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
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

// Custom Text Field Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        // validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          prefixIcon: Icon(icon, color: Colors.white70),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}

// Custom Glass Button Widget
class GlassButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  const GlassButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _controller.reverse(),
        child: GlassContainer(
          width: widget.width,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Text Button Widget
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final FontWeight? fontWeight;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF00D9FF),
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

// Animated Text Widget
class AnimatedText extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const AnimatedText({
    Key? key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          color: widget.color ?? Colors.white,
        ),
      ),
    );
  }
}

// Custom Divider Widget
class CustomDivider extends StatelessWidget {
  final String text;

  const CustomDivider({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Social Button Widget
class SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SocialButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: GlassContainer(
        width: 60,
        height: 60,
        borderRadius: 30,
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}