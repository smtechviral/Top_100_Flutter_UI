import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const InstagramApp());
}

class InstagramApp extends StatelessWidget {
  const InstagramApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const InstagramHomePage(),
    );
  }
}

// Models
class StoryModel {
  final String username;
  final String imageUrl;
  final bool isYourStory;
  final bool hasStory;

  StoryModel({
    required this.username,
    required this.imageUrl,
    this.isYourStory = false,
    this.hasStory = true,
  });
}

class PostModel {
  final String username;
  final String location;
  final String userImage;
  final List<String> postImages;
  final List<String> likedBy;
  final int totalLikes;
  final String caption;
  final String timeAgo;
  final int commentsCount;
  bool isLiked;
  bool isSaved;

  PostModel({
    required this.username,
    required this.location,
    required this.userImage,
    required this.postImages,
    required this.likedBy,
    required this.totalLikes,
    required this.caption,
    required this.timeAgo,
    required this.commentsCount,
    this.isLiked = false,
    this.isSaved = false,
  });
}

// Main Home Page
class InstagramHomePage extends StatefulWidget {
  const InstagramHomePage({Key? key}) : super(key: key);

  @override
  State<InstagramHomePage> createState() => _InstagramHomePageState();
}

class _InstagramHomePageState extends State<InstagramHomePage> {
  int _selectedIndex = 0;

  final List<StoryModel> stories = [
    StoryModel(
      username: 'Your story',
      imageUrl: 'https://picsum.photos/150/150?random=1',
      isYourStory: true,
    ),
    StoryModel(
      username: 'silverfrog',
      imageUrl: 'https://picsum.photos/150/150?random=2',
    ),
    StoryModel(
      username: 'sadpanda',
      imageUrl: 'https://picsum.photos/150/150?random=3',
    ),
    StoryModel(
      username: 'angryswan',
      imageUrl: 'https://picsum.photos/150/150?random=4',
    ),
    StoryModel(
      username: 'shmo',
      imageUrl: 'https://picsum.photos/150/150?random=5',
    ),
    StoryModel(
      username: 'johndoe',
      imageUrl: 'https://picsum.photos/150/150?random=6',
    ),
    StoryModel(
      username: 'jane_smith',
      imageUrl: 'https://picsum.photos/150/150?random=7',
    ),
    StoryModel(
      username: 'photographer',
      imageUrl: 'https://picsum.photos/150/150?random=8',
    ),
  ];

  final List<PostModel> posts = [
    PostModel(
      username: 'mrbright',
      location: 'Europe',
      userImage: 'https://picsum.photos/150/150?random=10',
      postImages: [
        'https://picsum.photos/600/600?random=20',
        'https://picsum.photos/600/600?random=21',
        'https://picsum.photos/600/600?random=22',
      ],
      likedBy: ['angryswan', 'silverfrog'],
      totalLikes: 801,
      caption: 'Hey everyone guys. Hope all is well with you. We\'re starting a new series of neon shots that we took during our trip to Europe. The colors were absolutely stunning and we can\'t wait to share more! 🎨✨',
      timeAgo: '2 HOURS AGO',
      commentsCount: 45,
    ),
    PostModel(
      username: 'travelphotography',
      location: 'Bali, Indonesia',
      userImage: 'https://picsum.photos/150/150?random=11',
      postImages: [
        'https://picsum.photos/600/600?random=23',
        'https://picsum.photos/600/600?random=24',
      ],
      likedBy: ['johndoe', 'jane_smith'],
      totalLikes: 1234,
      caption: 'Sunset vibes in Bali 🌅 Nothing beats this view!',
      timeAgo: '5 HOURS AGO',
      commentsCount: 89,
    ),
    PostModel(
      username: 'foodlover',
      location: 'Mumbai, India',
      userImage: 'https://picsum.photos/150/150?random=12',
      postImages: [
        'https://picsum.photos/600/600?random=25',
      ],
      likedBy: ['angryswan'],
      totalLikes: 567,
      caption: 'Best street food in Mumbai! You have to try this 😋🔥',
      timeAgo: '8 HOURS AGO',
      commentsCount: 34,
    ),
    PostModel(
      username: 'fitnessguru',
      location: 'Los Angeles, CA',
      userImage: 'https://picsum.photos/150/150?random=13',
      postImages: [
        'https://picsum.photos/600/600?random=26',
        'https://picsum.photos/600/600?random=27',
        'https://picsum.photos/600/600?random=28',
        'https://picsum.photos/600/600?random=29',
      ],
      likedBy: ['silverfrog', 'photographer'],
      totalLikes: 2341,
      caption: 'Morning workout routine 💪 Consistency is key!',
      timeAgo: '12 HOURS AGO',
      commentsCount: 156,
    ),
  ];

