
import 'package:flutter/material.dart';
import 'dart:ui';

// Product Model
class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String? discount;
  final String? tag;
  final String? description;
  final List<String>? tags;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.discount,
    this.tag,
    this.description,
    this.tags,
  });
}

// Mock Data
final List<Product> products = [
  Product(
    id: 1,
    name: "UNISEX RELAXED-FIT HOODIE",
    price: 198.00,
    image: "https://shop.teamsg.in/cdn/shop/files/3_9dd0e3dc-a202-49e1-9a1a-74e0e8ac8b90.jpg?v=1744283424&width=1445",
    discount: "-20%",
    tag: "SALE",
    description: "A creatively styled unisex hoodie. This hooded sweatshirt is cut to a relaxed fit in French cotton-terry.",
    tags: ["NEW", "REGULAR FIT", "PREMIUM QUALITY"],
  ),
  Product(
    id: 2,
    name: "COTTON-TERRY HOODIE",
    price: 198.00,
    image: "https://static.vecteezy.com/system/resources/thumbnails/045/592/974/small/handsome-man-wear-black-hoodie-on-transparent-background-png.png",
    discount: "-30%",
    tag: "HOT",
    description: "A creatively styled unisex hoodie by BOSS. This hooded sweatshirt is cut to a relaxed fit in French cotton-terry.",
    tags: ["NEW", "BOSS X FREDDIE MERCURY", "REGULAR FIT"],
  ),
  Product(
    id: 3,
    name: "CLASSIC SPORT HOODIE",
    price: 178.00,
    image: "https://images.unsplash.com/photo-1578587018452-892bacefd3f2?w=400&h=500&fit=crop",
    tag: "NEW",
    description: "Classic sport hoodie with premium quality fabric and modern design.",
    tags: ["NEW ARRIVAL", "SPORT EDITION"],
  ),
  Product(
    id: 4,
    name: "PREMIUM COTTON HOODIE",
    price: 215.00,
    image: "https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=400&h=500&fit=crop",
    description: "Premium quality cotton hoodie for ultimate comfort.",
    tags: ["PREMIUM", "LIMITED EDITION"],
  ),
];

// ==================== CUSTOM WIDGETS ====================

