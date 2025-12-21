import 'package:flutter/material.dart';

class EcoHomeScreen extends StatefulWidget {
  const EcoHomeScreen({Key? key}) : super(key: key);

  @override
  State<EcoHomeScreen> createState() => _EcoHomeScreenState();
}

class _EcoHomeScreenState extends State<EcoHomeScreen> {
  int selectedIndex = 0;
  final List<Product> newArrivals = [
    Product(
      id: '1',
      name: 'Brown Jacket',
      price: 210,
      image:
          'https://images-cdn.ubuy.co.in/68b3eed3c31b87e2ca02d01c-tacvasen-men-s-bomber-jacket-lightweight.jpg',
      isFavorite: false,
    ),
    Product(
      id: '2',
      name: 'White Sneakers',
      price: 120,
      image:
          'https://converse.static.n7.io/media/catalog/product/cache/c2eb1f0db702462ce5dab3d57b75c6e4/1/u/1u646c_e_107x155.jpg',
      isFavorite: false,
    ),
  ];

  void onBottomNavTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _toggleFavorite(String productId) {
    setState(() {
      final product = newArrivals.firstWhere((p) => p.id == productId);
      product.isFavorite = !product.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(),
                SizedBox(height: 20,),
                SearchBarWidget(
                  onFilterTap: () {

                  },
                ),
                SizedBox(height: 20,),
                PromoBanner(),
                SizedBox(height: 20,),
                SectionHeader(title: "Categories"),
                SizedBox(height: 15,),
                CategoriesRow(),
                SizedBox(height: 25,),
                SectionHeader(title: "New Arrival"),
                SizedBox(height: 15,),
                ProductGrid(
                  onFavoriteToggle: _toggleFavorite,
                  products: newArrivals,

                ),
                SizedBox(height: 80,)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: CustomBottomNavBar(
          currentIndex: selectedIndex,
          onTap: onBottomNavTap,
        ),
      ),
    );
  }
}

// Custom Widgets

// 1. Menu Icon Widget
class MenuIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const MenuIcon({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.menu, color: Colors.black, size: 24),
      ),
    );
  }
}

// 2. Cart Icon Widget
class CartIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final int itemCount;

  const CartIcon({Key? key, this.onTap, this.itemCount = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
              size: 24,
            ),
            if (itemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// 3. Top Bar Widget
class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MenuIcon(
          onTap: () {
            // Open drawer
          },
        ),
        CartIcon(
          onTap: () {
            // Navigate to cart
          },
        ),
      ],
    );
  }
}

// 4. Search Bar Widget
class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onFilterTap;

  const SearchBarWidget({Key? key, this.onFilterTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.search, color: Colors.grey, size: 24),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.tune, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// 5. Promo Banner Widget with Carousel
class PromoBanner extends StatefulWidget {
  const PromoBanner({Key? key}) : super(key: key);

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<BannerData> banners = [
    BannerData(
      title: 'First Purchase Enjoy',
      subtitle: 'a Special Offer',
      tag: 'Limited Offer',
      imageUrl:
          'https://static.vecteezy.com/system/resources/thumbnails/008/476/780/small/asian-woman-with-her-shopping-bags-file-png.png',
      gradient: [Color(0xFFB4D86B), Color(0xFFA8D85F)],
    ),
    BannerData(
      title: 'Summer Collection',
      subtitle: 'Up to 50% Off',
      tag: 'Hot Deal',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/048/778/727/non_2x/clothes-hanging-on-wooden-hanger-ai-generative-free-png.png',
      gradient: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
    ),
    BannerData(
      title: 'New Arrivals',
      subtitle: 'Check Latest Trends',
      tag: 'Trending',
      imageUrl:
          'https://png.pngtree.com/png-vector/20240131/ourmid/pngtree-clothing-garment-apparel-png-image_11576281.png',
      gradient: [Color(0xFFA8EDEA), Color(0xFFFED6E3)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Auto scroll every 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _autoScroll();
      }
    });
  }

  void _autoScroll() {
    if (!mounted) return;

    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients && mounted) {
        int nextPage = _currentPage + 1;
        if (nextPage >= banners.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        _autoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return BannerCard(banner: banners[index]);
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: BannerDot(isActive: index == _currentPage),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Banner Data Model
class BannerData {
  final String title;
  final String subtitle;
  final String tag;
  final String imageUrl;
  final List<Color> gradient;

  BannerData({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.imageUrl,
    required this.gradient,
  });
}

// Banner Card Widget
class BannerCard extends StatelessWidget {
  final BannerData banner;

  const BannerCard({Key? key, required this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: banner.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                banner.tag,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  banner.subtitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: ShopNowButton(
              onTap: () {
                // Navigate to shop
              },
            ),
          ),
          Positioned(
            right: -20,
            bottom: 0,
            top: 20,
            child: Image.network(
              banner.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(width: 150, color: Colors.transparent);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 6. Shop Now Button Widget
class ShopNowButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ShopNowButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Shop Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

// 7. Banner Dot Widget
class BannerDot extends StatelessWidget {
  final bool isActive;

  const BannerDot({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFB4D86B)
            : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// 8. Section Header Widget
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;

  const SectionHeader({Key? key, required this.title, this.onSeeAllTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: const Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ],
    );
  }
}

// 9. Category Card Widget
class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 60,
                      width: 60,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 10. Categories Row Widget
class CategoriesRow extends StatelessWidget {
  const CategoriesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryCard(
            title: "Men's\noutfit",
            imageUrl:
                'https://images.unsplash.com/photo-1516257984-b1b4d707412e?w=300',
            onTap: () {},
          ),
          const SizedBox(width: 12),
          CategoryCard(
            title: "woman's\noutfit",
            imageUrl:
                'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=300',
            onTap: () {},
          ),
          const SizedBox(width: 12),
          CategoryCard(
            title: "Men's\nfootwears",
            imageUrl:
                'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300',
            onTap: () {},
          ),
          CategoryCard(
            title: "Men's\nfootwears",
            imageUrl:
                'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// 11. Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onFavoriteTap;

  const ProductCard({Key? key, required this.product, this.onFavoriteTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: true,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // soft shadow color
              blurRadius: 8, // how blurry the shadow is
              offset: const Offset(0, 4), // x,y offset
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 12. Product Grid Widget
class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Function(String) onFavoriteToggle;

  const ProductGrid({
    Key? key,
    required this.products,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onFavoriteTap: () => onFavoriteToggle(products[index].id),
        );
      },
    );
  }
}

// 13. Custom Bottom Navigation Bar Widget
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            icon: Icons.home,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          NavBarItem(
            icon: Icons.local_shipping_outlined,
            label: 'Orders',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          NavBarItem(
            icon: Icons.favorite_border,
            label: 'Wishlist',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          NavBarItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

// 14. Nav Bar Item Widget
class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFB4D86B).withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF76A832) : Colors.grey,
              size: 24,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF76A832),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Product Model
class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.isFavorite = false,
  });
}
