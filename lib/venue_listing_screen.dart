import 'package:flutter/material.dart';
import 'guesthomescreen.dart';
import 'venue_details_screen.dart';

class VenueListingScreen extends StatelessWidget {
  const VenueListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Heaven',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Roboto',
      ),
      home: const BrowseVenuesScreen(),
    );
  }
}

class BrowseVenuesScreen extends StatefulWidget {
  const BrowseVenuesScreen({super.key});

  @override
  State<BrowseVenuesScreen> createState() => _BrowseVenuesScreenState();
}

class _BrowseVenuesScreenState extends State<BrowseVenuesScreen> {
  int _selectedCategoryIndex = 0;

  // Filter States
  String _selectedCity = 'Lahore';
  RangeValues _priceRange = const RangeValues(10000, 300000);
  RangeValues _guestCapacity = const RangeValues(50, 1000);
  RangeValues _ratingRange = const RangeValues(3.5, 5.0);

  final List<String> _categories = [
    'All',
    'Marriage Halls',
    'Marquees',
    'Banquet Halls',
    'Hotels',
    'Outdoor Venues',
  ];

  final List<Map<String, dynamic>> _allVenues = [
    {
      'title': 'Royal Crown Marriage Hall',
      'location': 'GT Road, Gujranwala',
      'city': 'Gujranwala',
      'category': 'Marriage Halls',
      'tag': 'Marriage Hall',
      'rating': '4.9',
      'reviews': 124,
      'reviewsCount': '124',
      'guests': '800 Guests',
      'minGuests': 800,
      'maxGuests': 800,
      'price': 250000,
      'priceText': 'Rs. 250,000',
      'image':
          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=500&q=80',
      'about':
          'Experience luxury and elegance at Royal Crown Marriage Hall. Our state-of-the-art facilities, spacious stage setups, and grand architecture make your special day truly memorable.',
      'isFeatured': true,
    },
    {
      'title': 'Al-Noor Grand Marquee',
      'location': 'Canal Road, Gujranwala',
      'city': 'Gujranwala',
      'category': 'Marquees',
      'tag': 'Marquee',
      'rating': '4.7',
      'reviews': 98,
      'reviewsCount': '98',
      'guests': '600 Guests',
      'minGuests': 600,
      'maxGuests': 600,
      'price': 320000,
      'priceText': 'Rs. 320,000',
      'image':
          'https://images.unsplash.com/photo-1544078751-58fee2d8a03b?w=500&q=80',
      'about':
          'Al-Noor Grand Marquee offers a breathtaking outdoor & indoor ambiance with premium chandelier lighting, climate control, and lavish seating arrangements.',
      'isFeatured': true,
    },
    {
      'title': 'Imperial Banquet Hall',
      'location': 'Model Town, Gujranwala',
      'city': 'Gujranwala',
      'category': 'Banquet Halls',
      'tag': 'Banquet Hall',
      'rating': '4.8',
      'reviews': 115,
      'reviewsCount': '115',
      'guests': '450 Guests',
      'minGuests': 450,
      'maxGuests': 450,
      'price': 180000,
      'priceText': 'Rs. 180,000',
      'image':
          'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=500&q=80',
      'about':
          'Imperial Banquet Hall specializes in intimate gatherings, family celebrations, and corporate dinners. Complete with high-tech audio/visual setups.',
      'isFeatured': true,
    },
    {
      'title': 'Pearl Continental Hotel Lawn',
      'location': 'Downtown, Lahore',
      'city': 'Lahore',
      'category': 'Hotels',
      'tag': 'Hotel Lawn',
      'rating': '4.9',
      'reviews': 310,
      'reviewsCount': '310',
      'guests': '1200 Guests',
      'minGuests': 1200,
      'maxGuests': 1200,
      'price': 550000,
      'priceText': 'Rs. 550,000',
      'image':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&q=80',
      'about':
          'Pearl Continental Hotel Lawn brings world-class 5-star hospitality, exquisite catering menus, and an expansive lush green lawn setup suited for mega weddings.',
      'isFeatured': true,
    },
    {
      'title': 'Green Valley Outdoor Resort',
      'location': 'Bypass Road, Gujranwala',
      'city': 'Gujranwala',
      'category': 'Outdoor Venues',
      'tag': 'Outdoor Resort',
      'rating': '4.6',
      'reviews': 145,
      'reviewsCount': '145',
      'guests': '500 Guests',
      'minGuests': 500,
      'maxGuests': 500,
      'price': 200000,
      'priceText': 'Rs. 200,000',
      'image':
          'https://images.unsplash.com/photo-1527529482837-4698179dc6ce?w=500&q=80',
      'about':
          'Green Valley Outdoor Resort offers a serene natural landscape for daytime and evening ceremonies under open skies with custom floral decorations.',
      'isFeatured': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredVenues {
    if (_selectedCategoryIndex == 0) {
      return _allVenues;
    }
    final targetCategory = _categories[_selectedCategoryIndex];
    return _allVenues
        .where((item) => item['category'] == targetCategory)
        .toList();
  }

  // Auth Required Popup Function
  void _showAuthRequiredDialog(BuildContext context, String actionText) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_outline_rounded,
                  color: Color(0xFF8B5CF6),
                  size: 38,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Login Required",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please log in or sign up to $actionText and manage your account.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "LOGIN / SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayedList = _filteredVenues;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Header
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF8B5CF6),
                    Color(0xFFEC4899),
                    Color(0xFFF97316),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GuestHomeScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Browse Venues',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search venues...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.tune_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _showFilterBottomSheet(context);
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Category Bar
            Container(
              height: 54,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                              )
                            : null,
                        color: isSelected ? null : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Count Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${displayedList.length} venues found',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Venue Cards List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: displayedList.length,
                itemBuilder: (context, index) {
                  final item = displayedList[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                              child: SizedBox(
                                height: 160,
                                width: double.infinity,
                                child: Image.network(
                                  item['image'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        size: 60,
                                        color: Color(0xFFD1D5DB),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (item['isFeatured'] == true)
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFF97316),
                                        Color(0xFFEC4899),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Text(
                                    'Featured',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                            // Favorite Icon with Login Popup Trigger
                            Positioned(
                              top: 12,
                              right: 12,
                              child: GestureDetector(
                                onTap: () => _showAuthRequiredDialog(
                                  context,
                                  "save your favorite venues",
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Color(0xFFEC4899),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Card Content
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item['location'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['rating'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        ' (${item['reviews']})',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    item['guests'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),

                              // Price + View Details Button
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['priceText'],
                                    style: const TextStyle(
                                      color: Color(0xFF8B5CF6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF8B5CF6),
                                          Color(0xFFEC4899),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Navigates to Venue Detail Screen passing exact clicked item
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VenueDetailScreen(
                                                  venueData:
                                                      Map<String, dynamic>.from(
                                                        item,
                                                      ),
                                                ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'View Details',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Filter Bottom Sheet
  void _showFilterBottomSheet(BuildContext context) {
    String tempCity = _selectedCity;
    RangeValues tempPrice = _priceRange;
    RangeValues tempGuest = _guestCapacity;
    RangeValues tempRating = _ratingRange;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setModalState(() {
                                tempCity = 'Lahore';
                                tempPrice = const RangeValues(10000, 300000);
                                tempGuest = const RangeValues(50, 1000);
                                tempRating = const RangeValues(3.5, 5.0);
                              });
                            },
                            child: const Text(
                              'Reset All',
                              style: TextStyle(
                                color: Color(0xFF8B5CF6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        const Text(
                          'City / Location',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: tempCity,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF8B5CF6),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFF8B5CF6),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: const Color(
                                  0xFF8B5CF6,
                                ).withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          items:
                              ['Lahore', 'Gujranwala', 'Islamabad', 'Karachi']
                                  .map(
                                    (city) => DropdownMenuItem(
                                      value: city,
                                      child: Text(city),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setModalState(() {
                                tempCity = val;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Price Range',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Rs. ${tempPrice.start.toInt()} — Rs. ${tempPrice.end.toInt()}',
                              style: const TextStyle(
                                color: Color(0xFF8B5CF6),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        RangeSlider(
                          values: tempPrice,
                          min: 10000,
                          max: 300000,
                          divisions: 29,
                          activeColor: const Color(0xFF8B5CF6),
                          inactiveColor: Colors.grey.shade200,
                          onChanged: (val) {
                            setModalState(() {
                              tempPrice = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Guest Capacity',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${tempGuest.start.toInt()} — ${tempGuest.end.toInt()} Guests',
                              style: const TextStyle(
                                color: Color(0xFF8B5CF6),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        RangeSlider(
                          values: tempGuest,
                          min: 50,
                          max: 1000,
                          divisions: 95,
                          activeColor: const Color(0xFF8B5CF6),
                          inactiveColor: Colors.grey.shade200,
                          onChanged: (val) {
                            setModalState(() {
                              tempGuest = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Rating',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${tempRating.start.toStringAsFixed(1)} — ${tempRating.end.toStringAsFixed(1)} Stars',
                                  style: const TextStyle(
                                    color: Color(0xFF8B5CF6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        RangeSlider(
                          values: tempRating,
                          min: 1.0,
                          max: 5.0,
                          divisions: 40,
                          activeColor: const Color(0xFF8B5CF6),
                          inactiveColor: Colors.grey.shade200,
                          onChanged: (val) {
                            setModalState(() {
                              tempRating = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF8B5CF6),
                          Color(0xFFEC4899),
                          Color(0xFFF97316),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedCity = tempCity;
                          _priceRange = tempPrice;
                          _guestCapacity = tempGuest;
                          _ratingRange = tempRating;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
