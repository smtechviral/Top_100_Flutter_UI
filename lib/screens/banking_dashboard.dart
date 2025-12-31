import 'package:flutter/material.dart';

class BankingDashboard extends StatelessWidget {
  const BankingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8,),
                    buildWalletCard(),
                    SizedBox(height: 30,),
                    buildSpendingCashbackRow(),
                    SizedBox(height: 30,),
                    buildQuickActionsRow(),
                    SizedBox(height: 30,),
                    buildReferCard(),
                    SizedBox(height: 30,),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNav(),

    );
  }

  // ==================== HEADER SECTION ====================
  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildProfileAvatar(),
          const SizedBox(width: 12),
          _buildSearchBar(),
          const SizedBox(width: 12),
          _buildHeaderIcon(
            'https://images.vexels.com/media/users/3/239086/isolated/preview/f2af05e1e1634fcc409e0dd939d2482b-shopping-bag-e-commerce-cut-out.png',
          ),
          const SizedBox(width: 8),
          _buildHeaderIcon(
            'https://cdn-icons-png.flaticon.com/512/3119/3119338.png',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.network(
        "https://i.pinimg.com/736x/60/5b/9b/605b9b86a82dd0147ed8aa612381326f.jpg",
        height: 40,
        width: 40,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            SizedBox(width: 16),
            Icon(Icons.search, color: Colors.grey, size: 20),
            SizedBox(width: 8),
            Text('Search', style: TextStyle(color: Colors.grey, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(String imageUrl) {
    return Image.network(imageUrl, height: 20, color: Colors.white);
  }

  // ==================== WALLET CARD ====================
  Widget buildWalletCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF191919), const Color(0xFF3b3b3b)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWalletHeader(),
          const SizedBox(height: 6),
          _buildWalletTitle(),
          const SizedBox(height: 30),
          _buildWalletBalance(),
          const SizedBox(height: 8),
          _buildWalletAccountInfo(),
        ],
      ),
    );
  }

  Widget _buildWalletHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Wallet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 18),
        ),
      ],
    );
  }

  Widget _buildWalletTitle() {
    return const Text(
      'Sunny Singh',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildWalletBalance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '\$15,630.71',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
        ),
        _buildMastercardLogo(),
      ],
    );
  }

  Widget _buildMastercardLogo() {
    return Container(
      width: 40,
      height: 20,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 24,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 24,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.orange.shade700,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletAccountInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Account ** 5087',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Row(
          children: const [
            Text(
              '**** 3264',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  // ==================== SPENDING & CASHBACK ROW ====================
  Widget buildSpendingCashbackRow() {
    return Row(
      children: [
        Expanded(child: _buildSpendingCard()),
        const SizedBox(width: 12),
        Expanded(child: _buildCashBackCard()),
      ],
    );
  }

  Widget _buildSpendingCard({double height = 120}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSpendingTitle(),
          const Spacer(),
          _buildSpendingChart(),
        ],
      ),
    );
  }

  Widget _buildSpendingTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Spending',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Spent in October',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildSpendingChart() {
    return Row(
      children: [
        _buildColorPill(Colors.purple, height: 20, width: 60),
        const SizedBox(width: 5),
        _buildColorPill(Colors.red, height: 20, width: 25),
        const SizedBox(width: 5),
        _buildColorPill(Colors.yellow, height: 18, width: 8),
        const SizedBox(width: 5),
        _buildColorPill(Colors.green, height: 18, width: 30),
        const SizedBox(width: 5),
        _buildColorPill(Colors.blue, height: 18, width: 10),
      ],
    );
  }

  Widget _buildColorPill(Color color, {double width = 32, double height = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildCashBackCard() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildCashBackTitle(), const Spacer(), _buildBrandLogos()],
      ),
    );
  }

  Widget _buildCashBackTitle() {
    return const Text(
      'Cash Back',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBrandLogos() {
    return SizedBox(
      height: 40,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildBrandLogoImage(
            left: 0,
            imageUrl: 'https://pngimg.com/d/netflix_PNG15.png',
          ),
          _buildBrandLogoImage(
            left: 30,
            imageUrl:
                'https://cdn.freebiesupply.com/logos/large/2x/nike-4-logo-black-and-white.png',
            bgColor: Colors.white,
          ),
          _buildBrandLogoImage(
            left: 50,
            imageUrl: 'https://pngimg.com/d/mcdonalds_PNG17.png',
            bgColor: Colors.red,
          ),
          _buildBrandLogoImage(
            left: 80,
            imageUrl:
                'https://download.logo.wine/logo/Adidas/Adidas-Logo.wine.png',
            bgColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogoImage({
    required double left,
    required String imageUrl,
    Color bgColor = Colors.black,
  }) {
    return Positioned(
      left: left,
      child: Container(
        width: 36,
        height: 36,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.network(imageUrl, fit: BoxFit.contain),
      ),
    );
  }

  // ==================== QUICK ACTIONS ROW ====================
  Widget buildQuickActionsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuickActionsColumn(),
        const SizedBox(width: 12),
        _buildLargeActionsRow(),
      ],
    );
  }

  Widget _buildQuickActionsColumn() {
    return Column(
      children: [
        _buildQuickActionButton(Icons.qr_code_scanner),
        const SizedBox(height: 12),
        _buildQuickActionButton(Icons.add),
      ],
    );
  }

  Widget _buildQuickActionButton(IconData icon) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildLargeActionsRow() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: _buildLargeActionCard(
              icon: Icons.school_outlined,
              title: 'Tips And Training',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildLargeActionCard(
              icon: Icons.grid_view_rounded,
              title: 'All Services',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeActionCard({
    required IconData icon,
    required String title,
  }) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionCardIcon(icon),
          Spacer(),
          _buildActionCardTitle(title),
        ],
      ),
    );
  }

  Widget _buildActionCardIcon(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  Widget _buildActionCardTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w800,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  // ==================== REFER CARD ====================
  Widget buildReferCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildReferCardContent(),
          const SizedBox(width: 12),
          _buildReferCardBubbles(),
        ],
      ),
    );
  }

  Widget _buildReferCardContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReferCardTitle(),
          const SizedBox(height: 8),
          _buildReferCardDescription(),
          const SizedBox(height: 18),
          _buildReferCardButton(),
        ],
      ),
    );
  }

  Widget _buildReferCardTitle() {
    return const Text(
      'Refer and Earn',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildReferCardDescription() {
    return const Text(
      'Share a referral link to your friend and get rewarded',
      style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
    );
  }

  Widget _buildReferCardButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Learn more',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildReferCardBubbles() {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -10,
            top: 40,
            child: Image.network(
              'https://static.vecteezy.com/system/resources/thumbnails/049/580/421/small/colorful-transparent-soap-bubble-isolated-on-transparent-background-free-png.png',
              width: 52,
              height: 52,
              fit: BoxFit.contain,
              color: Colors.black,
            ),
          ),
          Positioned(
            right: 20,
            top: 0,
            child: Image.network(
              'https://static.vecteezy.com/system/resources/thumbnails/049/580/421/small/colorful-transparent-soap-bubble-isolated-on-transparent-background-free-png.png',
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== BOTTOM NAVIGATION ====================
  Widget buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home, 'Home', true),
            _buildNavItem(Icons.bar_chart_rounded, 'Payment', false),
            _buildNavItem(Icons.message_outlined, 'Message', false),
            _buildNavItem(Icons.more_horiz, 'More', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.white : Colors.grey, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
