import 'package:flutter/material.dart';
import 'welcome_screen.dart';

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
              // 1. Clean Header (Right-Aligned Skip Button)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _navigateToWelcome,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
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
                    final List<String> items = List<String>.from(
                      slide['gridItems'],
                    );

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 15),

                            // Category Icon Circle (Resized to 110px for zero screen overflow)
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                slide['icon'],
                                size: 56,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Title
                            Text(
                              slide['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Description
                            Text(
                              slide['description'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13.5,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Optimized 2x2 Feature Pills (Lightweight Flex Rows)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFeaturePill(items[0]),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFeaturePill(items[1]),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFeaturePill(items[2]),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFeaturePill(items[3]),
                                    ),
                                  ],
                                ),
                              ],
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
                  vertical: 16,
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

                    // Dynamic Action Button (NEXT / GET STARTED)
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

  // Helper widget for feature pills (reduces layout delegate overhead)
  Widget _buildFeaturePill(String title) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
