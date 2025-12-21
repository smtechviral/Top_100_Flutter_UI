import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';


class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with TickerProviderStateMixin {
  late AnimationController backgroundController;
  late AnimationController _cardController;
  late PageController _pageController;
  double currentPage = 1.0;
  int selectedPlan = 1;

  final List<PlanModel> plans = [
    PlanModel(
      name: 'Basic',
      price: '₹199',
      duration: '/month',
      features: [
        'HD Quality',
        '1 Device',
        'Limited Downloads',
        'Basic Support',
      ],
      color: Colors.blue,
      icon: Icons.smartphone,
    ),
    PlanModel(
      name: 'Premium',
      price: '₹499',
      duration: '/month',
      features: [
        '4K Ultra HD',
        '4 Devices',
        'Unlimited Downloads',
        'Priority Support',
        'Ad-Free Experience',
      ],
      color: Colors.purple,
      icon: Icons.star,
      isPopular: true,
    ),
    PlanModel(
      name: 'Family',
      price: '₹799',
      duration: '/month',
      features: [
        '4K Ultra HD',
        '6 Devices',
        'Unlimited Downloads',
        '24/7 Premium Support',
        'Ad-Free Experience',
        'Family Sharing',
      ],
      color: Colors.pink,
      icon: Icons.family_restroom,
    ),
  ];

  @override
  void initState() {
    super.initState();
    backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.8,
    );

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 1.0;
      });
    });

    _cardController.forward();
  }

  @override
  void dispose() {
    backgroundController.dispose();
    _cardController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedGradientBackground(controller: backgroundController),
          SafeArea(
            child: Column(
              children: [

                SizedBox(height: 5,),
                header(),
                SizedBox(height: 30,),
                pageIndicator(),
                SizedBox(height: 20,),
                pageView(),
                SizedBox(height: 20,),
                successDialog(),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ],
      ),
    );
  }
















  pageIndicator(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        plans.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentPage.round() == index ? 24 : 8,
          decoration: BoxDecoration(
            color: currentPage.round() == index
                ? plans[index].color
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }


  pageView(){
    return  Expanded(
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedPlan = index;
          });
          _cardController.reset();
          _cardController.forward();
        },
        itemCount: plans.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
              }

              return Center(
                child: SizedBox(
                  height: Curves.easeInOut.transform(value) * 500,
                  child: child,
                ),
              );
            },
            child: buildPlanCard(index),
          );
        },
      ),
    );
  }

  successDialog(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GlassmorphicButton(
        onTap: () => showSuccessDialog(context),
      ),
    );
  }

  header(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GlassmorphicHeader(),
    );
  }

  Widget buildPlanCard(int index) {
    bool isCenter = currentPage.round() == index;

    return AnimatedBuilder(
      animation: _cardController,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: SubscriptionCard(
            plan: plans[index],
            isSelected: isCenter,
            animation: _cardController,
          ),
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SuccessDialog(plan: plans[selectedPlan]),
    );
  }
}

// Custom Class: Plan Model
class PlanModel {
  final String name;
  final String price;
  final String duration;
  final List<String> features;
  final Color color;
  final IconData icon;
  final bool isPopular;

  PlanModel({
    required this.name,
    required this.price,
    required this.duration,
    required this.features,
    required this.color,
    required this.icon,
    this.isPopular = false,
  });
}

// Custom Class: Animated Gradient Background
class AnimatedGradientBackground extends StatelessWidget {
  final AnimationController controller;

  const AnimatedGradientBackground({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                math.cos(controller.value * 2 * math.pi) * 0.5,
                math.sin(controller.value * 2 * math.pi) * 0.5,
              ),
              end: Alignment(
                -math.cos(controller.value * 2 * math.pi) * 0.5,
                -math.sin(controller.value * 2 * math.pi) * 0.5,
              ),
              colors: const [
                Color(0xFF1a1a2e),
                Color(0xFF16213e),
                Color(0xFF0f3460),
                Color(0xFF1a1a2e),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Custom Class: Glassmorphic Header
class GlassmorphicHeader extends StatelessWidget {
  const GlassmorphicHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.workspace_premium,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              const Text(
                'Choose Your Plan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Swipe to explore plans',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Class: Subscription Card
class SubscriptionCard extends StatelessWidget {
  final PlanModel plan;
  final bool isSelected;
  final Animation<double> animation;

  const SubscriptionCard({
    Key? key,
    required this.plan,
    required this.isSelected,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Glow Effect
          if (isSelected)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: plan.color.withOpacity(0.6),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),

          // Main Card
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isSelected
                        ? [
                      plan.color.withOpacity(0.35),
                      plan.color.withOpacity(0.2),
                    ]
                        : [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.04),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected
                        ? plan.color.withOpacity(0.6)
                        : Colors.white.withOpacity(0.15),
                    width: isSelected ? 2.5 : 1.5,
                  ),
                ),
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon and Name
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: plan.color.withOpacity(0.35),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              plan.icon,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plan.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (plan.isPopular)
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.amber,
                                          Colors.orange,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'MOST POPULAR',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.price,
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              plan.duration,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Divider
                      Container(
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

                      const SizedBox(height: 25),

                      // Features
                      ...List.generate(
                        plan.features.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-0.5, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Interval(
                                  index * 0.1,
                                  0.5 + index * 0.1,
                                  curve: Curves.easeOut,
                                ),
                              ),
                            ),
                            child: FadeTransition(
                              opacity: animation,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: plan.color,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      plan.features[index],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Selected Indicator
          if (isSelected)
            Positioned(
              top: -10,
              right: 20,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.elasticOut,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: plan.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: plan.color.withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Custom Class: Glassmorphic Button
class GlassmorphicButton extends StatefulWidget {
  final VoidCallback onTap;

  const GlassmorphicButton({Key? key, required this.onTap}) : super(key: key);

  @override
  State<GlassmorphicButton> createState() => _GlassmorphicButtonState();
}

class _GlassmorphicButtonState extends State<GlassmorphicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.6),
                    Colors.pink.withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Subscribe Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
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

// Custom Class: Success Dialog
class SuccessDialog extends StatefulWidget {
  final PlanModel plan;

  const SuccessDialog({Key? key, required this.plan}) : super(key: key);

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _controller,
                    curve: Curves.elasticOut,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                FadeTransition(
                  opacity: _controller,
                  child: Column(
                    children: [
                      const Text(
                        'Subscription Successful!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'You have successfully subscribed to ${widget.plan.name} plan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.plan.color,
                                widget.plan.color.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