class ModernWidgets {
  // Glass Container
  static Widget buildGlassContainer({
    required Widget child,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    List<Color>? gradientColors,
    bool enableShadow = true,
    double? width,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors ??
              [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.05),
              ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: enableShadow
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: child,
        ),
      ),
    );
  }

  // Neumorphic Container
  static Widget buildNeumorphicContainer({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    Color? bgColor,
    bool isPressed = false,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.grey[100],
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: isPressed
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(6, 6),
            blurRadius: 15,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-4, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: child,
    );
  }

  // Title Text
  static Widget buildTitle(
      String text, {
        double fontSize = 18,
        FontWeight? fontWeight,
        Color? color,
        double letterSpacing = 0.5,
      }) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w800,
        letterSpacing: letterSpacing,
      ),
    );
  }

  // Subtitle Text
  static Widget buildSubtitle(
      String text, {
        double fontSize = 14,
        Color? color,
      }) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.grey[600],
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // 3D Floating Button
  static Widget build3DButton({
    required Widget child,
    VoidCallback? onTap,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    List<Color>? gradientColors,
    Color? solidColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          gradient: solidColor == null
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors ??
                [
                  const Color(0xFF667EEA),
                  const Color(0xFF764BA2),
                ],
          )
              : null,
          color: solidColor,
          boxShadow: [
            BoxShadow(
              color: (solidColor ?? gradientColors?.first ?? const Color(0xFF667EEA))
                  .withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }

  // Floating Card with 3D Transform
  static Widget buildFloatingCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? height,
    double? width,
    BorderRadius? borderRadius,
  }) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-0.01),
      alignment: Alignment.center,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(22),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  // Header with Glass Effect
  static Widget buildHeader({
    required Widget leading,
    required Widget title,
    required Widget trailing,
    EdgeInsetsGeometry? padding,
  }) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [leading, Expanded(child: Center(child: title)), trailing],
      ),
    );
  }

  // Gradient Badge
  static Widget buildBadge({
    required String text,
    List<Color>? gradientColors,
    Color? solidColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: solidColor == null
            ? LinearGradient(
          colors: gradientColors ??
              [
                Colors.orangeAccent,
                Colors.deepOrange,
              ],
        )
            : null,
        color: solidColor,
        boxShadow: [
          BoxShadow(
            color: (solidColor ?? Colors.orange).withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// Home Page
class ModernArobixApp extends StatefulWidget {
  const ModernArobixApp({Key? key}) : super(key: key);

  @override
  State<ModernArobixApp> createState() => _ModernArobixAppState();
}

class _ModernArobixAppState extends State<ModernArobixApp> {
  int _selectedIndex = 0;
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            buildModernHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 100),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        buildModernBanner(),
                        SizedBox(height: 28,),
                        buildCategoriesSection(),
                        SizedBox(height: 28,),
                        buildSectionHeader(),
                        SizedBox(height: 20,),
                        buildProductsGrid(),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: buildGlassBottomNav(),
    );
  }

  Widget buildModernHeader() {
    return ModernWidgets.buildHeader(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      leading: ThreeDIconButton(
        imageUrl: "https://images.icon-icons.com/2550/PNG/512/menu_icon_152582.png",
        onTap: () => print("Menu tapped"),
      ),
      title: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ).createShader(bounds),
        child: const Text(
          'SMSHOP',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
      ),
      trailing: ThreeDIconButton(
        imageUrl: "https://cdn-icons-png.flaticon.com/512/54/54481.png",
        onTap: () => print("Cart tapped"),
      ),
    );
  }

  Widget buildModernBanner() {
    return ModernWidgets.buildFloatingCard(
      height: 200,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF667EEA).withOpacity(0.1),
                  const Color(0xFF764BA2).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          Positioned(
            right: -30,
            bottom: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              child: Image.network(
                'https://pngimg.com/d/hoodie_PNG11.png',
                fit: BoxFit.contain,
                width: 220,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ModernWidgets.buildTitle(
                  'Buy 1',
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
                ModernWidgets.buildTitle(
                  'Get 3',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
                const SizedBox(height: 16),
                ModernWidgets.build3DButton(
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  borderRadius: BorderRadius.circular(25),
                  solidColor: Colors.black,
                  onTap: () {},
                  child: const Text(
                    'SHOP NOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesSection() {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategory("https://cdn-icons-png.flaticon.com/512/600/600233.png", 'Discount'),
          _buildCategory("https://cdn-icons-png.flaticon.com/512/3531/3531881.png", 'T-shirt'),
          _buildCategory("https://cdn-icons-png.flaticon.com/512/755/755999.png", 'Hoodie'),
          _buildCategory("https://cdn-icons-png.flaticon.com/512/1974/1974211.png", 'Hat'),
          _buildCategory("https://cdn-icons-png.flaticon.com/512/2589/2589973.png", 'Jeans'),
          _buildCategory("https://cdn-icons-png.flaticon.com/512/88/88815.png", 'Jackets'),
        ],
      ),
    );
  }

  Widget _buildCategory(String imageUrl, String title) {
    final bool isSelected = selectedCategory == title;

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ThreeDIconButton(
            imageUrl: imageUrl,
            size: 64,
            iconSize: 32,
            borderRadius: 18,
            backgroundColor: isSelected ? Colors.black : Colors.white,
            iconColor: isSelected ? Colors.white : Colors.black,
            isGradient: isSelected,
            onTap: () {
              setState(() {
                selectedCategory = title;
              });
            },
          ),
          const SizedBox(height: 8),
          ModernWidgets.buildSubtitle(
            title,
            fontSize: 12,
            color: isSelected ? Colors.black : Colors.grey[600],
          ),
        ],
      ),
    );
  }

  Widget buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ModernWidgets.buildTitle(
          'New Arrival',
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        GestureDetector(
          onTap: () {},
          child: ModernWidgets.buildSubtitle(
            'See all',
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget buildProductsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModernProductDetailPage(product: product),
          ),
        );
      },
      child: ModernWidgets.buildFloatingCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                    child: Image.network(
                      product.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                  if (product.discount != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: ModernWidgets.buildBadge(text: product.discount!),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModernWidgets.buildTitle(
                    '\$${product.price.toStringAsFixed(2)}',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                  const SizedBox(height: 6),
                  ModernWidgets.buildSubtitle(
                    product.name,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGlassBottomNav() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.4),
                  Colors.white.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home_rounded, 0),
                _buildNavItem(Icons.mail_outline_rounded, 1),
                _buildNavItem(Icons.shopping_bag_outlined, 2),
                _buildNavItem(Icons.person_outline_rounded, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(isSelected ? 14 : 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey[600],
          size: isSelected ? 30 : 28,
        ),
      ),
    );
  }
}

