import 'package:flutter/material.dart';
import 'venue_owner_dashboard.dart'; // Navigates to Venue Owner Dashboard

class VenueOwnerRegistrationScreen extends StatefulWidget {
  const VenueOwnerRegistrationScreen({super.key});

  @override
  State<VenueOwnerRegistrationScreen> createState() =>
      _VenueOwnerRegistrationScreenState();
}

class _VenueOwnerRegistrationScreenState
    extends State<VenueOwnerRegistrationScreen> {
  int _currentStep = 0;

  // --- Step 1 Controllers & State ---
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _businessRegController = TextEditingController();

  String _selectedRole = 'Owner';
  final List<String> _roleOptions = [
    'Owner',
    'General Manager',
    'Booking Manager',
  ];

  // --- Step 2 Controllers & State ---
  final TextEditingController _venueNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _minCapacityController = TextEditingController();
  final TextEditingController _maxCapacityController = TextEditingController();
  final TextEditingController _baseRentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Marquee';
  final List<String> _categoryOptions = [
    'Marquee',
    'Banquet Hall',
    'Event Complex',
    'Farmhouse / Lawn',
  ];

  String _selectedCity = 'Gujranwala';
  final List<String> _cityOptions = [
    'Gujranwala',
    'Lahore',
    'Sialkot',
    'Islamabad',
    'Faisalabad',
    'Rawalpindi',
  ];

  bool _isMapLocationPicked = false;
  String _mapCoordinatesText = "No GPS pin selected";

  final Map<String, bool> _amenities = {
    'Air Conditioning (AC)': true,
    'Heavy Soundproof Generator Backup': true,
    'Bridal Suite / VIP Room': true,
    'Valet Parking Available': false,
    'In-House Catering Service': false,
    'Stage Lighting & Sound Set': false,
  };

  // --- Step 3 Document & Photo States ---
  bool _cnicFrontUploaded = false;
  bool _cnicBackUploaded = false;
  bool _ownershipDocUploaded = false;
  bool _mainBannerUploaded = false;
  int _galleryPhotosCount = 0;

  @override
  void dispose() {
    _ownerNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cnicController.dispose();
    _businessRegController.dispose();
    _venueNameController.dispose();
    _addressController.dispose();
    _minCapacityController.dispose();
    _maxCapacityController.dispose();
    _baseRentController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
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
              "Your venue registration request and legal verification documents have been submitted to System Admin.\n\nYou will receive an approval notification once verified.",
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
                      builder: (context) => const VenueOwnerDashboardScreen(),
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
          // Top Sticky Gradient Header & Step Indicators
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
                          "Venue Owner Registration",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "List your venue on Event Heaven",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Step Progress Bars
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

          // Dynamic Step Form Body
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
        return "Personal & Owner Info";
      case 1:
        return "Venue Details & Amenities";
      case 2:
        return "Docs & Review";
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
        return _buildStep1PersonalForm();
      case 1:
        return _buildStep2VenueDetailsForm();
      case 2:
        return _buildStep3DocsAndReview();
      default:
        return const SizedBox();
    }
  }

  // --- STEP 1: PERSONAL & BUSINESS INFO ---
  Widget _buildStep1PersonalForm() {
    return Column(
      children: [
        _buildFormCard(
          title: "Personal & Business Information",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _ownerNameController,
                label: "Full Name",
                hint: "Enter your full name",
                prefixIcon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 14),
              const Text(
                "Your Role / Designation",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                decoration: _inputDecoration(prefixIcon: Icons.badge_outlined),
                items: _roleOptions
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedRole = val!),
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _emailController,
                label: "Email Address",
                hint: "your.email@example.com",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _phoneController,
                label: "Phone Number",
                hint: "+92 300 1234567",
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _cnicController,
                label: "Owner CNIC Number",
                hint: "34101-0000000-0",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.credit_card_outlined,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _businessRegController,
                label: "Business Registration Number (Optional)",
                hint: "Enter SECP / FBR registration number if any",
                prefixIcon: Icons.description_outlined,
              ),
              const SizedBox(height: 6),
              Text(
                "Optional field. Required only if your business is formally registered.",
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- STEP 2: VENUE DETAILS & AMENITIES ---
  Widget _buildStep2VenueDetailsForm() {
    return Column(
      children: [
        _buildFormCard(
          title: "Venue Profile & Classification",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _venueNameController,
                label: "Venue / Hall Name",
                hint: "e.g., Royal Palace Marquee",
                prefixIcon: Icons.storefront_outlined,
              ),
              const SizedBox(height: 14),
              const Text(
                "Venue Category",
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
              const Text(
                "City",
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
                label: "Complete Street Address",
                hint: "Street address, area, nearby landmark",
                maxLines: 2,
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 12),

              // GPS Location Picker Option
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
                                  ? "GPS Pin Location Saved"
                                  : "Pin Location on Google Maps",
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
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _minCapacityController,
                      label: "Min Capacity",
                      hint: "150",
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.groups_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: _maxCapacityController,
                      label: "Max Capacity",
                      hint: "1000",
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.groups_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _baseRentController,
                label: "Starting Base Rent / Per Event (Rs.)",
                hint: "150000",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.payments_outlined,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: _descriptionController,
                label: "About Venue / Features Description",
                hint: "Describe interior theme, lighting, parking space...",
                maxLines: 3,
                prefixIcon: Icons.info_outline_rounded,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Amenities Section
        _buildFormCard(
          title: "Facilities & Amenities Included",
          child: Column(
            children: _amenities.keys.map((key) {
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
                value: _amenities[key],
                onChanged: (val) {
                  setState(() => _amenities[key] = val!);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // --- STEP 3: DOCUMENTS, PHOTOS & REVIEW ---
  Widget _buildStep3DocsAndReview() {
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
                label: "Venue Registry / Ownership Document",
                isUploaded: _ownershipDocUploaded,
                onTap: () => setState(
                  () => _ownershipDocUploaded = !_ownershipDocUploaded,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Visual Gallery Sub-Section
        _buildFormCard(
          title: "2. Venue Photos & Cover Banner",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Main Cover Photo (Displayed on App Cards)",
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildUploadTile(
                label: "Upload Main Hall Cover Banner",
                isUploaded: _mainBannerUploaded,
                onTap: () =>
                    setState(() => _mainBannerUploaded = !_mainBannerUploaded),
              ),
              const SizedBox(height: 14),
              const Text(
                "Gallery Photos (Stage, Entrance, Seating)",
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _galleryPhotosCount = _galleryPhotosCount == 0 ? 5 : 0;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: _galleryPhotosCount > 0
                        ? const Color(0xFFDCFCE7)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _galleryPhotosCount > 0
                          ? const Color(0xFF16A34A)
                          : Colors.grey.shade300,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _galleryPhotosCount > 0
                            ? Icons.photo_library_rounded
                            : Icons.add_a_photo_outlined,
                        color: _galleryPhotosCount > 0
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF8B5CF6),
                        size: 32,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _galleryPhotosCount > 0
                            ? "$_galleryPhotosCount Gallery Photos Selected"
                            : "Tap to pick gallery photos",
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: _galleryPhotosCount > 0
                              ? const Color(0xFF16A34A)
                              : Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        "Recommended: 5 to 10 photos",
                        style: TextStyle(
                          fontSize: 11,
                          color: _galleryPhotosCount > 0
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
                "Owner Name",
                _ownerNameController.text.trim().isEmpty
                    ? "Not Specified"
                    : _ownerNameController.text.trim(),
              ),
              const SizedBox(height: 6),
              _buildSummaryRow("Owner Role", _selectedRole),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "Owner CNIC",
                _cnicController.text.trim().isEmpty
                    ? "Not Specified"
                    : _cnicController.text.trim(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1),
              ),
              _buildSummaryRow(
                "Venue Name",
                _venueNameController.text.trim().isEmpty
                    ? "Not Specified"
                    : _venueNameController.text.trim(),
              ),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "Category & City",
                "$_selectedCategory ($_selectedCity)",
              ),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "Guest Capacity",
                "${_minCapacityController.text.trim().isEmpty ? '0' : _minCapacityController.text.trim()} - ${_maxCapacityController.text.trim().isEmpty ? '0' : _maxCapacityController.text.trim()} Guests",
              ),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "Starting Base Rent",
                "Rs. ${_baseRentController.text.trim().isEmpty ? '0' : _baseRentController.text.trim()}",
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1),
              ),
              _buildSummaryRow(
                "CNIC & Registry Docs",
                (_cnicFrontUploaded &&
                        _cnicBackUploaded &&
                        _ownershipDocUploaded)
                    ? "Uploaded ✓"
                    : "Pending Upload",
              ),
              const SizedBox(height: 6),
              _buildSummaryRow(
                "Main Cover Banner",
                _mainBannerUploaded ? "Uploaded ✓" : "Pending Upload",
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // System Admin Review Disclaimer Notice
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
                  "System Admin Review Notice: Your venue details and legal registry will be sent to the System Admin panel. Listing will be published once verified.",
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
