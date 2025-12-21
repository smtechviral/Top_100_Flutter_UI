import 'package:day_challenge_100/widgets/appColor.dart';
import 'package:flutter/material.dart';

class HotelBookingHome extends StatefulWidget {
  const HotelBookingHome({Key? key}) : super(key: key);

  @override
  State<HotelBookingHome> createState() => _HotelBookingHomeState();
}

class _HotelBookingHomeState extends State<HotelBookingHome> {
  final TextEditingController searchController = TextEditingController();
  final Set<int> bookmarkedHotels = {};

  void _toggleBookmark(int hotelId) {
    setState(() {
      if (bookmarkedHotels.contains(hotelId)) {
        bookmarkedHotels.remove(hotelId);
      } else {
        bookmarkedHotels.add(hotelId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Where do you want to stay?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              buildSearchBar(),
              SizedBox(height: 20,),
              buildSectionHeader("Popular Hotels"),
              SizedBox(height: 15,),
              buildPopularHotels(),
              SizedBox(height: 30,),
              buildSectionHeader("More Hotels"),
              SizedBox(height: 15,),
              buildMoreHotels(),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=12'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.blue.shade100, width: 2),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Hello Ripon!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.notifications_outlined, size: 24),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search your hotel',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'See all',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPopularHotels() {
    final hotels = [
      {
        'id': 1,
        'name': 'Hotel Royel Sea Crown',
        'location': 'Dhaka, Bangladesh',
        'image':
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
      },
      {
        'id': 2,
        'name': 'Hotel Royal Palace',
        'location': 'Dhaka, Bangladesh',
        'image':
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800',
      },
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return _buildPopularHotelCard(
            hotel['id'] as int,
            hotel['name'] as String,
            hotel['location'] as String,
            hotel['image'] as String,
          );
        },
      ),
    );
  }

  Widget _buildPopularHotelCard(
    int id,
    String name,
    String location,
    String imageUrl,
  ) {
    final isBookmarked = bookmarkedHotels.contains(id);

    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              width: 280,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.blue.shade900,
                  child: const Center(
                    child: Icon(Icons.hotel, color: Colors.white, size: 50),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: GestureDetector(
              onTap: () => _toggleBookmark(id),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isBookmarked ? Icons.favorite : Icons.favorite_border,
                  color: isBookmarked ? Colors.red : Colors.black87,
                  size: 22,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMoreHotels() {
    final hotels = [
      {
        'id': 3,
        'name': 'Century Park Hotel',
        'location': "Cox's bazar, Bangladesh",
        'rating': 4.7,
        'reviews': '150+',
        'price': 69,
        'image':
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400',
      },
      {
        'id': 4,
        'name': 'Prime Plaza Hotel',
        'location': "Cox's bazar, Bangladesh",
        'rating': 4.5,
        'reviews': '120+',
        'price': 85,
        'image':
            'https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=400',
      },
      {
        'id': 5,
        'name': 'Ocean View Resort',
        'location': "Cox's bazar, Bangladesh",
        'rating': 4.8,
        'reviews': '200+',
        'price': 95,
        'image':
            'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        return _buildMoreHotelCard(
          hotel['id'] as int,
          hotel['name'] as String,
          hotel['location'] as String,
          hotel['rating'] as double,
          hotel['reviews'] as String,
          hotel['price'] as int,
          hotel['image'] as String,
        );
      },
    );
  }

  Widget _buildMoreHotelCard(
    int id,
    String name,
    String location,
    double rating,
    String reviews,
    int price,
    String imageUrl,
  ) {
    final isBookmarked = bookmarkedHotels.contains(id);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.blue.shade100,
                  child: const Icon(Icons.hotel, color: Colors.blue, size: 40),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _toggleBookmark(id),
                        child: Icon(
                          isBookmarked ? Icons.favorite : Icons.favorite_border,
                          color: isBookmarked ? Colors.red : Colors.grey,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey.shade600,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$rating ($reviews)',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$$price',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(
                              text: '/Night',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
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
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
