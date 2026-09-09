import 'package:flutter/material.dart';

// Absolute Package Imports
import 'package:event_heaven/screens/user_panel/user_home_screen.dart';
import 'package:event_heaven/screens/user_panel/user_venue_detail_screen.dart';

// ============================================================================
// CUSTOM GRADIENT TRACK SHAPES (3-COLOR GRADIENT FOR SLIDERS)
// ============================================================================

class GradientRangeSliderTrackShape extends RangeSliderTrackShape {
  final LinearGradient gradient;

  const GradientRangeSliderTrackShape({
    this.gradient = const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF97316)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 6.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.grey.shade200
      ..style = PaintingStyle.fill;

    final Paint activePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..style = PaintingStyle.fill;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, const Radius.circular(10)),
      inactivePaint,
    );

    final Rect activeRect = Rect.fromLTRB(
      startThumbCenter.dx,
      trackRect.top,
      endThumbCenter.dx,
      trackRect.bottom,
    );

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, const Radius.circular(10)),
      activePaint,
    );
  }
}

class GradientSliderTrackShape extends RoundedRectSliderTrackShape {
  final LinearGradient gradient;

  const GradientSliderTrackShape({
    this.gradient = const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF97316)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    double additionalActiveTrackHeight = 0.0,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.grey.shade200
      ..style = PaintingStyle.fill;

    final Paint activePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..style = PaintingStyle.fill;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, const Radius.circular(10)),
      inactivePaint,
    );

    final Rect activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, const Radius.circular(10)),
      activePaint,
    );
  }
}

// ============================================================================
// USER VENUE LISTING SCREEN
// ============================================================================

class UserVenueListingScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? favoriteVenues;
  final Function(Map<String, dynamic>)? onToggleFavorite;

  const UserVenueListingScreen({
    super.key,
    this.favoriteVenues,
    this.onToggleFavorite,
  });

  @override
  State<UserVenueListingScreen> createState() => _UserVenueListingScreenState();
}

class _UserVenueListingScreenState extends State<UserVenueListingScreen> {
  int _selectedCategoryIndex = 0;
  bool _argsHandled = false;

  late List<Map<String, dynamic>> _localFavorites;
  final TextEditingController _searchController = TextEditingController();

  // Primary Filter State Defaults
  String _selectedCity = 'All';
  RangeValues _priceRange = const RangeValues(0, 1000000);
  RangeValues _guestCapacity = const RangeValues(0, 2000);
  double _minRating = 1.0;

  final Map<String, bool> _amenities = {
    'AC & Climate Control': false,
    'Generator Backup': false,
    'Bridal Room': false,
    'Parking / Valet': false,
    'Segregation Setup': false,
  };

  final Gradient _primaryGradient = const LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Standardized Horizontal Category Chips
  final List<String> _categories = [
    'All',
    'Marriage Hall',
    'Marquee',
    'Banquet Hall',
    'Outdoor Venue',
    'Hotel',
  ];

  final List<String> _cities = [
    'All',
    'Gujranwala',
    'Lahore',
    'Sialkot',
    'Islamabad',
  ];

