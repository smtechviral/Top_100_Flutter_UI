import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlassApp extends StatelessWidget {
  const LiquidGlassApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liquid Glass UI',
      theme: ThemeData.dark(),
      home: const LiquidGlassHome(),
    );
  }
}

class LiquidGlassHome extends StatefulWidget {
  const LiquidGlassHome({Key? key}) : super(key: key);

  @override
  State<LiquidGlassHome> createState() => _LiquidGlassHomeState();
}

class _LiquidGlassHomeState extends State<LiquidGlassHome>
    with TickerProviderStateMixin {
  late AnimationController bubbleController;
  late AnimationController waveController;
  late AnimationController _cardController;
  late AnimationController fadeController;
  int selectedIndex = 0;
  bool isDarkMode = true;

  @override
  void initState() {
    super.initState();
    bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    bubbleController.dispose();
    waveController.dispose();
    _cardController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    fadeController.reset();
    fadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.transparent,
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.transparent,
            ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [

            buildGradiant(),
            buildBubble(),
            SafeArea(
              child: FadeTransition(
                opacity: fadeController,
                child: Column(
                  children: [
                    buildHeader(),
                    Expanded(child: buildContent()),
                    buildBottomNav()

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  buildGradiant() {
    return AnimatedGradientBackground(
      controller: waveController,
      isDarkMode: isDarkMode,
    );
  }

  buildBubble() {
    return AnimatedBubbles(
      controller: bubbleController,
      isDarkMode: isDarkMode,
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .animate(
          CurvedAnimation(
            parent: _cardController,
            curve: Curves.elasticOut,
          ),
        ),
        child: GlassContainer(
          isDarkMode: isDarkMode,
          child: Row(
            children: [
              buildImage(),
              SizedBox(width: 15,),
              buildTitle(),
              buildNotification(),
              SizedBox(width: 10,),
              buildDark()
            ],
          ),
        ),
      ),
    );
  }


  buildImage() {
    return Hero(
      tag: 'profile',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
        ),
        child: const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
      ),
    );
  }

  buildTitle() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back! 👋',
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black.withOpacity(0.6),
            ),
          ),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  buildNotification() {
    return LiquidButton(
      icon: Icons.notifications_outlined,
      isDarkMode: isDarkMode,
      onTap: () {},
    );
  }

  buildDark() {
    return LiquidButton(
      icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
      isDarkMode: isDarkMode,
      onTap: toggleTheme,
    );
  }

  Widget buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 20,),
          buildStatsCards(),
          SizedBox(height: 30,),
          buildQuickActions(),
          SizedBox(height: 30,),
          buildActivitySection(),
          SizedBox(height: 100,)
        ],
      ),
    );
  }

  Widget buildStatsCards() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          final colors = [
            [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
            [const Color(0xFFEC4899), const Color(0xFFF43F5E)],
            [const Color(0xFF10B981), const Color(0xFF06B6D4)],
          ];
          final icons = [Icons.trending_up, Icons.analytics, Icons.star];
          final titles = ['Revenue', 'Analytics', 'Rating'];
          final values = ['\$24.5k', '12.4k', '4.8'];

          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: Offset(1 + (index * 0.2), 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _cardController,
                    curve: Interval(
                      index * 0.2,
                      0.6 + (index * 0.2),
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                ),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: StatCard(
                  gradient: colors[index],
                  icon: icons[index],
                  title: titles[index],
                  value: values[index],
                  isDarkMode: isDarkMode,
                  index: index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: _cardController,
                    curve: const Interval(0.4, 0.7, curve: Curves.elasticOut),
                  ),
                ),
                child: QuickActionButton(
                  icon: Icons.send_rounded,
                  label: 'Send',
                  gradient: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: _cardController,
                    curve: const Interval(0.5, 0.8, curve: Curves.elasticOut),
                  ),
                ),
                child: QuickActionButton(
                  icon: Icons.qr_code_scanner,
                  label: 'Scan',
                  gradient: const [Color(0xFFEC4899), Color(0xFFF43F5E)],
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: _cardController,
                    curve: const Interval(0.6, 0.9, curve: Curves.elasticOut),
                  ),
                ),
                child: QuickActionButton(
                  icon: Icons.account_balance_wallet,
                  label: 'Wallet',
                  gradient: const [Color(0xFF10B981), Color(0xFF06B6D4)],
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        ...List.generate(4, (index) {
          final icons = [
            Icons.shopping_bag,
            Icons.restaurant,
            Icons.local_gas_station,
            Icons.movie,
          ];
          final titles = [
            'Shopping',
            'Food & Dining',
            'Transport',
            'Entertainment',
          ];
          final amounts = ['-\$124', '-\$45', '-\$30', '-\$89'];
          final times = ['2h ago', '5h ago', '1d ago', '2d ago'];

          // Calculate interval values ensuring they don't exceed 1.0
          final start = (0.5 + (index * 0.1)).clamp(0.0, 1.0);
          final end = (0.8 + (index * 0.1)).clamp(0.0, 1.0);

          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(
                  CurvedAnimation(
                    parent: _cardController,
                    curve: Interval(start, end, curve: Curves.easeOutCubic),
                  ),
                ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _cardController,
                  curve: Interval(start, end, curve: Curves.easeOutCubic),
                ),
              ),
              child: ActivityItem(
                icon: icons[index],
                title: titles[index],
                amount: amounts[index],
                time: times[index],
                isDarkMode: isDarkMode,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _cardController,
                curve: const Interval(0.7, 1.0, curve: Curves.elasticOut),
              ),
            ),
        child: GlassContainer(
          height: 80,
          isDarkMode: isDarkMode,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home_rounded, 0),
              buildNavItem(Icons.explore_rounded, 1),
              buildNavItem(Icons.favorite_rounded, 2),
              buildNavItem(Icons.person_rounded, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                )
              : null,
          borderRadius: BorderRadius.circular(15),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: isDarkMode
              ? (isSelected ? Colors.white : Colors.white.withOpacity(0.7))
              : (isSelected ? Colors.white : Colors.black54),
          size: isSelected ? 28 : 24,
        ),
      ),
    );
  }
}

