import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';

class FlareLoginPage extends StatefulWidget {
  @override
  _FlareLoginPageState createState() => _FlareLoginPageState();
}

class _FlareLoginPageState extends State<FlareLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final FlareControls _flareControls = FlareControls();

  bool _obscurePassword = true;
  bool _isLogin = true;
  String _currentAnimation = "idle";

  List<String> _availableAnimations = [];
  bool _showAnimationsList = false;

  @override
  void initState() {
    super.initState();

    // Email field focus listener
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        _playAnimation("test");
      } else {
        if (!_passwordFocusNode.hasFocus) {
          _playAnimation("idle");
        }
      }
    });

    // Password field focus listener - FIXED
    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        // Password field focused
        if (_obscurePassword) {
          // Password hidden - hands up
          _playAnimation("hands_up");
        } else {
          // Password visible - can look (hands down)
          _playAnimation("test");
        }
      } else {
        // Password field lost focus - FIXED
        // Small delay to let other focus node update
        Future.delayed(Duration(milliseconds: 50), () {
          if (_emailFocusNode.hasFocus) {
            // Switched to email - hands down
            _playAnimation("test");
          } else {
            _playAnimation("idle");
          }
        });
      }
    });
  }

  void _playAnimation(String animationName) {
    setState(() {
      _currentAnimation = animationName;
      _flareControls.play(animationName);
    });
    print("🎬 Playing animation: $animationName");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleSubmit() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _playAnimation("fail");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 12),
              Text('Please fill all fields!'),
            ],
          ),
          backgroundColor: Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        _playAnimation("idle");
      });
      return;
    }

    if (!_isValidEmail(_emailController.text)) {
      _playAnimation("fail");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.email_outlined, color: Colors.white),
              SizedBox(width: 12),
              Text('Invalid email format!'),
            ],
          ),
          backgroundColor: Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        _playAnimation("idle");
      });
      return;
    }

    if (_passwordController.text.length < 6) {
      _playAnimation("fail");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.lock_outline, color: Colors.white),
              SizedBox(width: 12),
              Text('Password must be at least 6 characters!'),
            ],
          ),
          backgroundColor: Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        _playAnimation("idle");
      });
      return;
    }

    _playAnimation("success");

    Future.delayed(Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 12),
              Text(_isLogin ? 'Login Successful!' : 'Account Created!'),
            ],
          ),
          backgroundColor: Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      _emailController.clear();
      _passwordController.clear();
      _playAnimation("idle");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildFlareCard(),
                buildLoginForm()

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFlareCard() {
    return SizedBox(
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: FlareActor(
          "assets/images/Teddy.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          controller: _flareControls,
          animation: _currentAnimation,
        ),
      ),
    );
  }


  Widget buildLoginForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTittleText(),
          SizedBox(height: 8,),
          buildSubtitle(),
          SizedBox(height: 28,),
          buildEmail(),
          SizedBox(height: 16,),
          buildPasswordField(),
          buildForgotPassword(),
          SizedBox(height: 24,),
          buildSubmitButton(),
          SizedBox(height: 24,),
          buildToggleButton()

        ],
      ),
    );
  }

  buildForgotPassword(){
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              _playAnimation("test");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.email_outlined, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Password reset link sent!'),
                    ],
                  ),
                  backgroundColor: Color(0xFF3B82F6),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );

              Future.delayed(Duration(seconds: 2), () {
                _playAnimation("idle");
              });
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color(0xFF6366F1),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),

      ],
    );
  }

  buildTittleText(){
    return Text(
      _isLogin ? 'Sign In' : 'Create Account',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }

  buildSubtitle(){
    return Text(
      _isLogin ? 'Enter your credentials to continue' : 'Fill the details to get started',
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF64748B),
      ),
    );
  }

  buildEmail(){
    return  buildTextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      label: 'Email Address',
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: focusNode.hasFocus ? Color(0xFF6366F1) : Color(0xFFE2E8F0),
              width: focusNode.hasFocus ? 2 : 1,
            ),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: 'Enter your $label',
              hintStyle: TextStyle(color: Color(0xFF94A3B8)),
              prefixIcon: Icon(
                icon,
                color: focusNode.hasFocus ? Color(0xFF6366F1) : Color(0xFF94A3B8),
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _passwordFocusNode.hasFocus ? Color(0xFF6366F1) : Color(0xFFE2E8F0),
              width: _passwordFocusNode.hasFocus ? 2 : 1,
            ),
          ),
          child: TextField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            obscureText: _obscurePassword,
            style: TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: TextStyle(color: Color(0xFF94A3B8)),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: _passwordFocusNode.hasFocus ? Color(0xFF6366F1) : Color(0xFF94A3B8),
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });

                  // FIXED: Manually trigger animation when visibility changes
                  if (_passwordFocusNode.hasFocus) {
                    if (_obscurePassword) {
                      // Password is now hidden - hands up
                      _playAnimation("hands_up");
                    } else {
                      // Password is now visible - hands down (test)
                      _playAnimation("test");
                    }
                  }
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6366F1),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Color(0xFF6366F1).withOpacity(0.4),
        ),
        child: Text(
          _isLogin ? 'Sign In' : 'Create Account',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget buildToggleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isLogin ? "Don't have an account? " : "Already have an account? ",
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 14,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _isLogin = !_isLogin;
              _playAnimation("idle");
            });
          },
          child: Text(
            _isLogin ? 'Sign Up' : 'Sign In',
            style: TextStyle(
              color: Color(0xFF6366F1),
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}