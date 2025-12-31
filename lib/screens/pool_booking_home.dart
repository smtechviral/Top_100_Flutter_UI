import 'package:flutter/material.dart';

class PoolBookingHome extends StatefulWidget {
  const PoolBookingHome({Key? key}) : super(key: key);

  @override
  State<PoolBookingHome> createState() => _PoolBookingHomeState();
}

class _PoolBookingHomeState extends State<PoolBookingHome> {
  int _selectedIndex = 0;
  String _selectedFilter = 'Public';

  // Nearby pools data
  final List<Map<String, dynamic>> nearbyPools = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800',
      'title': 'Hotel Arcadia (Rooftop)',
      'price': '₹ 2,000 - ₹ 4,500',
      'priceUnit': 'per hours',
      'rating': 3.0,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
      'title': 'Luxury Sky Pool',
      'price': '₹ 3,000 - ₹ 6,000',
      'priceUnit': 'per hours',
      'rating': 4.2,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
      'title': 'Paradise Resort Pool',
      'price': '₹ 1,500 - ₹ 3,500',
      'priceUnit': 'per hours',
      'rating': 4.5,
    },
  ];

  // Recommended pools data
  final List<Map<String, dynamic>> recommendedPools = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1575429198097-0414ec08e8cd?w=800',
      'isPrivate': true,
      'title': 'Taj Kumarakom Resort',
      'rating': 4.5,
      'reviews': 20,
      'price': '₹1,500 - ₹3,000',
      'priceUnit': 'per hours',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=800',
      'isPrivate': false,
      'title': 'Kottayam Club, Kanji...',
      'rating': 4.5,
      'reviews': 201,
      'price': '₹200 - ₹500',
      'priceUnit': 'per person',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=800',
      'isPrivate': true,
      'title': 'Marina Bay Resort',
      'rating': 4.8,
      'reviews': 156,
      'price': '₹2,500 - ₹5,000',
      'priceUnit': 'per hours',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=800',
      'isPrivate': false,
      'title': 'City Sports Club',
      'rating': 4.2,
      'reviews': 89,
      'price': '₹150 - ₹300',
      'priceUnit': 'per person',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4F8),
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            buildSearchBar(),
            buildFilterChips(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildNearbySection(),
                    SizedBox(height: 24,),
                    buildRecommendedSection(),
                    SizedBox(height: 24,)
                
                
                  ],
                ),
              ),
            )
          ],
        ),

      ),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF6B4CE6), Color(0xFF9B7EF5)],
              ),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'My Location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF6B7280)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Icon(Icons.location_on, color: Color(0xFF2563EB), size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Kottayam, Kerala',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.notifications_outlined, color: Color(0xFF1F2937)),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            Expanded(
              child: Text(
                'Find pool by location',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
            Icon(Icons.tune, color: Color(0xFF6B7280)),
          ],
        ),
      ),
    );
  }

  Widget buildFilterChips() {
    final filters = [
      {'icon': Icons.public, 'label': 'Public'},
      {'icon': Icons.workspace_premium, 'label': 'Premium'},
      {'icon': Icons.lock_outline, 'label': 'Private'},
      {'icon': Icons.hot_tub, 'label': 'Indoor Heat'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            final isSelected = _selectedFilter == filter['label'];
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FilterChip(
                selected: isSelected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      filter['icon'] as IconData,
                      size: 16,
                      color: isSelected ? Colors.white : const Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      filter['label'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF6B7280),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                selectedColor: const Color(0xFF1F2937),
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = filter['label'] as String;
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Nearby You!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              Icon(Icons.more_horiz, color: Color(0xFF6B7280)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: nearbyPools.length,
            itemBuilder: (context, index) {
              final pool = nearbyPools[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index < nearbyPools.length - 1 ? 16 : 0,
                ),
                child: _buildNearbyCard(
                  imageUrl: pool['imageUrl'],
                  title: pool['title'],
                  price: pool['price'],
                  priceUnit: pool['priceUnit'],
                  rating: pool['rating'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyCard({
    required String imageUrl,
    required String title,
    required String price,
    required String priceUnit,
    required double rating,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width * 0.85,
              height: 220,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 220,
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: Color(0xFFFBBF24), size: 16),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: price,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' $priceUnit',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Get More Info',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
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

  Widget buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Recommended For You!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              Icon(Icons.more_horiz, color: Color(0xFF6B7280)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.86,
            ),
            itemCount: recommendedPools.length,
            itemBuilder: (context, index) {
              final pool = recommendedPools[index];
              return _buildRecommendedCard(
                imageUrl: pool['imageUrl'],
                isPrivate: pool['isPrivate'],
                title: pool['title'],
                rating: pool['rating'],
                reviews: pool['reviews'],
                price: pool['price'],
                priceUnit: pool['priceUnit'],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedCard({
    required String imageUrl,
    required bool isPrivate,
    required String title,
    required double rating,
    required int reviews,
    required String price,
    required String priceUnit,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPrivate ? Icons.lock_outline : Icons.public,
                        size: 14,
                        color: const Color(0xFF6B7280),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isPrivate ? 'Private Pool' : 'Public Pool',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      'Resort:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$rating',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        '($reviews Reviews)',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9CA3AF),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: price,
                        style: const TextStyle(
                          color: Color(0xFF2563EB),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' $priceUnit',
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: const Color(0xFF9CA3AF),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}