import 'package:flutter/material.dart';

class NeumorphicMusicPlayerUI extends StatefulWidget {
  const NeumorphicMusicPlayerUI({Key? key}) : super(key: key);

  @override
  State<NeumorphicMusicPlayerUI> createState() =>
      _NeumorphicMusicPlayerUIState();
}

class _NeumorphicMusicPlayerUIState extends State<NeumorphicMusicPlayerUI> {
  bool isPlaying = true;
  double sliderValue = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: Column(
            children: [
              TopBar(),
              SizedBox(height: 60),
              AlbumArt(),
              SizedBox(height: 50),
              SongInfo(),
              SizedBox(height: 40,),
              ProgressBar(
                value: sliderValue,
                onChanged: (v) => setState(() => sliderValue = v),
              ),
              SizedBox(height: 50),

              ControlButtons(
                isPlaying: isPlaying,
                onPlayPause: () => setState(() => isPlaying = !isPlaying),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// ──────────────────────────────── CUSTOM WIDGETS ────────────────────────────────
//

class TopBar extends StatelessWidget {
  const TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NeumorphicButton(
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF9CA3AF),
            size: 20,
          ),
          onTap: () {},
        ),
        const Text(
          'PLAYING NOW',
          style: TextStyle(
            color: Color(0xFFB8BFC9),
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        NeumorphicButton(
          child: const Icon(Icons.menu, color: Color(0xFF9CA3AF), size: 24),
          onTap: () {},
        ),
      ],
    );
  }
}

class AlbumArt extends StatelessWidget {
  const AlbumArt();

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      size: 280,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8B5CE), Color(0xFFB8A4E8), Color(0xFF7B9FE8)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Opacity(
              opacity: 0.6,
              child: Image.network(
                'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.music_note,
                  size: 80,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SongInfo extends StatelessWidget {
  const SongInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Lose it',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A5568),
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Flume ft. Vic Mensa',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFB8BFC9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const ProgressBar({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeumorphicSlider(value: value, onChanged: onChanged),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1:26',
                style: TextStyle(
                  color: Color(0xFFB8BFC9),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '3:46',
                style: TextStyle(
                  color: Color(0xFFB8BFC9),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ControlButtons extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const ControlButtons({required this.isPlaying, required this.onPlayPause});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NeumorphicButton(
          size: 65,
          child: const Icon(
            Icons.skip_previous,
            color: Color(0xFF9CA3AF),
            size: 32,
          ),
          onTap: () {},
        ),
        const SizedBox(width: 20),
        NeumorphicButton(
          size: 80,
          isPressed: isPlaying,
          color: const Color(0xFF6B9FED),
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 38,
          ),
          onTap: onPlayPause,
        ),
        const SizedBox(width: 20),
        NeumorphicButton(
          size: 65,
          child: const Icon(
            Icons.skip_next,
            color: Color(0xFF9CA3AF),
            size: 32,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}

//
// ──────────────────────────────── BASE NEUMORPHIC ELEMENTS ────────────────────────────────
//

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final double size;

  const NeumorphicContainer({Key? key, required this.child, this.size = 100})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE0E5EC),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: const Color(0xFFA3B1C6).withOpacity(0.6),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(15), child: child),
    );
  }
}

class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double size;
  final Color? color;
  final bool isPressed;

  const NeumorphicButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.size = 50,
    this.color,
    this.isPressed = false,
  }) : super(key: key);

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final pressed = widget.isPressed || _isPressed;
    final bgColor = widget.color ?? const Color(0xFFE0E5EC);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          boxShadow: pressed
              ? [
                  BoxShadow(
                    color: const Color(0xFFA3B1C6).withOpacity(0.4),
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    offset: const Offset(-4, -4),
                    blurRadius: 8,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    offset: const Offset(-6, -6),
                    blurRadius: 12,
                  ),
                  BoxShadow(
                    color: const Color(0xFFA3B1C6).withOpacity(0.5),
                    offset: const Offset(6, 6),
                    blurRadius: 12,
                  ),
                ],
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}

class NeumorphicSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const NeumorphicSlider({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFE0E5EC),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA3B1C6).withOpacity(0.5),
            offset: const Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            offset: const Offset(-2, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 8,
          padding: EdgeInsets.zero,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
          activeTrackColor: const Color(0xFF6B9FED),
          inactiveTrackColor: Colors.transparent,
          thumbColor: const Color(0xFF6B9FED),
          overlayColor: const Color(0xFF6B9FED).withOpacity(0.2),
        ),
        child: Slider(value: value, onChanged: onChanged),
      ),
    );
  }
}
