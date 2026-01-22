import 'dart:ui';

import 'package:flutter/material.dart';

class GlassLoginScreen extends StatefulWidget {
  const GlassLoginScreen({Key? key}) : super(key: key);

  @override
  State<GlassLoginScreen> createState() => _GlassLoginScreenState();
}

class _GlassLoginScreenState extends State<GlassLoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _containerController;
  late AnimationController _elementsController;

  late Animation<double> _containerFade;
  late Animation<Offset> _containerSlide;
  late Animation<double> _containerScale;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _welcomeFade;
  late Animation<Offset> _welcomeSlide;
  late Animation<double> _emailFade;
  late Animation<Offset> _emailSlide;
  late Animation<double> _passwordFade;
  late Animation<Offset> _passwordSlide;
  late Animation<double> _forgetFade;
  late Animation<double> _buttonFade;
  late Animation<double> _buttonScale;
  late Animation<double> _signupFade;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _containerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _elementsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _containerFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _containerController, curve: Curves.easeOut),
    );

    _containerSlide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _containerController,
            curve: Curves.easeOutCubic,
          ),
        );

    _containerScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _containerController, curve: Curves.easeOut),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
      ),
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.2, 0.35, curve: Curves.easeOut),
      ),
    );

    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _elementsController,
            curve: const Interval(0.2, 0.35, curve: Curves.easeOut),
          ),
        );

    _welcomeFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.3, 0.45, curve: Curves.easeOut),
      ),
    );

    _welcomeSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _elementsController,
            curve: const Interval(0.3, 0.45, curve: Curves.easeOut),
          ),
        );

    _emailFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.4, 0.55, curve: Curves.easeOut),
      ),
    );

    _emailSlide = Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _elementsController,
            curve: const Interval(0.4, 0.55, curve: Curves.easeOut),
          ),
        );

    _passwordFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.5, 0.65, curve: Curves.easeOut),
      ),
    );

    _passwordSlide =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _elementsController,
            curve: const Interval(0.5, 0.65, curve: Curves.easeOut),
          ),
        );

    _forgetFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.6, 0.7, curve: Curves.easeOut),
      ),
    );

    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.7, 0.85, curve: Curves.easeOut),
      ),
    );

    _buttonScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.7, 0.85, curve: Curves.easeOut),
      ),
    );

    _signupFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _elementsController,
        curve: const Interval(0.85, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  void _startAnimations() {
    _containerController.forward().then((_) {
      _elementsController.forward();
    });
  }

  @override
  void dispose() {
    _containerController.dispose();
    _elementsController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody());
  }

  buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://i.pinimg.com/736x/55/fc/8f/55fc8fa7b34f2070656f0bbabafc2ac6.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(children: [buildMainContent()]),
    );
  }

  Widget buildBackgroundBlobs() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.purple.withOpacity(0.3),
                  Colors.purple.withOpacity(0.0),
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
                  Colors.purple.withOpacity(0.3),
                  Colors.purple.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMainContent() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: FadeTransition(
              opacity: _containerFade,
              child: SlideTransition(
                position: _containerSlide,
                child: ScaleTransition(
                  scale: _containerScale,
                  child: buildGlassContainer(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGlassContainer() {
    return Container(
      constraints: BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 50.0,
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                buildLogo(),
                SizedBox(height: 30,),
                buildBrandName(),
                SizedBox(height: 35,),
                buildWelcomeText(),
                SizedBox(height: 45,),
                buildEmailField(),
                SizedBox(height: 25,),
                buildPasswordField(),
                SizedBox(height: 10,),
                buildForgetPassword(),
                SizedBox(height: 25,),
                buildLoginButton(),
                SizedBox(height: 35,),
                buildSignUpText()

              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return FadeTransition(
      opacity: _logoFade,
      child: ScaleTransition(
        scale: _logoScale,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: Icon(Icons.auto_awesome, size: 45, color: Color(0xFFCDB4E8)),
        ),
      ),
    );
  }

  Widget buildBrandName() {
    return FadeTransition(
      opacity: _titleFade,
      child: SlideTransition(
        position: _titleSlide,
        child: Text(
          'SMTECHVIRAL',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 6,
          ),
        ),
      ),
    );
  }

  Widget buildWelcomeText() {
    return FadeTransition(
      opacity: _welcomeFade,
      child: SlideTransition(
        position: _welcomeSlide,
        child: Text(
          'Welcome Back, Rahul',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildEmailField() {
    return FadeTransition(
      opacity: _emailFade,
      child: SlideTransition(
        position: _emailSlide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 8),
              child: Text(
                'Email address',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return FadeTransition(
      opacity: _passwordFade,
      child: SlideTransition(
        position: _passwordSlide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 8),
              child: Text(
                'Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(0xFFCDB4E8),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildForgetPassword() {
    return FadeTransition(
      opacity: _forgetFade,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Text(
            'Forget Password ?',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return FadeTransition(
      opacity: _buttonFade,
      child: ScaleTransition(
        scale: _buttonScale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {},
                  splashColor: Colors.white.withOpacity(0.2),
                  highlightColor: Colors.white.withOpacity(0.1),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
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

  Widget buildSignUpText() {
    return FadeTransition(
      opacity: _signupFade,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Are You New Member ? ',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign UP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
