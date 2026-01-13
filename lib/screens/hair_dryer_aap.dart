import 'dart:ui';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  double _dragPosition = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.delta.dx;
      if (_dragPosition < 0) _dragPosition = 0;
      if (_dragPosition > 200) _dragPosition = 200;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragPosition > 100) {
      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    } else {
      // Reset position
      setState(() {
        _dragPosition = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFB8C5E8), Color(0xFFD4C5E8), Color(0xFFE8D4E8)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 40,),
              buildHeader(),
              SizedBox(height: 30,),
              buildImage(),
              SizedBox(height: 20,),
              buildDec(),
              SizedBox(height: 20,),
              buildButton()
            ],
          ),
        ),

      ),
    );
  }

  buildHeader() {
    return Text(
      'Airy Hair\nDrier',
      style: TextStyle(
        color: Colors.white,
        fontSize: 56,
        fontWeight: FontWeight.bold,
        height: 1.1,
      ),
    );
  }

  buildImage() {
    return Image.asset(
      "assets/images/d1.png",
      width: 200,
      height: 470,
      fit: BoxFit.cover,
    );
  }

  buildDec() {
    return Text(
      'Airy Hair Dryer delivers fast, even drying with a lightweight,\nergonomic design for everyday comfort.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 13,
        height: 1.5,
      ),
    );
  }

  buildButton() {
    return Center(
      child: GestureDetector(
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Background track
            GlassMorphicContainer2(
              child: Container(
                width: 280,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white.withOpacity(0.5),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            // Draggable power button
            Transform.translate(
              offset: Offset(_dragPosition, 0),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GlassMorphicContainer1(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.power_settings_new,
                      color: Colors.white.withOpacity(0.9),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Model
class Product {
  final String name;
  final String price;
  final String image;
  final Color primaryColor;
  final Color secondaryColor;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int selectedTab = 0;
  late PageController _pageController;
  int _currentPage = 0;

  final List<Product> products = [
    Product(
      name: 'Airy Hair Drier',
      price: '\$254',
      image: 'assets/images/h1.png',
      primaryColor: Color(0xFFD4C5E8),
      secondaryColor: Color(0xFFB8C5E8),
    ),
    Product(
      name: 'Pro Hair Styler',
      price: '\$189',
      image: 'assets/images/h1.png',
      primaryColor: Color(0xFFFFB6C1),
      secondaryColor: Color(0xFFFFE4E1),
    ),
    Product(
      name: 'Turbo Dryer X',
      price: '\$299',
      image: 'assets/images/h1.png',
      primaryColor: Color(0xFFB0E0E6),
      secondaryColor: Color(0xFF87CEEB),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              products[_currentPage].primaryColor,
              products[_currentPage].secondaryColor,
              products[_currentPage].primaryColor,
            ],
          ),
        ),
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProfileHeader(),
              SizedBox(height: 24,),
              buildMainTitle(),
              SizedBox(height: 24,),
              buildSearch(),
              SizedBox(height: 20,),
              buildCategory(),
              SizedBox(height: 20,),
              buildSwipeCard(),
              SizedBox(height: 10,),
              buildPageIndicator(),
              SizedBox(height: 20,)
            ],
          ),
        )),

      ),
    );
  }

  buildProfileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                "https://i.pinimg.com/736x/0b/97/6f/0b976f0a7aa1aa43870e1812eee5a55d.jpg",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Sunny',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        GlassMorphicIconButton(icon: Icons.shopping_bag_outlined, onTap: () {}),
      ],
    );
  }

  buildMainTitle() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Redefining ',
            style: TextStyle(
              color: Colors.white.withOpacity(.6),
              fontSize: 40,
              fontWeight: FontWeight.w400,
              height: 1.1,
            ),
          ),
          TextSpan(
            text: 'Hair\nDrying.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  buildSearch() {
    return Row(
      children: [
        Expanded(
          child: GlassMorphicContainer1(
            padding: EdgeInsets.all(1),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GlassMorphicContainer1(
                    child: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Search products',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        GlassMorphicIconButton(icon: Icons.tune, onTap: () {}),
      ],
    );
  }

  buildCategory() {
    return Row(
      children: [
        CategoryTab(
          text: 'All items',
          isSelected: selectedTab == 0,
          onTap: () => setState(() => selectedTab = 0),
        ),
        SizedBox(width: 12),
        CategoryTab(
          text: 'Hair Dryer',
          isSelected: selectedTab == 1,
          onTap: () => setState(() => selectedTab = 1),
        ),
        SizedBox(width: 12),
        CategoryTab(
          text: 'Styling Tools',
          isSelected: selectedTab == 2,
          onTap: () => setState(() => selectedTab = 2),
        ),
      ],
    );
  }

  buildSwipeCard() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: products.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeOut.transform(value) * 600,
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductCard(product: products[index]),
            ),
          );
        },
      ),
    );
  }

  buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        products.length,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Colors.white
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphicContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Center(
              child: Text(
                product.name,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          SizedBox(height: 12),

          // Price and Product Image
          Expanded(
            child: Stack(
              children: [
                // Price text with blur in background
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      product.price,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -5,
                      ),
                    ),
                  ),
                ),
                // Product image
                Positioned(
                  right: -20,
                  bottom: 0,
                  top: 100,
                  child: Container(
                    width: 320,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.contain,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 5),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Container(
                  width: 180,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Text(
                    'Add to cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8B9DC3),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                GlassMorphicIconButton(
                  icon: Icons.favorite_border,
                  onTap: () {},
                ),
                SizedBox(width: 8),
                GlassMorphicIconButton(icon: Icons.add, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GlassMorphicContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const GlassMorphicContainer({Key? key, required this.child, this.padding})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 2.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GlassMorphicContainer1 extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const GlassMorphicContainer1({Key? key, required this.child, this.padding})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GlassMorphicContainer2 extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const GlassMorphicContainer2({Key? key, required this.child, this.padding})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 300,
          padding: padding ?? EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GlassMorphicButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const GlassMorphicButton({Key? key, required this.child, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class GlassMorphicIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const GlassMorphicIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Icon(icon, color: Colors.white.withOpacity(0.9), size: 24),
          ),
        ),
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTab({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Color(0xFF8B9DC3)
                : Colors.white.withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
