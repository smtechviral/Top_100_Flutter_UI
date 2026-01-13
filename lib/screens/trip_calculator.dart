import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripCalculatorScreen extends StatefulWidget {
  const TripCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<TripCalculatorScreen> createState() => _TripCalculatorScreenState();
}

class _TripCalculatorScreenState extends State<TripCalculatorScreen> {
  bool isDarkMode = false;
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode;
    final bgColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtextColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final cardColor = isDark ? const Color(0xFF252525) : Colors.white;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(textColor, subtextColor),
                      SizedBox(height: 30,),
                      buildLocationRoute(cardColor, textColor, subtextColor),
                      SizedBox(height: 20,),
                      buildTripDetailsCard(isDark, cardColor, textColor, subtextColor),
                      SizedBox(height: 20,),
                      buildVehicleSelection(cardColor, textColor, subtextColor),
                      SizedBox(height: 20,),
                      buildFuelPricing(cardColor, textColor, subtextColor)

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(cardColor, textColor, subtextColor),
    );
  }

  Widget buildHeader(Color textColor, Color? subtextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: subtextColor,
              ),
            ),
            Row(
              children: [
                Text(
                  'smtechviral',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                const Text(
                  '👋',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        _buildUserAvatar(),
        const SizedBox(width: 10),
        _buildThemeToggle(),
      ],
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFF2196F3),
        shape: BoxShape.circle,
      ),
      child: Text(
        'SM',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkMode = !isDarkMode;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: Image.network(
          isDarkMode
              ? "https://static.vecteezy.com/system/resources/thumbnails/013/250/772/small/clear-night-3d-rendering-isometric-icon-png.png"
              : "https://cdn3d.iconscout.com/3d/premium/thumb/sun-3d-icon-png-download-9531500.png",
          key: ValueKey(isDarkMode),
          fit: BoxFit.contain,
          height: isDarkMode ? 35 : 40,
        ),
      ),
    );
  }

  Widget buildLocationRoute(Color cardColor, Color textColor, Color? subtextColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, size: 20, color: subtextColor),
          const SizedBox(width: 8),
          Text(
            'Port-Harcourt',
            style: GoogleFonts.poppins(fontSize: 14, color: textColor),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 16, color: subtextColor),
          const SizedBox(width: 8),
          Text(
            'Calabar',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTripDetailsCard(bool isDark, Color cardColor, Color textColor, Color? subtextColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 1,
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildMapImage(),
            const SizedBox(height: 20),
            _buildCostInfo(textColor, subtextColor),
            _buildDistanceAndDuration(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildMapImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.network(
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        "https://storage.googleapis.com/support-forums-api/attachment/message-237576265-6955616305050567035.PNG",
      ),
    );
  }

  Widget _buildCostInfo(Color textColor, Color? subtextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estimated Cost',
              style: GoogleFonts.poppins(fontSize: 12, color: subtextColor),
            ),
            Text(
              '₦59,000',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
        Text(
          '32 MPG',
          style: GoogleFonts.poppins(fontSize: 14, color: subtextColor),
        ),
      ],
    );
  }

  Widget _buildDistanceAndDuration(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            isDark: isDark,
            title: 'Distance',
            value: '145',
            unit: 'mi',
            showBorder: false,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoCard(
            isDark: isDark,
            title: 'Duration',
            value: '300',
            unit: 'min',
            showBorder: true,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required bool isDark,
    required String title,
    required String value,
    required String unit,
    required bool showBorder,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF232323) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(25),
        border: showBorder
            ? Border.all(
          width: 1,
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE0E0E0),
        )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isDark ? const Color(0xFF9E9E9E) : const Color(0xFF757575),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? const Color(0xFFE0E0E0) : const Color(0xFF212121),
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDark ? const Color(0xFF9E9E9E) : const Color(0xFF757575),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildVehicleSelection(Color cardColor, Color textColor, Color? subtextColor) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    fit: BoxFit.cover,
                    "https://static.vecteezy.com/system/resources/thumbnails/048/524/115/small/realistic-sport-car-isolated-on-background-3d-rendering-illustration-png.png",
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AMG C 43 Sedan',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      Text(
                        '17.4 gallons (66 litres)',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: subtextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildChangeVehicleButton(),
        ],
      ),
    );
  }

  Widget _buildChangeVehicleButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2196F3),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          'Change Vehicle',
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildFuelPricing(Color cardColor, Color textColor, Color? subtextColor) {
    return Row(
      children: [
        Expanded(
          child: _buildFuelCard(
            cardColor: cardColor,
            textColor: textColor,
            subtextColor: subtextColor,
            imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/057/358/829/small/illustration-of-red-gas-pump-free-png.png",
            title: 'Cheapest fuel',
            value: '₦793 🔥',
            valueColor: textColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildFuelCard(
            cardColor: cardColor,
            textColor: textColor,
            subtextColor: subtextColor,
            imageUrl: "https://pngimg.com/d/price_label_PNG86.png",
            title: 'Price Trend',
            value: '2.4% lower',
            valueColor: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildFuelCard({
    required Color cardColor,
    required Color textColor,
    required Color? subtextColor,
    required String imageUrl,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, height: 20),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 12, color: subtextColor),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavBar(Color cardColor, Color textColor, Color? subtextColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0, selectedTab == 0, textColor, subtextColor),
              _buildNavItem(Icons.bar_chart, 'Statistics', 1, selectedTab == 1, textColor, subtextColor),
              _buildNavItem(Icons.analytics, 'Analytics', 2, selectedTab == 2, textColor, subtextColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon,
      String label,
      int index,
      bool isSelected,
      Color textColor,
      Color? subtextColor,
      ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF2196F3) : subtextColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isSelected ? const Color(0xFF2196F3) : subtextColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}