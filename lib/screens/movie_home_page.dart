import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
      ),
      home: const MovieHomePage(),
    );
  }
}

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({Key? key}) : super(key: key);

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final ScrollController _scrollController = ScrollController();
  int _currentNavIndex = 0;

  final List<Movie> trendingMovies = [
    Movie(
      title: 'Joker',
      rating: 8.4,
      year: '2019',
      duration: '2h 2min',
      genre: 'Crime, Drama',
      director: 'Todd Phillips',
      cast: 'Joaquin Phoenix, Robert De Niro',
      description:
      'A gritty character study of Arthur Fleck, a man disregarded by society, and how he descends into madness to become the Joker.',
      imageUrl:
      'https://play-lh.googleusercontent.com/xjc3o1P7nHE2F_t7bJhkrttra06DWUTeA_-ZT5P6LpXpZJ-I_a9GmupRu57l_654tlSvBMNOxXA3OolyTXs=w240-h480-rw',
    ),

    Movie(
      title: 'The Dark Knight Rises',
      rating: 8.4,
      year: '2012',
      duration: '2h 44min',
      genre: 'Action, Thriller',
      director: 'Christopher Nolan',
      cast: 'Christian Bale, Tom Hardy',
      description:
      'Eight years after the Joker’s reign, Batman must return to save Gotham from the brutal revolutionary Bane.',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlVHYEycuZnV5Ih8PbdTwzeDb55DyPmlJCZA&s',
    ),

    Movie(
      title: 'Avengers: Endgame',
      rating: 8.4,
      year: '2019',
      duration: '3h 1min',
      genre: 'Action, Sci-Fi',
      director: 'Anthony Russo, Joe Russo',
      cast: 'Robert Downey Jr., Chris Evans',
      description:
      'After the devastating events of Infinity War, the Avengers assemble once more to undo Thanos’ actions.',
      imageUrl:
      'https://cdn.marvel.com/content/2x/avengersendgame_lob_crd_05_0.jpg',
    ),

    Movie(
      title: 'Spider-Man: No Way Home',
      rating: 8.2,
      year: '2021',
      duration: '2h 28min',
      genre: 'Action, Adventure',
      director: 'Jon Watts',
      cast: 'Tom Holland, Zendaya',
      description:
      'Peter Parker’s identity is revealed, bringing villains from other universes into his world.',
      imageUrl:
      'https://m.media-amazon.com/images/I/81y0foYjoFL._AC_UF1000,1000_QL80_.jpg',
    ),

    Movie(
      title: 'Doctor Strange in the Multiverse of Madness',
      rating: 7.0,
      year: '2022',
      duration: '2h 6min',
      genre: 'Fantasy, Action',
      director: 'Sam Raimi',
      cast: 'Benedict Cumberbatch, Elizabeth Olsen',
      description:
      'Doctor Strange navigates the dangerous multiverse with the help of new and old allies.',
      imageUrl:
      'https://resizing.flixster.com/RfZ4YhxZPdnbMcPd9CkitjdSijQ=/ems.cHJkLWVtcy1hc3NldHMvbW92aWVzLzIxODJmNzBkLWE5MDYtNGYyYi1hZGU4LWMyMTFlMTVjODkzMy5qcGc=',
    ),

    Movie(
      title: 'X-Men: Days of Future Past',
      rating: 8.0,
      year: '2014',
      duration: '2h 12min',
      genre: 'Action, Sci-Fi',
      director: 'Bryan Singer',
      cast: 'Hugh Jackman, James McAvoy',
      description:
      'The X-Men send Wolverine back in time to prevent a future that would lead to extinction.',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/en/thumb/0/0c/X-Men_Days_of_Future_Past_poster.jpg/250px-X-Men_Days_of_Future_Past_poster.jpg',
    ),

    Movie(
      title: 'Logan',
      rating: 8.1,
      year: '2017',
      duration: '2h 17min',
      genre: 'Action, Drama',
      director: 'James Mangold',
      cast: 'Hugh Jackman, Patrick Stewart',
      description:
      'In a bleak future, a weary Logan cares for an ailing Professor X while protecting a young mutant.',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/en/3/37/Logan_2017_poster.jpg',
    ),

    Movie(
      title: 'Black Panther',
      rating: 7.3,
      year: '2018',
      duration: '2h 14min',
      genre: 'Action, Adventure',
      director: 'Ryan Coogler',
      cast: 'Chadwick Boseman, Michael B. Jordan',
      description:
      'T’Challa returns home to Wakanda to take his rightful place as king but faces a powerful enemy.',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/en/d/d6/Black_Panther_%28film%29_poster.jpg',
    ),

  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          SafeArea(
            child: Column(
              children: [
                buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        buildFeaturedSection(),
                        SizedBox(height: 30,),
                        buildCategoryChips(),
                        SizedBox(height: 20,),
                        buildMoviesList(),
                        SizedBox(height: 100,)

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildGlassBottomNav()
        ],
      ),

    );
  }

  Widget buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F0F1E),
            const Color(0xFF1A1A2E),
            const Color(0xFF16213E),
            const Color(0xFF0F0F1E),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNeumorphicIcon(Icons.menu),
          Column(
            children: [
              buildTitle('CineVerse', 24, FontWeight.bold),
              buildText('Discover Movies', 12, Colors.white54),
            ],
          ),
          _buildNeumorphicIcon(Icons.notifications_outlined),
        ],
      ),
    );
  }

  Widget _buildNeumorphicIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white70, size: 24),
    );
  }

  Widget buildFeaturedSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          height: 480,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildGlassmorphicCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.network(
                          trendingMovies[selectedIndex].imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              buildText(
                                trendingMovies[selectedIndex].rating.toString(),
                                14,
                                Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTitle(
                          trendingMovies[selectedIndex].title,
                          26,
                          FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        buildText(
                          trendingMovies[selectedIndex].genre,
                          14,
                          Colors.white70,
                        ),
                        const SizedBox(height: 12),
                        buildRow([
                          _buildInfoChip(Icons.calendar_today,
                              trendingMovies[selectedIndex].year),
                          _buildInfoChip(Icons.access_time,
                              trendingMovies[selectedIndex].duration),
                        ]),
                        const SizedBox(height: 12),
                        buildText(
                          trendingMovies[selectedIndex].description,
                          13,
                          Colors.white60,
                          maxLines: 2,
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

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 14),
          const SizedBox(width: 6),
          buildText(text, 12, Colors.white70),
        ],
      ),
    );
  }

  Widget _buildPlayButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade600,
            Colors.blue.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.play_arrow, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          buildTitle('Play Now', 16, FontWeight.bold),
        ],
      ),
    );
  }

  Widget buildCategoryChips() {
    final categories = ['All', 'Action', 'Drama', 'Sci-Fi', 'Thriller'];
    return Container(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                colors: [Colors.purple.shade600, Colors.blue.shade600],
              )
                  : null,
              color: isSelected ? null : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.2),
              ),
            ),
            child: Center(
              child: buildText(
                categories[index],
                14,
                Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGlassmorphicCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget buildMoviesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTitle('Trending Now', 22, FontWeight.bold),
              buildText('See all', 14, Colors.blue.shade400),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...trendingMovies.asMap().entries.map((entry) {
          int index = entry.key;
          Movie movie = entry.value;
          return _buildMovieListItem(movie, index);
        }).toList(),
      ],
    );
  }

  Widget _buildMovieListItem(Movie movie, int index) {
    bool isSelected = selectedIndex == index;
    return AnimatedContainer(
      key: ValueKey('movie_$index'),
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () async {
          setState(() {
            selectedIndex = index;
          });

          // Pehle scroll to top
          await _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );

          // Phir animations start karo
          _fadeController.reset();
          _slideController.reset();
          await Future.delayed(const Duration(milliseconds: 100));
          _fadeController.forward();
          _slideController.forward();
        },
        child: _buildGlassmorphicCard(
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.purple.withOpacity(0.5),
                width: 2,
              ),
            )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Hero(
                    tag: 'movie_${movie.title}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        movie.imageUrl,
                        width: 100,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTitle(movie.title, 18, FontWeight.bold),
                        const SizedBox(height: 6),
                        buildText('Director: ${movie.director}', 12, Colors.white54),
                        const SizedBox(height: 4),
                        buildText(movie.genre, 13, Colors.white60),
                        const SizedBox(height: 8),
                        buildRow([
                          _buildIconText(Icons.star, movie.rating.toString()),
                          _buildIconText(Icons.calendar_today, movie.year),
                        ]),
                        const SizedBox(height: 10),
                        buildText(
                          movie.description,
                          12,
                          Colors.white54,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        buildText(text, 13, Colors.white70),
      ],
    );
  }

  Widget buildGlassBottomNav() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_rounded, 'Home', 0),
                  _buildNavItem(Icons.search_rounded, 'Search', 1),
                  _buildNavItem(Icons.favorite_rounded, 'Favorites', 2),
                  _buildNavItem(Icons.person_rounded, 'Profile', 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentNavIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentNavIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
            colors: [
              Colors.purple.shade600.withOpacity(0.8),
              Colors.blue.shade600.withOpacity(0.8),
            ],
          )
              : null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white60,
              size: 26,
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              buildText(label, 11, Colors.white),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String text, double size, FontWeight weight) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget buildText(String text, double size, Color color, {int? maxLines}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  Widget buildRow(List<Widget> children) {
    return Row(
      children: children
          .map((child) => Padding(
        padding: const EdgeInsets.only(right: 12),
        child: child,
      ))
          .toList(),
    );
  }
}

class Movie {
  final String title;
  final double rating;
  final String year;
  final String duration;
  final String genre;
  final String director;
  final String cast;
  final String description;
  final String imageUrl;

  Movie({
    required this.title,
    required this.rating,
    required this.year,
    required this.duration,
    required this.genre,
    required this.director,
    required this.cast,
    required this.description,
    required this.imageUrl,
  });
}