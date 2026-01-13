import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class ModernSocialFeed extends StatefulWidget {
  const ModernSocialFeed({Key? key}) : super(key: key);

  @override
  State<ModernSocialFeed> createState() => _ModernSocialFeedState();
}

class _ModernSocialFeedState extends State<ModernSocialFeed>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _refreshController;
  late Animation<double> _refreshAnimation;
  bool _isRefreshing = false;

  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800',
    'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=800',
    'https://images.unsplash.com/photo-1418065460487-3e41a6c84dc5?w=800',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
    'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800',
  ];

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _refreshAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _refreshController, curve: Curves.easeInOut),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    _refreshController.repeat();
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.stop();
    _refreshController.reset();
    setState(() => _isRefreshing = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.purpleAccent,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            buildAppBar(),
            buildStorySec(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ModernPostCard(
                  imageUrl: imageUrls[index % imageUrls.length],
                  index: index,
                ),
                childCount: 8,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: buildFloatingButton(),
    );
  }

  buildStorySec() {
    return SliverToBoxAdapter(child: buildStoriesSection());
  }

  Widget buildAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 70,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.withOpacity(0.3),
                  Colors.blue.withOpacity(0.2),
                  Colors.pink.withOpacity(0.2),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: buildAppBarContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppBarContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [buildTitle(), _buildAppBarActions()],
      ),
    );
  }

  Widget buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.purpleAccent, Colors.blueAccent],
      ).createShader(bounds),
      child: const Text(
        'SocialVerse',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildAppBarActions() {
    return Row(
      children: [
        _buildGlassIconButton(Icons.notifications_outlined),
        const SizedBox(width: 8),
        _buildGlassIconButton(Icons.messenger_outline),
      ],
    );
  }

  Widget _buildGlassIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Icon(icon, size: 24),
    );
  }

  Widget buildStoriesSection() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 8,
        itemBuilder: (context, index) => StoryCircle3D(
          imageUrl: imageUrls[index % imageUrls.length],
          name: [
            'You',
            'Alex',
            'Sarah',
            'Mike',
            'Emma',
            'John',
            'Lisa',
            'Tom',
          ][index],
          isFirst: index == 0,
        ),
      ),
    );
  }

  Widget buildFloatingButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Colors.purpleAccent, Colors.blueAccent],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}

class StoryCircle3D extends StatefulWidget {
  final String imageUrl;
  final String name;
  final bool isFirst;

  const StoryCircle3D({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.isFirst = false,
  }) : super(key: key);

  @override
  State<StoryCircle3D> createState() => _StoryCircle3DState();
}

