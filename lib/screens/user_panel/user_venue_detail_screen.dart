import 'package:flutter/material.dart';
import 'venue_booking_form_screen.dart';

class UserVenueDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? venueData;
  final bool initialIsFavorite;
  final Function(Map<String, dynamic>)? onToggleFavorite;
  final bool autoOpenReviewForm;

  const UserVenueDetailScreen({
    super.key,
    this.venueData,
    this.initialIsFavorite = false,
    this.onToggleFavorite,
    this.autoOpenReviewForm = false,
  });

  @override
  State<UserVenueDetailScreen> createState() => _UserVenueDetailScreenState();
}

class _UserVenueDetailScreenState extends State<UserVenueDetailScreen> {
  late final Map<String, dynamic> venue;
  late bool _isFavorite;

  final LinearGradient _primaryGradient = const LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();
    venue =
        widget.venueData ??
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
              'Experience luxury and elegance at Royal Crown Marriage Hall. Our state-of-the-art facilities, spacious stage setups, and grand architecture make your special day truly memorable. Fully equipped for royal weddings and corporate events.',
          'hasSegregation': true,
          'ownerId': 'owner_12345',
        };

    if (venue['about'] == null) {
      venue['about'] =
          'Welcome to ${venue['title']}. We offer top-tier event venue services with modern infrastructure, premium lighting, dynamic stage options, and dedicated staff to make your function seamless and memorable.';
    }
    if (venue['location'] == null) {
      venue['location'] = 'Main Boulevard, Gujranwala';
    }
    if (venue['reviewsCount'] == null && venue['reviews'] != null) {
      venue['reviewsCount'] = '${venue['reviews']}';
    } else if (venue['reviewsCount'] == null) {
      venue['reviewsCount'] = '142';
    }
    if (venue['price'] == null && venue['priceText'] != null) {
      venue['price'] = venue['priceText'];
    }

    _isFavorite = widget.initialIsFavorite || (venue['isFavorite'] == true);

    // Auto-trigger Write Review dialog if user was redirected post-login
    if (widget.autoOpenReviewForm) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWriteReviewDialog();
      });
    }
  }

  // Dynamic Amenities List
  List<String> get _venueAmenities {
    if (venue['amenities'] != null && venue['amenities'] is List) {
      return List<String>.from(venue['amenities']);
    }
    return const [
      'Air Conditioning',
      'Parking Space',
      'Stage & Decorations',
      'Audio System',
      'Catering Kitchen',
      'Bridal Room',
      'Backup Generator',
      'Segregation Setup (Parda)',
    ];
  }

  // Sample Reviews List
  final List<Map<String, dynamic>> _sampleReviews = [
    {
      'name': 'Sarah Ali',
      'date': '2 weeks ago',
      'rating': 5,
      'comment':
          'Amazing venue! Perfect for our family wedding. The staff was very cooperative and the stage decoration exceeded our expectations.',
    },
    {
      'name': 'Usman Tariq',
      'date': '1 month ago',
      'rating': 4.5,
      'comment':
          'Spacious hall with excellent air conditioning and generator backup. Valet parking was managed really smoothly.',
    },
  ];

  void _shareVenue() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Sharing link for ${venue['title']}..."),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF8B5CF6),
      ),
    );
  }

  // Favorite Toggle for Logged-In User
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      venue['isFavorite'] = _isFavorite;
    });

    if (widget.onToggleFavorite != null) {
      widget.onToggleFavorite!(venue);
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite
              ? "${venue['title']} saved to your favorites!"
              : "${venue['title']} removed from your favorites!",
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF8B5CF6),
      ),
    );
  }

  // Write Review Dialog using StatefulBuilder
  void _showWriteReviewDialog() {
    double userRating = 5.0;
    final TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.rate_review_rounded,
                      color: Color(0xFF8B5CF6),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Write a Review",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rate your experience:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            userRating = index + 1.0;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.star_rounded,
                            color: index < userRating
                                ? Colors.amber
                                : Colors.grey.shade300,
                            size: 32,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: reviewController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          "Share feedback about stage, catering, staff...",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color(0xFF8B5CF6),
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: _primaryGradient,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (reviewController.text.trim().isNotEmpty) {
                        setState(() {
                          _sampleReviews.insert(0, {
                            'name': 'Risal Ahmad',
                            'date': 'Just now',
                            'rating': userRating,
                            'comment': reviewController.text.trim(),
                          });
                          int currentReviews =
                              int.tryParse(venue['reviewsCount'].toString()) ??
                              142;
                          venue['reviewsCount'] = '${currentReviews + 1}';
                        });
                        Navigator.pop(dialogContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Thank you for your review!"),
                            backgroundColor: Color(0xFF8B5CF6),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Navigate directly to Booking Form Screen
  void _proceedToBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserBookingFormScreen(venueData: venue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Top Banner Image & Actions
                Stack(
                  children: [
                    Image.network(
                      venue['image'] ??
                          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=500&q=80',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: _shareVenue,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.share_outlined,
                                      size: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: _toggleFavorite,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border_rounded,
                                      size: 18,
                                      color: _isFavorite
                                          ? const Color(0xFFEC4899)
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Main Info Card
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  venue['title'] ?? 'Venue Name',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Color(0xFF16A34A),
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Verified",
                                      style: TextStyle(
                                        color: Color(0xFF16A34A),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
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
                                  venue['location'] ?? 'Gujranwala, Pakistan',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${venue['rating'] ?? '4.8'} ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "(${venue['reviewsCount']} reviews)",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              const Icon(
                                Icons.people_outline_rounded,
                                size: 18,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                venue['guests'] ?? '500-800 guests',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF334155),
                                ),
                              ),
                              const SizedBox(width: 18),
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                "Available Today",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF334155),
                                ),
                              ),
                            ],
                          ),
                          if (venue['hasSegregation'] == true) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F3FF),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(
                                    0xFF8B5CF6,
                                  ).withOpacity(0.3),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shield_outlined,
                                    size: 14,
                                    color: Color(0xFF8B5CF6),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "Segregation Setup (Parda) Available",
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8B5CF6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Starting from",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${venue['price']} /day",
                                style: const TextStyle(
                                  color: Color(0xFF8B5CF6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // About Description Section
                Transform.translate(
                  offset: const Offset(0, -16),
                  child: Padding(
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
                            "About",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            venue['about'] ?? '',
                            style: TextStyle(
                              fontSize: 13.5,
                              color: Colors.grey.shade700,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Amenities Section
                Transform.translate(
                  offset: const Offset(0, -4),
                  child: Padding(
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
                            "Amenities",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _venueAmenities.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4.2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 12,
                                ),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFDCFCE7),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      size: 14,
                                      color: Color(0xFF16A34A),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _venueAmenities[index],
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Reviews Section with "+ Write Review" Action
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reviews (${venue['reviewsCount']})",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            TextButton(
                              onPressed: _showWriteReviewDialog,
                              child: const Text(
                                "+ Write Review",
                                style: TextStyle(
                                  color: Color(0xFF8B5CF6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _sampleReviews.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 24),
                          itemBuilder: (context, index) {
                            final rev = _sampleReviews[index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Text(
                                    rev['name'][0],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8B5CF6),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            rev['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.5,
                                            ),
                                          ),
                                          Text(
                                            rev['date'],
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (i) => Icon(
                                            Icons.star_rounded,
                                            color: i < (rev['rating'] as num)
                                                ? Colors.amber
                                                : Colors.grey.shade300,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        rev['comment'],
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          color: Colors.grey.shade700,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 110),
              ],
            ),
          ),

          // Single Sticky Bottom Bar: Full-Width [Book Now]
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: _primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _proceedToBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
