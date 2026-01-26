import 'package:flutter/material.dart';
import 'dart:math' as math;


class RepublicDayHome extends StatefulWidget {
  const RepublicDayHome({Key? key}) : super(key: key);

  @override
  State<RepublicDayHome> createState() => _RepublicDayHomeState();
}

class _RepublicDayHomeState extends State<RepublicDayHome>
    with TickerProviderStateMixin {
  late AnimationController _flagController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _rotateController;

  late Animation<double> _flagAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  bool _showConfetti = false;
  int _likeCount = 1947;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();

    _flagController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _flagAnimation = Tween<double>(begin: -0.02, end: 0.02).animate(
      CurvedAnimation(parent: _flagController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.elasticOut));

    _slideController.forward();
  }

  @override
  void dispose() {
    _flagController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likeCount++;
        _showConfetti = true;
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _showConfetti = false);
          }
        });
      } else {
        _likeCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildGradientBackground(),
          buildAnimatedCircles(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  buildAnimatedHeader(),
                  SizedBox(height: 30,),
                  buildHeroCard(),
                  SizedBox(height: 30,),
                  buildInteractiveStats(),
                  SizedBox(height: 30,),
                  build3DCards(),
                  SizedBox(height: 30,),
                  buildFloatingTimeline(),
                  SizedBox(height: 30,),
                  buildQuoteSection(),
                  SizedBox(height: 30,),
                  buildLikeButton(),
                  SizedBox(height: 50,)

                ],
              ),
            ),
          ),
          if (_showConfetti) buildConfetti(),
        ],
      ),
    );
  }

  Widget buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF9933),
            Color(0xFFFFBF80),
            Colors.white,
            Color(0xFF90EE90),
            Color(0xFF138808),
          ],
          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        ),
      ),
    );
  }

  Widget buildAnimatedCircles() {
    return AnimatedBuilder(
      animation: _rotateController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: 100,
              right: -50,
              child: Transform.rotate(
                angle: _rotateController.value * 2 * math.pi,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFFF9933).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              left: -30,
              child: Transform.rotate(
                angle: -_rotateController.value * 2 * math.pi,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFF138808).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildAnimatedHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFFFF9933), Color(0xFF138808)],
            ).createShader(bounds),
            child: Text(
              '🇮🇳 REPUBLIC DAY 🇮🇳',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9933), Color(0xFFFF6600)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '26 JANUARY 2026',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeroCard() {
    return AnimatedBuilder(
      animation: _flagAnimation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_flagAnimation.value),
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF9933).withOpacity(0.5),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF9933), Color(0xFFFF7700)],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF138808), Color(0xFF0A5504)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF000080),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: AshokaChakrePainter(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '77 YEARS',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFFF9933),
                              ),
                            ),
                            Text(
                              'Of Democracy & Freedom',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInteractiveStats() {
    final stats = [
      {'num': '2.5', 'label': 'Hours', 'icon': '⏱️', 'color': Color(0xFFFF9933)},
      {'num': '21', 'label': 'Gun Salute', 'icon': '🎖️', 'color': Color(0xFF138808)},
      {'num': '1950', 'label': 'Est. Year', 'icon': '📜', 'color': Color(0xFF000080)},
      {'num': '448', 'label': 'Articles', 'icon': '📚', 'color': Color(0xFFFF6600)},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: stats.map((stat) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${stat['label']}: ${stat['num']}'),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (stat['color'] as Color).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      stat['icon'] as String,
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stat['num'] as String,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: stat['color'] as Color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stat['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget build3DCards() {
    final facts = [
      {
        'icon': '🏛️',
        'title': 'Dr. B.R. Ambedkar',
        'subtitle': 'Architect of Indian Constitution',
        'color': Color(0xFFFF9933),
      },
      {
        'icon': '🇮🇳',
        'title': '26 January 1950',
        'subtitle': 'India Became a Republic',
        'color': Color(0xFF138808),
      },
      {
        'icon': '🪖',
        'title': 'Indian Armed Forces',
        'subtitle': 'Symbol of Courage & Discipline',
        'color': Color(0xFF000080),
      },
      {
        'icon': '🎺',
        'title': 'Republic Day Parade',
        'subtitle': 'Unity in Diversity',
        'color': Color(0xFFFF6600),
      },
    ];


    return Column(
      children: facts.asMap().entries.map((entry) {
        final index = entry.key;
        final fact = entry.value;
        final isEven = index % 2 == 0;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 600 + (index * 100)),
          tween: Tween(begin: 0.5, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(isEven ? -(1 - value) * 100 : (1 - value) * 100, 0),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  margin: EdgeInsets.only(
                    left: isEven ? 20 : 60,
                    right: isEven ? 60 : 20,
                    bottom: 20,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        (fact['color'] as Color).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: (fact['color'] as Color).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: fact['color'] as Color,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            fact['icon'] as String,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fact['title'] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: fact['color'] as Color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              fact['subtitle'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget buildFloatingTimeline() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.9),
            Color(0xFFFF9933).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFF9933).withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '⏳ Journey to Republic',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF138808),
            ),
          ),
          const SizedBox(height: 25),
          _buildTimelineItem('1947', 'Independence from British Rule', '🇮🇳'),
          _buildTimelineItem('1949', 'Constitution Adopted (26 Nov)', '📜'),
          _buildTimelineItem('1950', 'Constitution in Effect (26 Jan)', '⚖️'),
          _buildTimelineItem('2026', '76th Republic Day Celebration', '🎉'),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String year, String event, String emoji) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9933), Color(0xFFFF6600)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF9933).withOpacity(0.5),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF138808),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuoteSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF9933),
            Color(0xFFFFBF80),
            Colors.white,
            Color(0xFF90EE90),
            Color(0xFF138808),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF138808).withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '💬',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 15),
          Text(
            '"They may kill me, but they cannot kill my ideas."',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            '- Bhagat Singh',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLikeButton() {
    return GestureDetector(
      onTap: _handleLike,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.elasticOut,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isLiked
                ? [Color(0xFFFF9933), Color(0xFFFF6600)]
                : [Colors.white, Colors.grey[200]!],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: _isLiked
                  ? Color(0xFFFF9933).withOpacity(0.5)
                  : Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(_isLiked),
                color: _isLiked ? Colors.white : Color(0xFFFF9933),
                size: 32,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isLiked ? 'Thank You!' : 'Celebrate Republic Day',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isLiked ? Colors.white : Color(0xFF138808),
                  ),
                ),
                Text(
                  '$_likeCount patriots celebrated',
                  style: TextStyle(
                    fontSize: 12,
                    color: _isLiked
                        ? Colors.white.withOpacity(0.9)
                        : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildConfetti() {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: ConfettiPainter(),
        ),
      ),
    );
  }
}

class AshokaChakrePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;

    canvas.drawCircle(center, radius, paint);

    for (int i = 0; i < 24; i++) {
      final angle = (i * 15) * math.pi / 180;
      final x1 = center.dx + radius * math.cos(angle);
      final y1 = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x1, y1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [Color(0xFFFF9933), Colors.white, Color(0xFF138808)];
    final random = math.Random(42);

    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final color = colors[random.nextInt(colors.length)];

      final paint = Paint()..color = color.withOpacity(0.8);
      canvas.drawCircle(Offset(x, y), 5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}