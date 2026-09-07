import 'package:flutter/material.dart';
import 'guesthomescreen.dart'; // Guest Home Screen import

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B5CF6), // Top Vibrant Purple
              Color(0xFFEC4899), // Bottom Vibrant Pink
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 15),

              // Header Section: Direct White Transparent Logo & Titles
              Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                    height: 100,
                    color: Colors.white,
                    colorBlendMode: BlendMode.srcIn,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.storefront_rounded,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const Text(
                          "Welcome!",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Choose how you want to get started",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 22),

                        // 1. Explore as a Guest (Bright Violet/Purple Gradient)
                        _buildRoleOptionCard(
                          context,
                          icon: Icons.login_rounded,
                          title: "Explore as a Guest",
                          subtitle: "Browse venues and services",
                          gradientColors: [
                            const Color(0xFF9333EA),
                            const Color(0xFF7C3AED),
                          ],
                          onTap: () {
                            // Guest Home Screen Navigation
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GuestHomeScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // 2. Register as a User (Bright Vivid Pink Gradient)
                        _buildRoleOptionCard(
                          context,
                          icon: Icons.account_circle_outlined,
                          title: "Register as a User",
                          subtitle: "Book venues for your events",
                          gradientColors: [
                            const Color(0xFFEC4899),
                            const Color(0xFFE11D48),
                          ],
                          onTap: () {
                            // User Register Navigation Logic
                          },
                        ),
                        const SizedBox(height: 14),

                        // 3. Register as Venue Owner (Bright Coral / Orange-Red Gradient)
                        _buildRoleOptionCard(
                          context,
                          icon: Icons.apartment_rounded,
                          title: "Register as Venue Owner",
                          subtitle: "List your venue on our platform",
                          gradientColors: [
                            const Color(0xFFFF5722),
                            const Color(0xFFF97316),
                          ],
                          onTap: () {
                            // Venue Owner Register Navigation Logic
                          },
                        ),
                        const SizedBox(height: 14),

                        // 4. Register as Service Provider (Rich Vibrant Purple-to-Pink Gradient)
                        _buildRoleOptionCard(
                          context,
                          icon: Icons.work_outline_rounded,
                          title: "Register as Service Provider",
                          subtitle: "Offer your professional services",
                          gradientColors: [
                            const Color(0xFF8B5CF6),
                            const Color(0xFFD92662),
                          ],
                          onTap: () {
                            // Service Provider Register Navigation Logic
                          },
                        ),

                        const SizedBox(height: 24),

                        // Footer: Already have an account? Sign In
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 13,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Sign In Navigation Logic
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Color(0xFF8B5CF6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Vibrant Card Component
  Widget _buildRoleOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.35),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11.5,
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
