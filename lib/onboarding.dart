import 'package:flutter/material.dart';
import 'welcome.dart'; // Direct Package Importr

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentSlide = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Navigation function for Skip & Get Started buttons
  void _navigateToWelcome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'Discover Perfect Venues',
      'description':
          'Browse through hundreds of marriage halls, marquees, and banquet halls for your special day',
      'icon': Icons.apartment_rounded,
      'colors': [
        const Color(0xFF8B5CF6), // Purple
        const Color(0xFFEC4899), // Pink
      ],
      'gridItems': [
        'Marriage Halls',
        'Marquees',
        'Banquet Halls',
        'Outdoor Venues',
      ],
    },
    {
      'title': 'Book Trusted Services',
      'description':
          'Connect with verified DJs, photographers, caterers, decorators, and more - all in one place',
      'icon': Icons.people_alt_rounded,
      'colors': [
        const Color(0xFFEC4899), // Pink
        const Color(0xFFF97316), // Orange
      ],
      'gridItems': ['DJ Services', 'Photography', 'Catering', 'Decoration'],
    },
    {
      'title': 'Easy Booking & Payment',
      'description':
          'Book your dream event with secure payments, real-time chat, and verified reviews',
      'icon': Icons.calendar_month_rounded,
      'colors': [
        const Color(0xFFF97316), // Orange
        const Color(0xFF8B5CF6), // Purple
      ],
      'gridItems': [
        'Instant Booking',
        'Secure Payment',
        'Live Chat',
        'Reviews',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentData = _onboardingData[_currentSlide];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: currentData['colors'],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // 1. Header Bar (Logo & Skip Button)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 45), // Left balancing space
                    // Center Logo Block
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: 80,
                          height: 80,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.storefront_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),

                    // Skip Action
                    GestureDetector(
                      onTap: _navigateToWelcome,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Main Onboarding Slider
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentSlide = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final slide = _onboardingData[index];
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),

                            // Main Category Icon Circle
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                slide['icon'],
                                size: 70,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Title
                            Text(
                              slide['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Description
                            Text(
                              slide['description'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 13.5,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // 2x2 Feature Pills
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 52,
                                    crossAxisSpacing: 14,
                                    mainAxisSpacing: 14,
                                  ),
                              itemBuilder: (context, gridIndex) {
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.22),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    slide['gridItems'][gridIndex],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 3. Footer Navigation Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    // Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 7,
                          width: _currentSlide == index ? 24 : 7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Dynamic Button (NEXT / GET STARTED)
                    ElevatedButton(
                      onPressed: () {
                        if (_currentSlide == _onboardingData.length - 1) {
                          _navigateToWelcome();
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: currentData['colors'][0],
                        minimumSize: const Size(double.infinity, 52),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentSlide == _onboardingData.length - 1
                                ? "GET STARTED"
                                : "NEXT",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
