import 'package:day_challenge_100/widgets/divider_with_text.dart';
import 'package:day_challenge_100/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/login_card.dart';
import '../widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40,),
                      LoginHeader(),
                      SizedBox(height: 40,),
                      LoginCard(),
                      SizedBox(),
                      DividerWithText(text: "Login With",),
                      SizedBox(height: 40,),
                      SocialLoginButtons()
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
