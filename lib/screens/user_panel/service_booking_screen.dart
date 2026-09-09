import 'package:flutter/material.dart';
import 'payment_screen.dart';

class UserServiceBookingFormScreen extends StatefulWidget {
  final Map<String, dynamic> serviceData;

  const UserServiceBookingFormScreen({super.key, required this.serviceData});

  @override
  State<UserServiceBookingFormScreen> createState() =>
      _UserServiceBookingFormScreenState();
}

class _UserServiceBookingFormScreenState
    extends State<UserServiceBookingFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // 1. Common Personal Details (Empty Defaults)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _specialNotesController = TextEditingController();

  // 2. Dates & Timing
  DateTime _startDate = DateTime.now().add(const Duration(days: 1));

  // Service Category Detection
  late String _category;

  // --- CAR RENTAL FIELDS ---
  final TextEditingController _userCnicController = TextEditingController();
  final TextEditingController _witnessCnicController = TextEditingController();
  final TextEditingController _pickupLocationController =
      TextEditingController();
  final TextEditingController _destinationLocationController =
      TextEditingController();

  bool _userCnicFrontUploaded = false;
  bool _userCnicBackUploaded = false;
  bool _witnessCnicFrontUploaded = false;
  bool _witnessCnicBackUploaded = false;

  String _selectedCarModel = 'Honda Civic RS — Rs. 15,000/day';
  final Map<String, int> _carPrices = {
    'Honda Civic RS — Rs. 15,000/day': 15000,
    'Toyota Fortuner Sigma — Rs. 28,000/day': 28000,
    'Audi A6 Luxury Sedan — Rs. 45,000/day': 45000,
    'Hyundai Sonata VIP — Rs. 22,000/day': 22000,
  };
  int _carRentalDays = 1;
  String _selectedCarShift = 'Day Shift (12 PM - 4 PM)';
  bool _withDriver = true;
  bool _includeCarDecoration = false;
  final int _carDecorationFee = 7000;
  final int _nightShiftExtraFee = 2000;

  // --- LIGHTING FIELDS ---
  String _selectedLightingPackage = 'Fairy Light Canopy Setup — Rs. 25,000';
  final Map<String, int> _lightingPrices = {
    'Fairy Light Canopy Setup — Rs. 25,000': 25000,
    'Stage Spotlights & RGB Lasers — Rs. 45,000': 45000,
    'Full Building Architectural Illumination — Rs. 75,000': 75000,
  };
  String _lightingVenueType = 'Outdoor Lawn / Rooftop';
  String _lightingThemeColor = 'Warm White';
  bool _includeGeneratorBackup = false;
  final int _generatorFee = 8000;

  // --- CATERING FIELDS ---
  int _guestCount = 150;
  late TextEditingController _guestController;
  String _selectedCateringPackage =
      'Package B (Executive Menu) — Rs. 1,250/head';
  final Map<String, int> _cateringPerHeadPrices = {
    'Package A (Traditional Biryani & Kheer) — Rs. 850/head': 850,
    'Package B (Executive Menu) — Rs. 1,250/head': 1250,
    'Package C (Royal Buffet & BBQ) — Rs. 1,750/head': 1750,
  };
  String _cateringServiceStyle = 'Self-Service Buffet';
  bool _useVipCrockery = false;
  final int _vipCrockeryPerHeadFee = 50;

  // --- DJ & SOUND SYSTEM FIELDS ---
  String _selectedDjPackage = 'Concert Heavy Bass Console — Rs. 35,000';
  final Map<String, int> _djPrices = {
    'Party Dual Speakers & Mic — Rs. 20,000': 20000,
    'Concert Heavy Bass Console — Rs. 35,000': 35000,
    'VIP Live Sound + Fog Machine + Stage Lights — Rs. 55,000': 55000,
  };
  String _musicGenre = 'Bhangra / Wedding Hits';
  int _djHours = 4;

  // --- PHOTOGRAPHY & VIDEOGRAPHY FIELDS ---
  String _selectedPhotoPackage = 'Cinematic Movie + HD Album — Rs. 60,000';
  final Map<String, int> _photoPrices = {
    'Basic Still Photography Shoot — Rs. 30,000': 30000,
    'Cinematic Movie + HD Album — Rs. 60,000': 60000,
    'VIP 4K Drone + Cinematic + 2 Albums — Rs. 100,000': 100000,
  };
  bool _includeDroneShoot = false;
  final int _droneShootFee = 15000;
  String _albumType = '1 HD Printed Leather Album';

  // Constants
  final int _serviceFee = 2000;

  @override
  void initState() {
    super.initState();
    _guestController = TextEditingController(text: _guestCount.toString());
    _category =
        (widget.serviceData['category'] ??
                widget.serviceData['tag'] ??
                'Car Rental')
            .toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _specialNotesController.dispose();
    _userCnicController.dispose();
    _witnessCnicController.dispose();
    _pickupLocationController.dispose();
    _destinationLocationController.dispose();
    _guestController.dispose();
    super.dispose();
  }

  DateTime get _endDate => _startDate.add(Duration(days: _carRentalDays - 1));

  String get _computedCarPickupTime {
    if (_carRentalDays == 1) {
      return _selectedCarShift.contains('Night') ? '06:00 PM' : '12:00 PM';
    }
    return '12:00 PM (Start Date)';
  }

  String get _computedCarReturnTime {
    if (_carRentalDays == 1) {
      return _selectedCarShift.contains('Night') ? '12:00 AM' : '04:00 PM';
    }
    return '12:00 PM (End Date)';
  }

  int get _calculatedServiceTotal {
    if (_category.contains('Car')) {
      int dailyRate = _carPrices[_selectedCarModel] ?? 15000;
      int total = dailyRate * _carRentalDays;
      if (_carRentalDays == 1 && _selectedCarShift.contains('Night')) {
        total += _nightShiftExtraFee;
      }
      if (_includeCarDecoration) total += _carDecorationFee;
      return total;
    } else if (_category.contains('Lighting')) {
      int base = _lightingPrices[_selectedLightingPackage] ?? 25000;
      if (_includeGeneratorBackup) base += _generatorFee;
      return base;
    } else if (_category.contains('Catering')) {
      int perHead = _cateringPerHeadPrices[_selectedCateringPackage] ?? 1250;
      if (_useVipCrockery) perHead += _vipCrockeryPerHeadFee;
      return perHead * _guestCount;
    } else if (_category.contains('DJ') || _category.contains('Sound')) {
      int base = _djPrices[_selectedDjPackage] ?? 35000;
      if (_djHours > 4) base += (_djHours - 4) * 3000;
      return base;
    } else if (_category.contains('Photo') || _category.contains('Video')) {
      int base = _photoPrices[_selectedPhotoPackage] ?? 60000;
      if (_includeDroneShoot && !_selectedPhotoPackage.contains('VIP')) {
        base += _droneShootFee;
      }
      return base;
    }
    return 25000;
  }

  int get _grandTotalAmount => _calculatedServiceTotal + _serviceFee;
  int get _requiredAdvancePayment => (_grandTotalAmount * 0.25).round();

  void _proceedToPayment() {
    final bookingDetails = {
      'venueTitle': widget.serviceData['title'] ?? 'Service Provider',
      'serviceCategory': _category,
      'fullName': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'eventAddress': _addressController.text.trim(),
      'eventDate': "${_startDate.day}/${_startDate.month}/${_startDate.year}",
      'specialRequests': _specialNotesController.text.trim(),
      'calculatedServiceCost': _calculatedServiceTotal,
      'serviceFee': _serviceFee,
      'totalAmount': _grandTotalAmount,
      'advanceRequired': _requiredAdvancePayment,
      'paymentAccounts': widget.serviceData['paymentAccounts'],
    };

    if (_category.contains('Car')) {
      bookingDetails['carModel'] = _selectedCarModel;
      bookingDetails['rentalDays'] = _carRentalDays;
      bookingDetails['withDriver'] = _withDriver;
      bookingDetails['pickupLocation'] = !_withDriver
          ? 'Royal Car Rentals Head Office, GT Road, Gujranwala'
          : _pickupLocationController.text.trim();
      bookingDetails['destinationLocation'] = _destinationLocationController
          .text
          .trim();
    } else if (_category.contains('Lighting')) {
      bookingDetails['lightingPackage'] = _selectedLightingPackage;
      bookingDetails['venueType'] = _lightingVenueType;
      bookingDetails['themeColor'] = _lightingThemeColor;
      bookingDetails['generatorIncluded'] = _includeGeneratorBackup;
    } else if (_category.contains('Catering')) {
      bookingDetails['guestCount'] = _guestCount;
      bookingDetails['cateringPackage'] = _selectedCateringPackage;
      bookingDetails['serviceStyle'] = _cateringServiceStyle;
      bookingDetails['vipCrockery'] = _useVipCrockery;
    } else if (_category.contains('DJ') || _category.contains('Sound')) {
      bookingDetails['djPackage'] = _selectedDjPackage;
      bookingDetails['musicGenre'] = _musicGenre;
      bookingDetails['djHours'] = _djHours;
    } else if (_category.contains('Photo') || _category.contains('Video')) {
      bookingDetails['photoPackage'] = _selectedPhotoPackage;
      bookingDetails['droneIncluded'] = _includeDroneShoot;
      bookingDetails['albumType'] = _albumType;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UserPaymentReceiptScreen(bookingDetails: bookingDetails),
      ),
    );
  }

  Future<void> _pickStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF8B5CF6)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    String titleText = widget.serviceData['title'] ?? 'Service Booking';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Gradient Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 50),
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
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Text(
                              "Service Booking",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Category: $_category",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                titleText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form Content Body
                  Transform.translate(
                    offset: const Offset(0, -24),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // Section 1: Personal Info
                          _buildFormCard(
                            title: "1. Personal Contact Info",
                            child: Column(
                              children: [
                                _buildTextField(
                                  controller: _nameController,
                                  label: "Full Name",
                                  hint: "Enter your name",
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  controller: _phoneController,
                                  label: "Phone Number",
                                  hint: "0300 0000000",
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 12),
                                _buildTextField(
                                  controller: _addressController,
                                  label: "Event Address / Venue Location",
                                  hint: "Street Address, Area, City",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Car CNICs Section
                          if (_category.contains('Car')) ...[
                            _buildFormCard(
                              title: "2. Verification Documents",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTextField(
                                    controller: _userCnicController,
                                    label: "Customer CNIC Number",
                                    hint: "34101-0000000-0",
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildImageUploadTile(
                                          label: "User CNIC Front",
                                          isUploaded: _userCnicFrontUploaded,
                                          onTap: () => setState(
                                            () => _userCnicFrontUploaded =
                                                !_userCnicFrontUploaded,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: _buildImageUploadTile(
                                          label: "User CNIC Back",
                                          isUploaded: _userCnicBackUploaded,
                                          onTap: () => setState(
                                            () => _userCnicBackUploaded =
                                                !_userCnicBackUploaded,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Divider(height: 1),
                                  ),
                                  _buildTextField(
                                    controller: _witnessCnicController,
                                    label: "Witness CNIC Number",
                                    hint: "34101-0000000-0",
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildImageUploadTile(
                                          label: "Witness Front",
                                          isUploaded: _witnessCnicFrontUploaded,
                                          onTap: () => setState(
                                            () => _witnessCnicFrontUploaded =
                                                !_witnessCnicFrontUploaded,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: _buildImageUploadTile(
                                          label: "Witness Back",
                                          isUploaded: _witnessCnicBackUploaded,
                                          onTap: () => setState(
                                            () => _witnessCnicBackUploaded =
                                                !_witnessCnicBackUploaded,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Section 2: Dynamic Category Customization
                          _buildFormCard(
                            title: "2. Service Customization Details",
                            child: _buildDynamicCategoryFields(),
                          ),
                          const SizedBox(height: 16),

                          // Section 3: Special Instructions
                          _buildFormCard(
                            title: "3. Special Instructions",
                            child: _buildTextField(
                              controller: _specialNotesController,
                              label: "Additional Customization Notes",
                              hint:
                                  "Theme preferences, special diet requests, route instructions, etc.",
                              maxLines: 3,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Terms Note for Car Rentals
                          if (_category.contains('Car')) ...[
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF7ED),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(
                                    0xFFF97316,
                                  ).withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Color(0xFFF97316),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _withDriver
                                          ? "IMPORTANT NOTE: In case of damage caused due to driver error, the rental company/driver will bear expenses. If damage occurs due to customer interference, the customer will be responsible."
                                          : "IMPORTANT NOTE: For self-drive (without driver) rentals, the customer will be 100% liable for all damages incurred during the rental duration.",
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
                            const SizedBox(height: 16),
                          ],

                          // Section 4: Billing Summary
                          _buildFormCard(
                            title: "Price Breakdown Summary",
                            child: Column(
                              children: [
                                _buildSummaryRow(
                                  "Selected Service Charges",
                                  "Rs. ${_calculatedServiceTotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                ),
                                const SizedBox(height: 8),
                                _buildSummaryRow(
                                  "Platform Service Fee",
                                  "Rs. ${_serviceFee.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(height: 1),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Amount",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      "Rs. ${_grandTotalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF8B5CF6),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Advance Deposit Required (25%)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "Rs. ${_requiredAdvancePayment.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFEC4899),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky Bottom Button Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                    ),
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _proceedToPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: const Text(
                      "Proceed to Payment",
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

  // --- Dynamic Form Renderer per Category ---
  Widget _buildDynamicCategoryFields() {
    // 1. CAR RENTAL
    if (_category.contains('Car')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Car Model & Daily Rent",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedCarModel,
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            decoration: _inputDecoration(),
            items: _carPrices.keys.map((car) {
              return DropdownMenuItem(value: car, child: Text(car));
            }).toList(),
            onChanged: (val) => setState(() => _selectedCarModel = val!),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Rental Duration (Days):",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Color(0xFF8B5CF6),
                    ),
                    onPressed: () {
                      if (_carRentalDays > 1) setState(() => _carRentalDays--);
                    },
                  ),
                  Text(
                    "$_carRentalDays Day(s)",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xFF8B5CF6),
                    ),
                    onPressed: () => setState(() => _carRentalDays++),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_carRentalDays == 1) ...[
            const Text(
              "Select Shift",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            RadioListTile<String>(
              title: const Text(
                "Day Shift (12:00 PM – 04:00 PM)",
                style: TextStyle(fontSize: 12.5),
              ),
              value: 'Day Shift (12 PM - 4 PM)',
              groupValue: _selectedCarShift,
              activeColor: const Color(0xFF8B5CF6),
              contentPadding: EdgeInsets.zero,
              onChanged: (val) => setState(() => _selectedCarShift = val!),
            ),
            RadioListTile<String>(
              title: const Text(
                "Night Shift (06:00 PM – 12:00 AM)",
                style: TextStyle(fontSize: 12.5),
              ),
              subtitle: const Text("+Rs. 2,000 Shift Surcharge"),
              value: 'Night Shift (6 PM - 12 AM)',
              groupValue: _selectedCarShift,
              activeColor: const Color(0xFF8B5CF6),
              contentPadding: EdgeInsets.zero,
              onChanged: (val) => setState(() => _selectedCarShift = val!),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _carRentalDays == 1 ? "Rent Date" : "Start Date",
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: _pickStartDate,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 18,
                              color: Color(0xFF8B5CF6),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${_startDate.day}/${_startDate.month}/${_startDate.year}",
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_carRentalDays > 1) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "End Date (Auto)",
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          "${_endDate.day}/${_endDate.month}/${_endDate.year}",
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            "Chauffeur Preference",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text("With Driver")),
                  selected: _withDriver,
                  selectedColor: const Color(0xFF8B5CF6).withOpacity(0.2),
                  onSelected: (val) => setState(() => _withDriver = true),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text("Without Driver")),
                  selected: !_withDriver,
                  selectedColor: const Color(0xFF8B5CF6).withOpacity(0.2),
                  onSelected: (val) => setState(() => _withDriver = false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (_withDriver) ...[
            _buildTextField(
              controller: _pickupLocationController,
              label: "Pickup Location",
              hint: "e.g. Model Town, Gujranwala",
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _destinationLocationController,
              label: "Destination Location",
              hint: "e.g. PC Hotel, Lahore",
            ),
          ] else ...[
            const Text(
              "Pickup Location (Car Rental Office)",
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                "Royal Car Rentals Head Office, GT Road, Gujranwala",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _destinationLocationController,
              label: "Destination Location",
              hint: "Where will you be driving?",
            ),
          ],
          const SizedBox(height: 10),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF8B5CF6),
            title: const Text(
              "Fresh Rose Car Decoration (+Rs. 7,000)",
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
            ),
            value: _includeCarDecoration,
            onChanged: (val) => setState(() => _includeCarDecoration = val!),
          ),
        ],
      );
    }
    // 2. LIGHTING SERVICES
    else if (_category.contains('Lighting')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Lighting Setup Package",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedLightingPackage,
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            decoration: _inputDecoration(),
            items: _lightingPrices.keys
                .map((pkg) => DropdownMenuItem(value: pkg, child: Text(pkg)))
                .toList(),
            onChanged: (val) => setState(() => _selectedLightingPackage = val!),
          ),
          const SizedBox(height: 14),
          const Text(
            "Venue / Area Type",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _lightingVenueType,
            dropdownColor: Colors.white,
            decoration: _inputDecoration(),
            items: [
              'Outdoor Lawn / Rooftop',
              'Indoor Hall / Marquee',
              'Building Exterior',
              'Residential Home / Street',
            ].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (val) => setState(() => _lightingVenueType = val!),
          ),
          const SizedBox(height: 14),
          const Text(
            "Illumination Theme Color",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _lightingThemeColor,
            dropdownColor: Colors.white,
            decoration: _inputDecoration(),
            items: [
              'Warm White',
              'Royal Golden',
              'Cool White',
              'Multi-Color RGB',
            ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (val) => setState(() => _lightingThemeColor = val!),
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF8B5CF6),
            title: const Text(
              "Include Heavy Duty Generator Backup",
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              "Add 50 KVA Soundproof Generator (+Rs. 8,000)",
            ),
            value: _includeGeneratorBackup,
            onChanged: (val) => setState(() => _includeGeneratorBackup = val!),
          ),
        ],
      );
    }
    // 3. CATERING SERVICES
    else if (_category.contains('Catering')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Expected Guests Count",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Color(0xFF8B5CF6),
                ),
                onPressed: () {
                  if (_guestCount > 30) {
                    setState(() {
                      _guestCount -= 10;
                      _guestController.text = _guestCount.toString();
                    });
                  }
                },
              ),
              Expanded(
                child: TextFormField(
                  controller: _guestController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: _inputDecoration(),
                  onChanged: (val) {
                    int? parsed = int.tryParse(val.trim());
                    if (parsed != null && parsed > 0)
                      setState(() => _guestCount = parsed);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF8B5CF6),
                ),
                onPressed: () {
                  setState(() {
                    _guestCount += 10;
                    _guestController.text = _guestCount.toString();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            "Select Menu Package",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedCateringPackage,
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
            decoration: _inputDecoration(),
            items: _cateringPerHeadPrices.keys
                .map((pkg) => DropdownMenuItem(value: pkg, child: Text(pkg)))
                .toList(),
            onChanged: (val) => setState(() => _selectedCateringPackage = val!),
          ),
          const SizedBox(height: 14),
          const Text(
            "Serving Style",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _cateringServiceStyle,
            dropdownColor: Colors.white,
            decoration: _inputDecoration(),
            items: [
              'Self-Service Buffet',
              'VIP Table Service',
              'Live Cooking & BBQ Counters',
            ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (val) => setState(() => _cateringServiceStyle = val!),
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF8B5CF6),
            title: const Text(
              "Use VIP Bone China Crockery Set",
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("Premium dinnerware (+Rs. 50 / head)"),
            value: _useVipCrockery,
            onChanged: (val) => setState(() => _useVipCrockery = val!),
          ),
        ],
      );
    }
    // 4. DJ & SOUND SYSTEM
    else if (_category.contains('DJ') || _category.contains('Sound')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sound System Package Tier",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedDjPackage,
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
            decoration: _inputDecoration(),
            items: _djPrices.keys
                .map((pkg) => DropdownMenuItem(value: pkg, child: Text(pkg)))
                .toList(),
            onChanged: (val) => setState(() => _selectedDjPackage = val!),
          ),
          const SizedBox(height: 14),
          const Text(
            "Music Genre Preference",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _musicGenre,
            dropdownColor: Colors.white,
            decoration: _inputDecoration(),
            items: [
              'Bhangra / Wedding Hits',
              'Commercial Pop / EDM',
              'Sufi & Qawwali Acoustic',
              'Cultural / Regional Hits',
            ].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
            onChanged: (val) => setState(() => _musicGenre = val!),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Performance Coverage (Hours):",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Color(0xFF8B5CF6),
                    ),
                    onPressed: () {
                      if (_djHours > 2) setState(() => _djHours--);
                    },
                  ),
                  Text(
                    "$_djHours Hours",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xFF8B5CF6),
                    ),
                    onPressed: () => setState(() => _djHours++),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
    // 5. PHOTOGRAPHY & VIDEOGRAPHY
    else if (_category.contains('Photo') || _category.contains('Video')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Coverage Package Tier",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedPhotoPackage,
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
            decoration: _inputDecoration(),
            items: _photoPrices.keys
                .map((pkg) => DropdownMenuItem(value: pkg, child: Text(pkg)))
                .toList(),
            onChanged: (val) => setState(() => _selectedPhotoPackage = val!),
          ),
          const SizedBox(height: 14),
          const Text(
            "Physical Deliverables Choice",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _albumType,
            dropdownColor: Colors.white,
            decoration: _inputDecoration(),
            items: [
              'Digital Copy Only (USB Drive)',
              '1 HD Printed Leather Album',
              '2 HD Printed Premium Albums (+Rs. 10,000)',
            ].map((a) => DropdownMenuItem(value: a, child: Text(a))).toList(),
            onChanged: (val) => setState(() => _albumType = val!),
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF8B5CF6),
            title: const Text(
              "Include 4K Aerial Drone Coverage",
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("DJI Drone operator (+Rs. 15,000)"),
            value: _includeDroneShoot,
            onChanged: (val) => setState(() => _includeDroneShoot = val!),
          ),
        ],
      );
    }

    return const Text("Standard service booking terms apply.");
  }

  Widget _buildImageUploadTile({
    required String label,
    required bool isUploaded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isUploaded ? const Color(0xFFDCFCE7) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isUploaded ? const Color(0xFF16A34A) : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(
              isUploaded
                  ? Icons.check_circle_rounded
                  : Icons.cloud_upload_outlined,
              color: isUploaded
                  ? const Color(0xFF16A34A)
                  : const Color(0xFF8B5CF6),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isUploaded
                    ? const Color(0xFF16A34A)
                    : Colors.grey.shade700,
              ),
            ),
            Text(
              isUploaded ? "Uploaded" : "Tap to Upload",
              style: TextStyle(
                fontSize: 10,
                color: isUploaded ? const Color(0xFF16A34A) : Colors.grey,
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
          decoration: _inputDecoration(hint: hint),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12.5),
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
        Text(label, style: const TextStyle(fontSize: 12.5, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
