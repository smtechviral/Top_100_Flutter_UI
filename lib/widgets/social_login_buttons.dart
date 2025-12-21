import 'package:flutter/material.dart';
import 'social_login_button.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginButton(
          icon: Icons.facebook,
          color: const Color(0xFF1877F2),
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        SocialLoginButton(
          icon: Icons.g_mobiledata,
          color: const Color(0xFFDB4437),
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        SocialLoginButton(
          icon: Icons.apple,
          color: Colors.black,
          onPressed: () {},
        ),
      ],
    );
  }
}