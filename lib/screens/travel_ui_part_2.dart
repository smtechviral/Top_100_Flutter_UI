import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../widgets/appImage.dart';

// ==================== SCREEN 1: FIND HOUSING ====================

class FindHousingScreen extends StatefulWidget {
  const FindHousingScreen({Key? key}) : super(key: key);

  @override
  State<FindHousingScreen> createState() => _FindHousingScreenState();
}

class _FindHousingScreenState extends State<FindHousingScreen> {
  RangeValues priceRange = const RangeValues(20, 250);
  int selectedCategory = 0;
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                buildDestinationSection(),
                SizedBox(height: 24,),
                buildTravelCategoriesSection(),
                SizedBox(height: 24,),
                buildDateSection(),
                SizedBox(height: 40,),
                buildPriceRangeSection(),
                Spacer(),
                buildSearchButton(context),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // App Bar
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Find housing',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // Destination Section
  Widget buildDestinationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Destination'),
        const SizedBox(height: 12),
        _buildDestinationCard(),
      ],
    );
  }

  // Destination Card
  Widget _buildDestinationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.orange.withOpacity(0.05),
            offset: const Offset(-3, -3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            _buildDestinationImage(),
            const SizedBox(width: 12),
            _buildDestinationInfo(),
          ],
        ),
      ),
    );
  }

  // Destination Image
  Widget _buildDestinationImage() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=100&h=100&fit=crop',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Destination Info
  Widget _buildDestinationInfo() {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Squid Tower Building',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Jl. Kembang Melati 123 A, South Jakarta',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Travel Categories Section
  Widget buildTravelCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Travel categories'),
        const SizedBox(height: 12),
        _buildCategoryButtons(),
        const SizedBox(height: 8),
        _buildCategoryHint(),
      ],
    );
  }

  // Category Buttons Container
  Widget _buildCategoryButtons() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryButton('Trip', 0),
            const SizedBox(width: 8),
            _buildCategoryButton('Staycation', 1),
            const SizedBox(width: 8),
            _buildCategoryButton('Stay long', 2),
          ],
        ),
      ),
    );
  }

  // Single Category Button
  Widget _buildCategoryButton(String text, int index) {
    final bool isSelected = selectedCategory == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF09C52),
                Color(0xFFf6741e),
                Color(0xFFF15907),
              ],
            )
                : null,
            color: isSelected ? null : const Color(0xFFF6F7FC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.transparent),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.30),
                offset: const Offset(0, 8),
                blurRadius: 18,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.35),
                offset: const Offset(-2, -2),
                blurRadius: 6,
              ),
            ]
                : [
              BoxShadow(
                color: Colors.grey.withOpacity(0.10),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Category Hint
  Widget _buildCategoryHint() {
    return const Text(
      'Trip category: < 7 days',
      style: TextStyle(fontSize: 12, color: Colors.grey),
    );
  }

  // Date Section
  Widget buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Date arrival & check-in'),
        const SizedBox(height: 12),
        _buildDatePicker(),
      ],
    );
  }

  // Date Picker
  Widget _buildDatePicker() {
    return InkWell(
      onTap: _selectDateRange,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _getDateRangeText(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: 18,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  // Price Range Section
  Widget buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Price range'),
        const SizedBox(height: 12),
        _buildPriceDisplay(),
        const SizedBox(height: 10),
        _buildPriceSlider(),
      ],
    );
  }

  // Price Display Pills
  Widget _buildPriceDisplay() {
    return Row(
      children: [
        _buildPricePill('\$${priceRange.start.round()}'),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        _buildPricePill('\$${priceRange.end.round()}'),
      ],
    );
  }

  // Price Pill
  Widget _buildPricePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  // Price Slider
  Widget _buildPriceSlider() {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: const Color(0xFFFF8C42),
        inactiveTrackColor: Colors.grey.shade300,
        thumbColor: const Color(0xFFFF8C42),
        overlayColor: const Color(0xFFFF8C42).withOpacity(0.2),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        trackHeight: 4,
      ),
      child: RangeSlider(
        values: priceRange,
        min: 0,
        max: 500,
        onChanged: (RangeValues values) {
          setState(() {
            priceRange = values;
          });
        },
      ),
    );
  }

  // Search Button
  Widget buildSearchButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Color(0xFFF7903A), Color(0xFFF15907)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.30),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.35),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => _navigateToResults(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Text(
            'Search & Find',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Section Title (Reusable)
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  // Helper Methods
  String _getDateRangeText() {
    if (selectedDateRange == null) {
      return '23 - 25 November 2021  (3 days)';
    }
    final start = DateFormat('dd MMM yyyy').format(selectedDateRange!.start);
    final end = DateFormat('dd MMM yyyy').format(selectedDateRange!.end);
    final days = selectedDateRange!.duration.inDays + 1;
    return '$start - $end  ($days days)';
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: selectedDateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 2)),
          ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF8C42),
              onPrimary: Colors.white,
              surface: Colors.white,
              background: Colors.white,
              onSurface: Colors.black87,
              surfaceVariant: Colors.white,
              onSurfaceVariant: Colors.black87,
            ),
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            canvasColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Color(0xFFFF8C42)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  void _navigateToResults(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchingResultsScreen(),
      ),
    );
  }
}

// ==================== SCREEN 2: SEARCHING RESULTS ====================

class SearchingResultsScreen extends StatefulWidget {
  const SearchingResultsScreen({Key? key}) : super(key: key);

