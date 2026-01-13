import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/appImage.dart';

class MoodTrackerHome extends StatefulWidget {
  const MoodTrackerHome({Key? key}) : super(key: key);

  @override
  State<MoodTrackerHome> createState() => _MoodTrackerHomeState();
}

class _MoodTrackerHomeState extends State<MoodTrackerHome> {
  int _selectedIndex = 0;

  // Emoji data for October calendar
  final Map<int, String> emojiMap = {
    1: '😊',
    2: '😊',
    3: '😐',
    4: '😑',
    5: '😐',
    6: '😊',
    7: '😊',
    8: '🤐',
    9: '😰',
    10: '😑',
    11: '😊',
    12: '😄',
    13: '😊',
    14: '😑',
    15: '🤐',
    16: '😊',
    17: '😄',
    18: '😊',
    19: '😐',
    20: '😑',
    21: '😊',
    22: '🤪',
    23: '😐',
    24: '🤪',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f7f3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                SizedBox(height: 20,),
                goodCard(),
                SizedBox(height: 30,),
                headerPattern(),
                SizedBox(height: 20,),
                buildCalender()

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomBar(),

    );
  }

  buildHeader(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'WELCOME BACK',
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Hello, SM',
              style: TextStyle(
                color: Color(0xFF2a2a2a),
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'https://i.pravatar.cc/150?img=12',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  goodCard()
  {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          // 3D Emoji
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFFFE5B4),
                  const Color(0xFFFFE5B4),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFE5B4).withOpacity(0.8),
                  blurRadius: 0,
                  spreadRadius: 5,
                  offset: const Offset(0, 5), // shadow position
                ),
              ],
            ),
            child: Center(
              child: Text(
                '😊',
                style: TextStyle(
                  fontSize: 60,
                  shadows: [
                    Shadow(
                      offset: const Offset(2, 2),
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      'Feeling Good',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2a2a2a),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.5),
                          borderRadius: BorderRadius.circular(60)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'TODAY',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF888888),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Peaceful, content, and \nenergized',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoodCheckInScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children:  [
                      Text(
                        'EDIT CHECK-IN',
                        style: GoogleFonts.inder(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE8A547),
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFE8A547),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  headerPattern(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(
          'OCTOBER PATTERNS',
          style: GoogleFonts.poppins(
            color: Color(0xFF888888),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          'View Calendar',
          style: TextStyle(
            color: Color(0xFFE8A547),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  buildCalender(){
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Day Headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map(
                  (day) => SizedBox(
                width: 35,
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),
          const SizedBox(height: 12),

          // Calendar Days
          ...List.generate(5, (weekIndex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (dayIndex) {
                  int day = weekIndex * 7 + dayIndex + 1;
                  if (day > 31) return const SizedBox(width: 40);

                  String? emoji = emojiMap[day];
                  bool hasEmoji = emoji != null;

                  return CalendarDay(
                    day: day,
                    emoji: emoji ?? '',
                    hasEmoji: hasEmoji,
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }

  buildBottomBar(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(AppImages.homeIcon, 'HOME', 0),
              buildNavItem(AppImages.trendIcon, 'TRENDS', 1),
              buildNavItem(AppImages.userIcon, 'PROFILE', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(String imagePath, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              color:
              isSelected
                  ? const Color(0xFF2a2a2a)
                  : const Color(0xFF888888),
              height: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color:
                isSelected
                    ? const Color(0xFF2a2a2a)
                    : const Color(0xFF888888),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarDay extends StatelessWidget {
  final int day;
  final String emoji;
  final bool hasEmoji;

  const CalendarDay({
    Key? key,
    required this.day,
    required this.emoji,
    required this.hasEmoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration:
            hasEmoji
                ? BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFF1D6), // highlight
                  Color(0xFFFFC67A), // depth
                ],
              ),
              boxShadow: [
                // depth shadow (bottom)
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
                // highlight shadow (top)
                BoxShadow(
                  color: Color(0xFFFFC67A).withOpacity(0.7),
                  blurRadius: 6,
                  offset: const Offset(-2, -2),
                ),
              ],
            )
                : const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFe8e8e8),
            ),
            child:
            hasEmoji
                ? Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 22, height: 1),
              ),
            )
                : null,
          ),
          const SizedBox(height: 4),
          Text(
            day.toString(),
            style: TextStyle(
              color:
              hasEmoji ? const Color(0xFF2a2a2a) : const Color(0xFFcccccc),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class MoodCheckInScreen extends StatefulWidget {
  const MoodCheckInScreen({Key? key}) : super(key: key);

  @override
  State<MoodCheckInScreen> createState() => _MoodCheckInScreenState();
}

class _MoodCheckInScreenState extends State<MoodCheckInScreen> {
  int selectedMoodIndex = 2; // Default to "Good" (middle emoji)
  final TextEditingController noteController = TextEditingController();

  final List<Map<String, dynamic>> moods = [
    {
      'emoji': '🤯',
      'label': 'Overwhelmed',
      'description': 'Stressed & Anxious',
    },
    {'emoji': '😟', 'label': 'Worried', 'description': 'Concerned & Uneasy'},
    {'emoji': '😊', 'label': 'Good', 'description': 'Peaceful & Content'},
    {'emoji': '😌', 'label': 'Calm', 'description': 'Relaxed & Serene'},
    {'emoji': '🤩', 'label': 'Excited', 'description': 'Energized & Happy'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f7f3),
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [

                      SizedBox(height: 40,),
                      buildTitle(),
                      SizedBox(height: 40,),
                      buildMainEmoji(),
                      SizedBox(height: 30,),
                      buildMoodLabel(),
                      SizedBox(height: 40,),
                      buildNoteInput(),
                      SizedBox(height: 80,),
                      buildEmojiSelector(),
                      SizedBox(height: 30,)

                    ],
                  ),
                ),
              ),
            ),
            buildBottomButtons()

          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          threeDIcon(
            icon: Icons.arrow_back,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'OCT 24',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              letterSpacing: 1,
            ),
          ),
          threeDIcon(
            icon: Icons.close,
            onTap: () {},
          ),
        ],
      ),
    );
  }


  Widget threeDIcon({
    required IconData icon,
    required VoidCallback onTap,
    bool outlined = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          gradient: outlined
              ? null
              : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFEDEDED),
            ],
          ),
          border: outlined
              ? Border.all(color: Colors.grey.shade400, width: 1.5)
              : null,
          boxShadow: [
            // Depth shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
            // Highlight
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              blurRadius: 0,
              offset: const Offset(-1, -1),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: const Color(0xFF2a2a2a),
        ),
      ),
    );
  }


  Widget buildTitle() {
    return Column(
      children: [
        Text(
          'CHECK IN',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'ALEX, HOW DO YOU FEEL',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2a2a2a),
            letterSpacing: 0.5,
          ),
        ),
        const Text(
          'THIS EVENING?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2a2a2a),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget buildMainEmoji() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 140,
            height: 140,
            child: Center(
              child: Text(
                moods[selectedMoodIndex]['emoji'],
                style: const TextStyle(fontSize: 120),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMoodLabel() {
    return Column(
      children: [
        Text(
          moods[selectedMoodIndex]['label'],
          style: GoogleFonts.playfairDisplay(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2a2a2a),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          moods[selectedMoodIndex]['description'],
          style: GoogleFonts.nunito(fontSize: 15, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget buildNoteInput() {
    return TextField(
      controller: noteController,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
      ),
      decoration: InputDecoration(
        hintText: 'Add a note (optional)...',
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[400],
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFFFFC67A), // accent color
            width: 1.5,
          ),
        ),
      ),
    );
  }


  Widget buildEmojiSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(moods.length, (index) {
          final isSelected = selectedMoodIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMoodIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 60 : 50,
              height: isSelected ? 60 : 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                boxShadow:
                isSelected
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
                    : [],
              ),
              child: Center(
                child: Text(
                  moods[index]['emoji'],
                  style: TextStyle(fontSize: isSelected ? 32 : 26),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xfff8f7f3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.20),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFFd49843), const Color(0xFFd49843)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFd49843).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Handle confirm action
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.check_circle, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
}

