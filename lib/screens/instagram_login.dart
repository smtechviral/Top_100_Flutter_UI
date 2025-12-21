import 'package:flutter/material.dart';

class InstagramLoginScreen extends StatefulWidget {
  const InstagramLoginScreen({Key? key}) : super(key: key);

  @override
  State<InstagramLoginScreen> createState() => _InstagramLoginScreenState();
}

class _InstagramLoginScreenState extends State<InstagramLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                buildLogo(),
                SizedBox(height: 50,),
                buildEmailField(),
                SizedBox(height: 40,),
                buildPasswordField(),
                SizedBox(height: 30,),
                buildForgotPassword(),
                SizedBox(height: 25,),
                buildLoginButton(),
                SizedBox(height: 30,),
                OrDivider(),
                SizedBox(height: 30,),
                buildFacebookButton(),
                SizedBox(height: 40,),
                buildSignUpText(),
                SizedBox(height: 40,)

              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget buildLogo() => const InstagramLogo();

  Widget buildEmailField() => NeumorphicTextField(
    controller: _emailController,
    hintText: 'Phone, email address or username',
    keyboardType: TextInputType.emailAddress,
  );

  Widget buildPasswordField() => NeumorphicTextField(
    controller: _passwordController,
    hintText: 'Password',
    isPassword: true,
    isPasswordVisible: _isPasswordVisible,
    onVisibilityToggle: () {
      setState(() {
        _isPasswordVisible = !_isPasswordVisible;
      });
    },
  );

  Widget buildForgotPassword() => Align(
    alignment: Alignment.centerRight,
    child: GestureDetector(
      onTap: () {},
      child: const Text(
        'Forgotten your login details?',
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );

  Widget buildLoginButton() => NeumorphicButton(
    onPressed: () {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
    },
    child: const Text(
      'Log In',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget buildFacebookButton() => FacebookLoginButton(
    onPressed: () {},
  );

  Widget buildSignUpText() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have an account? ",
        style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 13),
      ),
      GestureDetector(
        onTap: () {},
        child: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

// ---------------- Custom Widgets ----------------

class InstagramLogo extends StatelessWidget {
  const InstagramLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/insta.png",
      height: 60,
    );
  }
}

class NeumorphicTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onVisibilityToggle;
  final TextInputType keyboardType;

  const NeumorphicTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onVisibilityToggle,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFF262626), fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey.shade600,
              size: 20,
            ),
            onPressed: onVisibilityToggle,
          )
              : null,
        ),
      ),
    );
  }
}

class NeumorphicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const NeumorphicButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFE0E5EC),
          borderRadius: BorderRadius.circular(30),
          boxShadow: _isPressed
              ? []
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              offset: const Offset(-4, -4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.grey.shade400],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade400, Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FacebookLoginButton extends StatefulWidget {
  final VoidCallback onPressed;

  const FacebookLoginButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  State<FacebookLoginButton> createState() => _FacebookLoginButtonState();
}

class _FacebookLoginButtonState extends State<FacebookLoginButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFE0E5EC),
          borderRadius: BorderRadius.circular(30),
          boxShadow: _isPressed
              ? [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              offset: const Offset(-2, -2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ]
              : [
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              offset: const Offset(-4, -4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFF3897F0),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'f',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Log in with Facebook',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
