import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class MedicalAppointmentScreen extends StatefulWidget {
  const MedicalAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MedicalAppointmentScreen> createState() =>
      _MedicalAppointmentScreenState();
}

class _MedicalAppointmentScreenState extends State<MedicalAppointmentScreen> {
  int _selectedIndex = 0;
  int _selectedCategory = 0;

  final List<Map<String, dynamic>> appointments = [
    {
      'name': 'Dr. Amit Sharma',
      'specialty': 'Cardiologist',
      'image':
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=200&h=200&fit=crop',
      'date': '18 Nov, Monday',
      'time': '8pm - 9:30 pm',
      'rating': 4.9,
      'reviews': 180,
    },
    {
      'name': 'Dr. Neha Verma',
      'specialty': 'Dermatologist',
      'image':
          'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=200&h=200&fit=crop',
      'date': '19 Nov, Tuesday',
      'time': '10am - 11:30 am',
      'rating': 4.8,
      'reviews': 165,
    },
    {
      'name': 'Dr. Rahul Mehta',
      'specialty': 'Neurologist',
      'image':
          'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=200&h=200&fit=crop',
      'date': '20 Nov, Wednesday',
      'time': '2pm - 3:30 pm',
      'rating': 4.7,
      'reviews': 142,
    },
  ];

  final List<Map<String, dynamic>> popularDoctors = [
    {
      'name': 'Dr. Amit Sharma',
      'specialty': 'Cardiology',
      'image':
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=200&h=200&fit=crop',
      'rating': 4.9,
      'reviews': 180,
    },
    {
      'name': 'Dr. Neha Verma',
      'specialty': 'Dermatology',
      'image':
          'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=200&h=200&fit=crop',
      'rating': 4.8,
      'reviews': 165,
    },
  ];

