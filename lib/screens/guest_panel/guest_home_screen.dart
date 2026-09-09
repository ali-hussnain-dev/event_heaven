import 'package:flutter/material.dart';

// Fixed Absolute Package Imports
import 'package:event_heaven/screens/guest_panel/venue_listing_screen.dart';
import 'package:event_heaven/screens/guest_panel/service_detail_screen.dart';
import 'package:event_heaven/screens/guest_panel/venue_detail_screen.dart';
import 'package:event_heaven/screens/guest_panel/service_listing_screen.dart';
import 'package:event_heaven/screens/auth_onboarding/signup_signin.dart';

// ============================================================================
// CUSTOM GRADIENT TRACK SHAPES
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
// MAIN GUEST HOME SCREEN
// ============================================================================

class GuestHomeScreen extends StatelessWidget {
  const GuestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainGuestScreen();
  }
}

class MainGuestScreen extends StatefulWidget {
  const MainGuestScreen({super.key});

  @override
  State<MainGuestScreen> createState() => _MainGuestScreenState();
}

class _MainGuestScreenState extends State<MainGuestScreen> {
  int _currentIndex = 0;

  final Gradient _primaryGradient = const LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(onOpenFilter: () => _showFilterBottomSheet(context)),
      const GuestAuthLockState(
        title: "Save Your Favorites",
        description:
            "Log in or Sign up to save your favorite venues, marquees, and event services in one place.",
        icon: Icons.favorite_border_rounded,
        targetTabIndex: 1,
      ),
      const GuestAuthLockState(
        title: "Manage Your Bookings",
        description:
            "Log in or Sign up to track your upcoming event bookings, payment receipts, and status.",
        icon: Icons.calendar_month_rounded,
        targetTabIndex: 2,
      ),
      const GuestProfileScreen(),
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginSignupScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: const Color(0xFF8B5CF6),
          unselectedItemColor: Colors.grey.shade400,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, size: 26),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded, size: 26),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded, size: 24),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, size: 26),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    String selectedCategory = 'Venues';
    String selectedCity = 'All';

    // Venue Specific Filters
    String selectedVenueType = 'All';
    RangeValues venuePriceRange = const RangeValues(0, 1000000);
    RangeValues guestCapacity = const RangeValues(0, 2000);
    double venueMinRating = 1.0;
    final Map<String, bool> amenities = {
      'AC & Climate Control': false,
      'Generator Backup': false,
      'Bridal Room': false,
      'Parking / Valet': false,
      'Segregation Setup': false,
    };

    // Service Specific Filters
    String selectedServiceType = 'All';
    RangeValues servicePriceRange = const RangeValues(0, 500000);
    double serviceMinRating = 1.0;

    final List<String> cities = [
      'All',
      'Gujranwala',
      'Lahore',
      'Sialkot',
      'Islamabad',
    ];
    final List<String> venueTypes = [
      'All',
      'Marriage Hall',
      'Marquee',
      'Banquet Hall',
      'Outdoor Venue',
      'Hotel',
    ];
    final List<String> serviceTypes = [
      'All',
      'Car Rental',
      'DJ & Sound',
      'Lighting & Decoration',
      'Catering',
      'Photography & Videography',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            String pricingType = (selectedServiceType == 'Catering')
                ? 'Per Person'
                : 'Per Day';

            return Container(
              height: MediaQuery.of(context).size.height * 0.88,
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
                              "Filter Events",
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
                                      selectedCategory = 'Venues';
                                      selectedCity = 'All';
                                      selectedVenueType = 'All';
                                      venuePriceRange = const RangeValues(
                                        0,
                                        1000000,
                                      );
                                      guestCapacity = const RangeValues(
                                        0,
                                        2000,
                                      );
                                      venueMinRating = 1.0;
                                      amenities.updateAll(
                                        (key, value) => false,
                                      );
                                      selectedServiceType = 'All';
                                      servicePriceRange = const RangeValues(
                                        0,
                                        500000,
                                      );
                                      serviceMinRating = 1.0;
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

                  // Filter Content Body
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const Text(
                          "Select Category",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setModalState(
                                  () => selectedCategory = 'Venues',
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: selectedCategory == 'Venues'
                                        ? _primaryGradient
                                        : null,
                                    color: selectedCategory != 'Venues'
                                        ? Colors.grey.shade100
                                        : null,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: selectedCategory == 'Venues'
                                        ? [
                                            BoxShadow(
                                              color: const Color(
                                                0xFF8B5CF6,
                                              ).withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.apartment_rounded,
                                        size: 20,
                                        color: selectedCategory == 'Venues'
                                            ? Colors.white
                                            : Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Venues",
                                        style: TextStyle(
                                          color: selectedCategory == 'Venues'
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setModalState(
                                  () => selectedCategory = 'Services',
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: selectedCategory == 'Services'
                                        ? _primaryGradient
                                        : null,
                                    color: selectedCategory != 'Services'
                                        ? Colors.grey.shade100
                                        : null,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: selectedCategory == 'Services'
                                        ? [
                                            BoxShadow(
                                              color: const Color(
                                                0xFFEC4899,
                                              ).withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.music_note_rounded,
                                        size: 20,
                                        color: selectedCategory == 'Services'
                                            ? Colors.white
                                            : Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Services",
                                        style: TextStyle(
                                          color: selectedCategory == 'Services'
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // City Dropdown
                        const Text(
                          "City / Location",
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
                            value: selectedCity,
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
                            items: cities
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
                              if (val != null)
                                setModalState(() => selectedCity = val);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        // VENUE FILTERS SECTION
                        if (selectedCategory == 'Venues') ...[
                          const Text(
                            "Venue Type",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 8),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: venueTypes.map((type) {
                              final isSelected = selectedVenueType == type;
                              return GestureDetector(
                                onTap: () => setModalState(
                                  () => selectedVenueType = type,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? _primaryGradient
                                        : null,
                                    color: isSelected
                                        ? null
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.transparent
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 22),

                          // Price Range Slider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Price Range",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Rs. ${_formatPrice(venuePriceRange.start.toInt())} — Rs. ${_formatPrice(venuePriceRange.end.toInt())}",
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
                              values: venuePriceRange,
                              min: 0,
                              max: 1000000,
                              divisions: 100,
                              onChanged: (val) {
                                setModalState(() {
                                  double start =
                                      (val.start / 10000).round() * 10000.0;
                                  double end =
                                      (val.end / 10000).round() * 10000.0;
                                  venuePriceRange = RangeValues(start, end);
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Guest Capacity Slider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Guest Capacity",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${guestCapacity.start.toInt()} — ${guestCapacity.end.toInt()} Guests",
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
                              values: guestCapacity,
                              min: 0,
                              max: 2000,
                              divisions: 40,
                              onChanged: (val) {
                                setModalState(() {
                                  double start =
                                      (val.start / 50).round() * 50.0;
                                  double end = (val.end / 50).round() * 50.0;
                                  guestCapacity = RangeValues(start, end);
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Minimum Rating Slider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Minimum Rating",
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
                                      "${venueMinRating.toStringAsFixed(1)} ★",
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
                              value: venueMinRating,
                              min: 1.0,
                              max: 5.0,
                              divisions: 8,
                              onChanged: (val) =>
                                  setModalState(() => venueMinRating = val),
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Essential Amenities
                          const Text(
                            "Essential Amenities",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...amenities.keys.map((key) {
                            final isChecked = amenities[key] ?? false;
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
                                    () => amenities[key] = val ?? false,
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ],

                        // SERVICE FILTERS SECTION
                        if (selectedCategory == 'Services') ...[
                          const Text(
                            "Service Type",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 8),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: serviceTypes.map((type) {
                              final isSelected = selectedServiceType == type;
                              return GestureDetector(
                                onTap: () => setModalState(
                                  () => selectedServiceType = type,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? _primaryGradient
                                        : null,
                                    color: isSelected
                                        ? null
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.transparent
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 22),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Pricing Model:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: _primaryGradient,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    pricingType,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Service Price Slider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Budget Range",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Rs. ${_formatPrice(servicePriceRange.start.toInt())} — Rs. ${_formatPrice(servicePriceRange.end.toInt())}",
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
                              values: servicePriceRange,
                              min: 0,
                              max: 500000,
                              divisions: 50,
                              onChanged: (val) {
                                setModalState(() {
                                  double start =
                                      (val.start / 10000).round() * 10000.0;
                                  double end =
                                      (val.end / 10000).round() * 10000.0;
                                  servicePriceRange = RangeValues(start, end);
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Minimum Rating Slider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Minimum Rating",
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
                                      "${serviceMinRating.toStringAsFixed(1)} ★",
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
                              value: serviceMinRating,
                              min: 1.0,
                              max: 5.0,
                              divisions: 8,
                              onChanged: (val) =>
                                  setModalState(() => serviceMinRating = val),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Apply Filter Button (Only closes sheet, no navigation / execution logic)
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
                          Navigator.pop(
                            context,
                          ); // Pure UI action - only closes modal
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          "APPLY FILTERS",
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

// =========================================
// TAB 1: MAIN HOME SCREEN CONTENT
// =========================================
class HomeScreen extends StatefulWidget {
  final VoidCallback onOpenFilter;

  const HomeScreen({super.key, required this.onOpenFilter});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> venues = const [
    {
      'title': 'Royal Crown Marriage Hall',
      'tag': 'Marriage Hall',
      'rating': '4.9',
      'reviewsCount': '142',
      'guests': '800 Guests',
      'price': 'Rs. 250,000',
      'location': 'GT Road, Gujranwala',
      'image':
          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=500&q=80',
      'about': 'Experience luxury and elegance at Royal Crown Marriage Hall.',
    },
    {
      'title': 'Al-Noor Grand Marquee',
      'tag': 'Marquee',
      'rating': '4.7',
      'reviewsCount': '98',
      'guests': '600 Guests',
      'price': 'Rs. 320,000',
      'location': 'Canal Road, Gujranwala',
      'image':
          'https://images.unsplash.com/photo-1544078751-58fee2d8a03b?w=500&q=80',
      'about':
          'Al-Noor Grand Marquee offers breathtaking outdoor & indoor ambiance.',
    },
    {
      'title': 'Imperial Banquet Hall',
      'tag': 'Banquet Hall',
      'rating': '4.8',
      'reviewsCount': '115',
      'guests': '450 Guests',
      'price': 'Rs. 180,000',
      'location': 'Model Town, Gujranwala',
      'image':
          'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=500&q=80',
      'about': 'Imperial Banquet Hall specializes in intimate gatherings.',
    },
    {
      'title': 'Pearl Continental Hotel Lawn',
      'tag': 'Hotel',
      'rating': '4.9',
      'reviewsCount': '210',
      'guests': '1200 Guests',
      'price': 'Rs. 550,000',
      'location': 'Downtown, Lahore',
      'image':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&q=80',
      'about':
          'Pearl Continental Hotel Lawn brings world-class 5-star hospitality.',
    },
    {
      'title': 'Green Valley Outdoor Resort',
      'tag': 'Outdoor Venue',
      'rating': '4.6',
      'reviewsCount': '85',
      'guests': '500 Guests',
      'price': 'Rs. 200,000',
      'location': 'Bypass Road, Gujranwala',
      'image':
          'https://images.unsplash.com/photo-1527529482837-4698179dc6ce?w=500&q=80',
      'about':
          'Green Valley Outdoor Resort offers a serene natural landscape for daytime and evening ceremonies under open skies with custom floral decorations and spacious parking.',
    },
  ];

  final List<Map<String, dynamic>> services = const [
    {
      'title': 'Royal Luxury Car Rental',
      'tag': 'CAR RENTAL',
      'rating': '4.9',
      'price': 'Rs. 35,000/day',
      'image':
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500&q=80',
    },
    {
      'title': 'Lumos Grand Lighting',
      'tag': 'LIGHTING & DECOR',
      'rating': '4.7',
      'price': 'Rs. 45,000',
      'image':
          'https://images.unsplash.com/photo-1511578314322-379afb476865?w=500&q=80',
    },
    {
      'title': 'Royal Feast Catering Services',
      'tag': 'CATERING',
      'rating': '4.9',
      'price': 'Rs. 800/person',
      'image':
          'https://images.unsplash.com/photo-1555244162-803834f70033?w=500&q=80',
    },
    {
      'title': 'Bass Nation Sound & DJ Pro',
      'tag': 'DJ & SOUND',
      'rating': '4.8',
      'price': 'Rs. 25,000',
      'image':
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=500&q=80',
    },
    {
      'title': 'Studio Visuals Photography',
      'tag': 'PHOTOGRAPHY',
      'rating': '4.9',
      'price': 'Rs. 60,000',
      'image':
          'https://images.unsplash.com/photo-1537633552985-df8429e8048b?w=500&q=80',
    },
  ];

  void _showNotificationAuthDialog(BuildContext context) {
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
                  Icons.notifications_active_rounded,
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
                "Please log in or create an account to receive real-time updates and notifications about your event bookings.",
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
                        builder: (context) => const LoginSignupScreen(),
                        settings: const RouteSettings(
                          arguments: {
                            'targetTabIndex': 0,
                            'hasWelcomeNotification': true,
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
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Heaven",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Find Perfect Events",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _showNotificationAuthDialog(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Color(0xFF8B5CF6),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Banner Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8B5CF6),
                      Color(0xFFEC4899),
                      Color(0xFFF97316),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome guest! 👋",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Book Your Dream Event",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Standard Search TextField UI Without Suggestions Overlay or Logic
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText:
                                    "Search venues, marquees, services...",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onOpenFilter,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF8B5CF6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Category Cards Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VenueListingScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.apartment_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Venues & Halls",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "120+ listed",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "Explore ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ServiceListingScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFEC4899), Color(0xFFF97316)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.music_note_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Event Services",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "80+ providers",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "Explore ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Top Venues Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top / Popular Venues",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Highest rated in your city",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VenueListingScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "See All >",
                      style: TextStyle(
                        color: Color(0xFF8B5CF6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 255,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: venues.length,
                itemBuilder: (context, index) {
                  final item = venues[index];
                  return Container(
                    width: 240,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
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
                                top: Radius.circular(20),
                              ),
                              child: Image.network(
                                item['image'],
                                height: 130,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        height: 130,
                                        color: Colors.grey.shade100,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Color(0xFF8B5CF6),
                                          ),
                                        ),
                                      );
                                    },
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      height: 130,
                                      color: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.apartment_rounded,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item['tag'],
                                  style: const TextStyle(
                                    color: Color(0xFF8B5CF6),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['rating'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.people_outline,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['guests'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['price'],
                                    style: const TextStyle(
                                      color: Color(0xFF8B5CF6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
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
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFEC4899),
                                            Color(0xFFF97316),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: const Text(
                                        "View Details",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
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
            const SizedBox(height: 24),

            // Top Services Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top Services",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Best-rated event professionals",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ServiceListingScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "See All >",
                      style: TextStyle(
                        color: Color(0xFF8B5CF6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final item = services[index];
                  return Container(
                    width: 220,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.network(
                            item['image'],
                            height: 125,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 125,
                                color: Colors.grey.shade100,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFFEC4899),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  height: 125,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.music_note_rounded,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['tag'],
                                style: const TextStyle(
                                  color: Color(0xFFEC4899),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['rating'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['price'],
                                    style: const TextStyle(
                                      color: Color(0xFF8B5CF6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceDetailScreen(
                                                serviceData:
                                                    Map<String, dynamic>.from(
                                                      item,
                                                    ),
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFEC4899),
                                            Color(0xFFF97316),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: const Text(
                                        "View Details",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class GuestAuthLockState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final int targetTabIndex;

  const GuestAuthLockState({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.targetTabIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF8B5CF6).withOpacity(0.15),
                    const Color(0xFFEC4899).withOpacity(0.15),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 50, color: const Color(0xFF8B5CF6)),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginSignupScreen(),
                      settings: RouteSettings(
                        arguments: {
                          'targetTabIndex': targetTabIndex,
                          'hasWelcomeNotification': false,
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text(
                  "LOGIN / SIGN UP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuestProfileScreen extends StatelessWidget {
  const GuestProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GuestAuthLockState(
      title: "You are browsing as Guest",
      description:
          "Log in or Sign up to manage your profile, view saved events, and connect directly with event providers.",
      icon: Icons.lock_person_rounded,
      targetTabIndex: 3,
    );
  }
}