  // ✅ BUILD APP BAR
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset(
        'assets/images/insta.png',
        height: 50,
        fit: BoxFit.contain,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.add, color: Colors.black, size: 30),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.black, size: 30),
          onPressed: () {},
        ),
      ],
    );
  }

  // ✅ BUILD STORIES SECTION
  Widget buildStories() {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          return _buildStoryItem(stories[index]);
        },
      ),
    );
  }

  // Helper: Build individual story item
  Widget _buildStoryItem(StoryModel story) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Viewing ${story.username}\'s story'),
              duration: const Duration(milliseconds: 800),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: story.hasStory
                    ? const LinearGradient(
                  colors: [
                    Color(0xFFFD1D1D),
                    Color(0xFFF56040),
                    Color(0xFFFCAF45),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )
                    : null,
                border: !story.hasStory
                    ? Border.all(color: Colors.grey.shade300, width: 2)
                    : null,
              ),
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: DecorationImage(
                    image: NetworkImage(story.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: story.isYourStory
                    ? Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 68,
              child: Text(
                story.username,
                style: const TextStyle(fontSize: 11),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ BUILD POST
  Widget buildPost(PostModel post, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(post),
        _buildPostImages(post, index),
        _buildPostActions(post),
        _buildPostLikes(post),
        _buildPostCaption(post),
        _buildPostComments(post),
        _buildPostTimestamp(post),
        const SizedBox(height: 16),
      ],
    );
  }

  // Helper: Post Header
  Widget _buildPostHeader(PostModel post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFD1D1D),
                  Color(0xFFF56040),
                  Color(0xFFFCAF45),
                ],
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                  image: NetworkImage(post.userImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  post.location,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptionsBottomSheet(context),
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  // Helper: Post Images with carousel
  Widget _buildPostImages(PostModel post, int postIndex) {
    return _PostImageCarousel(
      imageUrls: post.postImages,
      onDoubleTap: () {
        setState(() {
          post.isLiked = true;
        });
      },
    );
  }

  // Helper: Post Actions (like, comment, share, save)
  Widget _buildPostActions(PostModel post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              post.isLiked ? Icons.favorite : Icons.favorite_border,
              color: post.isLiked ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                post.isLiked = !post.isLiked;
              });
            },
            iconSize: 28,
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {},
            iconSize: 26,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
            iconSize: 26,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
            iconSize: 26,
          ),
          const Spacer(),
          if (post.postImages.length > 1)
            Row(
              children: List.generate(
                min(post.postImages.length, 5),
                    (index) => Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.blue : Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          const Spacer(),
          IconButton(
            icon: Icon(
              post.isSaved ? Icons.bookmark : Icons.bookmark_border,
            ),
            onPressed: () {
              setState(() {
                post.isSaved = !post.isSaved;
              });
            },
            iconSize: 26,
          ),
        ],
      ),
    );
  }

  // Helper: Post Likes
  Widget _buildPostLikes(PostModel post) {
    final currentLikes = post.isLiked ? post.totalLikes + 1 : post.totalLikes;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Icon(Icons.account_circle, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 13),
                children: [
                  const TextSpan(text: 'Liked by '),
                  TextSpan(
                    text: post.likedBy.first,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (currentLikes > 1) ...[
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: '${currentLikes - 1} others',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Post Caption
  Widget _buildPostCaption(PostModel post) {
    final shouldShowToggle = post.caption.length > 80;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 13),
              children: [
                TextSpan(
                  text: '${post.username} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: shouldShowToggle
                      ? '${post.caption.substring(0, 80)}...'
                      : post.caption,
                ),
              ],
            ),
          ),
          if (shouldShowToggle)
            GestureDetector(
              onTap: () {
                // Toggle caption expansion
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'more',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper: Post Comments
  Widget _buildPostComments(PostModel post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Opening comments...'),
              duration: Duration(milliseconds: 800),
            ),
          );
        },
        child: Text(
          'View all ${post.commentsCount} comments',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Helper: Post Timestamp
  Widget _buildPostTimestamp(PostModel post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Text(
        post.timeAgo,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 10,
        ),
      ),
    );
  }

  // Helper: Show options bottom sheet
  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text('Report'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('Block'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Copy Link'),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  // ✅ BUILD BOTTOM NAVIGATION
  Widget buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, Icons.home_outlined, 0),
              _buildNavItem(Icons.search, Icons.search_outlined, 1),
              _buildNavItem(Icons.add_box, Icons.add_box_outlined, 2),
              _buildNavItem(Icons.favorite, Icons.favorite_border, 3),
              _buildNavItem(Icons.account_circle, Icons.account_circle_outlined, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData filledIcon, IconData outlinedIcon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tab ${index + 1} selected'),
            duration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Icon(
        isSelected ? filledIcon : outlinedIcon,
        size: 28,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
        },
        child: ListView.builder(
          itemCount: posts.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  buildStories(),
                  const Divider(height: 1, thickness: 0.3),
                ],
              );
            }
            return buildPost(posts[index - 1], index - 1);
          },
        ),
      ),
      bottomNavigationBar: buildBottomNav(),
    );
  }
}

// Separate widget for image carousel with animation
class _PostImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final VoidCallback onDoubleTap;

  const _PostImageCarousel({
    required this.imageUrls,
    required this.onDoubleTap,
  });

  @override
  State<_PostImageCarousel> createState() => _PostImageCarouselState();
}

class _PostImageCarouselState extends State<_PostImageCarousel> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  bool showHeartAnimation = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    widget.onDoubleTap();
    setState(() => showHeartAnimation = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => showHeartAnimation = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: AspectRatio(
            aspectRatio: 1,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => currentPage = index);
              },
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
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
                );
              },
            ),
          ),
        ),
        if (showHeartAnimation)
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 800),
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value * 1.5,
                child: Opacity(
                  opacity: 1.0 - value,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}