import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

// Main Page with Navigation
class HealthHomePage extends StatefulWidget {
  const HealthHomePage({Key? key}) : super(key: key);

  @override
  State<HealthHomePage> createState() => _HealthHomePageState();
}

class _HealthHomePageState extends State<HealthHomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFbcc7c8),
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(), // Disable swipe
        children: [
          buildHomePage(),
          EventPage(),
          StatisticPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  Widget buildHomePage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF224b4d), Color(0xFF496b6b), Color(0xFFbcc7c8)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSearchBar(),
                    SizedBox(height: 20,),
                    buildTodayStats(),
                    SizedBox(height: 20,),
                    buildTodayWorkout()

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
                width: 1.2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 18,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.28),
                              Colors.white.withOpacity(0.02),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.apps,
                        color: Colors.white.withOpacity(0.9),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.45),
                        width: 1.2,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.20),
                          Colors.white.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.video_library_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.45),
                            width: 1.2,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.20),
                              Colors.white.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=1',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'Welcome, ',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              TextSpan(
                text: 'Alex! ',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'here\'s your',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              TextSpan(
                text: '\nhealth snapshot for today!',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Today is 01 November 2025',
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.30),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.7),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Search...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTodayStats() {
    final List<Map<String, dynamic>> stats = [
      {
        "title": "Step to wall",
        "value": "5,400",
        "unit": "steps",
        "imagePath": "https://static.thenounproject.com/png/1180295-200.png",
        "badgeColor": Color(0xFF224b4d),
        "badgeLabel": "Good",
      },
      {
        "title": "Cal burnt",
        "value": "312",
        "unit": "KCAL",
        "imagePath": "https://static.thenounproject.com/png/1166857-200.png",
        "badgeColor": Color(0xFF224b4d),
        "badgeLabel": "Average",
      },
      {
        "title": "Kilo",
        "value": "312",
        "unit": "",
        "imagePath":
        "https://cdn-icons-png.freepik.com/256/14612/14612666.png?semt=ais_white_label",
        "badgeColor": Color(0xFF224b4d),
        "badgeLabel": "Good",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s stats',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'View more',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 145,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stats.length,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(right: 4),
            itemBuilder: (context, index) {
              final item = stats[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == stats.length - 1 ? 0 : 12,
                ),
                child: _buildGlassStatCard(
                  title: item["title"].toString(),
                  value: item["value"].toString(),
                  unit: item["unit"].toString(),
                  imagePath: item["imagePath"],
                  badgeColor: item["badgeColor"],
                  badgeLabel: item["badgeLabel"],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGlassStatCard({
    required String title,
    required String value,
    required String unit,
    required String imagePath,
    required Color badgeColor,
    required String badgeLabel,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.45),
              Colors.white.withOpacity(0.35),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$value ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: unit,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    badgeLabel,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
            Positioned(
              right: -6,
              bottom: 12,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Image.network(
                  imagePath,
                  color: Colors.white,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTodayWorkout() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'View more',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFbcc7c8),
                    Color(0xFF496b6b),
                    Color(0xFF224b4d),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upper body\nstrength',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '16 exercises',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              _buildCalorieBadge(
                                icon: Icons.alarm,
                                calories: '350 Cal',
                              ),
                              const SizedBox(width: 8),
                              _buildCalorieBadge(
                                icon: Icons.local_fire_department_rounded,
                                calories: '350 Cal',
                                isOrange: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 160,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://static.vecteezy.com/system/resources/thumbnails/046/395/757/small_2x/woman-in-black-sports-bra-posing-for-fitness-photography-png.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalorieBadge({
    required IconData icon,
    required String calories,
    bool isOrange = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black, size: 20),
          const SizedBox(width: 6),
          Text(
            calories,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF0D4A4F),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.home, "Home", 0),
          _buildNavItem(Icons.calendar_today_outlined, "Event", 1),
          _buildNavItem(Icons.bar_chart, "Statics", 2),
          _buildNavItem(Icons.person_outline, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String? label, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 21 : 0,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.black87, size: 22),
            ),
            if (isSelected && label != null) ...[
              const SizedBox(width: 0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Event Page
class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF224b4d), Color(0xFF496b6b), Color(0xFFbcc7c8)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today, size: 80, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Events Page',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your upcoming fitness events',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Statics Page
class StaticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF224b4d), Color(0xFF496b6b), Color(0xFFbcc7c8)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart, size: 80, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Statistics Page',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your health statistics & analytics',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile Page
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF224b4d), Color(0xFF496b6b), Color(0xFFbcc7c8)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=1',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Profile Page',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Alex - Fitness Enthusiast',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Steps', 'Steps', 'Regularity'];
  final List<IconData> _tabIcons = [
    Icons.directions_walk,
    Icons.favorite_border,
    Icons.bar_chart,
  ];

  final List<double> _weekData = [3200, 4100, 3800, 4500, 5400, 3900, 3500];
  final List<String> _weekDays = [
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.transparent, // keep the gradient visible
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF496b6b),
                      Color(0xFF224b4d),
                      Color(0xFFbcc7c8),
                    ],
                  ),
                ), //0xFF496b6b
                child: SafeArea(
                  child: Column(
                    children: [
                      _buildHeader(),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: Colors.white,
                                    // neon border color
                                    width: .5,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.05),
                                      Colors.white.withOpacity(0.1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    _buildTabBar(),
                                    const SizedBox(height: 20),
                                    _buildStatsCard(),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),
                              _buildRecentWorkout(),
                            ],
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
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
          Text(
            'Statistic',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(Icons.more_horiz, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: List.generate(_tabs.length, (index) {
        final isSelected = _selectedTab == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTab = index;
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _tabIcons[index],
                  color: isSelected ? Colors.black : Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  _tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatsCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '5,400 ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'average steps',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'This Week',
                          style: TextStyle(
                            color: Color(0xFF1B4D4E),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF1B4D4E),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildBarChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final maxValue = _weekData.reduce(math.max);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(_weekDays.length, (index) {
        final height = (_weekData[index] / maxValue) * 120;
        final isWednesday = _weekDays[index] == 'Wed';

        return Column(
          children: [
            Container(
              width: 40,
              height: height,
              decoration: BoxDecoration(
                color:
                isWednesday
                    ? Color(0xFF1B4D4E)
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _weekDays[index],
                    style: TextStyle(
                      color:
                      isWednesday
                          ? Colors.white
                          : Colors.black.withOpacity(0.9),
                      fontSize: 11,
                      fontWeight:
                      isWednesday ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildRecentWorkout() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'See all',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 6,
              child: _buildWorkoutCard(
                icon: Icons.favorite_border,
                title: 'Heart rate',
                value: '120',
                unit: 'spm',
                height: 240,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  _buildWorkoutCard(
                    icon: Icons.local_fire_department_outlined,
                    iconColor: Color(0xFFFF6B6B),
                    title: 'Calories',
                    value: '143',
                    unit: 'kcal',
                    height: 114,
                  ),
                  const SizedBox(height: 12),
                  _buildWorkoutCard(
                    icon: Icons.access_time,
                    title: 'Durations',
                    value: '130',
                    unit: 'minutes',
                    height: 114,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorkoutCard({
    required IconData icon,
    required String title,
    required String value,
    required String unit,
    required double height,
    Color? iconColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor ?? Colors.white, size: 20),
              ),
              if (title == 'Heart rate') ...[
                Expanded(child: _buildHeartRateGraph()),
              ] else ...[
                const Spacer(),
              ],
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' $unit',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
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
  }

  Widget _buildHeartRateGraph() {
    return CustomPaint(painter: HeartRateGraphPainter(), child: Container());
  }
}

class HeartRateGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
    Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Create wave-like pattern for heart rate
    final waveHeight = size.height * 0.4;
    final waveWidth = size.width / 6;

    path.moveTo(0, size.height);

    for (int i = 0; i < 7; i++) {
      final x = i * waveWidth;

      if (i % 2 == 0) {
        // Peak
        path.lineTo(x + waveWidth * 0.2, size.height - waveHeight * 1.2);
        path.lineTo(x + waveWidth * 0.4, size.height - waveHeight * 0.3);
        path.lineTo(x + waveWidth * 0.6, size.height - waveHeight * 0.8);
        path.lineTo(x + waveWidth, size.height - waveHeight * 0.5);
      } else {
        // Valley
        path.lineTo(x + waveWidth * 0.5, size.height - waveHeight * 0.4);
        path.lineTo(x + waveWidth, size.height - waveHeight * 0.6);
      }
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

