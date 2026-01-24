import 'package:flutter/material.dart';
import 'package:neo_glass/neo_glass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: const QuantumLoginPage(),
    );
  }
}

class QuantumLoginPage extends StatefulWidget {
  const QuantumLoginPage({super.key});

  @override
  State<QuantumLoginPage> createState() => _QuantumLoginPageState();
}

class _QuantumLoginPageState extends State<QuantumLoginPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _particleController;
  late AnimationController _glowController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _glowAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _particleController.dispose();
    _glowController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login Successful! 🎉'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuantumBackground(
        particleController: _particleController,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        quantumLogo(glowAnimation: _glowAnimation),
                        SizedBox(height: 25,),
                        quantumTitle(),
                        SizedBox(height: 30,),
                        loginCard(),
                        SizedBox(height: 35,),
                        quantumDivider(),
                        SizedBox(height: 25,),
                        quantumSocialButtons()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  loginCard(){
    return QuantumLoginCard(
      formKey: _formKey,
      emailController: _emailController,
      passwordController: _passwordController,
      obscurePassword: _obscurePassword,
      isLoading: _isLoading,
      onPasswordToggle: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
      onLogin: _handleLogin,
    );
  }
}



// Custom Widgets

class QuantumBackground extends StatelessWidget {
  final AnimationController particleController;
  final Widget child;

  const QuantumBackground({
    super.key,
    required this.particleController,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F0C29),
            Color(0xFF302B63),
            Color(0xFF24243E),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated Quantum Particles
          ...List.generate(25, (index) {
            return AnimatedBuilder(
              animation: particleController,
              builder: (context, child) {
                final offset = particleController.value * 2 * 3.14159;
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;

                return Positioned(
                  left: (50 + (index * 45)) % screenWidth,
                  top: (80 + (index * 60)) % screenHeight +
                      (40 *
                          (index % 2 == 0 ? 1 : -1) *
                          (0.4 + 0.6 * (index % 4) / 4) *
                          (offset % 6.28318)),
                  child: Container(
                    width: 3 + (index % 4) * 2,
                    height: 3 + (index % 4) * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal.withValues(alpha: 0.4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withValues(alpha: 0.6),
                          blurRadius: 12,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
          child,
        ],
      ),
    );
  }
}

class quantumLogo extends StatelessWidget {
  final Animation<double> glowAnimation;

  const quantumLogo({super.key, required this.glowAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowAnimation,
      builder: (context, child) {
        return NeoGlassContainer(
          effect: NeoGlassEffect.quantum,
          accentColor: Colors.teal,
          intensity: glowAnimation.value,
          borderRadius: 60.0,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.teal.shade400,
                  Colors.cyan.shade400,
                ],
              ),
            ),
            child: const Icon(
              Icons.scatter_plot,
              size: 55,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class quantumTitle extends StatelessWidget {
  const quantumTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return NeoGlassContainer(
      effect: NeoGlassEffect.quantum,
      accentColor: Colors.teal,
      intensity: 0.9,
      borderRadius: 30,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 6,
      ),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [
            Colors.teal.shade300,
            Colors.cyan.shade300,
            Colors.teal.shade200,
          ],
        ).createShader(bounds),
        child: const Text(
          'Quantum Login',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

class QuantumLoginCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onPasswordToggle;
  final VoidCallback onLogin;

  const QuantumLoginCard({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.onPasswordToggle,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return NeoGlassContainer(
      effect: NeoGlassEffect.quantum,
      accentColor: Colors.teal,
      intensity: 1.0,
      padding: const EdgeInsets.all(32),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            // Email Field
            QuantumTextField(
              controller: emailController,
              hintText: 'Email',
              icon: Icons.email_outlined,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter email';
                }
                if (!value!.contains('@')) {
                  return 'Please enter valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 22),

            // Password Field
            QuantumTextField(
              controller: passwordController,
              hintText: 'Password',
              icon: Icons.lock_outline,
              obscureText: obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.teal.shade300,
                ),
                onPressed: onPasswordToggle,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter password';
                }
                if (value!.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.teal.shade300,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Login Button
            QuantumLoginButton(
              isLoading: isLoading,
              onPressed: onLogin,
            ),
            const SizedBox(height: 15),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.teal.shade300,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuantumTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const QuantumTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return NeoGlassContainer(
      effect: NeoGlassEffect.quantum,
      accentColor: Colors.teal,
      intensity: 0.7,
      padding: EdgeInsets.zero,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
          prefixIcon: Icon(icon, color: Colors.teal.shade300),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.teal.shade300,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}

class QuantumLoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const QuantumLoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return NeoGlassContainer(
      effect: NeoGlassEffect.quantum,
      accentColor: Colors.teal,
      padding: const EdgeInsets.all(10),
      intensity: 1.0,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade600,
              Colors.cyan.shade600,
              Colors.teal.shade700,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: isLoading
              ? const SizedBox(
            height: 26,
            width: 26,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          )
              : const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.scatter_plot, color: Colors.white, size: 24),
              SizedBox(width: 12),
              Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class quantumDivider extends StatelessWidget {
  const quantumDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}

class quantumSocialButtons extends StatelessWidget {
  const quantumSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QuantumSocialButton(
          icon: Icons.g_mobiledata,
          color: Colors.red,
        ),
        SizedBox(width: 20),
        QuantumSocialButton(
          icon: Icons.facebook,
          color: Colors.blue,
        ),
        SizedBox(width: 20),
        QuantumSocialButton(
          icon: Icons.apple,
          color: Colors.white,
        ),
      ],
    );
  }
}

class QuantumSocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const QuantumSocialButton({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return NeoGlassContainer(
      effect: NeoGlassEffect.quantum,
      accentColor: Colors.teal,
      intensity: 0.8,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: 32,
          ),
        ),
      ),
    );
  }
}