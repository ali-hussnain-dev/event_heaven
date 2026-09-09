import 'package:flutter/material.dart';

// Fixed Absolute Package Imports
import 'package:event_heaven/screens/guest_panel/guest_home_screen.dart';
import 'package:event_heaven/screens/guest_panel/service_detail_screen.dart';
import 'package:event_heaven/screens/auth_onboarding/signup_signin.dart';

// ============================================================================
// CUSTOM GRADIENT TRACK SHAPES (3-COLOR GRADIENT WITH CORRECT OVERRIDES)
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

    // Background inactive track
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, const Radius.circular(10)),
      inactivePaint,
    );

    // Active track segment between thumbs
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

    // Background track
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, const Radius.circular(10)),
      inactivePaint,
    );

    // Active track segment up to thumb
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
// SERVICE LISTING SCREEN
// ============================================================================

class ServiceListingScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? favoriteServices;

  const ServiceListingScreen({super.key, this.favoriteServices});

  @override
  State<ServiceListingScreen> createState() => _ServiceListingScreenState();
}

class _ServiceListingScreenState extends State<ServiceListingScreen> {
  int _selectedCategoryIndex = 0;

  late List<Map<String, dynamic>> _localFavorites;
  final TextEditingController _searchController = TextEditingController();

  // Primary Filter State Defaults
  String _selectedCity = 'All';
  RangeValues _priceRange = const RangeValues(0, 500000);
  double _minRating = 1.0;

  final Gradient _primaryGradient = const LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final List<String> _categories = [
    'All',
    'Car Rental',
    'DJ & Sound',
    'Lighting & Decoration',
    'Catering',
    'Photography & Videography',
  ];

  final List<String> _cities = [
    'All',
    'Gujranwala',
    'Lahore',
    'Sialkot',
    'Islamabad',
  ];