  @override
  State<SearchingResultsScreen> createState() => _SearchingResultsScreenState();
}

class _SearchingResultsScreenState extends State<SearchingResultsScreen> {
  final Set<String> bookmarkedItems = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 24,),
            buildLocationCard(),
            SizedBox(height: 20,),
            buildResultsHeader(),
            SizedBox(height: 20,),
            buildHousingList()
          ],
        ),
      ),
    );
  }

  // App Bar
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Searching results',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Location Card
  Widget buildLocationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.orange.withOpacity(0.05),
            offset: const Offset(-3, -3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            _buildLocationImage(),
            const SizedBox(width: 12),
            _buildLocationInfo(),
          ],
        ),
      ),
    );
  }

  // Location Image
  Widget _buildLocationImage() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=100&h=100&fit=crop',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Location Info
  Widget _buildLocationInfo() {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Near",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 4),
              Text(
                'Squid Tower Building',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF91633a),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Jl. Kembang Melati 123 A, South Jakarta',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Results Header (Count + Filter)
  Widget buildResultsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildResultsCount(),
        _buildFilterButton(),
      ],
    );
  }

  // Results Count
  Widget _buildResultsCount() {
    return const Text(
      '36 housing items found',
      style: TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // Filter Button
  Widget _buildFilterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.tune, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            'Edit filter',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Housing List
  Widget buildHousingList() {
    return Expanded(
      child: ListView(
        children: [
          _buildHousingCard(
            'Kalibata City',
            'Hotel',
            '1.2 km away',
            75,
            5.0,
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&h=300&fit=crop',
          ),
          const SizedBox(height: 16),
          _buildHousingCard(
            'The Linden Tower',
            'Apartment',
            '3.2 km away',
            95,
            4.5,
            'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&h=300&fit=crop',
          ),
          const SizedBox(height: 16),
          _buildHousingCard(
            'White Green House',
            'Dormitory',
            '3.8 km away',
            25,
            4.5,
            'https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?w=400&h=300&fit=crop',
          ),
          const SizedBox(height: 16),
          _buildHousingCard(
            'Brutalism House',
            'Sharing Room',
            '5.2 km away',
            35,
            3.5,
            'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400&h=300&fit=crop',
          ),
          const SizedBox(height: 16),
          _buildHousingCard(
            'Deep Villa',
            'Sharing Room',
            '5.2 km away',
            35,
            4.5,
            'https://amazingarchitecture.com/storage/files/1/Architecture%20firms/Atrey%20&%20Associates/Deep%20Villa/08.1-Deep-Villa-Atrey-and-Associates-New-Delhi-ndia-Amazing-Architecture.jpg',
          ),
        ],
      ),
    );
  }

  // Single Housing Card
  Widget _buildHousingCard(
      String name,
      String type,
      String distance,
      int price,
      double rating,
      String imageUrl,
      ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            blurRadius: 4,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildCardContent(name, type, distance, price, rating, imageUrl),
          _buildBookmarkButton(imageUrl),
        ],
      ),
    );
  }

  // Card Main Content
  Widget _buildCardContent(
      String name,
      String type,
      String distance,
      int price,
      double rating,
      String imageUrl,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardImage(imageUrl),
        const SizedBox(width: 12),
        _buildCardInfo(name, type, distance, price, rating),
      ],
    );
  }

  // Card Image
  Widget _buildCardImage(String imageUrl) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl.trim()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Card Info
  Widget _buildCardInfo(
      String name,
      String type,
      String distance,
      int price,
      double rating,
      ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(name),
          const SizedBox(height: 3),
          _buildCardType(type),
          const SizedBox(height: 3),
          _buildCardDistance(distance),
          const SizedBox(height: 5),
          _buildCardPriceRow(price, rating),
        ],
      ),
    );
  }

  // Card Title
  Widget _buildCardTitle(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // Card Type
  Widget _buildCardType(String type) {
    return Text(
      type,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
      ),
    );
  }

  // Card Distance
  Widget _buildCardDistance(String distance) {
    return Text(
      distance,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade600,
      ),
    );
  }

  // Card Price Row
  Widget _buildCardPriceRow(int price, double rating) {
    return Row(
      children: [
        _buildPrice(price),
        const Spacer(),
        _buildRating(rating),
      ],
    );
  }

  // Price Display
  Widget _buildPrice(int price) {
    return Row(
      children: [
        Text(
          '\$$price',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFb17d58),
          ),
        ),
        const Text(
          '/month',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  // Rating Display
  Widget _buildRating(double rating) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 16,
          color: Color(0xFFFFC107),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Bookmark Button
  Widget _buildBookmarkButton(String imageUrl) {
    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
        onTap: () => _toggleBookmark(imageUrl.trim()),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                blurRadius: 4,
                offset: const Offset(-2, -2),
              ),
            ],
          ),
          child: Image.asset(
            _isBookmarked(imageUrl.trim())
                ? AppImages.likeIcon
                : AppImages.disLikeIcon,
            color: const Color(0xFF91633a),
            height: 15,
          ),
        ),
      ),
    );
  }

  // Helper Methods
  void _toggleBookmark(String itemIdentifier) {
    setState(() {
      if (bookmarkedItems.contains(itemIdentifier)) {
        bookmarkedItems.remove(itemIdentifier);
      } else {
        bookmarkedItems.add(itemIdentifier);
      }
    });
  }

  bool _isBookmarked(String itemIdentifier) {
    return bookmarkedItems.contains(itemIdentifier);
  }
}