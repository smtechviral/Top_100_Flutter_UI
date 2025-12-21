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
      bio: 'Looking for someone with a passion for books, traveling and long walks on weekends, and isn\'t afraid to try new things.',
      image: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&q=80',
      tags: ['Swimming', 'Hiking', 'Reading'],
    ),
    ProfileData(
      name: 'Emma Wilson',
      age: 26,
      location: 'Los Angeles, California',
      bio: 'Coffee lover, adventure seeker, and dog mom. Let\'s explore the city together!',
      image: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800&q=80',
      tags: ['Coffee', 'Travel', 'Dogs'],
    ),
    ProfileData(
      name: 'Sophia Martinez',
      age: 23,
      location: 'San Diego, California',
      bio: 'Artist and yoga enthusiast. Looking for someone who appreciates art and good conversations.',
      image: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=800&q=80',
      tags: ['Art', 'Yoga', 'Music'],
    ),
    ProfileData(
      name: 'Olivia Brown',
      age: 25,
      location: 'San Francisco, California',
      bio: 'Foodie and fitness enthusiast. Looking for gym partner and brunch buddy!',
      image: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&q=80',
      tags: ['Fitness', 'Food', 'Gym'],
    ),
  ];

  int currentIndex = 0;
  Offset dragOffset = Offset.zero;
  double rotation = 0;
  bool isDragging = false;
  late AnimationController _likeAnimController;
  late AnimationController _nopeAnimController;
  late Animation<double> _likeScaleAnim;
  late Animation<double> _nopeScaleAnim;

  @override
  void initState() {
    super.initState();
    _likeAnimController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _nopeAnimController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _likeScaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _likeAnimController, curve: Curves.elasticOut),
    );
    _nopeScaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _nopeAnimController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _likeAnimController.dispose();
    _nopeAnimController.dispose();
    super.dispose();
  }

  void onDragStart(DragStartDetails details) {
    setState(() {
      isDragging = true;
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      dragOffset += details.delta;
      rotation = dragOffset.dx / 1000;

      if (dragOffset.dx > 50) {
        _likeAnimController.forward();
        _nopeAnimController.reverse();
      } else if (dragOffset.dx < -50) {
        _nopeAnimController.forward();
        _likeAnimController.reverse();
      } else {
        _likeAnimController.reverse();
        _nopeAnimController.reverse();
      }
    });
  }

  void onDragEnd(DragEndDetails details) {
    setState(() {
      isDragging = false;
    });

    final swipeThreshold = MediaQuery.of(context).size.width * 0.3;

    if (dragOffset.dx.abs() > swipeThreshold) {
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
    }
  }

  void likeProfile() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      dragOffset = Offset(screenWidth * 1.5, -100);
      rotation = 0.3;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        if (currentIndex < profiles.length - 1) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        dragOffset = Offset.zero;
        rotation = 0;
      });
      _likeAnimController.reverse();
      _nopeAnimController.reverse();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.white),
            const SizedBox(width: 8),
            Text('You liked ${profiles[currentIndex].name}!'),
          ],
        ),
        backgroundColor: Colors.pink,
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void dislikeProfile() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      dragOffset = Offset(-screenWidth * 1.5, -100);
      rotation = -0.3;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        if (currentIndex < profiles.length - 1) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        dragOffset = Offset.zero;
        rotation = 0;
      });
      _likeAnimController.reverse();
      _nopeAnimController.reverse();
    });

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

  void superLike() {
    final screenHeight = MediaQuery.of(context).size.height;
    setState(() {
      dragOffset = Offset(0, -screenHeight * 1.5);
      rotation = 0;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        if (currentIndex < profiles.length - 1) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        dragOffset = Offset.zero;
        rotation = 0;
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.star, color: Colors.white),
            const SizedBox(width: 8),
            Text('Super liked ${profiles[currentIndex].name}! 💖'),
          ],
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = profiles[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: Column(
          children: [
            buildTopHeader(),
            Expanded(
              child: Stack(
                children: [

                  buildBackgroundCard(),
                  buildMainCardContainer(profile)
                ],
              ),
            ),
            buildActionButtons()
          ],
        ),
      ),
    );
  }

  // 1. Build Top Header Widget
  Widget buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.white),
          ),
          const Text(
            'Near You',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.wechat_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // 2. Build Background Card (Next Profile Preview)
  Widget buildBackgroundCard() {
    if (currentIndex >= profiles.length - 1) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Transform.scale(
        scale: 0.95,
        child: Opacity(
          opacity: 0.5,
          child: buildProfileCard(profiles[currentIndex + 1]),
        ),
      ),
    );
  }

  // 3. Build Main Card Container with Gestures
  Widget buildMainCardContainer(ProfileData profile) {
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              // 4. Profile Card
              buildProfileCard(profile),
              buildLikeStamp(),
              buildNopeStamp(),
              // 5. Like Stamp

              // 6. Nope Stamp
            ],
          ),
        ),
      ),
    );
  }

  // 4. Build Profile Card
  Widget buildProfileCard(ProfileData profile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 7. Profile Image
            buildProfileImage(profile.image),
            buildGradientOverlay(),
            buildProfileInfo(profile)
            // 8. Gradient Overlay

            // 9. Profile Info Section
          ],
        ),
      ),
    );
  }

  // 5. Build Like Stamp
  Widget buildLikeStamp() {
    if (dragOffset.dx <= 50) return const SizedBox.shrink();

    return Positioned(
      top: 80,
      left: 40,
      child: ScaleTransition(
        scale: _likeScaleAnim,
        child: Transform.rotate(
          angle: -0.3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'LIKE',
              style: TextStyle(
                color: Colors.green,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 6. Build Nope Stamp
  Widget buildNopeStamp() {
    if (dragOffset.dx >= -50) return const SizedBox.shrink();

    return Positioned(
      top: 80,
      right: 40,
      child: ScaleTransition(
        scale: _nopeScaleAnim,
        child: Transform.rotate(
          angle: 0.3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'NOPE',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 7. Build Profile Image
  Widget buildProfileImage(String imageUrl) {
    return Image.network(
      imageUrl,
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

  // 8. Build Gradient Overlay
  Widget buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
          stops: const [0.5, 1.0],
        ),
      ),
    );
  }

  // 9. Build Profile Info Section
  Widget buildProfileInfo(ProfileData profile) {
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
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 10. Tags List
                _buildTagsList(profile.tags),
                const SizedBox(height: 12),

                // 11. Name and Age Row
                _buildNameAgeRow(profile),
                const SizedBox(height: 8),

                // 12. Location Row
                _buildLocationRow(profile.location),
                const SizedBox(height: 12),

                // 13. Bio Text
                _buildBioText(profile.bio),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 10. Build Tags List
  Widget _buildTagsList(List<String> tags) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  // 11. Build Name and Age Row
  Widget _buildNameAgeRow(ProfileData profile) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${profile.name}, ${profile.age}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(
            Icons.verified,
            color: Colors.white,
            size: 18,
          ),
        ),
      ],
    );
  }

  // 12. Build Location Row
  Widget _buildLocationRow(String location) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: Colors.white.withOpacity(0.8),
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          location,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // 13. Build Bio Text
  Widget _buildBioText(String bio) {
    return Text(
      bio,
      style: TextStyle(
        color: Colors.white.withOpacity(0.85),
        fontSize: 14,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  // 14. Build Action Buttons Row
  Widget buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(
            icon: Icons.refresh,
            color: Colors.transparent,
            iconColor: Colors.amber,
            size: 50,
            onPressed: () {
              setState(() {
                if (currentIndex > 0) {
                  currentIndex--;
                }
              });
            },
          ),
          _ActionButton(
            icon: Icons.close,
            color: Colors.transparent,
            iconColor: Colors.red,
            size: 60,
            onPressed: dislikeProfile,
          ),
          _ActionButton(
            icon: Icons.star,
            color: Colors.blue,
            iconColor: Colors.white,
            size: 70,
            onPressed: superLike,
          ),
          _ActionButton(
            icon: Icons.favorite,
            color: Colors.transparent,
            iconColor: Colors.green,
            size: 60,
            onPressed: likeProfile,
          ),
          _ActionButton(
            icon: Icons.flash_on,
            color: Colors.transparent,
            iconColor: Colors.purple,
            size: 50,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile boosted! 🚀'),
                  backgroundColor: Colors.purple,
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  const _ActionButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
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
          border: Border.all(
            color: widget.color == Colors.transparent
                ? widget.iconColor.withOpacity(0.3)
                : Colors.white.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.color == Colors.blue
                  ? Colors.blue.withOpacity(0.4)
                  : Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
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
  final String bio;
  final String image;
  final List<String> tags;

  ProfileData({
    required this.name,
    required this.age,
    required this.location,
    required this.bio,
    required this.image,
    required this.tags,
  });
}