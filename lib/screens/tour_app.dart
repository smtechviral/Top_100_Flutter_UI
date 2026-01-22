import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TourData {
  final String country;
  final String location;
  final String image;
  final int tourCount;
  final double rating;
  final int reviewCount;
  final String nights;
  final String price;
  final String badge;
  final List<String> amenities;
  final String bookingRating;
  final String hotelOutRating;
  final String description;

  TourData({
    required this.country,
    required this.location,
    required this.image,
    required this.tourCount,
    required this.rating,
    required this.reviewCount,
    required this.nights,
    required this.price,
    this.badge = '',
    required this.amenities,
    required this.bookingRating,
    required this.hotelOutRating,
    required this.description,
  });
}

class DiscountTourApp extends StatelessWidget {
  const DiscountTourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TourData> countries = [
      TourData(
        country: 'Thailand',
        location: 'Koh Chang Tai, Thailand',
        image:
            'https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?w=800',
        tourCount: 18,
        rating: 4.5,
        reviewCount: 211,
        nights: '10 nights for two/all inclusive',
        price: '\$ 245.50',
        badge: 'New',
        amenities: [
          'Free Wi-Fi',
          'Sand Beach',
          'Coastline',
          'Island Restaurant',
        ],
        bookingRating: '8.0/10',
        hotelOutRating: '4.0/5',
        description:
            'Sea Flower Resort is located in Ko Chang, 19 km from Klong Son Temple and 20 km from Ao Sapparot Pier. It offers a garden, free Wi-Fi and free private parking. Guests can benefit from valet parking and relax on the terrace.',
      ),
      TourData(
        country: 'Malaysia',
        location: 'Kuala Lumpur, Malaysia',
        image:
            'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800',
        tourCount: 12,
        rating: 4.3,
        reviewCount: 156,
        nights: '10 nights for two/all inclusive',
        price: '\$ 299.99',
        badge: 'Sale',
        amenities: ['Free Wi-Fi', 'Pool', 'City View', 'Restaurant'],
        bookingRating: '8.5/10',
        hotelOutRating: '4.2/5',
        description:
            'Experience the vibrant culture of Malaysia with stunning city views and world-class amenities.',
      ),
      TourData(
        country: 'Cuba',
        location: 'Havana, Cuba',
        image:
            'https://images.unsplash.com/photo-1611348586804-61bf6c080437?w=800',
        tourCount: 15,
        rating: 4.5,
        reviewCount: 189,
        nights: '10 nights for two/all inclusive',
        price: '\$ 499.99',
        badge: '',
        amenities: ['Free Wi-Fi', 'Beach', 'Bar', 'Restaurant'],
        bookingRating: '8.3/10',
        hotelOutRating: '4.5/5',
        description:
            'Discover the colorful streets of Havana with all-inclusive beachfront accommodation.',
      ),
      TourData(
        country: 'Dominican',
        location: 'Punta Cana, Dominican',
        image:
            'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
        tourCount: 20,
        rating: 4.2,
        reviewCount: 203,
        nights: '10 nights for two/all inclusive',
        price: '\$ 399.00',
        badge: '',
        amenities: ['Free Wi-Fi', 'Beach', 'Pool', 'Restaurant'],
        bookingRating: '7.9/10',
        hotelOutRating: '4.1/5',
        description:
            'Relax on pristine beaches with crystal clear waters in beautiful Punta Cana.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            buildHeader(),
            SizedBox(height: 30,),
            buildTitle(),
            SizedBox(height: 20,),
            buildSection(),
            SizedBox(height: 15,),
            buildCountryCards(context, countries),
            SizedBox(height: 15,),
            buildPopularToursList(context, countries),


          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(),

    );
  }

















