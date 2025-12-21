import 'package:flutter/material.dart';

class EventDiscoveryApp extends StatelessWidget {
  const EventDiscoveryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               buildHeader(),
                SizedBox(height: 20,),
                SearchBarWidget(onSearchTap: (){}, onFilterTap: (){}),
                SizedBox(height: 20,),
                SectionHeader(title: "Categories", onSeeAllTap: (){}),
                SizedBox(height: 20,),
                categoryList(),
                SizedBox(height: 20,),
                SectionHeader(title: "Upcoming Events", onSeeAllTap: (){}),
                SizedBox(height: 20,),
                eventCardList(),
                SizedBox(height: 20,),
                SectionHeader(title: "Nearby Events", onSeeAllTap: (){}),
                nearByEvent(),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }

  buildHeader()
  {
    return  LocationHeader(
      location: 'Gujarat, India',
      onLocationTap: () {},
      onNotificationTap: () {},
    );
  }
  eventCardList() {
    return EventCardList(
      events: [
        EventModel(
          imageUrl:
              'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400',
          title: 'Acoustic Serenade Showcase',
          location: 'New York, USA',
          date: 'May 28',
          time: '10:00 PM',
          price: 30.00,
          attendees: 10,
        ),
        EventModel(
          imageUrl:
              'https://cdn.pixabay.com/photo/2016/11/23/15/48/audience-1853662_1280.jpg',
          title: 'Acoustic Night Live',
          location: 'New York, USA',
          date: 'May 30',
          time: '8:00 PM',
          price: 35.00,
          attendees: 8,
        ),
        EventModel(
          imageUrl:
              'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=400',
          title: 'Dino',
          location: 'Gujarat, India',
          date: 'June 30',
          time: '8:00 PM',
          price: 35.00,
          attendees: 8,
        ),
      ],
    );
  }

  nearByEvent() {
    return Column(
      children: [
        NearbyEventCard(
          imageUrl:
              'https://images.unsplash.com/photo-1504609773096-104ff2c73ba4?w=400',
          category: 'Dance',
          title: 'Dance Workshop',
          location: 'Brooklyn, NY',
        ),
        NearbyEventCard(
          imageUrl:
              'https://assets.vogue.in/photos/678e2b456d22a01cc96f60f3/3:4/w_2560%2Cc_limit/Coldplay%2520Mumbai%25202024%2520-%252001.jpg',
          category: 'Singing',
          title: 'Singing Workshop',
          location: 'Brooklyn, IND',
        ),
        NearbyEventCard(
          imageUrl:
              'https://images.unsplash.com/photo-1504609773096-104ff2c73ba4?w=400',
          category: 'Natak',
          title: 'Natak Workshop',
          location: 'Brooklyn, LON',
        ),
      ],
    );
  }

  categoryList(){
    return   CategoryList(
      categories: [
        CategoryModel(icon: Icons.sports_esports, label: 'Gaming'),
        CategoryModel(icon: Icons.palette, label: 'Arts'),
        CategoryModel(
          icon: Icons.business_center,
          label: 'Business',
        ),
        CategoryModel(icon: Icons.checkroom, label: 'Fashion'),
        CategoryModel(icon: Icons.book, label: 'Books'),
      ],
    );
  }

}

// Custom Classes

class LocationHeader extends StatelessWidget {
  final String location;
  final VoidCallback onLocationTap;
  final VoidCallback onNotificationTap;

  const LocationHeader({
    Key? key,
    required this.location,
    required this.onLocationTap,
    required this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: onLocationTap,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFFFF6B35),
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[800],
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              IconButton(
                onPressed: onNotificationTap,
                icon: const Icon(Icons.notifications_outlined),
                iconSize: 24,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Positioned(
                right: 15,
                top: 0,
                bottom: 15,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6B35),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;

  const SearchBarWidget({
    Key? key,
    required this.onSearchTap,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[400]),
                  const SizedBox(width: 12),
                  Text(
                    'Search Events, Organizer',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.onSeeAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: const Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFFF6B35),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryModel {
  final IconData icon;
  final String label;

  CategoryModel({required this.icon, required this.label});
}

class CategoryList extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoryList({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) => CategoryItem(category: cat)).toList(),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B35).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(category.icon, color: const Color(0xFFFF6B35), size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          category.label,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

class EventModel {
  final String imageUrl;
  final String title;
  final String location;
  final String date;
  final String time;
  final double price;
  final int attendees;

  EventModel({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.price,
    required this.attendees,
  });
}

class EventCardList extends StatelessWidget {
  final List<EventModel> events;

  const EventCardList({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < events.length - 1 ? 16 : 0),
            child: EventCard(event: events[index]),
          );
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.7;
    double imageHeight = cardWidth * 0.55; // responsive image height

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------- Top Image -------------------
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  event.imageUrl,
                  width: cardWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: cardWidth,
                      height: imageHeight,
                      color: Colors.grey[300],
                      child: const Icon(Icons.music_note, size: 50),
                    );
                  },
                ),
              ),

              // DATE TAG
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    event.date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // FAV ICON
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Color(0xFFFF6B35),
                  ),
                ),
              ),
            ],
          ),

          // ------------------- CONTENT -------------------
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                // LOCATION + TIME
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Color(0xFFFF6B35),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event.location,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time, size: 16, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      event.time,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // PRICE + ATTENDEES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${event.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6B35),
                      ),
                    ),

                    Row(
                      children: [
                        // PROFILE STACK
                        SizedBox(
                          width: 65,
                          height: 24,
                          child: Stack(
                            children: List.generate(3, (i) {
                              return Positioned(
                                left: i * 18.0,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(
                                    Icons.person,
                                    size: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        const SizedBox(width: 6),

                        // COUNT
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6B35),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "+${event.attendees}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NearbyEventCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final String location;

  const NearbyEventCard({
    Key? key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.event),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Color(0xFFFF6B35),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFFF6B35),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Color(0xFFFF6B35),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({Key? key, required this.currentIndex})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF6B35),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number_outlined),
            activeIcon: Icon(Icons.confirmation_number),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
