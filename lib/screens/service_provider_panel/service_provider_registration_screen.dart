import 'package:flutter/material.dart';
import 'service_provider_dashboard.dart'; // Navigates to Service Provider Dashboard

class ServiceProviderRegistrationScreen extends StatefulWidget {
  const ServiceProviderRegistrationScreen({super.key});

  @override
  State<ServiceProviderRegistrationScreen> createState() =>
      _ServiceProviderRegistrationScreenState();
}

class _ServiceProviderRegistrationScreenState
    extends State<ServiceProviderRegistrationScreen> {
  int _currentStep = 0;

  // --- Step 1: Personal & Vendor Controllers ---
  final TextEditingController _vendorNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _businessRegController = TextEditingController();

  String _selectedCategory = 'Car Rental';
  final List<String> _categoryOptions = [
    'Car Rental',
    'Lighting Services',
    'Catering Services',
    'DJ & Sound System',
    'Photography & Videography',
    'Stage Decor & Florist',
  ];

  // --- Step 2: Service Details Controllers ---
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _basePriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCity = 'Gujranwala';
  final List<String> _cityOptions = [
    'Gujranwala',
    'Lahore',
    'Sialkot',
    'Islamabad',
    'Faisalabad',
    'Rawalpindi',
  ];

  String _selectedExperience = '3 - 5 Years';
  final List<String> _experienceOptions = [
    '1 - 2 Years',
    '3 - 5 Years',
    '5 - 10 Years',
    '10+ Years Expert',
  ];

  bool _isMapLocationPicked = false;
  String _mapCoordinatesText = "No GPS pin selected";

  final Map<String, bool> _serviceCapabilities = {
    'On-Site Setup & Delivery Available': true,
    'Heavy Power Equipment / Backup Included': false,
    'Emergency Last-Minute Bookings Accepted': true,
    'Custom Catering / Specialized Themes Offered': false,
    'Advance Booking Deposit Required': true,
  };

  // --- Step 3: Verification & Portfolio States ---
  bool _cnicFrontUploaded = false;
  bool _cnicBackUploaded = false;
  bool _workProofUploaded = false;
  bool _coverBannerUploaded = false;
  int _portfolioCount = 0;

  @override
  void dispose() {
    _vendorNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cnicController.dispose();
    _businessRegController.dispose();
    _serviceNameController.dispose();
    _addressController.dispose();
    _basePriceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _submitRegistration() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.verified_user_rounded,
                color: Color(0xFF8B5CF6),
                size: 42,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Submitted for Review",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your service provider registration and portfolio documents have been submitted to System Admin.\n\nYou will receive an approval notification once verified.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
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
                  Navigator.pop(ctx);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ServiceProviderDashboardScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  "GO TO DASHBOARD",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Top Sticky Gradient Header & Step Progress
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 44, 16, 20),
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_currentStep > 0) {
                          _previousStep();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service Provider Registration",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Offer your professional services on Event Heaven",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Progress Bar
                Row(
                  children: [
                    Expanded(child: _buildProgressBar(0)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildProgressBar(1)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildProgressBar(2)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Step ${_currentStep + 1} of 3",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _getStepTitle(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Dynamic Body Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildCurrentStepBody(),
            ),
          ),

          // Bottom Action Navigation Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
              child: Row(
                children: [
                  if (_currentStep > 0) ...[
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: _previousStep,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF8B5CF6)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            "Back",
                            style: TextStyle(
                              color: Color(0xFF8B5CF6),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        ),
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
                        onPressed: _currentStep == 2
                            ? _submitRegistration
                            : _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          _currentStep == 2
                              ? "Submit Registration"
                              : "Continue",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return "Personal & Vendor Info";
      case 1:
        return "Service Details & Pricing";
      case 2:
        return "Portfolio & Admin Review";
      default:
        return "";
    }
  }

  Widget _buildProgressBar(int stepIndex) {
    bool isCompletedOrCurrent = _currentStep >= stepIndex;
    return Container(
      height: 5,
      decoration: BoxDecoration(
        color: isCompletedOrCurrent
            ? Colors.white
            : Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildCurrentStepBody() {
    switch (_currentStep) {
      case 0:
        return _buildStep1VendorInfoForm();
      case 1:
        return _buildStep2ServiceDetailsForm();
      case 2:
        return _buildStep3PortfolioAndReview();
      default:
        return const SizedBox();
    }
  }

  // --- STEP 1: PERSONAL & VENDOR INFO ---
  Widget _buildStep1VendorInfoForm() {
    return Column(
      children: [
        _buildFormCard(
          title: "Personal & Business Details",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _vendorNameController,
                label: "Vendor Full Name",
                hint: "Enter your full name",
                prefixIcon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 14),
              const Text(
                "Primary Service Category Offered",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                decoration: _inputDecoration(
                  prefixIcon: Icons.category_outlined,
                ),
                items: _categoryOptions
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _emailController,
                label: "Email Address",
                hint: "vendor.email@example.com",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _phoneController,
                label: "Contact Phone Number",
                hint: "+92 300 1234567",
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _cnicController,
                label: "Vendor CNIC Number",
                hint: "34101-0000000-0",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.credit_card_outlined,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _businessRegController,
                label: "Business License / NTN Number (Optional)",
                hint: "Enter NTN or registration number if any",
                prefixIcon: Icons.description_outlined,
              ),
              const SizedBox(height: 6),
              Text(
                "Optional. Fill if you operate a formally registered business.",
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- STEP 2: SERVICE DETAILS & PRICING ---
  Widget _buildStep2ServiceDetailsForm() {
    return Column(
      children: [
        _buildFormCard(
          title: "Service Business Profile",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _serviceNameController,
                label: "Service Business Name",
                hint: "e.g., Royal Car Rentals / SoundMasters DJ",
                prefixIcon: Icons.work_outline_rounded,
              ),
              const SizedBox(height: 14),
              const Text(
                "Operating City",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                decoration: _inputDecoration(
                  prefixIcon: Icons.location_city_outlined,
                ),
                items: _cityOptions
                    .map(
                      (city) =>
                          DropdownMenuItem(value: city, child: Text(city)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedCity = val!),
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _addressController,
                label: "Office / Workshop Address",
                hint: "Street address, shop number, area",
                maxLines: 2,
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 12),

              // GPS Location Pin
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isMapLocationPicked = !_isMapLocationPicked;
                    _mapCoordinatesText = _isMapLocationPicked
                        ? "Lat: 32.1877, Long: 74.1945 (Picked)"
                        : "No GPS pin selected";
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: _isMapLocationPicked
                        ? const Color(0xFFDCFCE7)
                        : const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _isMapLocationPicked
                          ? const Color(0xFF16A34A)
                          : const Color(0xFF8B5CF6),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isMapLocationPicked
                            ? Icons.check_circle_rounded
                            : Icons.map_rounded,
                        color: _isMapLocationPicked
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF8B5CF6),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isMapLocationPicked
                                  ? "GPS Office Location Saved"
                                  : "Pin Office Location on Google Maps",
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: _isMapLocationPicked
                                    ? const Color(0xFF16A34A)
                                    : const Color(0xFF8B5CF6),
                              ),
                            ),
                            Text(
                              _mapCoordinatesText,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                "Years of Field Experience",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedExperience,
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                decoration: _inputDecoration(
                  prefixIcon: Icons.workspace_premium_outlined,
                ),
                items: _experienceOptions
                    .map(
                      (exp) => DropdownMenuItem(value: exp, child: Text(exp)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedExperience = val!),
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _basePriceController,
                label: "Starting Price Range / Per Event Rate (Rs.)",
                hint: "e.g., 20000 - 50000",
                keyboardType: TextInputType.text,
                prefixIcon: Icons.payments_outlined,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _descriptionController,
                label: "Service Description & Specialties",
                hint:
                    "Describe your service packages, equipment quality, and work experience...",
                maxLines: 3,
                prefixIcon: Icons.info_outline_rounded,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Service Features & Capabilities
        _buildFormCard(
          title: "Service Features & Working Terms",
          child: Column(
            children: _serviceCapabilities.keys.map((key) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFF8B5CF6),
                title: Text(
                  key,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: _serviceCapabilities[key],
                onChanged: (val) {
                  setState(() => _serviceCapabilities[key] = val!);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // --- STEP 3: PORTFOLIO, DOCUMENTS & REVIEW ---
  Widget _buildStep3PortfolioAndReview() {
    return Column(
      children: [
        // Verification Documents Sub-Section
        _buildFormCard(
          title: "1. Legal Documents Verification (Admin Review)",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildUploadTile(
                      label: "CNIC Front",
                      isUploaded: _cnicFrontUploaded,
                      onTap: () => setState(
                        () => _cnicFrontUploaded = !_cnicFrontUploaded,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildUploadTile(
                      label: "CNIC Back",
                      isUploaded: _cnicBackUploaded,
                      onTap: () => setState(
                        () => _cnicBackUploaded = !_cnicBackUploaded,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildUploadTile(
                label: "Work Proof / Visiting Card / Business License",
                isUploaded: _workProofUploaded,
                onTap: () =>
                    setState(() => _workProofUploaded = !_workProofUploaded),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Portfolio Visuals Sub-Section
        _buildFormCard(
          title: "2. Work Portfolio & Service Visuals",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Main Cover Banner (Displayed on Service Listing Cards)",
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildUploadTile(
                label: "Upload Main Service Cover Banner",
                isUploaded: _coverBannerUploaded,
                onTap: () => setState(
                  () => _coverBannerUploaded = !_coverBannerUploaded,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                "Work Portfolio Gallery (Past Events, Setup Photos)",
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _portfolioCount = _portfolioCount == 0 ? 6 : 0;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: _portfolioCount > 0
                        ? const Color(0xFFDCFCE7)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _portfolioCount > 0
                          ? const Color(0xFF16A34A)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _portfolioCount > 0
                            ? Icons.collections_rounded
                            : Icons.add_a_photo_outlined,
                        color: _portfolioCount > 0
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF8B5CF6),
                        size: 32,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _portfolioCount > 0
                            ? "$_portfolioCount Portfolio Work Samples Selected"
                            : "Tap to pick portfolio samples",
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: _portfolioCount > 0
                              ? const Color(0xFF16A34A)
                              : Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        "Upload high-quality work samples to attract clients",
                        style: TextStyle(
                          fontSize: 11,
                          color: _portfolioCount > 0
                              ? const Color(0xFF16A34A)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Summary Card
        _buildFormCard(
          title: "Registration Summary",
          child: Column(
            children: [
              _buildSummaryRow(
                "Vendor Name",
                _vendorNameController.text.trim().isEmpty
                    ? "Not Specified"
                    : _vendorNameController.text.trim(),
              ),
              const SizedBox(height: 6),
              _buildSummaryRow("Service Category", _selectedCategory),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "Vendor CNIC",
                _cnicController.text.trim().isEmpty
                    ? "Not Specified"
                    : _cnicController.text.trim(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1),
              ),
              _buildSummaryRow(
                "Service Business Name",
                _serviceNameController.text.trim().isEmpty
                    ? "Not Specified"
                    : _serviceNameController.text.trim(),
              ),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "City & Experience",
                "$_selectedCity ($_selectedExperience)",
              ),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "Price Range Rate",
                _basePriceController.text.trim().isEmpty
                    ? "Not Specified"
                    : "Rs. ${_basePriceController.text.trim()}",
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1),
              ),
              _buildSummaryRow(
                "CNIC & Legal Documents",
                (_cnicFrontUploaded && _cnicBackUploaded && _workProofUploaded)
                    ? "Uploaded ✓"
                    : "Pending Upload",
              ),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "Cover & Portfolio Samples",
                _coverBannerUploaded ? "Uploaded ✓" : "Pending Upload",
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // System Admin Verification Disclaimer Notice
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF97316).withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Color(0xFFF97316),
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "System Admin Verification Notice: Your service provider details and CNIC credentials will be reviewed by System Admin. Services will be activated upon approval.",
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.brown.shade800,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildUploadTile({
    required String label,
    required bool isUploaded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isUploaded ? const Color(0xFFDCFCE7) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isUploaded ? const Color(0xFF16A34A) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUploaded
                  ? Icons.check_circle_rounded
                  : Icons.cloud_upload_outlined,
              color: isUploaded
                  ? const Color(0xFF16A34A)
                  : const Color(0xFF8B5CF6),
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isUploaded
                      ? const Color(0xFF16A34A)
                      : Colors.grey.shade700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              isUploaded ? "Uploaded" : "Upload",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isUploaded
                    ? const Color(0xFF16A34A)
                    : const Color(0xFF8B5CF6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 13),
          decoration: _inputDecoration(hint: hint, prefixIcon: prefixIcon),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint, IconData? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12.5),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, size: 18, color: Colors.grey)
          : null,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 1.5),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
