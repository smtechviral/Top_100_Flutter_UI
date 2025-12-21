import 'dart:ui';

import 'package:flutter/material.dart';

// Constants
class AppColors {
  static const gradient1 = Color(0xFF1A1A2E);
  static const gradient2 = Color(0xFF16213E);
  static const gradient3 = Color(0xFF0F3460);
  static const accent = Color(0xFFE94560);
  static const accentLight = Color(0xFFFF6B9D);
  static const glass = Color(0xFFFFFFFF);
}

class AppConstants {
  static const double borderRadius = 24.0;
  static const double spacing = 16.0;
  static const double glassOpacity = 0.12;
  static const double glassBlur = 15.0;
}

// Custom Glass Morphism Container
class GlassMorphicContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double borderRadius;
  final double blur;
  final Border? border;
  final List<BoxShadow>? shadows;

  const GlassMorphicContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius = AppConstants.borderRadius,
    this.blur = AppConstants.glassBlur,
    this.border,
    this.shadows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:
                  color ??
                  AppColors.glass.withOpacity(AppConstants.glassOpacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border:
                  border ??
                  Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
              boxShadow:
                  shadows ??
                  [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// Custom Toggle Switch
class CustomToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double width;
  final double height;

  const CustomToggleSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColors.accent,
    this.inactiveColor = Colors.white30,
    this.width = 56,
    this.height = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color: value ? activeColor : inactiveColor,
          boxShadow: [
            if (value)
              BoxShadow(
                color: activeColor.withOpacity(0.4),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: value ? width - height + 4 : 4,
              top: 3,
              child: Container(
                width: height - 6,
                height: height - 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Icon Container
class IconContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;
  final bool showGlow;

  const IconContainer({
    Key? key,
    required this.icon,
    this.iconColor = Colors.white,
    this.backgroundColor,
    this.size = 48,
    this.iconSize = 24,
    this.onTap,
    this.showGlow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: backgroundColor ?? Colors.white.withOpacity(0.15),
          boxShadow: showGlow
              ? [
                  BoxShadow(
                    color: iconColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}

// Custom Room Chip
class CustomRoomChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRoomChip({
    Key? key,
    required this.label,
    this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [AppColors.accent, AppColors.accentLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.15),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 16),
              SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Device Card Model
class DeviceCardModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? backgroundColor;
  final bool hasToggle;
  final bool isOn;

  DeviceCardModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.backgroundColor,
    this.hasToggle = true,
    this.isOn = false,
  });
}

class SmartHomePage extends StatefulWidget {
  const SmartHomePage({Key? key}) : super(key: key);

  @override
  State<SmartHomePage> createState() => _SmartHomePageState();
}

class _SmartHomePageState extends State<SmartHomePage>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  bool smartLightOn = true;
  bool alarmOn = true;
  bool acOn = true;
  bool securityOn = true;
  String selectedRoom = 'Living Room';
  double musicProgress = 0.4;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradient1,
              AppColors.gradient2,
              AppColors.gradient3,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(),
                  SizedBox(height: 28),
                  buildWelcomeSection(),
                  SizedBox(height: 28),
                  buildRoomSelector(),
                  SizedBox(height: 25),
                  buildMusicPlayer(),
                  SizedBox(height: 20),
                  Expanded(child: buildDeviceGrid()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconContainer(icon: Icons.menu_rounded, onTap: () {}),
        Row(
          children: [
            Stack(
              children: [
                IconContainer(icon: Icons.notifications_none_rounded),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.2),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://i.pravatar.cc/150?img=12',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi Robbie 👋',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Welcome Home! Everything is under control.',
          style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.6)),
        ),
      ],
    );
  }

  Widget buildRoomSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GlassMorphicContainer(
            padding: EdgeInsets.all(12),
            borderRadius: 16,
            child: Icon(Icons.add_rounded, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12),
          CustomRoomChip(
            label: 'Living Room',
            icon: Icons.weekend_rounded,
            isSelected: selectedRoom == 'Living Room',
            onTap: () => setState(() => selectedRoom = 'Living Room'),
          ),
          SizedBox(width: 10),
          CustomRoomChip(
            label: 'Kitchen',
            icon: Icons.restaurant_rounded,
            isSelected: selectedRoom == 'Kitchen',
            onTap: () => setState(() => selectedRoom = 'Kitchen'),
          ),
          SizedBox(width: 10),
          CustomRoomChip(
            label: 'Bedroom',
            icon: Icons.bed_rounded,
            isSelected: selectedRoom == 'Bedroom',
            onTap: () => setState(() => selectedRoom = 'Bedroom'),
          ),
          SizedBox(width: 10),
          CustomRoomChip(
            label: 'Bathroom',
            icon: Icons.bathroom_rounded,
            isSelected: selectedRoom == 'Bathroom',
            onTap: () => setState(() => selectedRoom = 'Bathroom'),
          ),
        ],
      ),
    );
  }

  Widget buildMusicPlayer() {
    return GlassMorphicContainer(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?w=150&h=150&fit=crop',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'People Are People',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Depeche Mode',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconContainer(
                icon: Icons.playlist_play_rounded,
                size: 40,
                iconSize: 22,
                backgroundColor: AppColors.accent.withOpacity(0.2),
                iconColor: AppColors.accent,
              ),
            ],
          ),
          SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
              activeTrackColor: AppColors.accent,
              inactiveTrackColor: Colors.white.withOpacity(0.2),
              thumbColor: Colors.white,
            ),
            child: Slider(
              value: musicProgress,
              onChanged: (value) => setState(() => musicProgress = value),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '2:30',
                style: TextStyle(color: Colors.white60, fontSize: 11),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      color: Colors.white70,
                    ),
                    onPressed: () {},
                    iconSize: 28,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.accent, AppColors.accentLight],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.4),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => setState(() => isPlaying = !isPlaying),
                      iconSize: 32,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next_rounded, color: Colors.white70),
                    onPressed: () {},
                    iconSize: 28,
                  ),
                ],
              ),
              Text(
                '5:00',
                style: TextStyle(color: Colors.white60, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDeviceGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildSmartLightCard(),
        _buildAlarmCard(),
        _buildACCard(),
        _buildSecurityCard(),
      ],
    );
  }

  Widget _buildSmartLightCard() {
    return GlassMorphicContainer(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconContainer(
                icon: Icons.lightbulb_rounded,
                iconColor: smartLightOn ? Colors.amber : Colors.white70,
                backgroundColor: smartLightOn
                    ? Colors.amber.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                showGlow: smartLightOn,
              ),
              CustomToggleSwitch(
                value: smartLightOn,
                onChanged: (val) => setState(() => smartLightOn = val),
                activeColor: Colors.amber,
              ),
            ],
          ),
          Spacer(),
          Text(
            'Smart Light',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '8 lights active',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlarmCard() {
    return GlassMorphicContainer(
      color: Colors.white.withOpacity(0.95),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alarm',
                style: TextStyle(
                  color: AppColors.gradient3,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              CustomToggleSwitch(
                value: alarmOn,
                onChanged: (val) => setState(() => alarmOn = val),
                activeColor: AppColors.accent,
              ),
            ],
          ),
          Spacer(),
          Text(
            '07:00',
            style: TextStyle(
              color: AppColors.gradient3,
              fontWeight: FontWeight.bold,
              fontSize: 36,
              letterSpacing: -1,
            ),
          ),
          Text(
            'Work Day',
            style: TextStyle(
              color: AppColors.gradient3.withOpacity(0.6),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildACCard() {
    return GlassMorphicContainer(
      color: Color(0xFF4ECDC4).withOpacity(0.15),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconContainer(
                icon: Icons.ac_unit_rounded,
                iconColor: Color(0xFF4ECDC4),
                backgroundColor: Color(0xFF4ECDC4).withOpacity(0.2),
                showGlow: acOn,
              ),
              CustomToggleSwitch(
                value: acOn,
                onChanged: (val) => setState(() => acOn = val),
                activeColor: Color(0xFF4ECDC4),
              ),
            ],
          ),
          Spacer(),
          Text(
            'Air Conditioner',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '22°C',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityCard() {
    return GlassMorphicContainer(
      color: Color(0xFF6C5CE7).withOpacity(0.15),
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconContainer(
                icon: Icons.security_rounded,
                iconColor: Color(0xFF6C5CE7),
                backgroundColor: Color(0xFF6C5CE7).withOpacity(0.2),
                showGlow: securityOn,
              ),
              CustomToggleSwitch(
                value: securityOn,
                onChanged: (val) => setState(() => securityOn = val),
                activeColor: Color(0xFF6C5CE7),
              ),
            ],
          ),
          Spacer(),
          Text(
            'Security',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'All sensors active',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
