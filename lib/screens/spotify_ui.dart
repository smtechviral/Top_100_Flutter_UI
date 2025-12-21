import 'dart:ui';

import 'package:day_challenge_100/widgets/appColor.dart';
import 'package:day_challenge_100/widgets/appImage.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isMenuOpen = false;
  bool isPlaying = false;
  double progress = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [AppColor.s1, AppColor.s2, AppColor.s3.withOpacity(.3)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Row(
                children: [
                  SidebarWidget(
                    onMenuTap: () {
                      setState(() {
                        isMenuOpen = !isMenuOpen;
                      });
                    },
                    isMenuOpen: isMenuOpen,
                  ),

                  Expanded(
                    child: AnimatedOpacity(
                      opacity: isMenuOpen ? 0.5 : 1.0,
                      duration: Duration(microseconds: 300),
                      child: MainContentWidget(),
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                duration: Duration(microseconds: 400),
                curve: Curves.easeOutCubic,
                left: isMenuOpen ? 80 : -400,
                top: 10,
                child: AnimatedOpacity(
                  opacity: isMenuOpen ? 1.0 : 0.0,
                  duration: Duration(microseconds: 300),
                  child: AnimatedScale(
                    scale: isMenuOpen ? 1.0 : 0.0,
                    duration: Duration(microseconds: 400),
                    curve: Curves.ease,
                    child: MenuWidget(
                      onClose: () {
                        setState(() {
                          isMenuOpen = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sidebar Widget
class SidebarWidget extends StatelessWidget {
  final VoidCallback onMenuTap;
  final bool isMenuOpen;

  const SidebarWidget({
    Key? key,
    required this.onMenuTap,
    required this.isMenuOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(.1),
                  Colors.white.withOpacity(.05),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildWindowButton(Colors.red),
                      SizedBox(width: 8),
                      buildWindowButton(Colors.yellow),
                      SizedBox(width: 8),
                      buildWindowButton(Colors.green),
                    ],
                  ),

                  SizedBox(height: 30),
                  Image.network(AppImages.spotifyLogo, height: 50),
                  SizedBox(height: 40),
                  buildSidebarItem(Icons.home, isMenuOpen),
                  buildSidebarItem(Icons.search, false),
                  buildSidebarItem(Icons.copy, false),
                  buildSidebarItem(Icons.settings, false),
                  buildSidebarItem(Icons.notifications, false),
                  buildSidebarItem(Icons.settings_outlined, false),

                  Spacer(),
                  buildSidebarItem(Icons.play_circle_filled, false),
                  buildSidebarItem(Icons.queue_music, false),
                  SizedBox(height: 20),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFC0C4C2), width: 2),
                    ),
                    child: Center(
                      child: Text(
                        "SM",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWindowButton(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget buildSidebarItem(IconData icon, bool isActive) {
    return GestureDetector(
      onTap: icon == Icons.home ? onMenuTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white.withOpacity(0.7), size: 28),
      ),
    );
  }
}

// Menu Widget
class MenuWidget extends StatelessWidget {
  final VoidCallback onClose;

  const MenuWidget({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        width: 350,
        height: MediaQuery.of(context).size.height / 1.14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(.2)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.3),
                    Colors.black.withOpacity(.3),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.network(AppImages.spotifyFullLogo, scale: 30),
                    ),
                  ),
                  Divider(color: Colors.white24),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "MENU",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildMenuItem(Icons.home, "Home", hasArrow: true),
                  buildMenuItem(Icons.search, "Search"),
                  buildMenuItem(Icons.library_music, "Your Library"),
                  buildMenuItem(Icons.workspace_premium, "Premium"),
                  buildMenuItem(Icons.notifications, "Notification",hasNotification: true),
                  buildMenuItem(Icons.settings, "Settings"),
          
                  buildNowPlaying(),
                  SizedBox(height: 20,),
                  buildUserSection(),
          
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
    IconData icon,
    String title, {
    bool hasArrow = false,
    bool hasNotification = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
          if (hasArrow) const Icon(Icons.chevron_right, color: Colors.white70),
          if (hasNotification)
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildNowPlaying() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Column(
        children: [
          // Album Art
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(AppImages.musicImage),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Song Info
          const Text(
            'Eminem',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Without me',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),

          const SizedBox(height: 16),

          // Progress Bar
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
            ),
            child: Slider(
              value: 0.4,
              onChanged: (value) {},
              activeColor: const Color(0xFF1DB954),
              inactiveColor: Colors.white24,
            ),
          ),

          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                color: Colors.white,
                iconSize: 32,
                onPressed: () {},
              ),
              const SizedBox(width: 20),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.skip_next),
                color: Colors.white,
                iconSize: 32,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildUserSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF1DB954), width: 2),
            ),
            child: const Center(
              child: Text(
                'SM',
                style: TextStyle(
                  color: Color(0xFF1DB954),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'smtechviral',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Premium Account',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.expand_more),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.open_in_new),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// Main Content Widget
class MainContentWidget extends StatelessWidget {
  const MainContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 12, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(.05),
                  Colors.white.withOpacity(.02),
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white70,
                          onPressed: () {},
                        ),

                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          color: Colors.white70,
                          onPressed: () {},
                        ),

                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "smtechviral",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Evening",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 100,
                              ),
                          itemCount: 6,

                          itemBuilder: (context, index) {
                            return buildPlaylistCard();
                          },
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Made For You",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),
                        SizedBox(
                          height: 240,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return buildAlbumCard();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlaylistCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                image: const DecorationImage(
                  image: NetworkImage(AppImages.likeImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Liked Songs',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAlbumCard() {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage(AppImages.listImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Daily Mix 1',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Artist 1, Artist 2 and more',
            style: TextStyle(color: Colors.white54, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
