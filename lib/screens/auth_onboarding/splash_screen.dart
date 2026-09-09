import 'package:flutter/material.dart';
import 'onboarding_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 1. Controller setup (2.5 seconds total for smooth progression)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 2. Smooth easeInOut curve to prevent sudden/abrupt progress fill
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // 3. Navigation trigger on animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });

    // 4. Ensure image is loaded in memory first before starting animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage("assets/images/logo.png"), context);
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8B5CF6), // Purple
              Color(0xFFEC4899), // Pink
              Color(0xFFF97316), // Orange
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),

              // App Logo Asset
              Image.asset(
                "assets/images/logo.png",
                width: 150,
                height: 150,
                color: Colors.white,
                colorBlendMode: BlendMode.srcIn,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.storefront_rounded,
                  color: Colors.white,
                  size: 90,
                ),
              ),

              const SizedBox(height: 35),

              // Smoothly Animated Progress Bar
              SizedBox(
                width: 180,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _animation.value,
                        minHeight: 5,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