  buildHeader(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu, color: Color(0xFF5A6C7A)),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF00BFA5),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'DiscountTour',
              style: GoogleFonts.adamina(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  buildTitle(){
    return  const Text(
      'Find the best tour',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2C3E50),
      ),
    );
  }

  buildSection(){
    return const Text(
      'Country',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF5A6C7A),
      ),
    );
  }


  buildPopular(){
    return const Text(
      'Popular tours',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2C3E50),
      ),
    );
  }

  Widget buildCountryCards(BuildContext context, List<TourData> countries) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final tour = countries[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(tour: tour),
                ),
              );
            },
            child: Container(
              width: 180,
              margin: const EdgeInsets.only(right: 15),
              child: Stack(
                children: [
                  // BACKGROUND IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      tour.image,
                      width: 180,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // DARK OVERLAY GRADIENT
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // BADGE + AVATARS ROW
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tour.badge.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.28),
                                      Colors.white.withOpacity(0.10),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  tour.badge,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        const Spacer(),

                        // AVATARS EXAMPLE
                        buildAvatarStack([
                          "https://i.pravatar.cc/70?img=1",
                          "https://i.pravatar.cc/70?img=2",
                          "https://i.pravatar.cc/70?img=3",
                          "https://i.pravatar.cc/70?img=4",
                          "https://i.pravatar.cc/70?img=5",
                        ]),
                      ],
                    ),
                  ),

                  // COUNTRY + TOURS BOTTOM TEXT
                  Positioned(
                    left: 15,
                    bottom: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tour.country,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${tour.tourCount} Tours",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // RATING GLASS CHIP
                  Positioned(
                    right: 15,
                    bottom: 15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.28),
                                Colors.white.withOpacity(0.10),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                tour.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Icon(
                                Icons.star,
                                size: 12,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPopularToursList(BuildContext context, List<TourData> countries) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final tour = countries[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(tour: tour),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(tour.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tour.country,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        tour.nights,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A9BA8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tour.price,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Text(
                        tour.rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildBottomBar(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF00BFA5),
        unselectedItemColor: const Color(0xFF8A9BA8),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
      ),
    );
  }


  Widget buildAvatarStack(List<String> avatars, {int maxVisible = 3}) {
    final extraCount = avatars.length - maxVisible;
    final displayAvatars = avatars.take(maxVisible).toList();
    final total = displayAvatars.length + (extraCount > 0 ? 1 : 0);

    return SizedBox(
      height: 26,
      width: total * 22, // <-- bounded width added
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerRight,
        children: [
          for (int i = 0; i < displayAvatars.length; i++)
            Positioned(
              right: i * 18,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(displayAvatars[i]),
                ),
              ),
            ),

          if (extraCount > 0)
            Positioned(
              right: displayAvatars.length * 18,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.white.withOpacity(.3),
                child: Text(
                  "+$extraCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final TourData tour;

  const DetailsScreen({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundImage(context),
          SafeArea(
            child: Column(
              children: [
                buildTopBar(context),
                buildTitleSection(),
                SizedBox(height: 20,),
                buildDetailsContainer()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  Widget buildBackgroundImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(tour.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.6),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.share, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 180),
          const Text(
            'Sea Flower Resort',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                tour.location,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          buildStarRating(),
        ],
      ),
    );
  }

  Widget buildStarRating() {
    return Row(
      children: List.generate(
        5,
            (index) => Icon(
          index < tour.rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        ),
      )..add(
        Text(
          '  ${tour.reviewCount}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget buildDetailsContainer() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            // Amenities
            buildAmenitiesRow(),
            const SizedBox(height: 25),

            // Ratings
            buildRatingsRow(),
            const SizedBox(height: 25),

            // Description
            buildDescription(),
            const SizedBox(height: 25),

            // Images
            buildImageGallery(),
          ],
        ),
      ),
    );
  }

  Widget buildAmenitiesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildAmenity(Icons.wifi, 'Free\nWi-Fi'),
        buildAmenity(Icons.beach_access, 'Sand\nBeach'),
        buildAmenity(Icons.water, 'Coastline'),
        buildAmenity(Icons.restaurant, 'Island\nRestaurant'),
      ],
    );
  }

  Widget buildAmenity(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F4F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF8A9BA8), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: Color(0xFF8A9BA8)),
        ),
      ],
    );
  }

  Widget buildRatingsRow() {
    return Row(
      children: [
        Expanded(child: buildBookingRatingCard()),
        const SizedBox(width: 15),
        Expanded(child: buildHotelOutRatingCard()),
      ],
    );
  }

  Widget buildBookingRatingCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4F8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A5F),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'B',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Booking',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
              Text(
                tour.bookingRating,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8A9BA8),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Based on 30 reviews',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF8A9BA8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHotelOutRatingCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4F8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.home,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'HotelOut',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
              Text(
                tour.hotelOutRating,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8A9BA8),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Based on 130 reviews',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF8A9BA8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDescription() {
    return Text(
      tour.description,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF5A6C7A),
        height: 1.6,
      ),
    );
  }

  Widget buildImageGallery() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(tour.image),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF00BFA5),
        unselectedItemColor: const Color(0xFF8A9BA8),
        elevation: 0,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
      ),
    );
  }
}