import 'package:flutter/material.dart';

// Absolute Package Import
import 'package:event_heaven/screens/auth_onboarding/signup_signin.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? serviceData;

  const ServiceDetailScreen({super.key, this.serviceData});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  late Map<String, dynamic> service;
  late List<String> specialties;
  late List<String> equipmentList;

  final LinearGradient _primaryGradient = const LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();
    _initializeServiceData();
  }

  void _initializeServiceData() {
    final Map<String, dynamic> raw = widget.serviceData != null
        ? Map<String, dynamic>.from(widget.serviceData!)
        : {
            'title': 'Bass Nation Sound & DJ Pro',
            'tag': 'DJ & SOUND SYSTEM',
            'rating': '4.8',
            'reviewsCount': '112',
            'priceText': 'Rs. 25,000',
            'image':
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=500&q=80',
          };

    String title = (raw['title'] ?? '').toString().toUpperCase();
    String tag = (raw['tag'] ?? '').toString().toUpperCase();
    String priceDisplay =
        (raw['priceText'] ?? raw['price']?.toString() ?? 'Rs. 25,000')
            .toString();

    // 1. CAR RENTAL CATEGORY
    if (tag.contains('CAR') ||
        title.contains('CAR') ||
        title.contains('RENTAL')) {
      service = {
        'title': raw['title'] ?? 'Royal Luxury Car Rental',
        'providerName': 'Usman Luxury Transport',
        'tag': 'CAR RENTAL',
        'rating': (raw['rating'] ?? '4.9').toString(),
        'reviewsCount':
            (raw['reviewsCount'] ?? raw['reviews']?.toString() ?? '124')
                .toString(),
        'price': priceDisplay.contains('Rs')
            ? priceDisplay
            : 'Rs. $priceDisplay/day',
        'location': (raw['location'] ?? 'Gujranwala / Lahore').toString(),
        'experience': '5 years',
        'eventsCompleted': '220+ completed',
        'image':
            (raw['image'] ??
                    'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500&q=80')
                .toString(),
        'about':
            'Luxury car rental services for royal wedding entries, VIP convoys, and guest transportation. We provide pristine luxury vehicles along with trained professional chauffeurs to make your event entry grand.',
      };
      specialties = [
        'Bridal Entry Car',
        'VIP Convoy Services',
        'Airport Pick & Drop',
        'Decorated Car Options',
        'Intercity Travel',
        'Chauffeur Driven',
      ];
      equipmentList = [
        'Decorated Luxury Sedan / SUV',
        'Professional Uniformed Chauffeur',
        'AC & Clean Leather Interior',
        'Fuel Included Packages',
        '24/7 On-Time Guarantee',
      ];
    }
    // 2. LIGHTING CATEGORY
    else if (tag.contains('LIGHT') ||
        title.contains('LIGHT') ||
        title.contains('LUMOS')) {
      service = {
        'title': raw['title'] ?? 'Lumos Grand Lighting',
        'providerName': 'Lumos Illumination Team',
        'tag': 'LIGHTING',
        'rating': (raw['rating'] ?? '4.7').toString(),
        'reviewsCount':
            (raw['reviewsCount'] ?? raw['reviews']?.toString() ?? '98')
                .toString(),
        'price': priceDisplay.contains('Rs')
            ? priceDisplay
            : 'Rs. $priceDisplay',
        'location': (raw['location'] ?? 'Gujranwala').toString(),
        'experience': '7 years',
        'eventsCompleted': '340+ completed',
        'image':
            (raw['image'] ??
                    'https://images.unsplash.com/photo-1511578314322-379afb476865?w=500&q=80')
                .toString(),
        'about':
            'High-end architectural illumination, fairy light canopy setups, stage spotlights, and ambient LED lighting designed for marriage halls, marquees, and outdoor events.',
      };
      specialties = [
        'Stage Spotlights',
        'Ambient Hall Lighting',
        'Outdoor Fairy Lights',
        'Laser FX Shows',
        'Pathway Illumination',
        'Theme Color Matching',
      ];
      equipmentList = [
        'LED Moving Head Lights',
        'Heavy Duty Power Generator Backup',
        'Stage Spotlights & Dimmers',
        'Fairy Light Canopy Curtains',
        'Insulated Safety Wiring Setup',
      ];
    }
    // 3. CATERING SERVICE CATEGORY
    else if (tag.contains('CATER') ||
        title.contains('CATER') ||
        title.contains('FEAST')) {
      service = {
        'title': raw['title'] ?? 'Royal Feast Catering Services',
        'providerName': 'Royal Feast Master Chefs',
        'tag': 'CATERING SERVICE',
        'rating': (raw['rating'] ?? '4.9').toString(),
        'reviewsCount':
            (raw['reviewsCount'] ?? raw['reviews']?.toString() ?? '156')
                .toString(),
        'price': priceDisplay.contains('Rs')
            ? priceDisplay
            : 'Rs. $priceDisplay/person',
        'location': (raw['location'] ?? 'Lahore / Gujranwala').toString(),
        'experience': '12 years',
        'eventsCompleted': '650+ completed',
        'image':
            (raw['image'] ??
                    'https://images.unsplash.com/photo-1555244162-803834f70033?w=500&q=80')
                .toString(),
        'about':
            'Authentic Pakistani wedding buffets, live BBQ counters, traditional desserts, and continental cuisines prepared under strict hygiene standards by experienced chefs.',
      };
      specialties = [
        'Royal Wedding Buffets',
        'Live BBQ Counters',
        'Corporate Dinners',
        'Dessert & Sweet Bars',
        'Traditional Dishes',
        'Custom Menu Packages',
      ];
      equipmentList = [
        'Hygienic Chafing Dish Buffets',
        'Uniformed Waiter Service Staff',
        'Live Cooking Stations',
        'Crockery & Fine Cutlery Set',
        'Fresh Food Quality Guarantee',
      ];
    }
    // 4. PHOTOGRAPHY CATEGORY
    else if (tag.contains('PHOTO') ||
        title.contains('PHOTO') ||
        title.contains('STUDIO') ||
        title.contains('VISUAL')) {
      service = {
        'title': raw['title'] ?? 'Studio Visuals Photography',
        'providerName': 'Studio Visuals Pro Team',
        'tag': 'PHOTOGRAPHY',
        'rating': (raw['rating'] ?? '4.9').toString(),
        'reviewsCount':
            (raw['reviewsCount'] ?? raw['reviews']?.toString() ?? '184')
                .toString(),
        'price': priceDisplay.contains('Rs')
            ? priceDisplay
            : 'Rs. $priceDisplay',
        'location': (raw['location'] ?? 'Lahore').toString(),
        'experience': '9 years',
        'eventsCompleted': '510+ completed',
        'image':
            (raw['image'] ??
                    'https://images.unsplash.com/photo-1537633552985-df8429e8048b?w=500&q=80')
                .toString(),
        'about':
            'Cinematic wedding videography, 4K drone camera coverage, bridal portraits, and premium photo album printing to capture your precious wedding moments with perfection.',
      };
      specialties = [
        'Cinematic Videography',
        '4K Drone Photography',
        'Bridal Portraits',
        'Traditional Event Photos',
        'Pre-Wedding Shoots',
        'Printed Photo Albums',
      ];
      equipmentList = [
        '4K Cinema Cameras (Sony/Canon)',
        'DJI Drone Camera System',
        'Studio Lighting & Softboxes',
        'Gimbals & Camera Stabilizers',
        'HD Printed Album Set',
      ];
    }
    // 5. DJ & SOUND SYSTEM CATEGORY (DEFAULT FALLBACK)
    else {
      service = {
        'title': raw['title'] ?? 'Bass Nation Sound & DJ Pro',
        'providerName': 'Ali Hassan & Bass Team',
        'tag': 'DJ & SOUND SYSTEM',
        'rating': (raw['rating'] ?? '4.8').toString(),
        'reviewsCount':
            (raw['reviewsCount'] ?? raw['reviews']?.toString() ?? '112')
                .toString(),
        'price': priceDisplay.contains('Rs')
            ? priceDisplay
            : 'Rs. $priceDisplay',
        'location': (raw['location'] ?? 'Lahore').toString(),
        'experience': '8 years',
        'eventsCompleted': '450+ completed',
        'image':
            (raw['image'] ??
                    'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=500&q=80')
                .toString(),
        'about':
            'Professional DJ services for all types of events. We bring energy, music, and unforgettable moments to your special occasions with state-of-the-art equipment and an extensive music library.',
      };
      specialties = [
        'Wedding Events',
        'Corporate Functions',
        'Birthday Parties',
        'Cultural Events',
        'Club Performances',
        'Private Events',
      ];
      equipmentList = [
        'Premium Sound System',
        'LED Stage Lights',
        'Wireless Microphones',
        'DJ Console & Mixers',
        'Subwoofers & Monitors',
      ];
    }
  }

  void _shareService() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Sharing link for ${service['title']}..."),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF8B5CF6),
      ),
    );
  }

  void _showAuthRequiredDialog({
    required String actionText,
    required String intentType,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F3FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    intentType == 'favorite'
                        ? Icons.favorite_rounded
                        : intentType == 'review'
                        ? Icons.rate_review_rounded
                        : Icons.lock_rounded,
                    color: const Color(0xFF8B5CF6),
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
                  "Please log in or sign up to $actionText and proceed with your request.",
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
                      Navigator.pop(dialogContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginSignupScreen(userRole: 'customer'),
                          settings: RouteSettings(
                            arguments: {
                              'targetTabIndex': intentType == 'favorite'
                                  ? 1
                                  : 0,
                              'pendingFavoriteItem': intentType == 'favorite'
                                  ? service
                                  : null,
                              'favoriteType': intentType == 'favorite'
                                  ? 'service'
                                  : null,
                              'openBookingForm': intentType == 'booking',
                              'targetBookingVenue': intentType == 'booking'
                                  ? service
                                  : null,
                              'targetBookingService': intentType == 'booking'
                                  ? service
                                  : null,
                              'bookingType': intentType == 'booking'
                                  ? 'service'
                                  : null,
                              'openReviewForm': intentType == 'review',
                              'targetReviewVenue': intentType == 'review'
                                  ? service
                                  : null,
                              'targetReviewService': intentType == 'review'
                                  ? service
                                  : null,
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
          ),
        );
      },
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
                // Top Banner Image & Floating Header Buttons
                Stack(
                  children: [
                    Image.network(
                      service['image'],
                      height: 290,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 290,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 290,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.35),
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
                                  onTap: _shareService,
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

                                // Favorite Heart Button
                                GestureDetector(
                                  onTap: () => _showAuthRequiredDialog(
                                    actionText:
                                        "save this service to favorites",
                                    intentType: 'favorite',
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.favorite_border_rounded,
                                      size: 18,
                                      color: Colors.black87,
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

                // Service Main Header Card
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
                                  service['title'] ?? 'Service Title',
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
                          const SizedBox(height: 4),
                          Text(
                            "by ${service['providerName']}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
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
                              Text(
                                service['location'] ?? 'Gujranwala',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${service['rating']} ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "(${service['reviewsCount']} reviews)",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Experience & Events Badges
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F3FF),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF8B5CF6,
                                          ).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.card_travel_rounded,
                                          color: Color(0xFF8B5CF6),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Experience",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF8B5CF6),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              service['experience'] ?? '',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF7ED),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFF97316,
                                          ).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.workspace_premium_outlined,
                                          color: Color(0xFFF97316),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Events",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFFF97316),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              service['eventsCompleted'] ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 12),

                          // Clean Price Row
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
                                "${service['price']}",
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

                // About Service Card
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
                            "About Service",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            service['about'] ?? '',
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

                // Specialties Card
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
                            "Specialties",
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
                            itemCount: specialties.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3.8,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 12,
                                ),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFCE7F3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      size: 14,
                                      color: Color(0xFFEC4899),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      specialties[index],
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

                // Equipment Included Card
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
                          "Equipment Included",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: equipmentList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
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
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      equipmentList[index],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Reviews Card with "+ Write Review" Action
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
                              "Reviews (${service['reviewsCount']})",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            TextButton(
                              onPressed: () => _showAuthRequiredDialog(
                                actionText: "write a review for this service",
                                intentType: 'review',
                              ),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFFF1F5F9),
                              child: Text("👨", style: TextStyle(fontSize: 20)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Hamza Malik",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "1 week ago",
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
                                      (i) => const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Extremely professional service! Everything was delivered on time and exceeded our expectations. Highly recommended!",
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
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 110),
              ],
            ),
          ),

          // Single Full-Width "Book Now" Gradient Action Bar at Bottom
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
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: _primaryGradient,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => _showAuthRequiredDialog(
                      actionText: "book this service",
                      intentType: 'booking',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
