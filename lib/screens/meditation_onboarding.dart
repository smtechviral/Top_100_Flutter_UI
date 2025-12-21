import 'package:day_challenge_100/screens/demo.dart';
import 'package:day_challenge_100/widgets/appColor.dart';
import 'package:day_challenge_100/widgets/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<OnboardingData> pages = [
    OnboardingData(
      animationPath: 'assets/json/m1.json',
      title: AppStrings.title1,
      description: AppStrings.des1,
    ),
    OnboardingData(
      animationPath: 'assets/json/m2.json',
      title: AppStrings.title2,
      description: AppStrings.des2,
    ),
    OnboardingData(
      animationPath: 'assets/json/m3.json',
      title: AppStrings.title3,
      description: AppStrings.des3,
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [

                SizedBox(height: 5,),
                buildSkip(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildDot(),
                    SizedBox(width: 8,),
                    buildDot(),
                    SizedBox(width: 8,),
                    buildDot(),
                    SizedBox(width: 12,),
                    Text("ONBOARDING",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: 2
                    ),),
                    SizedBox(width: 12,),
                    buildDot(),
                    SizedBox(width: 8,),
                    buildDot(),
                    SizedBox(width: 8,),
                    buildDot(),
                  ],
                ),

                SizedBox(height: 20,),
                buildSubtitle(),
                SizedBox(height: 30,),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: pages.length,
                    onPageChanged: (index){
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                    return buildPage(pages[index]);
                  },),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  buildSubtitle(){
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        AppStrings.appDes,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  buildSkip(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: GlassContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'SKIP',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPage(OnboardingData data) {
    final bool isLastPage = currentPage == pages.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          // Animation Container with modern styling
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Lottie.asset(
                data.animationPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 15),
          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 40),
          // Page Indicator Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
                  (index) => buildPageIndicator(index == currentPage),
            ),
          ),
          const Spacer(),
          // Single Button with condition
          CustomButton(
            text: isLastPage ? "GET STARTED" : "NEXT",
            onPressed: () {
              if (!isLastPage) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                _navigateToHome();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1E9DD0) : const Color(0xFFB0D4E3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingData {
  final String animationPath;
  final String title;
  final String description;

  OnboardingData({
    required this.animationPath,
    required this.title,
    required this.description,
  });
}