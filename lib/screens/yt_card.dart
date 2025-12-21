import 'package:flutter/material.dart';
import 'dart:math' as math;

class TrackingHomePage extends StatefulWidget {
  const TrackingHomePage({Key? key}) : super(key: key);

  @override
  State<TrackingHomePage> createState() => _TrackingHomePageState();
}

class _TrackingHomePageState extends State<TrackingHomePage>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                SizedBox(height: 20,),
                buildSearchBar(),
                SizedBox(height: 25,),
                buildCategoryCards(),
                SizedBox(height: 25,),
                buildSectionHeader("Current Shipment"),
                SizedBox(height: 15,),
                buildCurrentShipmentCard(),
                SizedBox(height: 25,),
                buildSectionHeader("Recent Shipment"),
                SizedBox(height: 15,),
                buildRecentShipments(),
                SizedBox(height: 100,)

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: buildBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // ===== HEADER =====
  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            build3DIconButton(
              icon: Icons.menu_rounded,
              onTap: () {},
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery Tracking',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1F36),
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  '10+ Delys, Riyadh',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (math.sin(_pulseController.value * math.pi * 2) * 0.05),
              child: build3DIconButton(
                icon: Icons.notifications_rounded,
                onTap: () {},
                hasNotification: true,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget build3DIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasNotification = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFF0F2F5)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              blurRadius: 15,
              offset: const Offset(-5, -5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Icon(icon, size: 24, color: const Color(0xFF1A1F36)),
            if (hasNotification)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B6B), Color(0xFFFF5252)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF6B6B).withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
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

  // ===== SEARCH BAR =====
  Widget buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFF8F9FA)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 15,
                  offset: const Offset(-5, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: Colors.grey[400], size: 24),
                const SizedBox(width: 12),
                Text(
                  'Search tracking number...',
                  style: TextStyle(color: Colors.grey[400], fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667EEA).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 24),
        ),
      ],
    );
  }

  // ===== CATEGORY CARDS =====
  Widget buildCategoryCards() {
    return Row(
      children: [
        Expanded(
          child: build3DCategoryCard(
            title: 'New\nDelivery',
            imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/024/830/372/small/delivery-truck-with-parcel-box-transport-vehicle-3d-rendering-free-png.png",
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFE8E0), Color(0xFFFFCDB8)],
            ),
            iconColor: const Color(0xFFFF6B6B),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: build3DCategoryCard(
            title: 'Track\nPackage',
            imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/050/176/301/small/delivery-box-isolated-on-transparent-background-png.png",
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFE0F2FF), Color(0xFFB8DCFF)],
            ),
            iconColor: const Color(0xFF4A90E2),
          ),
        ),
      ],
    );
  }

  Widget build3DCategoryCard({
    required String title,
    required String imageUrl, // 🔁 IconData → imageUrl
    required LinearGradient gradient,
    required Color iconColor,
  }) {
    return Transform.translate(
      offset: Offset(0, math.sin(_floatController.value * math.pi) * 5),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: gradient.colors[0].withOpacity(0.4),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1F36),
                      height: 1.3,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ClipOval(
                      child: Image.network(
                        imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: iconColor,
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
    );
  }


  // ===== SECTION HEADER =====
  Widget buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1F36),
            letterSpacing: -0.5,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See All',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ===== CURRENT SHIPMENT CARD =====
  Widget buildCurrentShipmentCard() {
    return Transform.translate(
      offset: Offset(0, math.sin(_floatController.value * math.pi * 2) * 3),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFFAFBFC)],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 20,
              offset: const Offset(-8, -8),
            ),
          ],
        ),
        child: Column(
          children: [
            buildShipmentHeader(),
            const SizedBox(height: 24),
            buildProgressBar(),
            const SizedBox(height: 20),
            buildLocationInfo(),
          ],
        ),
      ),
    );
  }

  Widget buildShipmentHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.local_shipping_rounded,
            size: 32,
            color: Color(0xFF667EEA),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ID: H31431S796',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1F36),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFF6B6B).withOpacity(0.15),
                      const Color(0xFFFF5252).withOpacity(0.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'In Transit',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFF5252),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            return Transform.rotate(
              angle: math.sin(_floatController.value * math.pi * 2) * 0.1,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFE8E0), Color(0xFFFFCDB8)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6B6B).withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.inventory_2_rounded, size: 36, color: Color(0xFFFF5252)),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildProgressBar() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFFE9ECEF),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return FractionallySizedBox(
                  widthFactor: 0.65,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B6B), Color(0xFFFF5252)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B6B).withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '65% Complete',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF667EEA),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '~ 2 days left',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLocationInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLocationPoint('Riyan, Riyadh', true),
        buildDottedLine(),
        buildLocationPoint('Janifra, Jeddah', false),
      ],
    );
  }

  Widget buildLocationPoint(String label, bool isFrom) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            gradient: isFrom
                ? const LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF5252)],
            )
                : null,
            color: isFrom ? null : const Color(0xFFE9ECEF),
            shape: BoxShape.circle,
            boxShadow: isFrom
                ? [
              BoxShadow(
                color: const Color(0xFFFF6B6B).withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ]
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isFrom ? const Color(0xFF1A1F36) : Colors.grey[600],
            fontWeight: isFrom ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget buildDottedLine() {
    return Expanded(
      child: Row(
        children: List.generate(
          8,
              (index) => Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===== RECENT SHIPMENTS =====
  Widget buildRecentShipments() {
    return Column(
      children: [
        build3DRecentCard(
          id: 'H31431S796',
          subId: 'ID: K37856337',
          status: 'On Process',
          statusColor: const Color(0xFFFFB74D),
        ),
        const SizedBox(height: 12),
        build3DRecentCard(
          id: 'K37856337',
          subId: '',
          status: 'Delivered',
          statusColor: const Color(0xFF66BB6A),
        ),
      ],
    );
  }

  Widget build3DRecentCard({
    required String id,
    required String subId,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFFAFBFC)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: 15,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  statusColor.withOpacity(0.2),
                  statusColor.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              status == 'Delivered' ? Icons.check_circle_rounded : Icons.local_shipping_rounded,
              size: 32,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: $id',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1F36),
                  ),
                ),
                if (subId.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subId,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  statusColor.withOpacity(0.15),
                  statusColor.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: statusColor.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== BOTTOM NAVIGATION =====
  Widget buildBottomNav() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1F36), Color(0xFF2D3142)],
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A1F36).withOpacity(0.5),
            blurRadius: 35,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildNavItem(Icons.home_rounded, 'Home', true),
          const SizedBox(width: 20),
          buildNavItem(Icons.access_time_rounded, 'Shipment', false),
          const SizedBox(width: 20),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (math.sin(_pulseController.value * math.pi * 2) * 0.08),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF6B6B), Color(0xFFFF5252)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF6B6B).withOpacity(0.6),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
                ),
              );
            },
          ),
          const SizedBox(width: 20),
          buildNavItem(Icons.location_on_rounded, 'Tracking', false),
          const SizedBox(width: 20),
          buildNavItem(Icons.person_rounded, 'Profile', false),
        ],
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.white : Colors.grey[500],
          size: 26,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[500],
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}