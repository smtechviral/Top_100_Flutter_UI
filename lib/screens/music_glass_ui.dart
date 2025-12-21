import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../widgets/appColor.dart';

class MusicPlayerScreenGlassUI extends StatefulWidget {
  const MusicPlayerScreenGlassUI({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreenGlassUI> createState() =>
      _MusicPlayerScreenGlassUIState();
}

class _MusicPlayerScreenGlassUIState extends State<MusicPlayerScreenGlassUI>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  bool isLiked = false;
  double currentTime = 80.0;
  final double totalTime = 220.0;
  Timer? _timer;

  late AnimationController _floatController;
  late AnimationController gradientController;
  late AnimationController _slideController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    // Float animation
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Gradient animation
    gradientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    // Slide animation for background text
    _slideController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _floatController.dispose();
    gradientController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (currentTime >= totalTime) {
              isPlaying = false;
              currentTime = 0;
              _timer?.cancel();
            } else {
              currentTime++;
            }
          });
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String formatTime(double seconds) {
    int mins = (seconds / 60).floor();
    int secs = (seconds % 60).floor();
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: gradientController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(
                        AppColor.glass1,
                        AppColor.glass2,
                        gradientController.value,
                      )!,
                      Color.lerp(
                        AppColor.glass3,
                        AppColor.glass4,
                        gradientController.value,
                      )!,
                      Color.lerp(
                        AppColor.glass5,
                        AppColor.glass6,
                        gradientController.value,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),
          Center(
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Padding(
                  padding:  EdgeInsets.all(24.0),
                  child: Transform.translate(
                    offset: Offset(0, _floatAnimation.value),
                    child: GlassmorphicCard(child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildHeader(),
                        SizedBox(height: 32,),
                        buildAlbumArt(),
                        SizedBox(height: 32,),
                        buildSongInfo(),
                        SizedBox(height: 24,),
                        buildLikeButton(),
                        SizedBox(height: 24,),
                        buildProgressBar(),
                        SizedBox(height: 24,),
                        buildControls()
                      ],

                    )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
          ),
          Row(
            children: const [
              Icon(Icons.music_note, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'NOW PLAYING',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget buildAlbumArt() {
    return Container(
      width: double.infinity,
      height: 320,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(12),
        child: Image.network(
          "https://m.media-amazon.com/images/M/MV5BMGNlODRhYjEtMTY3ZC00Y2QwLTk0Y2ItNDE0NDUyYmQxYWQ4XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildSongInfo() {
    return Column(
      children: const [
        Text(
          'Shape Of You',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text('PUBLIC', style: TextStyle(color: Colors.white70, fontSize: 18)),
      ],
    );
  }

  Widget buildLikeButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.white,
        size: 32,
      ),
    );
  }

  Widget buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withOpacity(0.3),
              thumbColor: Colors.white,
              overlayColor: Colors.white.withOpacity(0.2),
            ),
            child: Slider(
              value: currentTime,
              min: 0,
              max: totalTime,
              onChanged: (value) {
                setState(() {
                  currentTime = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(currentTime),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  formatTime(totalTime),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.repeat, color: Colors.white, size: 24),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 32,
            ),
          ),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: IconButton(
              onPressed: togglePlayPause,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.skip_next, color: Colors.white, size: 32),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shuffle, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class GlassmorphicCard extends StatelessWidget {
  final Widget child;

  const GlassmorphicCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
