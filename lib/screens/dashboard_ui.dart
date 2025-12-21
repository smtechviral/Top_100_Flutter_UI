import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(children: [
        TopBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreetingWidget(),
                SizedBox(height: 20,),
                SearchWidget(),
                SizedBox(height: 20,),
                WelcomeCard(),
                SizedBox(height: 25,),
                OngoingProjectsSection()
              ],
            ),
          ),
        )

      ])),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1A365d),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(onItemSelected: (p0) {}),
    );
  }
}

// Top Bar Widget
class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset("assets/images/window.png", height: 20),
            // child: const Icon(Icons.apps, color: Color(0xFF4A5568)),
          ),
          const Text(
            'Home',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF2C5282),
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

// Greeting Widget
class GreetingWidget extends StatelessWidget {
  const GreetingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Hi smtechviral!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Good Morning',
          style: TextStyle(fontSize: 14, color: Color(0xFFA0AEC0)),
        ),
      ],
    );
  }
}

// Search Widget
class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.search, color: Color(0xFFA0AEC0), size: 22),
          SizedBox(width: 10),
          Text(
            'Search',
            style: TextStyle(color: Color(0xFFA0AEC0), fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// Welcome Card
class WelcomeCard extends StatelessWidget {
  const WelcomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Let's schedule your\nprojects",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF718096),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF2C5282).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.computer,
                size: 40,
                color: const Color(0xFF2C5282),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Ongoing Projects Section
class OngoingProjectsSection extends StatelessWidget {
  const OngoingProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Ongoing Projects',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            Text(
              'view all',
              style: TextStyle(fontSize: 13, color: Color(0xFFA0AEC0)),
            ),
          ],
        ),
        const SizedBox(height: 15),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.90,
          children: const [
            ProjectCard(
              title: 'Mobile App',
              subtitle: 'Design',
              progress: 0.9,
              date: 'May 30, 2022',
              isDark: true,
              icon: Icons.phone_iphone,
            ),
            ProjectCard(
              title: 'Dashboard',
              subtitle: '',
              progress: 0.85,
              date: 'May 30, 2022',
              isDark: false,
              icon: Icons.dashboard,
            ),
            ProjectCard(
              title: 'Banner',
              subtitle: 'Marketing',
              progress: 0.65,
              date: 'May 30, 2022',
              isDark: false,
              icon: Icons.campaign,
            ),
            ProjectCard(
              title: 'Landx IX',
              subtitle: 'Task Manager',
              progress: 0.8,
              date: 'May 30, 2022',
              isDark: false,
              icon: Icons.layers,
            ),
          ],
        ),
      ],
    );
  }
}

// Project Card Widget
class ProjectCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String date;
  final bool isDark;
  final IconData icon;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.date,
    required this.isDark,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A365D) : const Color(0xFFEDF2F7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.white70 : const Color(0xFF718096),
                ),
              ),
              Icon(
                Icons.more_vert,
                size: 18,
                color: isDark ? Colors.white70 : const Color(0xFF718096),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.white : const Color(0xFF4A5568),
              size: 24,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF2D3748),
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white70 : const Color(0xFF718096),
              ),
            ),
          ],
          const Spacer(),
          Text(
            'Progress',
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white70 : const Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: isDark
                        ? Colors.white.withOpacity(0.2)
                        : const Color(0xFFCBD5E0),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDark ? Colors.white : const Color(0xFF2C5282),
                    ),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF4A5568),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Add Button
class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF1A365D),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A365D).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }
}

// Bottom Navigation Bar
class BottomNavBar extends StatefulWidget {
  final Function(int) onItemSelected;

  const BottomNavBar({Key? key, required this.onItemSelected})
    : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: BottomAppBar(
        color: const Color(0xFF1A365D),
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                'assets/images/home.png',
                'assets/images/home.png',
                'Home',
                0,
              ),
              _buildNavItem(
                'assets/images/task.png',
                'assets/images/task.png',
                'My task',
                1,
              ),
              const SizedBox(width: 40), // space for FAB
              _buildNavItem(
                'assets/images/credit-card.png',
                'assets/images/credit-card.png',
                'Payment',
                2,
              ),
              _buildNavItem(
                'assets/images/user.png',
                'assets/images/user.png',
                'Profile',
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String icon,
    String activeIcon,
    String label,
    int index,
  ) {
    final bool isActive = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTap(index),
      splashColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isActive ? activeIcon : icon,
            height: 22,
            width: 22,
            color: isActive ? Colors.white : const Color(0xFFA0AEC0),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? Colors.white : const Color(0xFFA0AEC0),
              fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
