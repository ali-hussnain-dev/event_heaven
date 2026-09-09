import 'package:flutter/material.dart';

// Fixed Absolute Package Imports
import 'package:event_heaven/screens/user_panel/user_home_screen.dart';
import 'package:event_heaven/screens/venue_owner/venue_owner_registration_screen.dart';
import 'package:event_heaven/screens/service_provider_panel/service_provider_registration_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  final bool isSignUp;
  final String
  userRole; // Roles: 'customer', 'venue_owner', 'hall_admin', 'service_provider', 'vendor'

  const LoginSignupScreen({
    super.key,
    this.isSignUp = true,
    this.userRole = 'customer',
  });

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool _isObscure = true;
  bool _isConfirmObscure = true;
  late bool _isSignUpMode;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _isSignUpMode = widget.isSignUp;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Header Title Generator
  String _getDynamicHeaderTitle() {
    if (_isSignUpMode) {
      if (widget.userRole == 'venue_owner' || widget.userRole == 'hall_admin') {
        return "Venue Owner Sign Up";
      } else if (widget.userRole == 'service_provider' ||
          widget.userRole == 'vendor') {
        return "Service Provider Sign Up";
      }
      return "User Sign Up";
    } else {
      return "Sign In";
    }
  }

  // Navigation redirect after Auth with Full Booking, Favorite & Review Arguments Forwarding
  void _handleAuthRedirect() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int targetTabIndex = args?['targetTabIndex'] ?? 0;
    final Map<String, dynamic>? pendingFavoriteItem =
        args?['pendingFavoriteItem'];
    final String? favoriteType = args?['favoriteType'];
    final bool openBookingForm = args?['openBookingForm'] ?? false;
    final Map<String, dynamic>? targetBookingVenue =
        args?['targetBookingVenue'];
    final bool openReviewForm = args?['openReviewForm'] ?? false;
    final Map<String, dynamic>? targetReviewVenue = args?['targetReviewVenue'];

    if (widget.userRole == 'customer') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => UserHomeScreen(
            initialTabIndex: targetTabIndex,
            showWelcomeNotification: true,
            pendingFavoriteItem: pendingFavoriteItem,
            favoriteType: favoriteType,
            openBookingForm: openBookingForm,
            targetBookingVenue: targetBookingVenue,
            openReviewForm: openReviewForm,
            targetReviewVenue: targetReviewVenue,
          ),
          settings: RouteSettings(arguments: args),
        ),
        (route) => false,
      );
    } else if (widget.userRole == 'venue_owner' ||
        widget.userRole == 'hall_admin') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VenueOwnerRegistrationScreen(),
        ),
      );
    } else if (widget.userRole == 'service_provider' ||
        widget.userRole == 'vendor') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ServiceProviderRegistrationScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // 1. TOP GRADIENT HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 55, bottom: 40),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF8B5CF6),
                      Color(0xFFEC4899),
                      Color(0xFFF43F5E),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    stops: [0.10, 0.65, 1.0],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 90,
                      width: 90,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.event_available_rounded,
                          color: Colors.white,
                          size: 75,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _getDynamicHeaderTitle(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isSignUpMode
                          ? "Create an account to get started"
                          : "Welcome back! Enter your credentials",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. FORM CARD CONTAINER
              Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // EMAIL FIELD
                      const Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 14),
                        decoration: _buildInputDecoration(
                          hint: "Enter your email",
                          icon: Icons.mail_outline_rounded,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // PASSWORD FIELD
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _isObscure,
                        style: const TextStyle(fontSize: 14),
                        decoration: _buildInputDecoration(
                          hint: "Enter your password",
                          icon: Icons.lock_outline_rounded,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey.shade400,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      ),

                      // CONFIRM PASSWORD FIELD (SIGN UP ONLY)
                      if (_isSignUpMode) ...[
                        const SizedBox(height: 18),
                        const Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: _isConfirmObscure,
                          style: const TextStyle(fontSize: 14),
                          decoration: _buildInputDecoration(
                            hint: "Re-enter your password",
                            icon: Icons.lock_clock_outlined,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmObscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey.shade400,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmObscure = !_isConfirmObscure;
                                });
                              },
                            ),
                          ),
                        ),
                      ],

                      // FORGOT PASSWORD LINK
                      if (!_isSignUpMode) ...[
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color(0xFFEC4899),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 26),

                      // ACTION BUTTON
                      Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFEC4899).withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _handleAuthRedirect,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: Text(
                            _isSignUpMode ? "Create Account" : "Sign In",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // TOGGLE MODE FOOTER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isSignUpMode
                                ? "Already have an account? "
                                : "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSignUpMode = !_isSignUpMode;
                              });
                            },
                            child: Text(
                              _isSignUpMode ? "Sign In" : "Sign Up",
                              style: const TextStyle(
                                color: Color(0xFFEC4899),
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
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
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFEC4899), width: 1.5),
      ),
    );
  }
}
