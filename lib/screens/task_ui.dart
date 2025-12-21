import 'package:flutter/material.dart';
import 'dart:ui';


class SleepTrackerHome extends StatefulWidget {
  const SleepTrackerHome({Key? key}) : super(key: key);

  @override
  State<SleepTrackerHome> createState() => _SleepTrackerHomeState();
}

class _SleepTrackerHomeState extends State<SleepTrackerHome> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int _selectedDayIndex = 5; // Saturday is selected by default
  bool isCalendarOpen = false;
  late AnimationController _calendarController;
  late Animation<double> _calendarAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    _calendarController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _calendarAnimation = CurvedAnimation(
      parent: _calendarController,
      curve: Curves.easeOutCubic,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _calendarController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void toggleCalendar() {
    setState(() {
      isCalendarOpen = !isCalendarOpen;
      if (isCalendarOpen) {
        _calendarController.forward();
      } else {
        _calendarController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F18),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0E0F18),
                  const Color(0xFF1A1C29),
                  const Color(0xFF0E0F18),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30,),
                            buildSleepBubble(),
                            SizedBox(height: 35,),
                            buildWeeklyProgress(),
                            SizedBox(height: 30,),
                            buildRecommendationCard(),
                            SizedBox(height: 30,),
                            buildDailyTasks(),
                            SizedBox(height: 100,)
                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          // Calendar Overlay
          if(isCalendarOpen)
            GestureDetector(
              onTap: toggleCalendar,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Container(
                  color: Colors.black.withOpacity(.6),
                ),
              ),
            ),

          buildAnimatedCalendar()
        ],
      ),
      extendBody: true,
      bottomNavigationBar: buildBottomNav(),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good evening',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.95),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Wednesday, 22 Aug',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: toggleCalendar,
                child: _buildGlassButton(Icons.calendar_today_outlined),
              ),
              const SizedBox(width: 12),
              _buildProfileAvatar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedCalendar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(_calendarAnimation),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF2A2D3A).withOpacity(0.95),
                      const Color(0xFF1A1C29).withOpacity(0.95),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 40,
                      spreadRadius: 0,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'August 2024',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.95),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.chevron_right,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Week days header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                              .map((day) => SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.4),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        // Calendar grid
                        ..._buildCalendarWeeks(),
                      ],
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

  List<Widget> _buildCalendarWeeks() {
    // Sample calendar data for August 2024
    final weeks = [
      [0, 0, 0, 0, 1, 2, 3],
      [4, 5, 6, 7, 8, 9, 10],
      [11, 12, 13, 14, 15, 16, 17],
      [18, 19, 20, 21, 22, 23, 24],
      [25, 26, 27, 28, 29, 30, 31],
    ];

    return weeks.map((week) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: week.map((day) {
            if (day == 0) {
              return SizedBox(width: 40, height: 40);
            }
            final isSelected = day == 22;
            return GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? const Color(0xFF8B7FFF).withOpacity(0.3)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF8B7FFF)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(isSelected ? 1.0 : 0.7),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  Widget _buildGlassButton(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isCalendarOpen
            ? const Color(0xFF8B7FFF).withOpacity(0.2)
            : Colors.white.withOpacity(0.05),
        border: Border.all(
          color: isCalendarOpen
              ? const Color(0xFF8B7FFF).withOpacity(0.5)
              : Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Icon(
            icon,
            color: isCalendarOpen
                ? const Color(0xFFA599FF)
                : Colors.white.withOpacity(0.7),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF8B7FFF).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B7FFF).withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          color: const Color(0xFF2A2D3A),
          child: Icon(
            Icons.person,
            color: Colors.white.withOpacity(0.7),
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget buildSleepBubble() {
    return Center(
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFF4A4E6B).withOpacity(0.4),
              const Color(0xFF2A2D3A).withOpacity(0.2),
              Colors.transparent,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A4E6B).withOpacity(0.3),
              blurRadius: 60,
              spreadRadius: -10,
            ),
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                  width: 1,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Image.asset("assets/images/night.png",height: 30,),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '7',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.95),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 4),
                        child: Text(
                          'hr',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '32',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.95),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 4),
                        child: Text(
                          'min',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your sleep time',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.4),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF8B7FFF).withOpacity(0.15),
                      border: Border.all(
                        color: const Color(0xFF8B7FFF).withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B7FFF).withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      '98% Sleep Score',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWeeklyProgress() {
    final days = [
      {'day': 'S', 'score': 100, 'index': 6},
      {'day': 'M', 'score': 82, 'index': 0},
      {'day': 'T', 'score': 78, 'index': 1},
      {'day': 'W', 'score': 54, 'index': 2},
      {'day': 'T', 'score': 84, 'index': 3},
      {'day': 'F', 'score': 78, 'index': 4},
      {'day': 'S', 'score': 98, 'index': 5},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: days.map((data) {
        final index = data['index'] as int;
        final isActive = _selectedDayIndex == index;
        final score = data['score'] as int;
        final day = data['day'] as String;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDayIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  width: isActive ? 50 : 44,
                  height: isActive ? 50 : 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: score == 0
                        ? Colors.white.withOpacity(0.05)
                        : const Color(0xFF4A4E6B).withOpacity(0.3),
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFF8B7FFF).withOpacity(0.6)
                          : Colors.white.withOpacity(0.1),
                      width: isActive ? 2 : 1,
                    ),
                    boxShadow: isActive
                        ? [
                      BoxShadow(
                        color: const Color(0xFF8B7FFF).withOpacity(0.4),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                    ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      score == 0 ? '' : '$score%',
                      style: TextStyle(
                        fontSize: isActive ? 13 : 12,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                        color: Colors.white.withOpacity(score == 0 ? 0.2 : 0.8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(isActive ? 0.7 : 0.4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4A4E6B).withOpacity(0.3),
            const Color(0xFF2A2D3A).withOpacity(0.3),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B7FFF).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: const Color(0xFFA599FF),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Somnia',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lower the room temperature slightly for a more restful night',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.3),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDailyTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.95),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.05),
              ),
              child: Text(
                '1/4',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildTaskCard(Icons.book_outlined, 'Fill the Sleep Diary')),
            const SizedBox(width: 12),
            Expanded(child: _buildTaskCard(Icons.psychology_outlined, 'Cognitive Rules')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTaskCard(Icons.air, 'Relaxation Activity')),
            const SizedBox(width: 12),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  Widget _buildTaskCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF1E2130).withOpacity(0.6),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.05),
            ),
            child: Icon(
              icon,
              color: Colors.white.withOpacity(0.6),
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNav() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xFF1A1C29).withOpacity(0.8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem("assets/images/night.png", 'Today', 0),
              buildNavItem("assets/images/plan.png", 'Plan', 1),
              buildNavItem("assets/images/window.png", 'Tools', 2),
              buildNavItem("assets/images/ai.png", 'Somnia', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(String imagePath, String label, int index) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? const Color(0xFF8B7FFF).withOpacity(0.15)
              : Colors.transparent,
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFF8B7FFF).withOpacity(0.3),
              blurRadius: 12,
            ),
          ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 24,
              width: 24,
              color: isSelected
                  ? const Color(0xFFA599FF)
                  : Colors.white.withOpacity(0.4),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? Colors.white.withOpacity(0.9)
                    : Colors.white.withOpacity(0.4),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
