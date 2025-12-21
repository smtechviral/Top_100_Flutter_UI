import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int currentImageIndex = 0;
  String selectedSize = 'L';
  int quantity = 1;
  bool isFavorite = false;
  bool isFollowing = true;

  final List<String> productImages = [
    'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=800',
    'https://images.unsplash.com/photo-1560769629-975ec94e6a86?w=800',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
  ];

  final List<String> sizes = ['S', 'M', 'L', 'XL'];

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void toggleFollowing() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerWidgets(),
                  ProductImageCarousel(
                    images: productImages,
                    currentIndex: currentImageIndex,
                    onPageChanged: (index) {
                      currentImageIndex = index;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Men Footwear",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            FavoriteButton(
                              isFavorite: isFavorite,
                              onTap: toggleFavorite,
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        Text(
                          "Grey Casual shoe",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                          ),
                        ),
                        SizedBox(height: 20),
                        StoreInfoCard(
                          isFollowing: isFollowing,
                          onFollowTap: toggleFollowing,
                        ),
                        SizedBox(height: 25),
                        selectSizeWidgets(),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: SizeSelector(
                                sizes: sizes,
                                selectedSize: selectedSize,
                                onSizeSelected: (size) {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                              ),
                            ),
                            QuantitySelector(
                              quantity: quantity,
                              onIncrement: incrementQuantity,
                              onDecrement: decrementQuantity,
                            ),
                          ],
                        ),
                        SizedBox(height: 25,),
                        descriptionWidgets(),
                        SizedBox(height: 100,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomButtonWidgets(context)
          ],
        ),
      ),
    );
  }
}

headerWidgets() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButtonWidget(
          onTap: () {
            // Navigate back
          },
        ),
        const Text(
          'Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        BagIconWidget(
          onTap: () {
            // Navigate to cart
          },
        ),
      ],
    ),
  );
}

descriptionWidgets() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Description',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Step into comfort and style with these sleek grey casual shoes. Perfect for everyday wear, these shoes feature a minimalist design that pairs well with any outfit.',
        style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
      ),
    ],
  );
}

selectSizeWidgets() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Select size',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      const Text(
        'QTY',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

bottomButtonWidgets(BuildContext context) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: AddToCartBar(
      price: 120,
      onAddToCart: () {
        // Add to cart action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to cart!'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    ),
  );
}

// 1. Back Button Widget
class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const BackButtonWidget({Key? key, this.onTap}) : super(key: key);

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
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 18,
        ),
      ),
    );
  }
}

// 2. Bag Icon Widget
class BagIconWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const BagIconWidget({Key? key, this.onTap}) : super(key: key);

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
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.black,
          size: 22,
        ),
      ),
    );
  }
}

// 3. Product Image Carousel Widget
class ProductImageCarousel extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final Function(int) onPageChanged;

  const ProductImageCarousel({
    Key? key,
    required this.images,
    required this.currentIndex,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: PageView.builder(
              itemCount: images.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image, size: 80, color: Colors.grey),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => ImageIndicatorDot(isActive: index == currentIndex),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Image Indicator Dot Widget
class ImageIndicatorDot extends StatelessWidget {
  final bool isActive;

  const ImageIndicatorDot({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// 5. Favorite Button Widget
class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoriteButton({
    Key? key,
    required this.isFavorite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey,
          size: 22,
        ),
      ),
    );
  }
}

// 6. Store Info Card Widget
class StoreInfoCard extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onFollowTap;

  const StoreInfoCard({
    Key? key,
    required this.isFollowing,
    required this.onFollowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Store Logo
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.store, color: Color(0xFF2196F3), size: 28),
        ),
        const SizedBox(width: 12),

        // Store Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    'Smtechviral Store',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.verified, size: 18, color: Colors.black),
                ],
              ),
              const SizedBox(height: 2),
              const Text(
                'Official store',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),

        // Follow Button
        FollowButton(isFollowing: isFollowing, onTap: onFollowTap),
      ],
    );
  }
}

// 7. Follow Button Widget
class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onTap;

  const FollowButton({Key? key, required this.isFollowing, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isFollowing ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isFollowing ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isFollowing ? Icons.check : Icons.add,
              color: isFollowing ? Colors.white : Colors.black,
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              isFollowing ? 'Following' : 'Follow',
              style: TextStyle(
                color: isFollowing ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 8. Size Selector Widget
class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String selectedSize;
  final Function(String) onSizeSelected;

  const SizeSelector({
    Key? key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: sizes.map((size) {
        final isSelected = size == selectedSize;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SizeButton(
            size: size,
            isSelected: isSelected,
            onTap: () => onSizeSelected(size),
          ),
        );
      }).toList(),
    );
  }
}

// 9. Size Button Widget
class SizeButton extends StatelessWidget {
  final String size;
  final bool isSelected;
  final VoidCallback onTap;

  const SizeButton({
    Key? key,
    required this.size,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB4D86B) : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// 10. Quantity Selector Widget
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          QuantityButton(icon: Icons.remove, onTap: onDecrement),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          QuantityButton(icon: Icons.add, onTap: onIncrement),
        ],
      ),
    );
  }
}

// 11. Quantity Button Widget
class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QuantityButton({Key? key, required this.icon, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.black, size: 20),
      ),
    );
  }
}

// 12. Add to Cart Bar Widget
class AddToCartBar extends StatelessWidget {
  final double price;
  final VoidCallback onAddToCart;

  const AddToCartBar({Key? key, required this.price, required this.onAddToCart})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Total price',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            AddToCartButton(onTap: onAddToCart),
          ],
        ),
      ),
    );
  }
}

// 13. Add to Cart Button Widget
class AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddToCartButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFB4D86B),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
