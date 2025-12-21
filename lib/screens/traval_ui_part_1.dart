import 'package:flutter/material.dart';

import '../widgets/appImage.dart';

class HomeScreenUI extends StatelessWidget {
  const HomeScreenUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopCard(),
              SizedBox(height: 30,),
              buildSectionTitle("Travel Categories"),
              SizedBox(height: 15,),
              buildCategoryList(),
              SizedBox(height: 15,),
              buildTripCardList(context)

            ],
          ),
        ),
      ),

      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  // Top Card with Gradient Background
  Widget buildTopCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF161928),
            Color(0xFF586378),
            Color(0xFF262d3d),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProfileRow(),
          SizedBox(height: 30,),
          buildTitle(),
          SizedBox(height: 20,),
          buildSearchBar()

        ],
      ),
    );
  }

  // Profile and Notification Row
  Widget buildProfileRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProfileSection(),
        _buildNotificationButton(),
      ],
    );
  }

  // Profile Avatar and Greeting
  Widget _buildProfileSection() {
    return Row(
      children: [
        _buildProfileAvatar(),
        const SizedBox(width: 12),
        const Text(
          'Hai, smtechviral!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Profile Avatar with Border
  Widget _buildProfileAvatar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.black.withOpacity(.3),
          width: 3,
        ),
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.network(
            'https://i.pravatar.cc/150?img=5',
            fit: BoxFit.cover,
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }

  // Notification Button
  Widget _buildNotificationButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Color(0xFF161928).withOpacity(.3),
          width: 5,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          AppImages.notificationPngIcon,
          height: 20,
        ),
      ),
    );
  }

  // Main Title
  Widget buildTitle() {
    return const Text(
      'Where do\nyou want to go?',
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    );
  }

  // Search Bar with Icon
  Widget buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search your destination point',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            border: InputBorder.none,
            suffixIcon: _buildSearchIcon(),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  // Search Icon with Shadow
  Widget _buildSearchIcon() {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.5),
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-2, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          AppImages.searchIcon,
          height: 20,
        ),
      ),
    );
  }

  // Section Title (Reusable)
  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C3E50),
      ),
    );
  }

  // Category Chips List
  Widget buildCategoryList() {
    return SizedBox(
      height: 60,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryChip('🎒', 'Trip', true),
          const SizedBox(width: 10),
          _buildCategoryChip('🏖️', 'Staycation', false),
          const SizedBox(width: 10),
          _buildCategoryChip('🏡', 'Stay In', false),
          const SizedBox(width: 10),
          _buildCategoryChip('🌾🏡', 'Farm', false),
          const SizedBox(width: 10),
          _buildCategoryChip('🏘️✨', 'Villa', false),
        ],
      ),
    );
  }

  // Single Category Chip
  Widget _buildCategoryChip(String emoji, String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF2C3E50) : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top Trips Header with Explore Button
  Widget buildTopTripsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSectionTitle('Top trips'),
        _buildExploreButton(),
      ],
    );
  }

  // Explore Button
  Widget _buildExploreButton() {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: const [
          Text(
            'Explore',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(width: 5),
          Icon(Icons.arrow_forward, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  // Trip Cards Horizontal List
  Widget buildTripCardList(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTripCard(
            context,
            'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400',
            'Kalibata City',
            'Apartment',
            '\$150',
          ),
          const SizedBox(width: 15),
          _buildTripCard(
            context,
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400',
            'Linden Tower',
            'Hotel',
            '\$50',
          ),
          const SizedBox(width: 15),
          _buildTripCard(
            context,
            'https://www.dellaresorts.com/new-images/enclave-ex-new-2-feb-1.webp',
            'Luxury Enclave',
            'Villa',
            '\$50',
          ),
        ],
      ),
    );
  }

  // Single Trip Card
  Widget _buildTripCard(
      BuildContext context,
      String imageUrl,
      String title,
      String subtitle,
      String price,
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _navigateToDetail(context, imageUrl, title, subtitle, price),
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTripCardImage(imageUrl, price),
              _buildTripCardInfo(title, subtitle),
            ],
          ),
        ),
      ),
    );
  }

  // Trip Card Image with Price Badge
  Widget _buildTripCardImage(String imageUrl, String price) {
    return Stack(
      children: [
        _buildCardImageContainer(imageUrl),
        _buildPriceBadge(price),
      ],
    );
  }

  // Card Image Container with Shadow
  Widget _buildCardImageContainer(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            imageUrl,
            height: 160,
            width: 160,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Price Badge
  Widget _buildPriceBadge(String price) {
    return Positioned(
      top: 15,
      right: 15,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // Trip Card Info Section
  Widget _buildTripCardInfo(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(title),
          const SizedBox(height: 4),
          _buildCardSubtitleRow(subtitle),
        ],
      ),
    );
  }

  // Card Title
  Widget _buildCardTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Color(0xFF2C3E50),
      ),
    );
  }

  // Card Subtitle with Like Button
  Widget _buildCardSubtitleRow(String subtitle) {
    return Row(
      children: [
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const Spacer(),
        _buildLikeButton(),
      ],
    );
  }

  // Like/Dislike Button
  Widget _buildLikeButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-2, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          AppImages.disLikeIcon,
          height: 20,
        ),
      ),
    );
  }

  // Bottom Navigation Bar
  Widget buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavIcon(AppImages.homeIcon, null),
          _buildNavIcon(AppImages.direction, Colors.grey),
          _buildCenterSearchButton(),
          _buildNavIcon(AppImages.disLikeIcon, Colors.grey),
          _buildCartIconWithBadge(),
        ],
      ),
    );
  }

  // Navigation Icon
  Widget _buildNavIcon(String iconPath, Color? color) {
    return Image.asset(iconPath, height: 28, color: color);
  }

  // Center Search Button with Gradient
  Widget _buildCenterSearchButton() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF8C42),
            Color(0xFFFF6B35),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Image.asset(
        AppImages.searchIcon,
        height: 28,
        color: Colors.white,
      ),
    );
  }

  // Cart Icon with Badge
  Widget _buildCartIconWithBadge() {
    return Stack(
      children: [
        Image.asset(AppImages.shop, height: 28, color: Colors.grey),
        _buildCartBadge(),
      ],
    );
  }

  // Cart Badge
  Widget _buildCartBadge() {
    return Positioned(
      right: 0,
      top: -4,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Color(0xFFFF6B35),
          shape: BoxShape.circle,
        ),
        child: const Text(
          '2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Navigate to Detail Screen
  void _navigateToDetail(
      BuildContext context,
      String imageUrl,
      String title,
      String subtitle,
      String price,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          imageUrl: imageUrl,
          title: title,
          subtitle: subtitle,
          price: price,
        ),
      ),
    );
  }
}

