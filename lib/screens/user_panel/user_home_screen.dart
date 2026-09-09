import 'package:flutter/material.dart';

// Absolute Package Imports
import 'package:event_heaven/screens/user_panel/user_venue_listing_screen.dart';
import 'package:event_heaven/screens/user_panel/user_service_listing_screen.dart';
import 'package:event_heaven/screens/user_panel/user_venue_detail_screen.dart';
import 'package:event_heaven/screens/user_panel/user_service_detail_screen.dart';
import 'package:event_heaven/screens/user_panel/venue_booking_form_screen.dart';
import 'package:event_heaven/screens/auth_onboarding/welcome_screen.dart';

// ============================================================================
// CUSTOM GRADIENT TRACK SHAPES FOR SLIDERS
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
// MAIN USER HOME SCREEN ENTRYPOINT
// ============================================================================

class UserHomeScreen extends StatelessWidget {
  final int initialTabIndex;
  final bool showWelcomeNotification;
  final Map<String, dynamic>? pendingFavoriteItem;
  final String? favoriteType;
  final bool openBookingForm;
  final Map<String, dynamic>? targetBookingVenue;
  final bool openReviewForm;
  final Map<String, dynamic>? targetReviewVenue;
  final Map<String, dynamic>? userData;

  const UserHomeScreen({
    super.key,
    this.initialTabIndex = 0,
    this.showWelcomeNotification = false,
    this.pendingFavoriteItem,
    this.favoriteType,
    this.openBookingForm = false,
    this.targetBookingVenue,
    this.openReviewForm = false,
    this.targetReviewVenue,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return MainUserScreen(
      initialTabIndex: initialTabIndex,
      showWelcomeNotification: showWelcomeNotification,
      pendingFavoriteItem: pendingFavoriteItem,
      favoriteType: favoriteType,
      openBookingForm: openBookingForm,
      targetBookingVenue: targetBookingVenue,
      openReviewForm: openReviewForm,
      targetReviewVenue: targetReviewVenue,
      userData: userData,
    );
  }
}

class MainUserScreen extends StatefulWidget {
  final int initialTabIndex;
  final bool showWelcomeNotification;
  final Map<String, dynamic>? pendingFavoriteItem;
  final String? favoriteType;
  final bool openBookingForm;
  final Map<String, dynamic>? targetBookingVenue;
  final bool openReviewForm;
  final Map<String, dynamic>? targetReviewVenue;
  final Map<String, dynamic>? userData;

  const MainUserScreen({
    super.key,
    this.initialTabIndex = 0,
    this.showWelcomeNotification = false,
    this.pendingFavoriteItem,
    this.favoriteType,
    this.openBookingForm = false,
    this.targetBookingVenue,
    this.openReviewForm = false,
    this.targetReviewVenue,
    this.userData,
  });

  @override
  State<MainUserScreen> createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> {
  late int _currentIndex;
  bool _hasProcessedPendingFavorite = false;
  bool _hasOpenedBookingForm = false;
  bool _hasOpenedReviewForm = false;

  final List<Map<String, dynamic>> _favoriteVenues = [];
  final List<Map<String, dynamic>> _favoriteServices = [];

  final Gradient _primaryGradient = const LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  Map<String, dynamic>? _castToMap(dynamic input) {
    if (input == null) return null;
    if (input is Map<String, dynamic>) return Map<String, dynamic>.from(input);
    if (input is Map) {
      return input.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;

    final safePendingFav = _castToMap(widget.pendingFavoriteItem);
    final safeTargetVenue = _castToMap(widget.targetBookingVenue);
    final safeTargetReviewVenue = _castToMap(widget.targetReviewVenue);

    _processFavoriteItem(safePendingFav, widget.favoriteType);

    if (widget.openBookingForm && safeTargetVenue != null) {
      _hasOpenedBookingForm = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToBookingScreen(safeTargetVenue);
      });
    }

    if (widget.openReviewForm && safeTargetReviewVenue != null) {
      _hasOpenedReviewForm = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToReviewScreen(safeTargetReviewVenue);
      });
    }

