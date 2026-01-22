import 'package:flutter/material.dart';

class FurnitureOnboardingScreen extends StatelessWidget {
  const FurnitureOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top left decorative circle
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(150, 150), // 👈 perfect oval
                ),
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
            ),
          ),

          // Bottom right decorative circle
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .5),
              ),
            ),
          ),

          // Left side image circle
          Positioned(
            left: -40,
            bottom: 350,
            child: Transform.rotate(
              angle: -0.30,
              // 👈 radians (negative = left tilt, positive = right tilt)
              child: Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(90, 130)),
                  border: Border.all(color: Colors.white, width: 3),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://i.pinimg.com/736x/57/a8/e2/57a8e2a6ac705cd9d76e04a173ea02c2.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Right side image circle
          Positioned(
            right: -40,
            top: 120,
            child: Transform.rotate(
              angle: 0.30,
              child: Container(
                height: 130,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(90, 120)),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://i.pinimg.com/736x/d8/0e/0d/d80e0d13c031bc3a8312ad882d471721.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Center oval container with main image and arrow button
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                /// ===== OVAL IMAGE WITH RIGHT BORDER EFFECT =====
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 👉 Right-side border oval (shifted)
                    Positioned(
                      left: 8,
                      bottom: 0,
                      child: Container(
                        width: 315,
                        height: 405,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.elliptical(320, 420),
                          ),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    // 👉 Main image oval
                    Container(
                      width: 310,
                      height: 400,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(320, 420),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://i.pinimg.com/736x/2a/dc/af/2adcaf9c49de5bc43805af6387030b3a.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // 👉 Arrow button
                    Positioned(
                      bottom: 20,
                      right: 15,
                      child: Transform.rotate(
                        angle: -0.7,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A6B6B),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                /// ===== TITLE =====
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'The Furniture App That\nElevates Your Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                      height: 1.3,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ===== DESCRIPTION =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor incididunt',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// ===== CTA BUTTON =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3C5A5D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Let\'s Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ===== SIGN IN =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF3C5A5D),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