class _StoryCircle3DState extends State<StoryCircle3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_rotationAnimation.value)
              ..scale(_scaleAnimation.value),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  _buildStoryRing(),
                  const SizedBox(height: 6),
                  _buildStoryName(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoryRing() {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isFirst
              ? [Colors.grey.withOpacity(0.6), Colors.grey.withOpacity(0.3)]
              : [Colors.purpleAccent, Colors.pinkAccent, Colors.orangeAccent],
        ),
        boxShadow: [
          BoxShadow(
            color: widget.isFirst
                ? Colors.grey.withOpacity(0.3)
                : Colors.purpleAccent.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF0A0E21), width: 3),
          ),
          child: ClipOval(
            child: widget.isFirst ? _buildAddStoryButton() : _buildStoryImage(),
          ),
        ),
      ),
    );
  }

  Widget _buildAddStoryButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.withOpacity(0.3), Colors.grey.withOpacity(0.2)],
        ),
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 32),
    );
  }

  Widget _buildStoryImage() {
    return Image.network(
      widget.imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey.withOpacity(0.2),
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.withOpacity(0.3),
                Colors.blue.withOpacity(0.3),
              ],
            ),
          ),
          child: const Icon(Icons.person, size: 32),
        );
      },
    );
  }

  Widget _buildStoryName() {
    return Text(
      widget.name,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ModernPostCard extends StatefulWidget {
  final String imageUrl;
  final int index;

  const ModernPostCard({Key? key, required this.imageUrl, required this.index})
    : super(key: key);

  @override
  State<ModernPostCard> createState() => _ModernPostCardState();
}

class _ModernPostCardState extends State<ModernPostCard>
    with TickerProviderStateMixin {
  bool isLiked = false;
  bool isBookmarked = false;
  bool showHeartAnimation = false;
  int likeCount = 0;

  late AnimationController _likeController;
  late AnimationController _heartController;
  late AnimationController _cardController;
  late Animation<double> _likeScaleAnimation;
  late Animation<double> _heartScaleAnimation;
  late Animation<double> _cardSlideAnimation;

  final List<String> names = [
    'Alex Johnson',
    'Sarah Miller',
    'Mike Davis',
    'Emma Wilson',
    'John Smith',
    'Lisa Brown',
    'Tom Anderson',
    'Kate Taylor',
  ];

  @override
  void initState() {
    super.initState();
    likeCount = 1234 + widget.index * 157;

    _likeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _heartController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _cardController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _likeScaleAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
        ]).animate(
          CurvedAnimation(parent: _likeController, curve: Curves.elasticOut),
        );

    _heartScaleAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.3), weight: 40),
          TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 30),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
        ]).animate(
          CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
        );

    _cardSlideAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _cardController.forward();
  }

  void _handleDoubleTap() {
    if (!isLiked) {
      setState(() {
        isLiked = true;
        likeCount++;
        showHeartAnimation = true;
      });
      _heartController.forward().then((_) {
        setState(() => showHeartAnimation = false);
        _heartController.reset();
      });
    }
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
    _likeController.forward().then((_) => _likeController.reset());
  }

  void _toggleBookmark() {
    setState(() => isBookmarked = !isBookmarked);
  }

  @override
  void dispose() {
    _likeController.dispose();
    _heartController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _cardSlideAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(_cardSlideAnimation),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: buildGlassCard(),
        ),
      ),
    );
  }

  Widget buildGlassCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              buildImageSection(),
              buildActionRow(),
              buildLikesAndCaption()

            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildProfilePicture(),
          const SizedBox(width: 12),
          _buildUserInfo(),
          const Spacer(),
          _buildMoreButton(),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Colors.purpleAccent, Colors.blueAccent],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipOval(
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.purple.withOpacity(0.3),
                child: const Icon(Icons.person, size: 24),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          names[widget.index % names.length],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          '${widget.index + 2} hours ago',
          style: TextStyle(color: Colors.grey[400], fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildMoreButton() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      child: Icon(Icons.more_horiz, color: Colors.grey[300]),
    );
  }

  Widget buildImageSection() {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildNetworkImage(),
          if (showHeartAnimation) _buildHeartAnimation(),
        ],
      ),
    );
  }

  Widget _buildNetworkImage() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey.withOpacity(0.1),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: Colors.purpleAccent,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.4),
                  Colors.blue.withOpacity(0.4),
                ],
              ),
            ),
            child: const Center(
              child: Icon(Icons.broken_image, size: 60, color: Colors.white54),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeartAnimation() {
    return ScaleTransition(
      scale: _heartScaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.3),
        ),
        child: const Icon(Icons.favorite, color: Colors.white, size: 80),
      ),
    );
  }

  Widget buildActionRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          _buildLikeButton(),
          _buildActionButton(Icons.chat_bubble_outline, () {}),
          _buildActionButton(Icons.send_rounded, () {}),
          const Spacer(),
          _buildBookmarkButton(),
        ],
      ),
    );
  }

  Widget _buildLikeButton() {
    return ScaleTransition(
      scale: _likeScaleAnimation,
      child: IconButton(
        icon: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : Colors.white,
          size: 30,
        ),
        onPressed: _toggleLike,
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return IconButton(icon: Icon(icon, size: 28), onPressed: onPressed);
  }

  Widget _buildBookmarkButton() {
    return IconButton(
      icon: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: isBookmarked ? Colors.yellowAccent : Colors.white,
        size: 28,
      ),
      onPressed: _toggleBookmark,
    );
  }

  Widget buildLikesAndCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLikesText(),
          const SizedBox(height: 8),
          _buildCaptionText(),
          const SizedBox(height: 6),
          _buildCommentsText(),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildLikesText() {
    return Text(
      '$likeCount likes',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    );
  }

  Widget _buildCaptionText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.white, fontSize: 14),
        children: [
          TextSpan(
            text: '${names[widget.index % names.length]} ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
                'Amazing view! The perfect blend of nature and serenity 🌄✨ #Nature #Photography',
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsText() {
    return Text(
      'View all ${45 + widget.index * 12} comments',
      style: TextStyle(color: Colors.grey[400], fontSize: 13),
    );
  }
}
