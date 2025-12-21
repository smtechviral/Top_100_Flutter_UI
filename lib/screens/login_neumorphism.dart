import 'package:flutter/material.dart';

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF222224),
      ),
      home: const MusicPlayerScreen(),
    );
  }
}

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    // 13 widgets ke liye animation controllers
    final int widgetCount = 13;
    _controllers = List.generate(
      widgetCount,
          (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
    }).toList();

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
    }).toList();

    // Sequential animation start
    _startSequentialAnimation();
  }

  void _startSequentialAnimation() async {
    // Har widget 500ms ke baad appear hoga (total ~6-7 seconds for all widgets)
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        _controllers[i].forward();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget animatedWidget(int index, Widget child) {
    return FadeTransition(
      opacity: _fadeAnimations[index],
      child: SlideTransition(
        position: _slideAnimations[index],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Upper Section Components (0-5)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF222224),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      animatedWidget(0, const HeaderSection()),
                      const SizedBox(height: 15),
                      animatedWidget(1, const SignInTextWidget()),
                      const SizedBox(height: 35),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            animatedWidget(2, const AlbumArtSection()),
                            const SizedBox(width: 30),
                            Expanded(
                              child: Column(
                                children: [
                                  animatedWidget(3, const SongTileWidget(
                                    title: 'Mockingbird',
                                    artist: 'Eminem',
                                    isPaused: true,
                                  )),
                                  const SizedBox(height: 18),
                                  animatedWidget(4, const SongTileWidget(
                                    title: 'Let Me Know',
                                    artist: 'Jimmy Brown',
                                    isPaused: false,
                                  )),
                                  const SizedBox(height: 18),
                                  animatedWidget(5, const SongTileWidget(
                                    title: 'Strong Terus',
                                    artist: 'Monqkey Boots',
                                    isPaused: false,
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),

                // Lower Section Components (6-12)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8a8a8a),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // 6-9. Music Controls Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          animatedWidget(6, const ControlButton(icon: Icons.volume_up, size: 34)),
                          const SizedBox(width: 55),
                          animatedWidget(7, const MainControlButton()),
                          const SizedBox(width: 55),
                          animatedWidget(8, const ControlButton(icon: Icons.headset, size: 34)),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // 9-10. Login Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: animatedWidget(9, const SideArchiveLabel()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              width: 380,
                              child: animatedWidget(10, LoginBoxWidget(
                                emailController: TextEditingController(),
                                passwordController: TextEditingController(),
                              )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      // 11. Forgot Password
                      animatedWidget(11, const ForgotPasswordLink()),
                      const SizedBox(height: 12),
                      // 12. Sign Up Link
                      animatedWidget(12, const SignUpLink()),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 2. Header Section Widget
class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TitleWidget(),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: TapToPlayWidget(),
          ),
        ],
      ),
    );
  }
}

// 3. Title Widget
class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Text(
          'Most Popular',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'playlist today',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

// 4. Tap To Play Widget
class TapToPlayWidget extends StatelessWidget {
  const TapToPlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.03),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Text(
        'tap to play',
        style: TextStyle(
          color: Colors.white60,
          fontSize: 13,
        ),
      ),
    );
  }
}

// 5. Sign In Text Widget
class SignInTextWidget extends StatelessWidget {
  const SignInTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'sign in to find more experience',
        style: TextStyle(
          color: Colors.white38,
          fontSize: 15,
        ),
      ),
    );
  }
}

// 7. Album Art Section Widget
class AlbumArtSection extends StatelessWidget {
  const AlbumArtSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 155,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1a1a1a),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.25),
            offset: const Offset(8, 8),
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            offset: const Offset(-8, -8),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 135,
          height: 135,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLkmsbtwxrFjveE5Fo7gsAGmUXlymSz0zl3Q&s",
              ),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 10,
                spreadRadius: -2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 9. Song Tile Widget
class SongTileWidget extends StatelessWidget {
  final String title;
  final String artist;
  final bool isPaused;

  const SongTileWidget({
    Key? key,
    required this.title,
    required this.artist,
    required this.isPaused,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(6, 8),
            blurRadius: 14,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            offset: const Offset(-3, -3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  artist,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          PlayButtonWidget(isPaused: isPaused),
        ],
      ),
    );
  }
}

// 10. Play Button Widget
class PlayButtonWidget extends StatelessWidget {
  final bool isPaused;

  const PlayButtonWidget({Key? key, required this.isPaused}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1a1a1a),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.03),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(
        isPaused ? Icons.pause : Icons.play_arrow,
        color: Colors.white54,
        size: 26,
      ),
    );
  }
}

// 13. Control Button Widget
class ControlButton extends StatelessWidget {
  final IconData icon;
  final double size;

  const ControlButton({
    Key? key,
    required this.icon,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF8a8a8a),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            offset: const Offset(-6, -6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: const Color(0xFF2a2a2a),
        size: size,
      ),
    );
  }
}

// 14. Main Control Button Widget
class MainControlButton extends StatelessWidget {
  const MainControlButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF8a8a8a),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
        ],
      ),
      child: const Icon(
        Icons.music_note,
        color: Color(0xFF2a2a2a),
        size: 50,
      ),
    );
  }
}

// 15. Login Box Widget
class LoginBoxWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginBoxWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a3a),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(12, 12),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          InputFieldWidget(
            controller: emailController,
            hintText: 'Email',
          ),
          const SizedBox(height: 22),
          InputFieldWidget(
            controller: passwordController,
            hintText: 'Password',
            isPassword: true,
          ),
        ],
      ),
    );
  }
}

// 16. Input Field Widget
class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  const InputFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            offset: const Offset(3, 3),
            blurRadius: 2,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.02),
            offset: const Offset(-6, -6),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white24,
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}

// 17. Forgot Password Link Widget
class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'forgot password',
      style: TextStyle(
        color: Color(0xFF2a2a2a),
        fontSize: 15,
        decoration: TextDecoration.underline,
        decorationColor: Color(0xFF2a2a2a),
      ),
    );
  }
}

// 18. Sign Up Link Widget
class SignUpLink extends StatelessWidget {
  const SignUpLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "don't have an account? ",
          style: TextStyle(
            color: Color(0xFF2a2a2a),
            fontSize: 15,
          ),
        ),
        Text(
          'sign up',
          style: TextStyle(
            color: Color(0xFF2a2a2a),
            fontSize: 15,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFF2a2a2a),
          ),
        ),
      ],
    );
  }
}

// 19. Side Archive Label Widget
class SideArchiveLabel extends StatelessWidget {
  const SideArchiveLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(60),
      ),
      child: const RotatedBox(
        quarterTurns: 3,
        child: Text(
          'Archived by Hitzall',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}