// Glass Container Widget
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final bool isDarkMode;

  const GlassContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ]
                  : [
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.5),
                    ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : Colors.white.withOpacity(0.4),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// Liquid Button with Ripple Effect
class LiquidButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDarkMode;

  const LiquidButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<LiquidButton> createState() => _LiquidButtonState();
}

class _LiquidButtonState extends State<LiquidButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Ripple Effect
              if (_rippleAnimation.value > 0)
                Container(
                  width: 50 + (_rippleAnimation.value * 20),
                  height: 50 + (_rippleAnimation.value * 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: (widget.isDarkMode ? Colors.white : Colors.blue)
                          .withOpacity(0.3 * (1 - _rippleAnimation.value)),
                      width: 2,
                    ),
                  ),
                ),
              // Main Button
              Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: widget.isDarkMode
                          ? [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.1),
                            ]
                          : [
                              Colors.white.withOpacity(0.8),
                              Colors.white.withOpacity(0.6),
                            ],
                    ),
                    border: Border.all(
                      color: widget.isDarkMode
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white.withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (widget.isDarkMode ? Colors.white : Colors.blue)
                            .withOpacity(0.2 * _rippleAnimation.value),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Stat Card with Floating Animation
class StatCard extends StatefulWidget {
  final List<Color> gradient;
  final IconData icon;
  final String title;
  final String value;
  final bool isDarkMode;
  final int index;

  const StatCard({
    Key? key,
    required this.gradient,
    required this.icon,
    required this.title,
    required this.value,
    required this.isDarkMode,
    required this.index,
  }) : super(key: key);

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000 + (widget.index * 300)),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: GlassContainer(
            width: 160,
            isDarkMode: widget.isDarkMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: widget.gradient),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: widget.gradient[0].withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(widget.icon, color: Colors.white, size: 28),
                      ),
                    );
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1200),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Text(
                            widget.value,
                            style: TextStyle(
                              color: widget.isDarkMode
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Quick Action Button with Bounce
class QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<Color> gradient;
  final VoidCallback onTap;
  final bool isDarkMode;

  const QuickActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.gradient,
    required this.onTap,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _bounceController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _bounceController.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _bounceController.reverse();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: GlassContainer(
          isDarkMode: widget.isDarkMode,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: widget.gradient),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: _isPressed
                      ? [
                          BoxShadow(
                            color: widget.gradient[0].withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: widget.gradient[0].withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                ),
                child: Icon(widget.icon, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Activity Item with Slide Animation
class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final String time;
  final bool isDarkMode;

  const ActivityItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.time,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GlassContainer(
        isDarkMode: isDarkMode,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isDarkMode ? Colors.white : Colors.black87,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black.withOpacity(0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Animated Gradient Background
class AnimatedGradientBackground extends StatelessWidget {
  final AnimationController controller;
  final bool isDarkMode;

  const AnimatedGradientBackground({
    Key? key,
    required this.controller,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      Color.lerp(
                        const Color(0xFF1a1a2e),
                        const Color(0xFF16213e),
                        controller.value,
                      )!,
                      Color.lerp(
                        const Color(0xFF0f3460),
                        const Color(0xFF533483),
                        controller.value,
                      )!,
                    ]
                  : [
                      Color.lerp(
                        const Color(0xFFE3F2FD),
                        const Color(0xFFBBDEFB),
                        controller.value,
                      )!,
                      Color.lerp(
                        const Color(0xFFF3E5F5),
                        const Color(0xFFE1BEE7),
                        controller.value,
                      )!,
                    ],
            ),
          ),
        );
      },
    );
  }
}

// Animated Bubbles
class AnimatedBubbles extends StatelessWidget {
  final AnimationController controller;
  final bool isDarkMode;

  const AnimatedBubbles({
    Key? key,
    required this.controller,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: List.generate(5, (index) {
            final offset = (controller.value + (index * 0.2)) % 1.0;
            return Positioned(
              left: 50.0 + (index * 80),
              top: MediaQuery.of(context).size.height * (offset % 1.0),
              child: Container(
                width: 60 + (index * 20.0),
                height: 60 + (index * 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.white.withOpacity(0.1), Colors.transparent],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