  final List<String> categories = [
    'All',
    'Cardiology',
    'Dermatology',
    'Dentist',
    'Neurologist',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          buildHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSection1(),
                  SizedBox(height: 16,),
                  buildAppointmentSwiper(),
                  SizedBox(height: 24,),
                  buildSection2(),
                  SizedBox(height: 16,),
                  buildCategoryList(),
                  SizedBox(height: 16,),
                  buildPopularDoctorsList()

                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: buildBottomNavBar(),


    );
  }

  buildSection1() {
    return buildSectionHeader('Upcoming Appointments', 'View All');
  }
  buildSection2(){
    return buildSectionHeader('Popular Doctors', 'View All');
  }

  // 🔹 HEADER WIDGET
  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          _buildTitle(),
          const SizedBox(height: 16),
          _buildSearchBar(),
        ],
      ),
    );
  }

  // 🔹 PROFILE HEADER WIDGET
  Widget _buildProfileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good morning!',
                  style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                ),
                SizedBox(height: 2),
                Text(
                  'Sunny Singh',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ],
        ),
        _buildNotificationButton(),
      ],
    );
  }

  // 🔹 NOTIFICATION BUTTON WIDGET
  Widget _buildNotificationButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.notifications_outlined,
        size: 22,
        color: Color(0xFF6B7280),
      ),
    );
  }

  // 🔹 TITLE WIDGET
  Widget _buildTitle() {
    return const Text(
      'How are your feeling\ntoday?',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
        height: 1.3,
      ),
    );
  }

  // 🔹 SEARCH BAR WIDGET
  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 8,
                ),
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(4, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                hintText: 'Search a doctor, medicine, etc...',
                hintStyle: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF9CA3AF),
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
              ),
            ),
          ),
        ),
        const SizedBox(width: 25),
        _buildMicButton(),
      ],
    );
  }

  // 🔹 MIC BUTTON WIDGET
  Widget _buildMicButton() {
    return Container(
      width: 60,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 8),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.network(
          "https://www.iconpacks.net/icons/1/free-microphone-icon-342-thumb.png",
          height: 25,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 🔹 SECTION HEADER WIDGET
  Widget buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        Text(
          actionText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3B82F6),
          ),
        ),
      ],
    );
  }

  // 🔹 APPOINTMENT SWIPER WIDGET
  Widget buildAppointmentSwiper() {
    return SizedBox(
      height: 250,
      child: Swiper(
        layout: SwiperLayout.TINDER,
        itemCount: appointments.length,
        fade: 1.0,
        viewportFraction: 9.0,
        itemWidth: 480.0,
        itemHeight: 400.0,
        itemBuilder: (context, index) {
          return _buildAppointmentCard(appointments[index]);
        },
      ),
    );
  }

  // 🔹 APPOINTMENT CARD WIDGET
  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF517dce), Color(0xFF517dce)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppointmentCardHeader(appointment),
            const SizedBox(height: 16),
            const Divider(thickness: .5),
            const SizedBox(height: 16),
            _buildAppointmentDateTime(appointment),
            const Spacer(),
            _buildAppointmentCardButtons(),
          ],
        ),
      ),
    );
  }

  // 🔹 APPOINTMENT CARD HEADER WIDGET
  Widget _buildAppointmentCardHeader(Map<String, dynamic> appointment) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            appointment['image'],
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                appointment['specialty'],
                style: const TextStyle(fontSize: 14, color: Color(0xFFDCE6FF)),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              "https://cdn-icons-png.flaticon.com/512/711/711245.png",
              height: 20,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 APPOINTMENT DATE & TIME WIDGET
  Widget _buildAppointmentDateTime(Map<String, dynamic> appointment) {
    return Row(
      children: [
        _buildDateTimeItem(Icons.calendar_today, "Date", appointment['date']),
        const Spacer(),
        _buildDateTimeItem(Icons.access_time, "Time", appointment['time']),
      ],
    );
  }

  // 🔹 DATE TIME ITEM WIDGET
  Widget _buildDateTimeItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, size: 14, color: Colors.white70),
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 🔹 APPOINTMENT CARD BUTTONS WIDGET
  Widget _buildAppointmentCardButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF517dce),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text('Re-Schedule', style: TextStyle(fontSize: 13)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withOpacity(.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('View Profile', style: TextStyle(fontSize: 13)),
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 CATEGORY LIST WIDGET
  Widget buildCategoryList() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryChip(index);
        },
      ),
    );
  }

  // 🔹 CATEGORY CHIP WIDGET
  Widget _buildCategoryChip(int index) {
    final isSelected = _selectedCategory == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF517dce) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          categories[index],
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  // 🔹 POPULAR DOCTORS LIST WIDGET
  Widget buildPopularDoctorsList() {
    return Column(
      children: popularDoctors.map((doctor) {
        return _buildDoctorCard(doctor);
      }).toList(),
    );
  }

  // 🔹 DOCTOR CARD WIDGET
  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              doctor['image'],
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doctor['specialty'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 6),
                _buildDoctorRating(doctor),
              ],
            ),
          ),
          _buildArrowButton(),
        ],
      ),
    );
  }

  // 🔹 DOCTOR RATING WIDGET
  Widget _buildDoctorRating(Map<String, dynamic> doctor) {
    return Row(
      children: [
        const Icon(Icons.star, size: 16, color: Color(0xFFFBBF24)),
        const SizedBox(width: 4),
        Text(
          '${doctor['rating']}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${doctor['reviews']} Reviews',
          style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
        ),
      ],
    );
  }

  // 🔹 ARROW BUTTON WIDGET
  Widget _buildArrowButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(0xFF6B7280),
      ),
    );
  }

  // 🔹 BOTTOM NAVIGATION BAR WIDGET
  Widget buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 0),
              _buildNavItem(Icons.calendar_today_rounded, 1),
              _buildNavItem(Icons.chat_bubble_rounded, 2),
              _buildNavItem(Icons.person_rounded, 3),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 NAV ITEM WIDGET
  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF517dce) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
          size: 24,
        ),
      ),
    );
  }
}
