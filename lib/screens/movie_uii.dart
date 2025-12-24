import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

// Screen 1 - Movie Detail Screen
class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0BA2E6),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              buildBackgroundImage(),
              buildGradientOverlay(),
              buildContentOverlay(context),
            ],
          ),
        ),
      ),
    );
  }

  // Background Image Widget
  Widget buildBackgroundImage() {
    return Positioned.fill(
      child: Image.network(
        'https://lumiere-a.akamaihd.net/v1/images/image_2ff75a5c.jpeg?region=0%2C0%2C540%2C810',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFF4DB8E8),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 80,
                color: Colors.white54,
              ),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: const Color(0xFF4DB8E8),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  // Gradient Overlay Widget
  Widget buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.6),
            ],
            stops: const [0.0, 0.5, 0.7, 1.0],
          ),
        ),
      ),
    );
  }

  // Content Overlay Widget
  Widget buildContentOverlay(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(height: 8),
            buildMetadata(),
            const SizedBox(height: 12),
            buildStarRating(),
            const SizedBox(height: 25),
            buildPlayButton(context),
            const SizedBox(height: 25),
            buildShowMoreIndicator(),
          ],
        ),
      ),
    );
  }

  // Title Widget
  Widget buildTitle() {
    return const Text(
      'Luca',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(color: Colors.black26, blurRadius: 10),
        ],
      ),
    );
  }

  // Metadata Widget (Year, Genre, Duration)
  Widget buildMetadata() {
    return Text(
      '2021 | Animation | 1h 25min',
      style: TextStyle(
        fontSize: 14,
        color: Colors.white.withOpacity(0.9),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // Star Rating Widget
  Widget buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            index < 4 ? Icons.star : Icons.star_border,
            color: const Color(0xFFFFB800),
            size: 24,
          ),
        );
      }),
    );
  }

  // Play Button Widget
  Widget buildPlayButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  // Show More Indicator Widget
  Widget buildShowMoreIndicator() {
    return Column(
      children: [
        Text(
          'Show More',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white.withOpacity(0.8),
          size: 24,
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            buildTopBar(),
            buildFeaturedBanner(),
            SizedBox(height: 30,),
            buildChannelSection(),
            SizedBox(height:30,),
            buildNewSection()

          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),

    );
  }

  // Top Bar Widget
  Widget buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProfileAvatar(
            "https://cdn.pixabay.com/photo/2023/04/28/23/32/ai-generated-7957457_1280.png",
          ),
          _buildLogo(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Disney%2B_logo.svg/2560px-Disney%2B_logo.svg.png",
          ),
          _buildDownloadIcon(
            "https://cdn.pixabay.com/photo/2016/12/18/13/45/download-1915753_1280.png",
          ),
        ],
      ),
    );
  }

  // Profile Avatar Widget
  Widget _buildProfileAvatar(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.network(
        imageUrl,
        width: 40,
        height: 40,
      ),
    );
  }

  // Logo Widget
  Widget _buildLogo(String imageUrl) {
    return Image.network(
      imageUrl,
      width: 80,
    );
  }

  // Download Icon Widget
  Widget _buildDownloadIcon(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.network(
        imageUrl,
        width: 40,
        height: 40,
      ),
    );
  }

  // Featured Banner Widget
  Widget buildFeaturedBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: NetworkImage(
            'https://lumiere-a.akamaihd.net/v1/images/luca_thumbnail_image_2d04cabd.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 25,
            bottom: 10,
            child: _buildBannerPlayButton(),
          ),
        ],
      ),
    );
  }

  // Banner Play Button Widget
  Widget _buildBannerPlayButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black87.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  // Channel Section Widget
  Widget buildChannelSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Channel'),
          const SizedBox(height: 18),
          _buildChannelList(),
        ],
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title) {
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
        Text(
          'See all',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Channel List Widget
  Widget _buildChannelList() {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          _buildChannelButton(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTROdYG7twWWoCzBj6npkQLbhgLvZI1_WvjYg&s',
          ),
          _buildChannelButton(
            'https://i.pinimg.com/736x/72/c8/d3/72c8d31d8779299857123e1966c4a710.jpg',
          ),
          _buildChannelButton(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Marvel_Logo.svg/2560px-Marvel_Logo.svg.png',
          ),
          _buildChannelButton(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQeRoc_BhrP-jahuwf0Hrxe48LiP6DiHWiiw&s',
          ),
        ],
      ),
    );
  }

  // Channel Button Widget
  Widget _buildChannelButton(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            imageUrl,
            width: 120,
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // New Section Widget
  Widget buildNewSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('New'),
          const SizedBox(height: 18),
          _buildMovieList(),
        ],
      ),
    );
  }

  // Movie List Widget
  Widget _buildMovieList() {
    return SizedBox(
      height: 240,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          _buildMovieCard(
            imageUrl:
            'https://assets-in.bmscdn.com/iedb/movies/images/mobile/thumbnail/xlarge/moana-et00049913-02-12-2016-05-31-47.jpg',
            title: 'Moana',
            duration: '1h 43m',
            rating: '9.5',
          ),
          const SizedBox(width: 18),
          _buildMovieCard(
            imageUrl:
            "https://lumiere-a.akamaihd.net/v1/images/p_encanto_homeent_22359_4892ae1c.jpeg",
            title: 'Encanto',
            duration: '1h 39m',
            rating: '9.5',
          ),
          const SizedBox(width: 18),
          _buildMovieCard(
            imageUrl:
            "https://upload.wikimedia.org/wikipedia/en/c/cf/Ice_Age_Collision_Course.jpg",
            title: 'Ice Age',
            duration: '2h 39m',
            rating: '9.8',
          ),
        ],
      ),
    );
  }

  // Movie Card Widget
  Widget _buildMovieCard({
    required String imageUrl,
    required String title,
    required String duration,
    required String rating,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 230,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMovieImage(imageUrl),
            _buildMovieInfo(title, duration, rating),
          ],
        ),
      ),
    );
  }

  // Movie Image Widget
  Widget _buildMovieImage(String imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 120,
                color: Colors.grey.shade300,
                child: const Icon(Icons.movie, size: 40),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 120,
                color: Colors.grey.shade200,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Movie Info Widget
  Widget _buildMovieInfo(String title, String duration, String rating) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMovieTitle(title),
          const SizedBox(height: 8),
          _buildMovieMetadata(duration, rating),
        ],
      ),
    );
  }

  // Movie Title Widget
  Widget _buildMovieTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: Colors.black87,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Movie Metadata Widget (Duration, Rating, Play Button)
  Widget _buildMovieMetadata(String duration, String rating) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDuration(duration),
            _buildRating(rating),
          ],
        ),
        _buildCenterPlayButton(),
      ],
    );
  }

  // Duration Widget
  Widget _buildDuration(String duration) {
    return Text(
      duration,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
      ),
    );
  }

  // Rating Widget
  Widget _buildRating(String rating) {
    return Row(
      children: [
        Text(
          rating,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(
          Icons.star,
          color: Color(0xFFFFC107),
          size: 16,
        ),
      ],
    );
  }

  // Center Play Button Widget
  Widget _buildCenterPlayButton() {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Color(0xFF2196F3),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  // Bottom Navigation Bar Widget
  Widget buildBottomNavigationBar() {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      items: [
        CurvedNavigationBarItem(
          child: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.bookmark_border),
          label: 'Search',
        ),
        CurvedNavigationBarItem(child: Icon(Icons.add), label: 'Chat'),
        CurvedNavigationBarItem(
          child: Icon(Icons.notifications_none),
          label: 'Feed',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.settings),
          label: 'Personal',
        ),
      ],
    );
  }
}