  // Database of Standardized Venues
  final List<Map<String, dynamic>> _allVenues = [
    {
      'title': 'Royal Crown Marriage Hall',
      'location': 'GT Road, Gujranwala',
      'city': 'Gujranwala',
      'category': 'Marriage Hall',
      'tag': 'Marriage Hall',
      'rating': '4.9',
      'reviews': 142,
      'reviewsCount': '142',
      'guests': '800 Guests',
      'minGuests': 50,
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
      'category': 'Marquee',
      'tag': 'Marquee',
      'rating': '4.7',
      'reviews': 98,
      'reviewsCount': '98',
      'guests': '600 Guests',
      'minGuests': 50,
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
      'category': 'Banquet Hall',
      'tag': 'Banquet Hall',
      'rating': '4.8',
      'reviews': 115,
      'reviewsCount': '115',
      'guests': '450 Guests',
      'minGuests': 50,
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
      'category': 'Hotel',
      'tag': 'Hotel',
      'rating': '4.9',
      'reviews': 210,
      'reviewsCount': '210',
      'guests': '1200 Guests',
      'minGuests': 50,
      'maxGuests': 1200,
      'price': 550000,
      'priceText': 'Rs. 550,000',
      'image':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&q=80',
      'about':
          'Pearl Continental Hotel Lawn brings world-class 5-star hospitality, exquisite catering menus, and an expansive lush green lawn setup suited for mega wedding functions.',
      'isFeatured': true,
    },
    {
      'title': 'Green Valley Outdoor Resort',
      'location': 'Bypass Road, Gujranwala',
      'city': 'Gujranwala',
      'category': 'Outdoor Venue',
      'tag': 'Outdoor Venue',
      'rating': '4.6',
      'reviews': 85,
      'reviewsCount': '85',
      'guests': '500 Guests',
      'minGuests': 50,
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

  @override
  void initState() {
    super.initState();
    _localFavorites = widget.favoriteVenues != null
        ? widget.favoriteVenues!
              .map((e) => Map<String, dynamic>.from(e))
              .toList()
        : [];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argsHandled) {
      _argsHandled = true;
      final rawArgs = ModalRoute.of(context)?.settings.arguments;

      if (rawArgs != null && rawArgs is Map) {
        final Map<String, dynamic> args = rawArgs.map(
          (key, value) => MapEntry(key.toString(), value),
        );

        if (args['targetType'] != null && args['targetType'] != 'All') {
          final String target = args['targetType']
              .toString()
              .trim()
              .toLowerCase();
          final index = _categories.indexWhere(
            (cat) =>
                cat.toLowerCase().contains(target) ||
                target.contains(cat.toLowerCase()),
          );
          if (index != -1) {
            _selectedCategoryIndex = index;
          }
        }
      }
    }
  }

  // Dynamic Filtering Logic (Search logic removed completely)
  List<Map<String, dynamic>> get _filteredVenues {
    List<Map<String, dynamic>> list = _allVenues;

    // 1. Horizontal Category Chip Filter
    if (_selectedCategoryIndex != 0) {
      final targetCategory = _categories[_selectedCategoryIndex].toLowerCase();
      list = list.where((item) {
        final cat = item['category'].toString().toLowerCase();
        final tag = item['tag'].toString().toLowerCase();
        return cat == targetCategory || tag == targetCategory;
      }).toList();
    }

    return list;
  }

  bool _isVenueFavorite(Map<String, dynamic> item) {
    if (widget.favoriteVenues != null) {
      return widget.favoriteVenues!.any(
        (element) => element['title'] == item['title'],
      );
    }
    return _localFavorites.any((element) => element['title'] == item['title']);
  }

  void _handleFavoriteToggle(Map<String, dynamic> item) {
    final safeItem = Map<String, dynamic>.from(item);
    setState(() {
      bool exists = _isVenueFavorite(safeItem);
      if (exists) {
        _localFavorites.removeWhere(
          (element) => element['title'] == safeItem['title'],
        );
      } else {
        _localFavorites.add(safeItem);
      }

      if (widget.onToggleFavorite != null) {
        widget.onToggleFavorite!(safeItem);
      }
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isVenueFavorite(safeItem)
              ? "${safeItem['title']} saved to your favorites!"
              : "${safeItem['title']} removed from your favorites!",
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF8B5CF6),
      ),
    );
  }

