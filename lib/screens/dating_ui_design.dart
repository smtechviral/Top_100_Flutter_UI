import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class DatingProfileScreen extends StatefulWidget {
  const DatingProfileScreen({Key? key}) : super(key: key);

  @override
  State<DatingProfileScreen> createState() => _DatingProfileScreenState();
}

class _DatingProfileScreenState extends State<DatingProfileScreen>
    with TickerProviderStateMixin {
  final List<ProfileData> profiles = [
    ProfileData(
      name: 'Isabella Lewis',
      age: 24,
      location: 'Ontario, California',
      distance: '2 km away',
      bio: 'Looking for someone with a passion for books, traveling and long walks on weekends, and isn\'t afraid to try new things.',
      images: [
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&q=80',
        'https://images.unsplash.com/photo-1488716820095-cbe80883c496?w=800&q=80',
        'https://images.unsplash.com/photo-1534008757030-27299c4371b6?w=800&q=80',
      ],
      tags: ['Swimming', 'Hiking', 'Reading'],
      interests: ['📚 Books', '✈️ Travel', '🎵 Music', '☕ Coffee'],
      isOnline: true,
    ),
    ProfileData(
      name: 'Emma Wilson',
      age: 26,
      location: 'Los Angeles, California',
      distance: '5 km away',
      bio: 'Coffee lover, adventure seeker, and dog mom. Let\'s explore the city together!',
      images: [
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800&q=80',
        'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=800&q=80',
        'https://images.unsplash.com/photo-1519699047748-de8e457a634e?w=800&q=80',
      ],
      tags: ['Coffee', 'Travel', 'Dogs'],
      interests: ['🐕 Dogs', '🏔️ Adventure', '📸 Photography'],
      isOnline: false,
    ),
    ProfileData(
      name: 'Sophia Martinez',
      age: 23,
      location: 'San Diego, California',
      distance: '8 km away',
      bio: 'Artist and yoga enthusiast. Looking for someone who appreciates art and good conversations.',
      images: [
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=800&q=80',
        'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=800&q=80',
        'https://images.unsplash.com/photo-1496440737103-cd596325d314?w=800&q=80',
      ],
      tags: ['Art', 'Yoga', 'Music'],
      interests: ['🎨 Art', '🧘 Yoga', '🎭 Theater', '🍷 Wine'],
      isOnline: true,
    ),
    ProfileData(
      name: 'Olivia Brown',
      age: 25,
      location: 'San Francisco, California',
      distance: '3 km away',
      bio: 'Foodie and fitness enthusiast. Looking for gym partner and brunch buddy!',
      images: [
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&q=80',
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=800&q=80',
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800&q=80',
      ],
      tags: ['Fitness', 'Food', 'Gym'],
      interests: ['💪 Fitness', '🍕 Food', '🏋️ Gym', '🥗 Healthy'],
      isOnline: true,
    ),
  ];

  int currentIndex = 0;
  int currentImageIndex = 0;
  Offset dragOffset = Offset.zero;
  double rotation = 0;
  bool isDragging = false;
  late AnimationController _likeAnimController;
  late AnimationController _nopeAnimController;
  late AnimationController _superLikeController;
  late AnimationController _heartController;
  late Animation<double> _likeScaleAnim;
  late Animation<double> _nopeScaleAnim;
  late Animation<double> _superLikeAnim;
  late Animation<double> _heartAnim;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _likeAnimController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _nopeAnimController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _superLikeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _likeScaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _likeAnimController, curve: Curves.elasticOut),
    );
    _nopeScaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _nopeAnimController, curve: Curves.elasticOut),
    );
    _superLikeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _superLikeController, curve: Curves.elasticOut),
    );
    _heartAnim = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _likeAnimController.dispose();
    _nopeAnimController.dispose();
    _superLikeController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  void onDragStart(DragStartDetails details) {
    setState(() => isDragging = true);
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      dragOffset += details.delta;
      rotation = dragOffset.dx / 1000;

      if (dragOffset.dx > 50) {
        _likeAnimController.forward();
        _nopeAnimController.reverse();
        _superLikeController.reverse();
      } else if (dragOffset.dx < -50) {
        _nopeAnimController.forward();
        _likeAnimController.reverse();
        _superLikeController.reverse();
      } else if (dragOffset.dy < -50) {
        _superLikeController.forward();
        _likeAnimController.reverse();
        _nopeAnimController.reverse();
      } else {
        _likeAnimController.reverse();
        _nopeAnimController.reverse();
        _superLikeController.reverse();
      }
    });
  }

  void onDragEnd(DragEndDetails details) {
    setState(() => isDragging = false);

    final swipeThreshold = MediaQuery.of(context).size.width * 0.25;
    final superLikeThreshold = MediaQuery.of(context).size.height * 0.2;

    if (dragOffset.dy < -superLikeThreshold) {
      superLike();
    } else if (dragOffset.dx.abs() > swipeThreshold) {
      if (dragOffset.dx > 0) {
        likeProfile();
      } else {
        dislikeProfile();
      }
    } else {
      setState(() {
        dragOffset = Offset.zero;
        rotation = 0;
      });
      _likeAnimController.reverse();
      _nopeAnimController.reverse();
      _superLikeController.reverse();
    }
  }

  void likeProfile() {
    _heartController.forward().then((_) => _heartController.reset());
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      dragOffset = Offset(screenWidth * 1.5, -100);
      rotation = 0.3;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _moveToNextProfile();
      _likeAnimController.reverse();
    });

    _showMatchDialog();
  }

  void dislikeProfile() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      dragOffset = Offset(-screenWidth * 1.5, -100);
      rotation = -0.3;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _moveToNextProfile();
      _nopeAnimController.reverse();
    });

    _showDislikeSnackBar();
  }

  void superLike() {
    final screenHeight = MediaQuery.of(context).size.height;
    setState(() {
      dragOffset = Offset(0, -screenHeight * 1.5);
      rotation = 0;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _moveToNextProfile();
      _superLikeController.reverse();
    });

    _showSuperLikeDialog();
  }

  void _moveToNextProfile() {
    setState(() {
      if (currentIndex < profiles.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      currentImageIndex = 0;
      dragOffset = Offset.zero;
      rotation = 0;
    });
  }

  void _showDislikeSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.close, color: Colors.white),
            const SizedBox(width: 8),
            Text('Passed on ${profiles[currentIndex].name}'),
          ],
        ),
        backgroundColor: Colors.grey[800],
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showMatchDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => MatchDialog(profileName: profiles[currentIndex].name),
    );
  }

  void _showSuperLikeDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => SuperLikeDialog(profileName: profiles[currentIndex].name),
    );
  }

  void nextImage() {
    setState(() {
      if (currentImageIndex < profiles[currentIndex].images.length - 1) {
        currentImageIndex++;
      }
    });
  }

  void previousImage() {
    setState(() {
      if (currentImageIndex > 0) {
        currentImageIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.withOpacity(0.1), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        body: Column(
          children: [
            const SizedBox(height: 60),
            buildHeader(),
            buildProfileCardStack(),
            buildActionButtons()
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return HeaderWidget();
  }

  Widget buildProfileCardStack() {
    final profile = profiles[currentIndex];
    return Expanded(
      child: Stack(
        children: [
          if(currentIndex < profiles.length - 1)
            buildNextCard(profiles[currentIndex + 1]),
          buildCurrentCard(profile)
        ],
      ),
    );
  }

  Widget buildNextCard(ProfileData nextProfile) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Transform.scale(
        scale: 0.92,
        child: Transform.translate(
          offset: Offset(dragOffset.dx * 0.1, dragOffset.dy * 0.1),
          child: Opacity(
            opacity: 0.5,
            child: ProfileCard(
              profile: nextProfile,
              imageIndex: 0,
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCurrentCard(ProfileData profile) {
    return AnimatedContainer(
      duration: isDragging ? Duration.zero : const Duration(milliseconds: 400),
      curve: Curves.elasticOut,
      transform: Matrix4.identity()
        ..translate(dragOffset.dx, dragOffset.dy)
        ..rotateZ(rotation),
      child: GestureDetector(
        onPanStart: onDragStart,
        onPanUpdate: onDragUpdate,
        onPanEnd: onDragEnd,
        onTap: () {
          final tapPosition = dragOffset.dx;
          final screenWidth = MediaQuery.of(context).size.width;
          if (tapPosition > screenWidth / 2) {
            nextImage();
          } else {
            previousImage();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              ProfileCard(
                profile: profile,
                imageIndex: currentImageIndex,
                onTap: () => showProfileDetailsSheet(profile),
              ),
              buildFloatingHeartAnimation(),
              buildLikeStamp(),
              buildNopeStamp(),
              buildSuperLikeStamp()

            ],
          ),
        ),
      ),
    );
  }

  Widget buildFloatingHeartAnimation() {
    if (!_heartController.isAnimating) return const SizedBox.shrink();
    return Center(
      child: ScaleTransition(
        scale: _heartAnim,
        child: FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_heartController),
          child: const Icon(Icons.favorite, color: Colors.white, size: 120),
        ),
      ),
    );
  }

  Widget buildLikeStamp() {
    if (dragOffset.dx <= 50) return const SizedBox.shrink();
    return Positioned(
      top: 80,
      left: 40,
      child: SwipeStamp(
        text: 'LIKE',
        color: Colors.green,
        rotation: -0.3,
        scaleAnimation: _likeScaleAnim,
      ),
    );
  }

  Widget buildNopeStamp() {
    if (dragOffset.dx >= -50) return const SizedBox.shrink();
    return Positioned(
      top: 80,
      right: 40,
      child: SwipeStamp(
        text: 'NOPE',
        color: Colors.red,
        rotation: 0.3,
        scaleAnimation: _nopeScaleAnim,
      ),
    );
  }

  Widget buildSuperLikeStamp() {
    if (dragOffset.dy >= -50) return const SizedBox.shrink();
    return Positioned(
      top: 80,
      left: 0,
      right: 0,
      child: Center(
        child: SwipeStamp(
          text: 'SUPER LIKE',
          color: Colors.blue,
          rotation: 0,
          scaleAnimation: _superLikeAnim,
        ),
      ),
    );
  }

  Widget buildActionButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionButton(
            icon: Icons.refresh,
            color: Colors.amber,
            iconColor: Colors.white,
            size: 50,
            onPressed: () {
              setState(() {
                if (currentIndex > 0) {
                  currentIndex--;
                  currentImageIndex = 0;
                }
              });
            },
          ),
          ActionButton(
            icon: Icons.close,
            color: Colors.red,
            iconColor: Colors.white,
            size: 60,
            onPressed: dislikeProfile,
          ),
          ActionButton(
            icon: Icons.star,
            color: Colors.blue,
            iconColor: Colors.white,
            size: 70,
            glowColor: Colors.blue,
            onPressed: superLike,
          ),
          ActionButton(
            icon: Icons.favorite,
            color: Colors.green,
            iconColor: Colors.white,
            size: 60,
            onPressed: likeProfile,
          ),
          ActionButton(
            icon: Icons.flash_on,
            color: Colors.purple,
            iconColor: Colors.white,
            size: 50,
            glowColor: Colors.purple,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('⚡ Profile boosted for 30 minutes!'),
                  backgroundColor: Colors.purple,
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void showProfileDetailsSheet(ProfileData profile) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfileDetailsSheet(profile: profile),
    );
  }
}

// CUSTOM WIDGETS

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildProfileIcon(),
          buildTitle(),
          buildNotificationIcon(),
        ],
      ),
    );
  }

  Widget buildProfileIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.person, color: Colors.white),
    );
  }

  Widget buildTitle() {
    return Column(
      children: [
        const Text(
          'Discover',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.pink, Colors.purple]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            '🔥 PREMIUM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNotificationIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          const Icon(Icons.notifications, color: Colors.white),
          Positioned(
            right: 0,
            top: 0,
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
    );
  }
}

class ProfileCard extends StatelessWidget {
  final ProfileData profile;
  final int imageIndex;
  final VoidCallback onTap;

  const ProfileCard({
    Key? key,
    required this.profile,
    required this.imageIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            buildBackgroundImage(),
            buildImageIndicators(),
            buildOnlineStatus(),
            buildGradientOverlay(),
            buildProfileInfo(context)
          ],
        ),
      ),
    );
  }

  Widget buildBackgroundImage() {
    return Image.network(
      profile.images[imageIndex],
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[900],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
              color: Colors.pink,
            ),
          ),
        );
      },
    );
  }

  Widget buildImageIndicators() {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Row(
        children: List.generate(profile.images.length, (index) {
          return Expanded(
            child: Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index == imageIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildOnlineStatus() {
    if (!profile.isOnline) return const SizedBox.shrink();
    return Positioned(
      top: 30,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.circle, color: Colors.white, size: 8),
            SizedBox(width: 4),
            Text(
              'ONLINE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          stops: const [0.4, 1.0],
        ),
      ),
    );
  }

  Widget buildProfileInfo(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.15),
                ],
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTags(),
                const SizedBox(height: 16),
                _buildNameAndAge(),
                const SizedBox(height: 10),
                _buildLocation(),
                const SizedBox(height: 12),
                _buildInterests(),
                const SizedBox(height: 12),
                _buildBio(),
                const SizedBox(height: 12),
                _buildViewProfileButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: profile.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink.withOpacity(0.4),
                Colors.purple.withOpacity(0.4),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNameAndAge() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${profile.name}, ${profile.age}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black54, blurRadius: 10)],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.blue, Colors.cyan]),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.6),
                blurRadius: 12,
              ),
            ],
          ),
          child: const Icon(Icons.verified, color: Colors.white, size: 20),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.pink.shade300, size: 18),
        const SizedBox(width: 4),
        Text(
          profile.location,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.pink.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.pink.withOpacity(0.5)),
          ),
          child: Text(
            profile.distance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterests() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: profile.interests.map((interest) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            interest,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBio() {
    return Text(
      profile.bio,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 14,
        height: 1.5,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildViewProfileButton(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.withOpacity(0.6),
              Colors.purple.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.info_outline, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'See Full Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeStamp extends StatelessWidget {
  final String text;
  final Color color;
  final double rotation;
  final Animation<double> scaleAnimation;

  const SwipeStamp({
    Key? key,
    required this.text,
    required this.color,
    required this.rotation,
    required this.scaleAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: text == 'SUPER LIKE' ? 40 : 45,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class MatchDialog extends StatelessWidget {
  final String profileName;

  const MatchDialog({Key? key, required this.profileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade400, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, color: Colors.white, size: 80),
            const SizedBox(height: 16),
            const Text(
              "It's a Match!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You and $profileName liked each other',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Keep Swiping'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Send Message'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SuperLikeDialog extends StatelessWidget {
  final String profileName;

  const SuperLikeDialog({Key? key, required this.profileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.cyan.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.white, size: 80),
            const SizedBox(height: 16),
            const Text(
              "Super Like Sent!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$profileName will see you stood out!',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailsSheet extends StatelessWidget {
  final ProfileData profile;

  const ProfileDetailsSheet({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1a1a1a),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDragHandle(),
            const SizedBox(height: 24),
            _buildNameAndAge(),
            const SizedBox(height: 8),
            _buildLocation(),
            const SizedBox(height: 24),
            _buildAboutSection(),
            const SizedBox(height: 24),
            _buildInterestsSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildNameAndAge() {
    return Text(
      '${profile.name}, ${profile.age}',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLocation() {
    return Text(
      profile.location,
      style: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 16,
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          profile.bio,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Interests',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: profile.interests.map((interest) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pink.withOpacity(0.3),
                    Colors.purple.withOpacity(0.3)
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Text(
                interest,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;
  final Color? glowColor;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.size,
    required this.onPressed,
    this.glowColor,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.glowColor?.withOpacity(0.5) ??
                  widget.color.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _controller.forward().then((_) => _controller.reverse());
              widget.onPressed();
            },
            borderRadius: BorderRadius.circular(widget.size / 2),
            child: Icon(
              widget.icon,
              color: widget.iconColor,
              size: widget.size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileData {
  final String name;
  final int age;
  final String location;
  final String distance;
  final String bio;
  final List<String> images;
  final List<String> tags;
  final List<String> interests;
  final bool isOnline;

  ProfileData({
    required this.name,
    required this.age,
    required this.location,
    required this.distance,
    required this.bio,
    required this.images,
    required this.tags,
    required this.interests,
    required this.isOnline,
  });
}