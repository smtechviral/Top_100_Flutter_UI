import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

import 'furniture_details_ui.dart';

// Add this import

class FurnitureHomePage extends StatefulWidget {
  const FurnitureHomePage({Key? key}) : super(key: key);

  @override
  State<FurnitureHomePage> createState() => _FurnitureHomePageState();
}

class _FurnitureHomePageState extends State<FurnitureHomePage> with TickerProviderStateMixin {
  int selectedCategory = 0;
  MotionTabBarController? _motionTabBarController;

  final List<String> categories = ['All', 'Chair', 'Table', 'Lamp', 'Floor'];

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: getVerticalSpacing(),
            left: _getHorizontalPadding(),
            right: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildMainContent(),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),

    );
  }

  // Helper methods for responsive dimensions
  double get _screenWidth => MediaQuery.of(context).size.width;
  double get _screenHeight => MediaQuery.of(context).size.height;
  double _getHorizontalPadding() => _screenWidth * 0.05;
  double getVerticalSpacing() => _screenHeight * 0.02;

  // Build main content widgets
  List<Widget> buildMainContent() {
    return [
      buildHeader(),
      SizedBox(height: getVerticalSpacing(),),
      buildSearchBar(),
      SizedBox(height: getVerticalSpacing(),),
      buildCategories(),
      SizedBox(height: getVerticalSpacing(),),
      buildProductList()

    ];
  }

  // Header widget
  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.only(right: _getHorizontalPadding()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Best Furniture',
            style: GoogleFonts.poppins(
              fontSize: _screenWidth * 0.06,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          Text(
            'Perfect Choice!',
            style: GoogleFonts.poppins(
              fontSize: _screenWidth * 0.035,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }

  // Search bar widget
  Widget buildSearchBar() {
    return Padding(
      padding: EdgeInsets.only(right: _getHorizontalPadding()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF9E9E9E), size: _screenWidth * 0.05),
            SizedBox(width: _screenWidth * 0.03),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: _screenWidth * 0.035,
                    color: const Color(0xFFBDBDBD),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            _buildFilterButton(),
          ],
        ),
      ),
    );
  }

  // Filter button widget
  Widget _buildFilterButton() {
    return Container(
      padding: EdgeInsets.all(_screenWidth * 0.015),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(Icons.tune, color: Color(0xFF2D2D2D), size: _screenWidth * 0.05),
    );
  }

  // Categories widget
  Widget buildCategories() {
    return SizedBox(
      height: _screenHeight * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: _getHorizontalPadding()),
        itemCount: categories.length,
        itemBuilder: (context, index) => _buildCategoryItem(index),
      ),
    );
  }

  // Category item widget
  Widget _buildCategoryItem(int index) {
    final isSelected = selectedCategory == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: _screenWidth * 0.02),
        padding: EdgeInsets.symmetric(
          horizontal: _screenWidth * 0.05,
          vertical: _screenHeight * 0.012,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3D3D3D) : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            categories[index],
            style: GoogleFonts.poppins(
              fontSize: _screenWidth * 0.035,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF9E9E9E),
            ),
          ),
        ),
      ),
    );
  }

  // Product list widget
  Widget buildProductList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(
          right: _getHorizontalPadding(),
          bottom: 0,
        ),
        itemCount: sampleProducts.length,
        itemBuilder: (context, index) {
          final product = sampleProducts[index];
          return Padding(
            padding: EdgeInsets.only(bottom: _screenHeight * 0.02),
            child: _buildProductCard(product, index),
          );
        },
      ),
    );
  }

  // Product card widget
  Widget _buildProductCard(dynamic product, int index) {
    return GestureDetector(
      onTap: () => _navigateToDetail(product, index),
      child: Container(
        decoration: _buildProductCardDecoration(),
        child: Padding(
          padding: EdgeInsets.all(_screenWidth * 0.05),
          child: Row(
            children: [
              _buildProductImage(product.imageUrl),
              SizedBox(width: _screenWidth * 0.04),
              _buildProductDetails(product),
            ],
          ),
        ),
      ),
    );
  }

  // Navigate to detail page
  void _navigateToDetail(dynamic product, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FurnitureDetailPage(
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl,
          productIndex: index,
        ),
      ),
    );
  }

  // Product card decoration
  BoxDecoration _buildProductCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 24,
          offset: const Offset(0, 14),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.9),
          blurRadius: 6,
          offset: const Offset(-4, -4),
        ),
      ],
    );
  }

  // Product image widget
  Widget _buildProductImage(String imageUrl) {
    return Stack(
      children: [
        Container(
          width: _screenWidth * 0.30,
          height: _screenWidth * 0.30,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.chair,
                    size: _screenWidth * 0.12,
                    color: Color(0xFF9E9E9E),
                  ),
                );
              },
            ),
          ),
        ),
        _buildFavoriteButton(),
      ],
    );
  }

  // Favorite button widget
  Widget _buildFavoriteButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: EdgeInsets.all(_screenWidth * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          Icons.favorite_border,
          size: _screenWidth * 0.04,
          color: Color(0xFF9E9E9E),
        ),
      ),
    );
  }

  // Product details widget
  Widget _buildProductDetails(dynamic product) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusBadge(product.status),
          SizedBox(height: _screenHeight * 0.008),
          _buildProductTitle(product.title),
          SizedBox(height: _screenHeight * 0.005),
          _buildProductDescription(product.description),
          SizedBox(height: _screenHeight * 0.01),
          _buildPriceAndBuyButton(product.price),
        ],
      ),
    );
  }

  // Status badge widget
  Widget _buildStatusBadge(String status) {
    return Row(
      children: [
        Container(
          width: _screenWidth * 0.02,
          height: _screenWidth * 0.02,
          decoration: const BoxDecoration(
            color: Color(0xFFFF6B6B),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: _screenWidth * 0.015),
        Text(
          status,
          style: GoogleFonts.poppins(
            fontSize: _screenWidth * 0.028,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFFF6B6B),
          ),
        ),
      ],
    );
  }

  // Product title widget
  Widget _buildProductTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: _screenWidth * 0.04,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF2D2D2D),
      ),
    );
  }

  // Product description widget
  Widget _buildProductDescription(String description) {
    return Text(
      description,
      style: GoogleFonts.poppins(
        fontSize: _screenWidth * 0.03,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF9E9E9E),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Price and buy button widget
  Widget _buildPriceAndBuyButton(String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPriceText(price),
        _buildBuyButton(),
      ],
    );
  }

  // Price text widget
  Widget _buildPriceText(String price) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: price,
            style: GoogleFonts.poppins(
              fontSize: _screenWidth * 0.045,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          TextSpan(
            text: ' .00',
            style: GoogleFonts.poppins(
              fontSize: _screenWidth * 0.035,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }

  // Buy button widget
  Widget _buildBuyButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _screenWidth * 0.05,
        vertical: _screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF3D3D3D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Buy',
        style: GoogleFonts.poppins(
          fontSize: _screenWidth * 0.035,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  // Bottom navigation bar widget
  Widget buildBottomNavigationBar() {
    return MotionTabBar(
      controller: _motionTabBarController,
      initialSelectedTab: "Home",
      useSafeArea: true,
      labels: const ["Home", "Lock", "Star", "Profile"],
      icons: const [
        Icons.home_rounded,
        Icons.lock_outline,
        Icons.star_border,
        Icons.person_outline,
      ],
      tabSize: _screenWidth * 0.125,
      tabBarHeight: _screenHeight * 0.07,
      textStyle: GoogleFonts.poppins(
        fontSize: _screenWidth * 0.03,
        color: const Color(0xFFFF6B6B),
        fontWeight: FontWeight.w500,
      ),
      tabIconColor: const Color(0xFF9E9E9E),
      tabIconSize: _screenWidth * 0.07,
      tabIconSelectedSize: _screenWidth * 0.065,
      tabSelectedColor: const Color(0xFFFF6B6B),
      tabIconSelectedColor: Colors.white,
      tabBarColor: Colors.white,
      onTabItemSelected: (int value) {
        setState(() {
          _motionTabBarController!.index = value;
        });
      },
    );
  }
}

class FurnitureProduct {
  final int id;
  final String title;
  final String status;
  final String description;
  final String price;
  final String imageUrl;

  FurnitureProduct({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

// Sample product data
final List<FurnitureProduct> sampleProducts = [
  FurnitureProduct(
    id: 0,
    title: 'Irul Chair',
    status: 'In Stock',
    description: 'Ergonomical for humans body curve.',
    price: '\$102',
    imageUrl: 'https://static.vecteezy.com/system/resources/previews/028/578/319/non_2x/sofa-3d-rendering-icon-illustration-free-png.png',
  ),
  FurnitureProduct(
    id: 1,
    title: 'Malik Chair',
    status: 'In Stock',
    description: 'Extra comfy chair with a plain rest.',
    price: '\$221',
    imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/021/186/877/small/couch-3d-illustration-png.png',
  ),
  FurnitureProduct(
    id: 2,
    title: 'Seto Chair',
    status: 'In Stock',
    description: 'Modern design with comfort.',
    price: '\$189',
    imageUrl: 'https://static.vecteezy.com/system/resources/previews/011/794/199/non_2x/fabric-armchair-soft-cushion-with-metal-leg-3d-rendering-modern-interior-design-for-living-room-free-png.png',
  ),
];