  void _navigateBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserHomeScreen(
            initialTabIndex: 0,
            showWelcomeNotification: false,
          ),
        ),
      );
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedCategoryIndex = 0;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayedList = _filteredVenues;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _navigateBack();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Column(
            children: [
              // Top Gradient Header Bar
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: 20,
                ),
                decoration: BoxDecoration(gradient: _primaryGradient),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _navigateBack,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Text(
                          'Explore Venues',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Search Bar without search logic or suggestions
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (val) {
                                // Search bar accepts input text freely without triggering search filtering logic
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText:
                                    'Search venues by name or location...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                              child: const Icon(
                                Icons.clear_rounded,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              _showFilterBottomSheet(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF8B5CF6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.tune_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Horizontal Category Chips
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
                          horizontal: 18,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF8B5CF6),
                                    Color(0xFFEC4899),
                                  ],
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

              // Results Counter
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${displayedList.length} venue(s) found',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Color(0xFF8B5CF6),
                        ),
                        SizedBox(width: 2),
                        Text(
                          'All Cities',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Venue Cards List View
              Expanded(
                child: displayedList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.search_off_rounded,
                                  size: 48,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "No venues found",
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "No venues match your current category selection.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _resetFilters,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B5CF6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                child: const Text(
                                  "Reset Filters",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: displayedList.length,
                        itemBuilder: (context, index) {
                          final item = displayedList[index];
                          final isFav = _isVenueFavorite(item);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
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
                                          loadingBuilder:
                                              (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Container(
                                                  color: Colors.grey.shade100,
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Color(
                                                            0xFF8B5CF6,
                                                          ),
                                                        ),
                                                  ),
                                                );
                                              },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return const Center(
                                                  child: Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                    size: 50,
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
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
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
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: GestureDetector(
                                        onTap: () =>
                                            _handleFavoriteToggle(item),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: const Color(0xFFEC4899),
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserVenueDetailScreen(
                                                          venueData:
                                                              Map<
                                                                String,
                                                                dynamic
                                                              >.from(item),
                                                          initialIsFavorite:
                                                              isFav,
                                                          onToggleFavorite:
                                                              (venue) {
                                                                _handleFavoriteToggle(
                                                                  venue,
                                                                );
                                                              },
                                                        ),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
      ),
    );
  }

  // Filter Bottom Sheet preserved with Apply Filter button not modifying active results/navigation
  void _showFilterBottomSheet(BuildContext context) {
    String tempCity = _selectedCity;
    RangeValues tempPrice = _priceRange;
    RangeValues tempGuest = _guestCapacity;
    double tempRating = _minRating;
    Map<String, bool> tempAmenities = Map.from(_amenities);

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
              child: Column(
                children: [
                  // Modal Top Bar Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: _primaryGradient,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 42,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Filter Venues",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      tempCity = 'All';
                                      tempPrice = const RangeValues(0, 1000000);
                                      tempGuest = const RangeValues(0, 2000);
                                      tempRating = 1.0;
                                      tempAmenities.updateAll(
                                        (key, value) => false,
                                      );
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      "Reset All",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.25),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: Colors.white,
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

                  // Filter Options
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const Text(
                          'City / Location',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: const Color(0xFF8B5CF6),
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: tempCity,
                            focusColor: Colors.transparent,
                            dropdownColor: Colors.white,
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
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5CF6),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            items: _cities
                                .map(
                                  (city) => DropdownMenuItem(
                                    value: city,
                                    child: Text(
                                      city == 'All' ? 'All Cities' : city,
                                    ),
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
                              'Rs. ${_formatPrice(tempPrice.start.toInt())} — Rs. ${_formatPrice(tempPrice.end.toInt())}',
                              style: const TextStyle(
                                color: Color(0xFF8B5CF6),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            rangeTrackShape:
                                const GradientRangeSliderTrackShape(),
                            inactiveTrackColor: Colors.grey.shade200,
                            thumbColor: const Color(0xFFEC4899),
                            overlayColor: const Color(
                              0xFF8B5CF6,
                            ).withOpacity(0.2),
                            trackHeight: 6,
                          ),
                          child: RangeSlider(
                            values: tempPrice,
                            min: 0,
                            max: 1000000,
                            divisions: 100,
                            onChanged: (val) {
                              setModalState(() {
                                double start =
                                    (val.start / 10000).round() * 10000.0;
                                double end =
                                    (val.end / 10000).round() * 10000.0;
                                tempPrice = RangeValues(start, end);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
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
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            rangeTrackShape:
                                const GradientRangeSliderTrackShape(),
                            inactiveTrackColor: Colors.grey.shade200,
                            thumbColor: const Color(0xFFEC4899),
                            overlayColor: const Color(
                              0xFF8B5CF6,
                            ).withOpacity(0.2),
                            trackHeight: 6,
                          ),
                          child: RangeSlider(
                            values: tempGuest,
                            min: 0,
                            max: 2000,
                            divisions: 40,
                            onChanged: (val) {
                              setModalState(() {
                                double start = (val.start / 50).round() * 50.0;
                                double end = (val.end / 50).round() * 50.0;
                                tempGuest = RangeValues(start, end);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Minimum Rating',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: _primaryGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${tempRating.toStringAsFixed(1)} ★',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GradientSliderTrackShape(),
                            inactiveTrackColor: Colors.grey.shade200,
                            thumbColor: const Color(0xFFEC4899),
                            overlayColor: const Color(
                              0xFF8B5CF6,
                            ).withOpacity(0.2),
                            trackHeight: 6,
                            showValueIndicator: ShowValueIndicator.never,
                          ),
                          child: Slider(
                            value: tempRating,
                            min: 1.0,
                            max: 5.0,
                            divisions: 8,
                            onChanged: (val) {
                              setModalState(() {
                                tempRating = val;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          "Essential Amenities",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...tempAmenities.keys.map((key) {
                          final isChecked = tempAmenities[key] ?? false;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              color: isChecked
                                  ? const Color(0xFF8B5CF6).withOpacity(0.06)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isChecked
                                    ? const Color(0xFF8B5CF6).withOpacity(0.4)
                                    : Colors.grey.shade200,
                              ),
                            ),
                            child: CheckboxListTile(
                              title: Text(
                                key,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isChecked
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isChecked
                                      ? const Color(0xFF8B5CF6)
                                      : const Color(0xFF334155),
                                ),
                              ),
                              value: isChecked,
                              activeColor: const Color(0xFF8B5CF6),
                              checkColor: Colors.white,
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 0,
                              ),
                              dense: true,
                              onChanged: (val) {
                                setModalState(
                                  () => tempAmenities[key] = val ?? false,
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Apply Filter Button (Now closes sheet without applying filter logic or navigating)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: _primaryGradient,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8B5CF6).withOpacity(0.35),
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
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          'APPLY FILTERS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
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