// Product Detail Page
class ModernProductDetailPage extends StatefulWidget {
  final Product product;

  const ModernProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ModernProductDetailPage> createState() => _ModernProductDetailPageState();
}

class _ModernProductDetailPageState extends State<ModernProductDetailPage> {
  bool isFavorite = false;
  bool isDetailExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildDetailHeader(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 10),
                  _buildProductImage(),
                  const SizedBox(height: 20),
                  _buildProductInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildAddToCartButton(),
    );
  }

  Widget _buildDetailHeader() {
    return ModernWidgets.buildHeader(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      leading: ThreeDIconButton(
        imageUrl: "https://cdn-icons-png.flaticon.com/512/271/271220.png",
        onTap: () => Navigator.pop(context),
        size: 44,
        iconSize: 20,
      ),
      title: ModernWidgets.buildTitle(
        'COTTON-TERRY HOODIE',
        fontSize: 13,
        letterSpacing: 1.2,
      ),
      trailing: GestureDetector(
        onTap: () => setState(() => isFavorite = !isFavorite),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.black,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ModernWidgets.buildFloatingCard(
        height: 420,
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Image.network(
            widget.product.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ).createShader(bounds),
            child: Text(
              '\$${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 14),
          ModernWidgets.buildTitle(
            widget.product.name.toUpperCase(),
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: (widget.product.tags ?? ['NEW', 'PREMIUM'])
                .map((tag) => _buildTag(tag))
                .toList(),
          ),
          const SizedBox(height: 28),
          _buildDetailSection(),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    final isNew = label == 'NEW';
    return ModernWidgets.buildBadge(
      text: label,
      solidColor: isNew ? Colors.black : Colors.grey[200],
    );
  }

  Widget _buildDetailSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => isDetailExpanded = !isDetailExpanded),
          child: Container(
            padding: const EdgeInsets.only(bottom: 16, top: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ModernWidgets.buildTitle(
                  'DETAIL',
                  fontSize: 15,
                  letterSpacing: 1.5,
                ),
                Icon(
                  isDetailExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  size: 28,
                  color: const Color(0xFF667EEA),
                ),
              ],
            ),
          ),
        ),
        if (isDetailExpanded) ...[
          const SizedBox(height: 18),
          ModernWidgets.buildSubtitle(
            widget.product.description ??
                'A creatively styled unisex hoodie by BOSS. This hooded sweatshirt is cut to a relaxed fit in French cotton-terry.',
            fontSize: 14,
          ),
        ],
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ModernWidgets.build3DButton(
        height: 58,
        borderRadius: BorderRadius.circular(35),
        solidColor: Colors.black,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to shopping bag!')),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 22),
            SizedBox(width: 14),
            Text(
              'ADD TO SHOPPING BAG',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ThreeDIconButton extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final double borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final bool isGradient;

  const ThreeDIconButton({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    this.size = 44,
    this.iconSize = 20,
    this.borderRadius = 12,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.isGradient = false,
  }) : super(key: key);

  @override
  State<ThreeDIconButton> createState() => _ThreeDIconButtonState();
}

class _ThreeDIconButtonState extends State<ThreeDIconButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: Matrix4.identity()
          ..translate(0.0, isPressed ? 3.0 : 0.0),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          gradient: widget.isGradient
              ? const LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          )
              : null,
          color: widget.isGradient ? null : widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 1.2,
          ),
          boxShadow: isPressed
              ? []
              : [
            BoxShadow(
              color: widget.isGradient
                  ? const Color(0xFF667EEA).withOpacity(0.4)
                  : Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Center(
          child: Image.network(
            widget.imageUrl,
            height: widget.iconSize,
            width: widget.iconSize,
            fit: BoxFit.contain,
            color: widget.iconColor,
          ),
        ),
      ),
    );
  }
}