    if (widget.showWelcomeNotification) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.party_mode, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Welcome to Event Heaven! Your account has been created successfully.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF8B5CF6),
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasProcessedPendingFavorite ||
        !_hasOpenedBookingForm ||
        !_hasOpenedReviewForm) {
      final rawArgs = ModalRoute.of(context)?.settings.arguments;
      final Map<String, dynamic>? args = _castToMap(rawArgs);

      if (args != null) {
        final pendingItem = _castToMap(args['pendingFavoriteItem']);
        final favType = args['favoriteType']?.toString();
        final targetIndex = args['targetTabIndex'] is int
            ? args['targetTabIndex'] as int
            : null;
        final bool openBooking = args['openBookingForm'] == true;
        final bookingVenue = _castToMap(args['targetBookingVenue']);
        final bool openReview = args['openReviewForm'] == true;
        final reviewVenue = _castToMap(args['targetReviewVenue']);

        if (targetIndex != null) {
          setState(() {
            _currentIndex = targetIndex;
          });
        }

        _processFavoriteItem(pendingItem, favType);

        if (openBooking && bookingVenue != null && !_hasOpenedBookingForm) {
          _hasOpenedBookingForm = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigateToBookingScreen(bookingVenue);
          });
        }

        if (openReview && reviewVenue != null && !_hasOpenedReviewForm) {
          _hasOpenedReviewForm = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigateToReviewScreen(reviewVenue);
          });
        }
      }
    }
  }

  void _navigateToBookingScreen(Map<String, dynamic> venue) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UserBookingFormScreen(venueData: Map<String, dynamic>.from(venue)),
      ),
    );
  }

  void _navigateToReviewScreen(Map<String, dynamic> venue) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserVenueDetailScreen(
          venueData: Map<String, dynamic>.from(venue),
          autoOpenReviewForm: true,
        ),
      ),
    );
  }

  void _processFavoriteItem(Map<String, dynamic>? item, String? type) {
    if (item == null || type == null || _hasProcessedPendingFavorite) return;

    final safeItem = Map<String, dynamic>.from(item);

    setState(() {
      if (type == 'venue') {
        bool exists = _favoriteVenues.any(
          (e) => e['title'] == safeItem['title'],
        );
        if (!exists) {
          _favoriteVenues.add(safeItem);
        }
      } else if (type == 'service') {
        bool exists = _favoriteServices.any(
          (e) => e['title'] == safeItem['title'],
        );
        if (!exists) {
          _favoriteServices.add(safeItem);
        }
      }
      _hasProcessedPendingFavorite = true;
    });
  }

  void _toggleVenueFavorite(Map<String, dynamic> rawItem) {
    final item = Map<String, dynamic>.from(rawItem);
    setState(() {
      bool exists = _favoriteVenues.any(
        (element) => element['title'] == item['title'],
      );
      if (exists) {
        _favoriteVenues.removeWhere(
          (element) => element['title'] == item['title'],
        );
      } else {
        _favoriteVenues.add(item);
      }
    });
  }

  void _toggleServiceFavorite(Map<String, dynamic> rawItem) {
    final item = Map<String, dynamic>.from(rawItem);
    setState(() {
      bool exists = _favoriteServices.any(
        (element) => element['title'] == item['title'],
      );
      if (exists) {
        _favoriteServices.removeWhere(
          (element) => element['title'] == item['title'],
        );
      } else {
        _favoriteServices.add(item);
      }
    });
  }

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreenContent(
        onOpenFilter: () => _showFilterBottomSheet(context),
        favoriteVenues: _favoriteVenues,
        favoriteServices: _favoriteServices,
        onToggleVenueFav: _toggleVenueFavorite,
        onToggleServiceFav: _toggleServiceFavorite,
        onSwitchTab: _switchTab,
      ),
      UserFavoritesTab(
        favoriteVenues: _favoriteVenues,
        favoriteServices: _favoriteServices,
        initialSubTab: widget.favoriteType == 'service' ? 1 : 0,
        onRemoveVenue: (index) {
          setState(() {
            _favoriteVenues.removeAt(index);
          });
        },
        onRemoveService: (index) {
          setState(() {
            _favoriteServices.removeAt(index);
          });
        },
        onToggleVenueFav: _toggleVenueFavorite,
        onToggleServiceFav: _toggleServiceFavorite,
      ),
      const UserBookingsTab(),
      UserProfileTab(userData: widget.userData, onSwitchTab: _switchTab),
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
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
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
              icon: Icon(Icons.calendar_month_rounded, size: 24),
              label: 'My Bookings',
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

  void _showFilterBottomSheet(BuildContext context) {
    String selectedCategory = 'Venues';
    String selectedCity = 'All';

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
                              if (val != null) {
                                setModalState(() => selectedCity = val);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
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
// TAB 1: USER HOME SCREEN CONTENT
// =========================================
class HomeScreenContent extends StatelessWidget {
  final VoidCallback onOpenFilter;
  final List<Map<String, dynamic>> favoriteVenues;
  final List<Map<String, dynamic>> favoriteServices;
  final Function(Map<String, dynamic>) onToggleVenueFav;
  final Function(Map<String, dynamic>) onToggleServiceFav;
  final Function(int) onSwitchTab;

  const HomeScreenContent({
    super.key,
    required this.onOpenFilter,
    required this.favoriteVenues,
    required this.favoriteServices,
    required this.onToggleVenueFav,
    required this.onToggleServiceFav,
    required this.onSwitchTab,
  });

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
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
                  size: 38,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "No new notifications right now. We will keep you updated on your booking status and exclusive discounts!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    "Got It",
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
      },
    );
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
      'about':
          'Experience luxury and elegance at Royal Crown Marriage Hall. Our state-of-the-art facilities make your special day truly memorable.',
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
          'Al-Noor Grand Marquee offers a breathtaking outdoor & indoor ambiance with premium chandelier lighting.',
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
      'about':
          'Imperial Banquet Hall specializes in intimate gatherings, family celebrations, and corporate dinners.',
    },
    {
      'title': 'Pearl Continental Hotel Lawn',
      'tag': 'Hotel',
      'rating': '4.9',
      'reviewsCount': '210',
      'guests': '1200 Guests',
      'price': 'Rs. 550,000',
      'location': 'Downtown, Gujranwala',
      'image':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&q=80',
      'about':
          'Pearl Continental Hotel Lawn brings world-class 5-star hospitality and exquisite catering menus.',
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
          'Green Valley Outdoor Resort offers a serene natural landscape for daytime and evening ceremonies under open skies.',
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
      'tag': 'LIGHTING',
      'rating': '4.7',
      'price': 'Rs. 45,000',
      'image':
          'https://images.unsplash.com/photo-1511578314322-379afb476865?w=500&q=80',
    },
    {
      'title': 'Royal Feast Catering Services',
      'tag': 'CATERING SERVICE',
      'rating': '4.9',
      'price': 'Rs. 800/person',
      'image':
          'https://images.unsplash.com/photo-1555244162-803834f70033?w=500&q=80',
    },
    {
      'title': 'Bass Nation Sound & DJ Pro',
      'tag': 'DJ & SOUND SYSTEM',
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
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
                        "Welcome Back, Risal 👋",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8B5CF6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _showNotificationDialog(context),
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
                      "Ready to plan your next event? 🎉",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Book Venues & Vendors",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Search bar without search/autocomplete suggestion logic
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
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
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
                            onTap: onOpenFilter,
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
                            builder: (context) => UserVenueListingScreen(
                              favoriteVenues: favoriteVenues,
                              onToggleFavorite: onToggleVenueFav,
                            ),
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
                            builder: (context) => UserServiceListingScreen(
                              favoriteServices: favoriteServices,
                              onToggleFavorite: onToggleServiceFav,
                            ),
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
                          builder: (context) => UserVenueListingScreen(
                            favoriteVenues: favoriteVenues,
                            onToggleFavorite: onToggleVenueFav,
                          ),
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
                  bool isFav = favoriteVenues.any(
                    (element) => element['title'] == item['title'],
                  );

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
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 130,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.apartment_rounded,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  );
                                },
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
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () => onToggleVenueFav(item),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
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
                                              UserVenueDetailScreen(
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
                          builder: (context) => UserServiceListingScreen(
                            favoriteServices: favoriteServices,
                            onToggleFavorite: onToggleServiceFav,
                          ),
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
                  bool isFav = favoriteServices.any(
                    (element) => element['title'] == item['title'],
                  );

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
                        Stack(
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
                                loadingBuilder:
                                    (context, child, loadingProgress) {
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
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 125,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.music_note_rounded,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () => onToggleServiceFav(item),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: const Color(0xFFEC4899),
                                    size: 16,
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
                                              UserServiceDetailScreen(
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

// =========================================
// TAB 2: USER FAVORITES TAB (TARGETED EMPTY ACTION BUTTONS)
// =========================================
class UserFavoritesTab extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteVenues;
  final List<Map<String, dynamic>> favoriteServices;
  final int initialSubTab;
  final Function(int) onRemoveVenue;
  final Function(int) onRemoveService;
  final Function(Map<String, dynamic>)? onToggleVenueFav;
  final Function(Map<String, dynamic>)? onToggleServiceFav;

  const UserFavoritesTab({
    super.key,
    required this.favoriteVenues,
    required this.favoriteServices,
    this.initialSubTab = 0,
    required this.onRemoveVenue,
    required this.onRemoveService,
    this.onToggleVenueFav,
    this.onToggleServiceFav,
  });

  @override
  State<UserFavoritesTab> createState() => _UserFavoritesTabState();
}

class _UserFavoritesTabState extends State<UserFavoritesTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialSubTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalCount =
        widget.favoriteVenues.length + widget.favoriteServices.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
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
                const Text(
                  "My Favorites",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$totalCount saved items",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF8B5CF6),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF8B5CF6),
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "Venues"),
                Tab(text: "Services"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                widget.favoriteVenues.isEmpty
                    ? _buildEmptyState(
                        icon: Icons.apartment_rounded,
                        title: "No Favorite Venues",
                        message:
                            "Bookmark top marriage halls & marquees to quickly access them for your upcoming events!",
                        buttonLabel: "Explore Venues",
                        buttonIcon: Icons.apartment_rounded,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserVenueListingScreen(
                                favoriteVenues: widget.favoriteVenues,
                                onToggleFavorite: widget.onToggleVenueFav,
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: widget.favoriteVenues.length,
                        itemBuilder: (context, index) {
                          final item = Map<String, dynamic>.from(
                            widget.favoriteVenues[index],
                          );
                          return _buildFavCard(
                            context: context,
                            item: item,
                            defaultIcon: Icons.apartment_rounded,
                            onDelete: () => widget.onRemoveVenue(index),
                            onTapDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserVenueDetailScreen(
                                    venueData: Map<String, dynamic>.from(item),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                widget.favoriteServices.isEmpty
                    ? _buildEmptyState(
                        icon: Icons.music_note_rounded,
                        title: "No Favorite Services",
                        message:
                            "Bookmark decorators, DJs, caterers & photographers for fast multi-service event planning!",
                        buttonLabel: "Explore Services",
                        buttonIcon: Icons.music_note_rounded,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserServiceListingScreen(
                                favoriteServices: widget.favoriteServices,
                                onToggleFavorite: widget.onToggleServiceFav,
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: widget.favoriteServices.length,
                        itemBuilder: (context, index) {
                          final item = Map<String, dynamic>.from(
                            widget.favoriteServices[index],
                          );
                          return _buildFavCard(
                            context: context,
                            item: item,
                            defaultIcon: Icons.headset_mic_rounded,
                            onDelete: () => widget.onRemoveService(index),
                            onTapDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserServiceDetailScreen(
                                    serviceData: Map<String, dynamic>.from(
                                      item,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
    required String buttonLabel,
    required IconData buttonIcon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 50, color: const Color(0xFF8B5CF6)),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 46,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(buttonIcon, size: 18, color: Colors.white),
                label: Text(
                  buttonLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavCard({
    required BuildContext context,
    required Map<String, dynamic> item,
    required IconData defaultIcon,
    required VoidCallback onDelete,
    required VoidCallback onTapDetails,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTapDetails,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item['image']?.toString() ?? '',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF8B5CF6),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Icon(
                        defaultIcon,
                        color: const Color(0xFF8B5CF6),
                        size: 36,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']?.toString() ?? 'Title',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              item['location']?.toString() ?? 'Gujranwala',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            item['rating']?.toString() ?? '4.8',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " (${item['reviewsCount']?.toString() ?? item['reviews']?.toString() ?? '120'})",
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['price']?.toString() ??
                            item['priceText']?.toString() ??
                            '',
                        style: const TextStyle(
                          color: Color(0xFF8B5CF6),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red.shade400,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFCE7F3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Color(0xFFEC4899),
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================
// TAB 3: MY BOOKINGS TAB (FULLY INTERACTIVE)
// =========================================
class UserBookingsTab extends StatefulWidget {
  const UserBookingsTab({super.key});

  @override
  State<UserBookingsTab> createState() => _UserBookingsTabState();
}

class _UserBookingsTabState extends State<UserBookingsTab> {
  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'EH-2026-88',
      'title': 'Royal Palace Hall',
      'category': 'Wedding Reception',
      'date': 'June 15, 2026',
      'time': '6:00 PM',
      'location': 'GT Road, Gujranwala',
      'status': 'Confirmed',
      'statusColor': const Color(0xFF16A34A),
      'totalAmount': 'Rs 250,000',
      'advancePaid': 'Rs 50,000',
      'image':
          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=500&q=80',
      'ownerName': 'Chaudhry Hall Admin',
    },
    {
      'id': 'EH-2026-42',
      'title': 'Studio Visuals Photography',
      'category': 'Photography Service',
      'date': 'October 20, 2026',
      'time': '4:00 PM',
      'location': 'Canal Road, Gujranwala',
      'status': 'Confirmed',
      'statusColor': const Color(0xFF16A34A),
      'totalAmount': 'Rs 60,000',
      'advancePaid': 'Rs 20,000',
      'image':
          'https://images.unsplash.com/photo-1537633552985-df8429e8048b?w=500&q=80',
      'ownerName': 'Studio Team Lead',
    },
    {
      'id': 'EH-2026-19',
      'title': 'Bass Nation Sound & DJ',
      'category': 'DJ & Music Service',
      'date': 'January 15, 2026',
      'time': '8:00 PM',
      'location': 'Model Town, Gujranwala',
      'status': 'Completed',
      'statusColor': Colors.blue,
      'totalAmount': 'Rs 25,000',
      'advancePaid': 'Rs 25,000',
      'image':
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=500&q=80',
      'ownerName': 'Ali Hassan DJ',
    },
    {
      'id': 'EH-2026-05',
      'title': 'Lumos Grand Lighting',
      'category': 'Event Decor',
      'date': 'August 05, 2026',
      'time': '7:00 PM',
      'location': 'Bypass Road, Gujranwala',
      'status': 'Cancelled',
      'statusColor': Colors.redAccent,
      'totalAmount': 'Rs 45,000',
      'advancePaid': 'Rs 10,000',
      'image':
          'https://images.unsplash.com/photo-1511578314322-379afb476865?w=500&q=80',
      'ownerName': 'Lumos Management',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
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
                  const Text(
                    "My Bookings",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelColor: const Color(0xFF8B5CF6),
                      unselectedLabelColor: Colors.white,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: "Upcoming"),
                        Tab(text: "Completed"),
                        Tab(text: "Cancelled"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildBookingsListForStatus(['Confirmed', 'Upcoming']),
                  _buildBookingsListForStatus(['Completed']),
                  _buildBookingsListForStatus(['Cancelled']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsListForStatus(List<String> statuses) {
    final filtered = _bookings
        .where((b) => statuses.contains(b['status']))
        .toList();

    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  size: 48,
                  color: Color(0xFF8B5CF6),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "No Bookings Found",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You don't have any bookings in this category right now.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final b = filtered[index];
        return _buildBookingCard(b);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> b) {
    bool isUpcoming = b['status'] == 'Confirmed' || b['status'] == 'Upcoming';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () => _showBookingDetailsBottomSheet(b),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E8FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          b['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.apartment_rounded,
                                color: Color(0xFF8B5CF6),
                                size: 30,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1E293B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            b['category'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: (b['statusColor'] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 13,
                            color: b['statusColor'],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            b['status'],
                            style: TextStyle(
                              color: b['statusColor'],
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      b['date'],
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      b['time'],
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        b['location'],
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, thickness: 0.8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          b['totalAmount'],
                          style: const TextStyle(
                            color: Color(0xFF8B5CF6),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (isUpcoming) ...[
                          OutlinedButton(
                            onPressed: () => _showCancelBookingDialog(b),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.redAccent),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Opening direct chat with ${b['ownerName']}...",
                                ),
                                backgroundColor: const Color(0xFF8B5CF6),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3E8FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Color(0xFF8B5CF6),
                              size: 18,
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
        ),
      ),
    );
  }

  void _showBookingDetailsBottomSheet(Map<String, dynamic> b) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booking Details (${b['id']})",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: (b['statusColor'] as Color).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      b['status'],
                      style: TextStyle(
                        color: b['statusColor'],
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    b['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  b['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  b['location'],
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const Divider(),
              const SizedBox(height: 8),
              _buildDetailRow("Event Date:", b['date']),
              _buildDetailRow("Time Slot:", b['time']),
              _buildDetailRow("Total Amount:", b['totalAmount']),
              _buildDetailRow("Advance Paid:", b['advancePaid']),
              _buildDetailRow("Vendor Contact:", b['ownerName']),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Downloading PDF Booking Receipt..."),
                        backgroundColor: Color(0xFF8B5CF6),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_rounded, color: Colors.white),
                  label: const Text(
                    "Download Invoice / Receipt",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelBookingDialog(Map<String, dynamic> b) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Cancel Booking?"),
          content: Text(
            "Are you sure you want to cancel booking ${b['id']}? As per policy, advance refund will be calculated.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text("No, Keep It"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  b['status'] = 'Cancelled';
                  b['statusColor'] = Colors.redAccent;
                });
                Navigator.pop(dialogCtx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Booking ${b['id']} cancelled successfully."),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                "Yes, Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

// =========================================
// TAB 4: USER PROFILE TAB (FULLY INTERACTIVE & WIRED)
// =========================================
class UserProfileTab extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final Function(int) onSwitchTab;

  const UserProfileTab({super.key, this.userData, required this.onSwitchTab});

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  late Map<String, dynamic> _profile;

  @override
  void initState() {
    super.initState();
    _profile = {
      'name': widget.userData?['name'] ?? 'Risal Ahmad',
      'email': widget.userData?['email'] ?? 'risal.ahmad@example.com',
      'phone': widget.userData?['phone'] ?? '+92 300 1234567',
      'city': widget.userData?['city'] ?? 'Gujranwala, Pakistan',
    };
  }

  void _openEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserEditProfileScreen(
          currentProfile: _profile,
          onSave: (updated) {
            setState(() {
              _profile = updated;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile updated successfully!"),
                backgroundColor: Color(0xFF8B5CF6),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showChangePasswordSheet() {
    final oldC = TextEditingController();
    final newC = TextEditingController();
    final confirmC = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: oldC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Current Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (newC.text == confirmC.text && newC.text.isNotEmpty) {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password updated successfully!"),
                          backgroundColor: Color(0xFF8B5CF6),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    "Update Password",
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
      },
    );
  }

  void _openHelpSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserHelpSupportScreen()),
    );
  }

  void _openPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserPrivacyPolicyScreen()),
    );
  }

  void _showMyPostedReviewsDialog() {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Row(
            children: [
              Icon(Icons.rate_review_rounded, color: Color(0xFF8B5CF6)),
              SizedBox(width: 8),
              Text("My Posted Reviews", style: TextStyle(fontSize: 18)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildReviewItemTile(
                "Royal Palace Hall",
                5.0,
                "Excellent ambiance and arrangements!",
              ),
              const Divider(),
              _buildReviewItemTile(
                "Bass Nation Sound & DJ",
                4.5,
                "Great sound quality, on time delivery.",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text(
                "Close",
                style: TextStyle(color: Color(0xFF8B5CF6)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReviewItemTile(String title, double rating, String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                  Text(" $rating", style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            comment,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Camera selected for picture"),
                          ),
                        );
                      },
                      icon: const Icon(Icons.camera_alt_rounded),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text("Camera", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Gallery selected for picture"),
                          ),
                        );
                      },
                      icon: const Icon(Icons.photo_library_rounded),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFEC4899),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text("Gallery", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: _openEditProfile,
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        tooltip: "Edit Profile",
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -40,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: const Color(0xFFF3E8FF),
                          child: Text(
                            _profile['name'][0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B5CF6),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showAvatarPicker,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Text(
              _profile['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _profile['email'],
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => widget.onSwitchTab(2),
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F5FF),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFF8B5CF6).withOpacity(0.2),
                          ),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "12",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B5CF6),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Bookings",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: _showMyPostedReviewsDialog,
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF0F5),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFFEC4899).withOpacity(0.2),
                          ),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "8",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEC4899),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Reviews",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
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
                    const Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildContactRow(
                      icon: Icons.email_outlined,
                      iconBg: const Color(0xFFF1F5F9),
                      iconColor: const Color(0xFF64748B),
                      label: "Email",
                      value: _profile['email'],
                    ),
                    const SizedBox(height: 14),
                    _buildContactRow(
                      icon: Icons.phone_outlined,
                      iconBg: const Color(0xFFF1F5F9),
                      iconColor: const Color(0xFF64748B),
                      label: "Phone",
                      value: _profile['phone'],
                    ),
                    const SizedBox(height: 14),
                    _buildContactRow(
                      icon: Icons.location_on_outlined,
                      iconBg: const Color(0xFFF1F5F9),
                      iconColor: const Color(0xFF64748B),
                      label: "Location",
                      value: _profile['city'],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
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
                    const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSettingsRow(
                      icon: Icons.edit_outlined,
                      iconBg: const Color(0xFFF5F3FF),
                      iconColor: const Color(0xFF8B5CF6),
                      title: "Edit Profile",
                      onTap: _openEditProfile,
                    ),
                    _buildSettingsRow(
                      icon: Icons.notifications_none_rounded,
                      iconBg: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xFF3B82F6),
                      title: "Notifications Settings",
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Notifications preferences updated"),
                          ),
                        );
                      },
                    ),
                    _buildSettingsRow(
                      icon: Icons.lock_outline_rounded,
                      iconBg: const Color(0xFFF0FDF4),
                      iconColor: const Color(0xFF22C55E),
                      title: "Change Password",
                      onTap: _showChangePasswordSheet,
                    ),
                    _buildSettingsRow(
                      icon: Icons.help_outline_rounded,
                      iconBg: const Color(0xFFFFF7ED),
                      iconColor: const Color(0xFFF97316),
                      title: "Help & Support",
                      onTap: _openHelpSupport,
                    ),
                    _buildSettingsRow(
                      icon: Icons.shield_outlined,
                      iconBg: const Color(0xFFF0FDF4),
                      iconColor: const Color(0xFF10B981),
                      title: "Terms & Privacy Policy",
                      onTap: _openPrivacyPolicy,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFFEE2E2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFF1F2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.logout_rounded,
                            color: Color(0xFFEF4444),
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Log Out",
                          style: TextStyle(
                            color: Color(0xFFEF4444),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          size: 20,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ==========================================
// NEW FULLY INTEGRATED SCREENS (PROFILE SECTION)
// ==========================================

class UserEditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> currentProfile;
  final Function(Map<String, dynamic>) onSave;

  const UserEditProfileScreen({
    super.key,
    required this.currentProfile,
    required this.onSave,
  });

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.currentProfile['name'],
    );
    _emailController = TextEditingController(
      text: widget.currentProfile['email'],
    );
    _phoneController = TextEditingController(
      text: widget.currentProfile['phone'],
    );
    _cityController = TextEditingController(
      text: widget.currentProfile['city'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      prefixIcon: const Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: "City / Location",
                      prefixIcon: const Icon(Icons.location_city_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8B5CF6),
                    Color(0xFFEC4899),
                    Color(0xFFF97316),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave({
                    'name': _nameController.text.trim(),
                    'email': _emailController.text.trim(),
                    'phone': _phoneController.text.trim(),
                    'city': _cityController.text.trim(),
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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

class UserHelpSupportScreen extends StatelessWidget {
  const UserHelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How can we help you?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Our support team is available 24/7 for assistance.",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Frequently Asked Questions",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          ExpansionTile(
            title: const Text("How do I book a Marriage Hall?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Search for halls in Gujranwala, select your preferred venue, click 'Book Now', fill event details and upload advance payment receipt.",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text("How to contact Hall Admin directly?"),
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "You can tap the 'Chat' button on any venue or booking card to start 1-on-1 direct chat with the hall owner.",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserPrivacyPolicyScreen extends StatelessWidget {
  const UserPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Terms & Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms of Service - Event Heaven",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to Event Heaven. By accessing or using our booking platform for Marriage Halls and Event Services in Pakistan, you agree to comply with our event reservation guidelines.",
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                "Advance Payments & Cancellations",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Advance payments submitted via manual receipt verification are directly authorized by hall owners. Partial refunds on cancellations depend on event dates.",
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
