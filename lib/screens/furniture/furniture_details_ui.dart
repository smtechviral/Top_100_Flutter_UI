import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FurnitureDetailPage extends StatefulWidget {
  final String title;
  final String price;
  final String description;
  final String imageUrl;
  final int productIndex;

  const FurnitureDetailPage({
    Key? key,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.productIndex,
  }) : super(key: key);

  @override
  State<FurnitureDetailPage> createState() => _FurnitureDetailPageState();
}

class _FurnitureDetailPageState extends State<FurnitureDetailPage> {
  int selectedColorIndex = 0;
  int quantity = 1;
  int currentImageIndex = 0;
  bool isFavorite = false;

  final List<Color> availableColors = [
    Color(0xFF8B4513), // Brown
    Color(0xFF2C3E50), // Dark Blue
    Color(0xFF6B4423), // Medium Brown
    Color(0xFF1E3A8A), // Blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            buildMainContent(),
            buildBottomPriceSection()

          ],
        ),
      ),
    );
  }

  // Helper methods for responsive dimensions
  double get _screenWidth => MediaQuery.of(context).size.width;
  double get _screenHeight => MediaQuery.of(context).size.height;

  // Main scrollable content
  Widget buildMainContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            buildImageSection(),
            buildProductDetailsSection()

          ],
        ),
      ),
    );
  }

  // Image section with header buttons
  Widget buildImageSection() {
    return Container(
      height: _screenHeight * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          _buildMainImage(),
          _buildBackButton(),
          _buildFavoriteButton(),
          _buildImageIndicatorDots(),
        ],
      ),
    );
  }

  // Main product image
  Widget _buildMainImage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _screenWidth * 0.1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            widget.imageUrl,
            height: _screenHeight * 0.40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.chair,
                size: _screenWidth * 0.3,
                color: Color(0xFF9E9E9E),
              );
            },
          ),
        ),
      ),
    );
  }

  // Back button
  Widget _buildBackButton() {
    return Positioned(
      top: 16,
      left: 16,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF2D2D2D),
          ),
        ),
      ),
    );
  }

  // Favorite button
  Widget _buildFavoriteButton() {
    return Positioned(
      top: 16,
      right: 16,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 22,
            color: Color(0xFFFF6B6B),
          ),
        ),
      ),
    );
  }

  // Image indicator dots
  Widget _buildImageIndicatorDots() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
              (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: index == currentImageIndex ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: index == currentImageIndex
                  ? Color(0xFF2D2D2D)
                  : Color(0xFFBDBDBD),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  // Product details section
  Widget buildProductDetailsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(_screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleAndRating(),
            SizedBox(height: 8),
            _buildBrandName(),
            SizedBox(height: 16),
            _buildDescription(),
            SizedBox(height: 24),
            _buildThumbnailImages(),
            SizedBox(height: 24),
            _buildColorAndQuantitySection(),
          ],
        ),
      ),
    );
  }

  // Title and rating row
  Widget _buildTitleAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: _screenWidth * 0.06,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ),
        _buildRatingBadge(),
      ],
    );
  }

  // Rating badge
  Widget _buildRatingBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Color(0xFFFFA500),
            size: 18,
          ),
          SizedBox(width: 4),
          Text(
            '4.7',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ],
      ),
    );
  }

  // Brand name
  Widget _buildBrandName() {
    return Text(
      'by Jello',
      style: GoogleFonts.poppins(
        fontSize: _screenWidth * 0.035,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9E9E9E),
      ),
    );
  }

  // Product description
  Widget _buildDescription() {
    return Text(
      'Crafted with a perfect combination by Seto Fabricant and have a balancing ergonomic for human\'s body, top quality leather in the back of the rest.',
      style: GoogleFonts.poppins(
        fontSize: _screenWidth * 0.0375,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B6B6B),
        height: 1.6,
      ),
    );
  }

  // Thumbnail images
  Widget _buildThumbnailImages() {
    return Row(
      children: List.generate(
        3,
            (index) => GestureDetector(
          onTap: () {
            setState(() {
              currentImageIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 12),
            width: _screenWidth * 0.18,
            height: _screenWidth * 0.18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: currentImageIndex == index
                    ? Color(0xFF2D2D2D)
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.chair,
                    size: 30,
                    color: Color(0xFF9E9E9E),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Color and quantity section
  Widget _buildColorAndQuantitySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildColorSelector(),
        _buildQuantitySelector(),
      ],
    );
  }

  // Color selector
  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: GoogleFonts.poppins(
            fontSize: _screenWidth * 0.04,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: List.generate(
            availableColors.length,
                (index) => _buildColorOption(index),
          ),
        ),
      ],
    );
  }

  // Individual color option
  Widget _buildColorOption(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColorIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: availableColors[index],
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColorIndex == index
                ? Color(0xFF2D2D2D)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: selectedColorIndex == index
            ? Icon(
          Icons.check,
          color: Colors.white,
          size: 18,
        )
            : null,
      ),
    );
  }

  // Quantity selector
  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _buildQuantityButton(
            icon: Icons.remove,
            onPressed: () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                });
              }
            },
          ),
          Text(
            '$quantity',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
            ),
          ),
          _buildQuantityButton(
            icon: Icons.add,
            onPressed: () {
              setState(() {
                quantity++;
              });
            },
          ),
        ],
      ),
    );
  }

  // Quantity button (+ or -)
  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Color(0xFF2D2D2D),
        size: 20,
      ),
    );
  }

  // Bottom price and buy button section
  Widget buildBottomPriceSection() {
    return Container(
      padding: EdgeInsets.all(_screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPriceDisplay(),
          _buildBuyNowButton(),
        ],
      ),
    );
  }

  // Price display
  Widget _buildPriceDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Price',
          style: GoogleFonts.poppins(
            fontSize: _screenWidth * 0.035,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9E9E9E),
          ),
        ),
        SizedBox(height: 2),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.price,
                style: GoogleFonts.poppins(
                  fontSize: _screenWidth * 0.07,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              TextSpan(
                text: '.00',
                style: GoogleFonts.poppins(
                  fontSize: _screenWidth * 0.045,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Buy now button
  Widget _buildBuyNowButton() {
    return GestureDetector(
      onTap: _handleBuyNow,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _screenWidth * 0.08,
          vertical: _screenHeight * 0.011,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFFF6B6B),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFF6B6B).withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          'Buy now',
          style: GoogleFonts.poppins(
            fontSize: _screenWidth * 0.035,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Handle buy now action
  void _handleBuyNow() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${widget.title} to cart!'),
        backgroundColor: Color(0xFFFF6B6B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}