  final List<Map<String, dynamic>> _allServices = [
    {
      'title': 'Royal Luxury Car Rental',
      'location': 'GT Road, Gujranwala',
      'city': 'Gujranwala',
      'category': 'Car Rental',
      'tag': 'CAR RENTAL',
      'rating': '4.9',
      'reviews': 88,
      'price': 35000,
      'priceText': 'Rs. 35,000/day',
      'pricingModel': 'Per Day',
      'image':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500&q=80',
      'about':
          'Premium luxury cars including Prado, Audi, and Mercedes for wedding bridal entry.',
      'isFeatured': true,
    },
    {
      'title': 'Bass Nation Sound & DJ Pro',
      'location': 'Model Town, Gujranwala',
      'city': 'Gujranwala',
      'category': 'DJ & Sound',
      'tag': 'DJ & SOUND',
      'rating': '4.8',
      'reviews': 64,
      'price': 25000,
      'priceText': 'Rs. 25,000',
      'pricingModel': 'Per Event',
      'image':
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=500&q=80',
      'about':
          'High-power concert sound systems, smoke machines, DJ console, and live mixing setup.',
      'isFeatured': true,
    },
    {
      'title': 'Lumos Grand Lighting',
      'location': 'Canal Road, Gujranwala',
      'city': 'Gujranwala',
      'category': 'Lighting & Decoration',
      'tag': 'LIGHTING & DECOR',
      'rating': '4.7',
      'reviews': 52,
      'price': 45000,
      'priceText': 'Rs. 45,000',
      'pricingModel': 'Per Setup',
      'image':
          'https://images.unsplash.com/photo-1511578314322-379afb476865?w=500&q=80',
      'about':
          'Architectural ambient lighting, LED fairy tunnels, theme stage setups, and floral entrance arches.',
      'isFeatured': true,
    },
    {
      'title': 'Royal Feast Catering Services',
      'location': 'Downtown, Lahore',
      'city': 'Lahore',
      'category': 'Catering',
      'tag': 'CATERING',
      'rating': '4.9',
      'reviews': 130,
      'price': 800,
      'priceText': 'Rs. 800/person',
      'pricingModel': 'Per Person',
      'image':
          'https://images.unsplash.com/photo-1555244162-803834f70033?w=500&q=80',
      'about':
          'Authentic Pakistani, Chinese, and Continental wedding menus with live Naan and BBQ stations.',
      'isFeatured': true,
    },
    {
      'title': 'Studio Visuals Photography',
      'location': 'Jinnah Road, Sialkot',
      'city': 'Sialkot',
      'category': 'Photography & Videography',
      'tag': 'PHOTOGRAPHY',
      'rating': '4.9',
      'reviews': 95,
      'price': 60000,
      'priceText': 'Rs. 60,000',
      'pricingModel': 'Per Day',
      'image':
          'https://images.unsplash.com/photo-1537633552985-df8429e8048b?w=500&q=80',
      'about':
          'Cinematic 4K drone shoots, candid photography, customized albums, and trailer video editing.',
      'isFeatured': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _localFavorites = widget.favoriteServices != null
        ? List.from(widget.favoriteServices!)
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

  // Raw list display without applying search or filter algorithms
  List<Map<String, dynamic>> get _filteredServices => _allServices;

  bool _isServiceFavorite(Map<String, dynamic> item) {
    if (widget.favoriteServices != null) {
      return widget.favoriteServices!.any(
        (element) => element['title'] == item['title'],
      );
    }
    return _localFavorites.any((element) => element['title'] == item['title']);
  }

  void _handleFavoriteToggle(Map<String, dynamic> item) {
    _showAuthRequiredDialog(context, item);
  }

  void _navigateBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GuestHomeScreen()),
      );
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedCategoryIndex = 0;
      _selectedCity = 'All';
      _priceRange = const RangeValues(0, 500000);
      _minRating = 1.0;
      _searchController.clear();
    });
  }

  void _showAuthRequiredDialog(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F3FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Color(0xFF8B5CF6),
                  size: 40,
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
                "Please log in or create an account to save '${item['title']}' to your favorites tab.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 46,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const LoginSignupScreen(userRole: 'customer'),
                        settings: RouteSettings(
                          arguments: {
                            'targetTabIndex': 1,
                            'pendingFavoriteItem': item,
                            'favoriteType': 'service',
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  child: const Text(
                    "LOGIN / SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
    final displayedList = _filteredServices;

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
                          'Event Services',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Standard Search TextField UI Without Suggestions Overlay or Logic
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
                              decoration: InputDecoration(
                                hintText: 'Search DJ, catering, photography...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
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
                                    Color(0xFFEC4899),
                                    Color(0xFFF97316),
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
                      '${displayedList.length} service(s) found',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Color(0xFFEC4899),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          _selectedCity == 'All' ? 'All Cities' : _selectedCity,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEC4899),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Service Cards List
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
                                "No services found",
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "No service providers match your search query or price constraints.",
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
                                  backgroundColor: const Color(0xFFEC4899),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                child: const Text(
                                  "Reset All Filters",
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
                        itemCount: displayedList.length,
                        itemBuilder: (context, index) {
                          final item = displayedList[index];
                          final isFav = _isServiceFavorite(item);

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
                                                if (loadingProgress == null)
                                                  return child;
                                                return Container(
                                                  color: Colors.grey.shade100,
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Color(
                                                            0xFFEC4899,
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
                                    Positioned(
                                      top: 12,
                                      left: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: Text(
                                          item['tag'],
                                          style: const TextStyle(
                                            color: Color(0xFFEC4899),
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
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              item['pricingModel'],
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF475569),
                                                fontWeight: FontWeight.w600,
                                              ),
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
                                                  Color(0xFFEC4899),
                                                  Color(0xFFF97316),
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
                                                        ServiceDetailScreen(
                                                          serviceData:
                                                              Map<
                                                                String,
                                                                dynamic
                                                              >.from(item),
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

  // Refined Service Filter Bottom Sheet (Pure UI action - only closes modal)
  void _showFilterBottomSheet(BuildContext context) {
    String tempCity = _selectedCity;
    RangeValues tempPrice = _priceRange;
    double tempRating = _minRating;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                children: [
                  // Top Gradient Header Bar
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
                              "Filter Services",
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
                                      tempPrice = const RangeValues(0, 500000);
                                      tempRating = 1.0;
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

                  // Filter Body
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // City Dropdown
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
                              primary: const Color(0xFFEC4899),
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: tempCity,
                            focusColor: Colors.transparent,
                            dropdownColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xFFEC4899),
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
                                  color: Color(0xFFEC4899),
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

                        // Service Price Range Slider with 3-Color Gradient Track
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Budget Range',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Rs. ${_formatPrice(tempPrice.start.toInt())} — Rs. ${_formatPrice(tempPrice.end.toInt())}',
                              style: const TextStyle(
                                color: Color(0xFFEC4899),
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
                            thumbColor: const Color(0xFF8B5CF6),
                            overlayColor: const Color(
                              0xFFEC4899,
                            ).withOpacity(0.2),
                            trackHeight: 6,
                          ),
                          child: RangeSlider(
                            values: tempPrice,
                            min: 0,
                            max: 500000,
                            divisions: 50,
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
                        const SizedBox(height: 20),

                        // Minimum Rating Slider with 3-Color Gradient Track & NO Blue Tooltip
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
                            thumbColor: const Color(0xFF8B5CF6),
                            overlayColor: const Color(
                              0xFFEC4899,
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
                      ],
                    ),
                  ),

                  // Apply Filter Action Button (Pure UI action - only closes modal)
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
