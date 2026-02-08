import 'package:day_challenge_100/screens/dashui/stat_card.dart';
import 'package:day_challenge_100/screens/dashui/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'overview_chart.dart';


class MyDashboardScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const MyDashboardScreen({super.key, required this.onThemeToggle});

  @override
  State<MyDashboardScreen> createState() => _MyDashboardScreenState();
}

class _MyDashboardScreenState extends State<MyDashboardScreen> {
  int _selectedTab = 0;
  String _selectedPeriod = 'Weekly';

  final List<Map<String, dynamic>> _weeklyData = [
    {'day': 'Sun', 'value': 65000.0},
    {'day': 'Mon', 'value': 45000.0},
    {'day': 'Tue', 'value': 55000.0},
    {'day': 'Wed', 'value': 50000.0},
    {'day': 'Thu', 'value': 70000.0},
    {'day': 'Fri', 'value': 80000.0},
    {'day': 'Sat', 'value': 60000.0},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(isDark),
                SizedBox(height: 24,),
                buildSearchBar(isDark),
                SizedBox(height: 24,),
                buildStatsGrid(),
                SizedBox(height: 32,),
                buildOverviewSection(isDark),
                SizedBox(height: 100,)
                
                
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNav(isDark),
    );
  }

  Widget buildHeader(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF5B7FFF),
                    const Color(0xFF5B7FFF).withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.analytics_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'ADOL',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        ThemeToggleButton(
          onToggle: widget.onThemeToggle,
        ),
      ],
    );
  }

  Widget buildSearchBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget buildStatsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            StatCard(
              icon: Icons.people_outline,
              iconColor: const Color(0xFF5B7FFF),
              iconBackground: const Color(0xFF5B7FFF).withOpacity(0.1),
              value: '855',
              label: 'Total Visitors',
              percentage: '+4,8%',
              isPositive: true,
              width: (constraints.maxWidth - 12) / 2,
            ),
            StatCard(
              icon: Icons.shopping_cart_outlined,
              iconColor: const Color(0xFF5B7FFF),
              iconBackground: const Color(0xFF5B7FFF).withOpacity(0.1),
              value: '658',
              label: 'Total Orders',
              percentage: '+2,5%',
              isPositive: true,
              width: (constraints.maxWidth - 12) / 2,
            ),
            StatCard(
              icon: Icons.visibility_outlined,
              iconColor: const Color(0xFF5B7FFF),
              iconBackground: const Color(0xFF5B7FFF).withOpacity(0.1),
              value: '788',
              label: 'Total Views',
              percentage: '-1,8%',
              isPositive: false,
              width: (constraints.maxWidth - 12) / 2,
            ),
            StatCard(
              icon: Icons.chat_bubble_outline,
              iconColor: const Color(0xFF5B7FFF),
              iconBackground: const Color(0xFF5B7FFF).withOpacity(0.1),
              value: '82%',
              label: 'Conversation',
              percentage: '+2,0%',
              isPositive: true,
              width: (constraints.maxWidth - 12) / 2,
            ),
          ],
        );
      },
    );
  }

  Widget buildOverviewSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Overview',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            _buildPeriodSelector(isDark),
          ],
        ),
        const SizedBox(height: 20),
        OverviewChart(
          data: _weeklyData,
          selectedPeriod: _selectedPeriod,
        ),
      ],
    );
  }

  Widget _buildPeriodSelector(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildPeriodButton('Today', isDark),
          _buildPeriodButton('Weekly', isDark),
          _buildPeriodButton('Monthly', isDark),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String period, bool isDark) {
    final isSelected = _selectedPeriod == period;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriod = period;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF3A3A3A) : Colors.grey[100])
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          period,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? (isDark ? Colors.white : Colors.black)
                : Colors.grey[500],
          ),
        ),
      ),
    );
  }

  Widget buildBottomNav(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.dashboard_outlined, 'Overview', isDark),
              _buildNavItem(1, Icons.inventory_2_outlined, 'Product', isDark),
              _buildNavItem(2, Icons.receipt_outlined, 'Order', isDark),
              _buildNavItem(3, Icons.favorite_outline, 'Wishlist', isDark),
              _buildNavItem(4, Icons.person_outline, 'Account', isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, String label, bool isDark) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF5B7FFF)
                  : (isDark ? Colors.grey[600] : Colors.grey[400]),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF5B7FFF)
                    : (isDark ? Colors.grey[600] : Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ADOLApp extends StatefulWidget {
  const ADOLApp({super.key});

  @override
  State<ADOLApp> createState() => _ADOLAppState();
}

class _ADOLAppState extends State<ADOLApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADOL Dashboard',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      home: MyDashboardScreen(onThemeToggle: _toggleTheme),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      primaryColor: const Color(0xFF5B7FFF),
      textTheme: GoogleFonts.interTextTheme(),
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Colors.white,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
      primaryColor: const Color(0xFF5B7FFF),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Color(0xFF2A2A2A),
      ),
    );
  }
}
