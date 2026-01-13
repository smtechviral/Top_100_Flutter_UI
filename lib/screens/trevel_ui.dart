import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class TravelMainScreen extends StatefulWidget {
  const TravelMainScreen({Key? key}) : super(key: key);

  @override
  State<TravelMainScreen> createState() => _TravelMainScreenState();
}

class _TravelMainScreenState extends State<TravelMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      extendBody: true,
      bottomNavigationBar: buildGlassBottomNavBar(),
    );
  }

  Widget buildGlassBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.bar_chart_rounded, 'Stats'),
                _buildNavItem(2, Icons.grid_view_rounded, 'Grid'),
                _buildNavItem(3, Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(40),
          border: isSelected
              ? null
              : Border.all(color: Colors.white.withOpacity(0.5), width: 1),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.white.withOpacity(0.01),
              blurRadius: 5,
              offset: const Offset(-2, -2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
          gradient: !isSelected
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.05),
            ],
          )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white.withOpacity(0.9),
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Mountains';

  final List<Map<String, String>> places = const [
    {
      'name': 'Swiss Alps',
      'description':
      'Breathtaking mountain scenery and\nworld-class skiing destinations',
      'distance': '500 miles',
      'image':
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    },
    {
      'name': 'Mount Everest',
      'description':
      'Experience the highest peak in the world\nwith stunning Himalayan views',
      'distance': '800 miles',
      'image':
      'https://images.unsplash.com/photo-1486870591958-9b9d0d1dda99?w=800',
    },
    {
      'name': 'Rocky Mountains',
      'description':
      'Majestic peaks and pristine wilderness\nfor adventure seekers',
      'distance': '350 miles',
      'image':
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
    },
    {
      'name': 'Alps France',
      'description':
      'Scenic alpine landscapes with\ncharming mountain villages',
      'distance': '600 miles',
      'image':
      'https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTopBar(),
                SizedBox(height: 20,),

                buildHeroSection(),
                buildCategoriesHeader(),
                SizedBox(height: 15,),
                buildCategoriesList(),
                SizedBox(height: 10,),
              ],
            ),
          ),
          buildPlacesList(),
          SizedBox(height: 100,)

        ],
      ),
    );
  }

  Widget buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=5',
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Hi, Kelly',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.notifications_outlined, size: 24),
        ),
      ],
    );
  }

  Widget buildHeroSection() {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://waryhub.com/public/uploads/thumbnail/mountain-clipart-black-and-white-png-11746350225vsqltva3td.png",
              fit: BoxFit.contain,
              width: double.infinity,
              alignment: Alignment.centerRight,
            ),
          ),
          Positioned(
            left: 15,
            top: 5,
            child: Text(
              "Make Every\nTrip Memorable!",
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        'Categories',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildCategoriesList() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: 45,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildCategoryItem('Mountains', Icons.terrain),
            _buildCategoryItem('Lakes', Icons.water),
            _buildCategoryItem('Forest', Icons.nature),
            _buildCategoryItem('Desert', Icons.landscape),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String label, IconData icon) {
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = label),
      child: _buildCategoryChip(label, icon, selectedCategory == label),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(25),
        border: selected
            ? null
            : Border.all(color: Colors.white.withOpacity(0.4), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? Colors.white : Colors.grey.withOpacity(0.3),
            ),
            child: Icon(
              icon,
              size: 16,
              color: selected ? Colors.black : Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlacesList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: places.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final place = places[index];
        return _buildPlaceCard(place, index);
      },
    );
  }

  Widget _buildPlaceCard(Map<String, String> place, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(place: place, index: index),
          ),
        );
      },
      child: Container(
        height: 350,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: NetworkImage(place['image']!),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlaceNameBadge(place['name']!),
              const Spacer(),
              _buildPlaceDescription(place['description']!),
              const SizedBox(height: 20),
              _buildPlaceFooter(place['distance']!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceNameBadge(String name) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.18),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceDescription(String description) {
    return Text(
      description,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildPlaceFooter(String distance) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLocationInfo(distance),
        _buildBookButton(),
      ],
    );
  }

  Widget _buildLocationInfo(String distance) {
    return Row(
      children: [
        _buildGlassIconContainer(Icons.location_on),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              distance,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Duration to rain",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGlassIconContainer(IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.18),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Icon(icon, size: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBookButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withOpacity(0.15),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Text(
            'Book',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, String> place;
  final int index;

  const DetailScreen({Key? key, required this.place, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            buildBackgroundImage(),
            buildTopBar(context),
            buildBottomSheet(context)


          ],
        ),
      ),
    );
  }

  Widget buildBackgroundImage() {
    return Positioned.fill(
      child: Image.network(place['image'] ?? '', fit: BoxFit.cover),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTopIcon(Icons.arrow_back, context),
            _buildTopIcon(Icons.favorite_border, context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopIcon(IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (icon == Icons.arrow_back) {
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 24),
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPriceHeader(),
              const SizedBox(height: 10),
              _buildPlaceName(),
              const SizedBox(height: 5),
              _buildLocation(),
              const SizedBox(height: 15),
              _buildMapSection(),
              _buildBookNowButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStackAvatars(),
        const Text(
          "\$530/day",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildStackAvatars() {
    final avatars = [
      "https://i.pravatar.cc/300",
      "https://i.pravatar.cc/301",
      "https://i.pravatar.cc/302",
      "https://i.pravatar.cc/303",
    ];

    return SizedBox(
      width: 120,
      height: 32,
      child: Stack(
        children: List.generate(avatars.length, (i) {
          return Positioned(
            left: i * 20.0,
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(avatars[i]),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPlaceName() {
    return Text(
      place['name'] ?? '',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, size: 18),
        const SizedBox(width: 4),
        Text(
          "Valais, Bernese Oberland, Switzerland",
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassOverlayImage(),
    );
  }

  Widget _buildBookNowButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text(
            "Book Now",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class GlassOverlayImage extends StatelessWidget {
  const GlassOverlayImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            buildMapImage(),
            buildDistanceChip(),
          ],
        ),
      ),
    );
  }

  Widget buildMapImage() {
    return Image.network(
      "https://storage.googleapis.com/support-forums-api/attachment/message-237576265-6955616305050567035.PNG",
      width: 420,
      height: 200,
      fit: BoxFit.cover,
    );
  }

  Widget buildDistanceChip() {
    return Positioned(
      right: 16,
      top: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.location_on, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  '300 miles',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}