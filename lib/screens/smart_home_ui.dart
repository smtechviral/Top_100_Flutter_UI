import 'package:flutter/material.dart';

class SmartHomeScreen extends StatefulWidget {
  const SmartHomeScreen({Key? key}) : super(key: key);

  @override
  State<SmartHomeScreen> createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  int selectedIndex = 0; // Default selected is "Kitchen"
  int selectedCardIndex = 0;

  // Room data - har icon ke liye alag room
  final Map<int, Map<String, String>> roomData = {
    0: {
      'name': 'Bedroom',
      'image': 'https://i.pinimg.com/736x/58/b3/65/58b36596b7687e94d4b354b574d30afa.jpg',
    },
    1: {
      'name': 'Living Room',
      'image': 'https://i.pinimg.com/1200x/c1/84/14/c18414dc5836cbcafd6a578fdec26089.jpg',
    },
    2: {
      'name': 'Kitchen',
      'image': 'https://i.pinimg.com/1200x/75/86/0c/75860cac3db695f15c6f319edd222dd2.jpg',
    },
    3: {
      'name': 'Garden',
      'image': 'https://i.pinimg.com/736x/ba/12/d5/ba12d55ca64bab59176859275e171dd7.jpg',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          buildLeftPanel(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: buildMainContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLeftPanel() {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 66),
      child: Column(
        children: [
          // Profile Picture
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=12'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Navigation Icons
          _buildNavIcon(Icons.bed_outlined, 0),
          const SizedBox(height: 20),
          _buildNavIcon(Icons.chair_outlined, 1),
          const SizedBox(height: 20),
          _buildNavIcon(Icons.grid_view_rounded, 2),
          const SizedBox(height: 20),
          _buildNavIcon(Icons.remove_red_eye_outlined, 3),

          Spacer(),

          // Settings Label (Rotated)
          RotatedBox(
            quarterTurns: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 6),
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB84D),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: 5,
                  height: 5,
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // Messages Label (Rotated)
          RotatedBox(
            quarterTurns: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 6),
                const Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB84D),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: 5,
                  height: 5,
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFD27F), // light top
              Color(0xFFFFA500), // dark bottom
            ],
          )
              : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0xFFEDEDED),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            // bottom shadow (depth)
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(4, 6),
            ),
            // top highlight (3D shine)
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              blurRadius: 8,
              offset: const Offset(-3, -3),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : const Color(0xFF9E9E9E),
          size: 24,
        ),
      ),
    );
  }

  Widget buildMainContent() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            buildHeader(),
            SizedBox(height: 30,),
            buildRoomCard(),
            SizedBox(height: 10,),
            buildGrid()

          ],
        ),
      ),
    );
  }


  buildHeader(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Smart home',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.menu,
            color: Color(0xFF2D2D2D),
            size: 20,
          ),
        ),
      ],
    );
  }


  buildRoomCard(){
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
            ),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey<int>(selectedIndex),
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: NetworkImage(
              roomData[selectedIndex]?['image'] ??
                  'https://i.pinimg.com/736x/4e/6d/4e/4e6d4eb03c6518de8b527b4bd30eab55.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(20),
          child: Text(
            roomData[selectedIndex]?['name'] ?? 'Room',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        GestureDetector(
          onTap: () {
            setState(() => selectedCardIndex = 0);
          },
          child: _buildControlCard(
            'Temp',
            Icons.thermostat_outlined,
            Colors.white,
            selectedCardIndex == 0,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() => selectedCardIndex = 1);
          },
          child: _buildControlCard(
            'Humidity',
            Icons.water_drop_outlined,
            Colors.white,
            selectedCardIndex == 1,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() => selectedCardIndex = 2);
          },
          child: _buildControlCard(
            'Internet',
            Icons.wifi,
            Colors.white,
            selectedCardIndex == 2,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() => selectedCardIndex = 3);
          },
          child: _buildControlCard(
            'Light',
            Icons.lightbulb,
            Colors.white,
            selectedCardIndex == 3,
          ),
        ),
      ],
    );
  }

  Widget _buildControlCard(
      String title,
      IconData icon,
      Color bgColor,
      bool isActive,
      ) {
    return Container(
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFD27F), // selected light
            Color(0xFFFFA500), // selected dark
          ],
        )
            : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFF1F1F1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
          // selected = more depth
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 22,
            offset: const Offset(6, 10),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 12,
            offset: const Offset(-4, -4),
          ),
        ]
            : [
          // normal = soft shadow
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.white
                      : const Color(0xFFFFB84D),
                  shape: BoxShape.circle,
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ]
                      : [],
                ),
              ),

              Icon(
                icon,
                color: getIconColor(title, isActive),

                size: 24,
              ),
            ],
          ),

          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isActive
                  ? Colors.white
                  : const Color(0xFF2D2D2D),
            ),
          ),
        ],
      ),
    );
  }

  Color getIconColor(String title, bool isActive) {
    if (!isActive) return const Color(0xFF9E9E9E);

    switch (title) {
      case 'Temp':
        return Colors.deepOrange;
      case 'Humidity':
        return Colors.cyan;
      case 'Internet':
        return Colors.blue;
      case 'Light':
        return Colors.white;
      default:
        return Colors.white;
    }
  }


}