// ==================== DETAIL SCREEN ====================

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;

  const DetailScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroImage(context),
                  _buildOverviewSection(),
                ],
              ),
            ),
          ),
          _buildRentButton(),
        ],
      ),
    );
  }

  // Hero Image with Gradient Overlay
  Widget _buildHeroImage(BuildContext context) {
    return Stack(
      children: [
        _buildImageWithGradient(),
        _buildBackButton(context),
        _buildBookmarkButton(),
        _buildActionButtons(),
        _buildImageOverlayInfo(),
      ],
    );
  }

  // Image with Gradient Overlay
  Widget _buildImageWithGradient() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Image.network(
            imageUrl,
            height: 600,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Back Button
  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Color(0xFF161928).withOpacity(.3),
              width: 5,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF2C3E50),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  // Bookmark Button
  Widget _buildBookmarkButton() {
    return Positioned(
      top: 60,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Color(0xFF161928).withOpacity(.3),
            width: 5,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            AppImages.disLikeIcon,
            height: 20,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  // Action Buttons (Gallery, 3D, Store)
  Widget _buildActionButtons() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Column(
        children: [
          _buildActionButton(Icons.photo_library_outlined),
          const SizedBox(height: 10),
          _buildActionButton(Icons.threed_rotation_rounded),
          const SizedBox(height: 10),
          _buildActionButton(Icons.store_outlined),
        ],
      ),
    );
  }

  // Single Action Button
  Widget _buildActionButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFF161928).withOpacity(.4), width: 4),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF2C3E50).withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  // Image Overlay Info (Title & Price)
  Widget _buildImageOverlayInfo() {
    return Positioned(
      bottom: 20,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$subtitle\n$title',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(0, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$price/month',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(0, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Overview Section
  Widget _buildOverviewSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8C45),
            ),
          ),
          const SizedBox(height: 15),
          _buildSpecsRow(),
          const SizedBox(height: 20),
          _buildDescription(),
        ],
      ),
    );
  }

  // Specifications Row
  Widget _buildSpecsRow() {
    return Row(
      children: [
        _buildSpecItem(Icons.bed_outlined, '2 bedroom', 'King size'),
        const SizedBox(width: 30),
        _buildSpecItem(Icons.straighten_outlined, '50 m²', 'Building area'),
      ],
    );
  }

  // Single Spec Item
  Widget _buildSpecItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(3, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(-2, -2),
              ),
            ],
          ),
          child: Center(
            child: Icon(icon, color: const Color(0xFFFF8C42), size: 24),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF2C3E50),
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  // Description Text
  Widget _buildDescription() {
    return Text(
      'The Kalibata City Apartment is located in the midst of the hustle and bustle of Jakarta, and is touted as one of the most popular residences in the area.',
      style: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        height: 1.6,
      ),
    );
  }

  // Rent Now Button
  Widget _buildRentButton() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFF35904),
                Color(0xFFF79037),
                Color(0xFFf8963d),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Rent now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}