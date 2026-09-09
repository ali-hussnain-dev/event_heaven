import 'package:flutter/material.dart';
import 'payment_screen.dart';

class UserBookingFormScreen extends StatefulWidget {
  final Map<String, dynamic> venueData;

  const UserBookingFormScreen({super.key, required this.venueData});

  @override
  State<UserBookingFormScreen> createState() => _UserBookingFormScreenState();
}

class _UserBookingFormScreenState extends State<UserBookingFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Personal Information Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final TextEditingController _specialNotesController = TextEditingController();

  // Event Details
  String? _selectedEventType;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedShift = 'Night Shift (06:00 PM - 10:00 PM)';

  // Guest Count
  int _guestCount = 200;
  late TextEditingController _guestController;

  // Catering Setup
  String _cateringOption = 'Venue Per Head'; // 'Venue Per Head' OR 'Own Halwai'
  String _selectedPackageKey = 'Package A';
  final int _halwaiKitchenRent = 25000;
  final int _serviceFee = 2000;

  // Event Types
  final List<String> _eventTypes = [
    'Barat / Wedding',
    'Walima',
    'Mehndi',
    'Birthday Party',
    'Corporate Event',
    'Other Gathering',
  ];

  // Menu Packages
  final Map<String, Map<String, dynamic>> _menuPackages = {
    'Package A': {
      'title': 'Package A — Traditional Feast',
      'pricePerHead': 850,
      'items': [
        'Chicken Biryani / Pulao',
        'Chicken Qorma / Karahi',
        'Roti & Naan Set',
        'Salad & Raita',
        'Kheer or Zarda',
        'Cold Drinks',
      ],
    },
    'Package B': {
      'title': 'Package B — Executive Royal',
      'pricePerHead': 1250,
      'items': [
        'Mutton Qorma / Kabuli Pulao',
        'Chicken Boneless Handi',
        'Live Seekh Kabab Counter',
        'Roghni Naan',
        'Shahi Tukda & Gulab Jamun',
        'Cold Drinks & Kashmiri Tea',
      ],
    },
    'Package C': {
      'title': 'Package C — VIP Grand Feast',
      'pricePerHead': 1750,
      'items': [
        'Mutton Biryani',
        'Chicken Steam Roast',
        'Live BBQ Counter',
        'Assorted Naan Basket',
        'Ice Cream Bar & Halwa',
        'Fresh Juices & Green Tea',
      ],
    },
  };

  bool get _isOutdoorVenue {
    String tag = (widget.venueData['tag'] ?? '').toString().toUpperCase();
    String title = (widget.venueData['title'] ?? '').toString().toUpperCase();
    return tag.contains('OUTDOOR') ||
        title.contains('OUTDOOR') ||
        title.contains('RESORT');
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Risal Ahmad");
    _emailController = TextEditingController(text: "risal.ahmad@example.com");
    _phoneController = TextEditingController(text: "+92 300 1234567");
    _guestController = TextEditingController(text: _guestCount.toString());

    if (_isOutdoorVenue) {
      _selectedShift = 'Full Day Event (12:00 PM - 11:00 PM)';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _specialNotesController.dispose();
    _guestController.dispose();
    super.dispose();
  }

  int get _basePrice {
    String rawPrice =
        (widget.venueData['price'] ?? widget.venueData['priceText'] ?? '50000')
            .toString();
    String numericOnly = rawPrice.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numericOnly) ?? 50000;
  }

  int get _cateringCost {
    if (_cateringOption == 'Own Halwai') {
      return _halwaiKitchenRent;
    }
    int pricePerHead =
        _menuPackages[_selectedPackageKey]?['pricePerHead'] ?? 850;
    return pricePerHead * _guestCount;
  }

  int get _totalAmount => _basePrice + _cateringCost + _serviceFee;

  int get _advanceRequired => (_totalAmount * 0.25).round();

  void _updateGuestCount(int newCount) {
    if (newCount < 50) newCount = 50;
    if (newCount > 3000) newCount = 3000;
    setState(() {
      _guestCount = newCount;
      _guestController.text = newCount.toString();
      _guestController.selection = TextSelection.fromPosition(
        TextPosition(offset: _guestController.text.length),
      );
    });
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
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
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 0),
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
      setState(() => _selectedTime = picked);
    }
  }

  void _proceedToPayment() {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar("Please fill all required fields.", isError: true);
      return;
    }

    if (_selectedDate == null) {
      _showSnackBar(
        "Please select an Event Date before proceeding.",
        isError: true,
      );
      return;
    }

    final bookingDetails = {
      'venueTitle': widget.venueData['title'] ?? 'Royal Palace Hall',
      'fullName': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'eventType': _selectedEventType ?? 'Wedding',
      'eventDate':
          "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
      'eventTime': _selectedTime != null
          ? _selectedTime!.format(context)
          : _selectedShift,
      'guestCount': _guestCount,
      'cateringOption': _cateringOption,
      'menuPackage': _cateringOption == 'Venue Per Head'
          ? _selectedPackageKey
          : 'Own Halwai',
      'specialRequests': _specialNotesController.text.trim(),
      'basePrice': _basePrice,
      'cateringCost': _cateringCost,
      'serviceFee': _serviceFee,
      'totalAmount': _totalAmount,
      'advanceRequired': _advanceRequired,
      'paymentAccounts': widget.venueData['paymentAccounts'],
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UserPaymentReceiptScreen(bookingDetails: bookingDetails),
      ),
    );
  }

  void _showSnackBar(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError
            ? Colors.red.shade600
            : const Color(0xFF8B5CF6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Header Gradient Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 60),
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
                              "Booking Details",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Venue",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.venueData['title'] ??
                                    "Royal Palace Hall",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Rs. ${_basePrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                    offset: const Offset(0, -30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // 1. Personal Information Card
                          _buildFormCard(
                            title: "Personal Information",
                            child: Column(
                              children: [
                                _buildTextField(
                                  controller: _nameController,
                                  label: "Full Name *",
                                  hint: "Enter your full name",
                                  validator: (v) =>
                                      v == null || v.trim().isEmpty
                                      ? "Full Name is required"
                                      : null,
                                ),
                                const SizedBox(height: 14),
                                _buildTextField(
                                  controller: _emailController,
                                  label: "Email Address *",
                                  hint: "your.email@example.com",
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) =>
                                      v == null || v.trim().isEmpty
                                      ? "Email is required"
                                      : null,
                                ),
                                const SizedBox(height: 14),
                                _buildTextField(
                                  controller: _phoneController,
                                  label: "Phone Number *",
                                  hint: "+92 300 0000000",
                                  keyboardType: TextInputType.phone,
                                  validator: (v) =>
                                      v == null || v.trim().isEmpty
                                      ? "Phone number is required"
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 2. Event Details Card
                          _buildFormCard(
                            title: "Event Details",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Event Type *",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<String>(
                                  value: _selectedEventType,
                                  hint: const Text(
                                    "Select event type",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                  decoration: _inputDecoration(),
                                  items: _eventTypes.map((type) {
                                    return DropdownMenuItem(
                                      value: type,
                                      child: Text(
                                        type,
                                        style: const TextStyle(fontSize: 13.5),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) =>
                                      setState(() => _selectedEventType = val),
                                  validator: (v) =>
                                      v == null ? "Select event type" : null,
                                ),
                                const SizedBox(height: 14),

                                // Date & Time Selectors
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Event Date *",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF334155),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          GestureDetector(
                                            onTap: _pickDate,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 14,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF8FAFC),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 18,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      _selectedDate == null
                                                          ? "dd/mm/yyyy"
                                                          : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                                                      style: TextStyle(
                                                        fontSize: 12.5,
                                                        color:
                                                            _selectedDate ==
                                                                null
                                                            ? Colors.grey
                                                            : const Color(
                                                                0xFF1E293B,
                                                              ),
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Event Time *",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF334155),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          GestureDetector(
                                            onTap: _pickTime,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 14,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF8FAFC),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time_rounded,
                                                    size: 18,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      _selectedTime == null
                                                          ? "--:-- --"
                                                          : _selectedTime!
                                                                .format(
                                                                  context,
                                                                ),
                                                      style: TextStyle(
                                                        fontSize: 12.5,
                                                        color:
                                                            _selectedTime ==
                                                                null
                                                            ? Colors.grey
                                                            : const Color(
                                                                0xFF1E293B,
                                                              ),
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),

                                // Time Shift Selection
                                const Text(
                                  "Shift Selection",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (!_isOutdoorVenue) ...[
                                  _buildShiftTile(
                                    'Day Shift (12:00 PM - 04:00 PM)',
                                  ),
                                  _buildShiftTile(
                                    'Night Shift (06:00 PM - 10:00 PM)',
                                  ),
                                ] else ...[
                                  _buildShiftTile(
                                    'Full Day Event (12:00 PM - 11:00 PM)',
                                  ),
                                  _buildShiftTile(
                                    'Custom Flexible Shift (8 Hours)',
                                  ),
                                ],
                                const SizedBox(height: 14),

                                // Guest Count Input Field & Steppers
                                const Text(
                                  "Number of Guests *",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          _updateGuestCount(_guestCount - 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5F3FF),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          color: Color(0xFF8B5CF6),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _guestController,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.people_outline_rounded,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                          hintText: "Enter custom count",
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                vertical: 12,
                                              ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF8B5CF6),
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        onChanged: (val) {
                                          int? parsed = int.tryParse(
                                            val.trim(),
                                          );
                                          setState(() {
                                            if (parsed != null && parsed > 0) {
                                              _guestCount = parsed;
                                            }
                                          });
                                        },
                                        validator: (val) {
                                          if (val == null ||
                                              val.trim().isEmpty) {
                                            return "Enter guest count";
                                          }
                                          int? parsed = int.tryParse(
                                            val.trim(),
                                          );
                                          if (parsed == null || parsed < 50) {
                                            return "Min 50 guests";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () =>
                                          _updateGuestCount(_guestCount + 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5F3FF),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Color(0xFF8B5CF6),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),

                                // Special Requests Input
                                _buildTextField(
                                  controller: _specialNotesController,
                                  label: "Special Requests",
                                  hint:
                                      "Any special requirements or requests...",
                                  maxLines: 3,
                                  prefixIcon: Icons.description_outlined,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 3. Catering & Food Selection Card
                          _buildFormCard(
                            title: "Food & Catering",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadioListTile<String>(
                                  value: 'Venue Per Head',
                                  groupValue: _cateringOption,
                                  activeColor: const Color(0xFF8B5CF6),
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text(
                                    "Venue Catering (Per Head Menu)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "Select from ready-made packages.",
                                    style: TextStyle(fontSize: 11.5),
                                  ),
                                  onChanged: (val) =>
                                      setState(() => _cateringOption = val!),
                                ),
                                RadioListTile<String>(
                                  value: 'Own Halwai',
                                  groupValue: _cateringOption,
                                  activeColor: const Color(0xFF8B5CF6),
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text(
                                    "Own Halwai / External Cook",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Bring your own team. Kitchen usage fee: Rs. $_halwaiKitchenRent",
                                    style: const TextStyle(fontSize: 11.5),
                                  ),
                                  onChanged: (val) =>
                                      setState(() => _cateringOption = val!),
                                ),
                                if (_cateringOption == 'Venue Per Head') ...[
                                  const Divider(height: 20),
                                  const Text(
                                    "Select Package:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ..._menuPackages.keys.map((pkgKey) {
                                    final pkg = _menuPackages[pkgKey]!;
                                    bool isSelected =
                                        _selectedPackageKey == pkgKey;
                                    return GestureDetector(
                                      onTap: () => setState(
                                        () => _selectedPackageKey = pkgKey,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFFF5F3FF)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color: isSelected
                                                ? const Color(0xFF8B5CF6)
                                                : Colors.grey.shade300,
                                            width: isSelected ? 2 : 1,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    pkg['title'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.5,
                                                      color: isSelected
                                                          ? const Color(
                                                              0xFF8B5CF6,
                                                            )
                                                          : const Color(
                                                              0xFF1E293B,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Rs. ${pkg['pricePerHead']}/head",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFEC4899),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (isSelected) ...[
                                              const SizedBox(height: 6),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    (pkg['items']
                                                            as List<String>)
                                                        .map(
                                                          (item) => Text(
                                                            "• $item",
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 11,
                                                                  color: Color(
                                                                    0xFF475569,
                                                                  ),
                                                                ),
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 4. Price Summary Card
                          _buildFormCard(
                            title: "Price Summary",
                            child: Column(
                              children: [
                                _buildSummaryRow(
                                  "Base Price",
                                  "Rs${_basePrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                ),
                                const SizedBox(height: 8),
                                _buildSummaryRow(
                                  _cateringOption == 'Own Halwai'
                                      ? "Kitchen Rent (Halwai)"
                                      : "Catering Cost ($_guestCount Guests)",
                                  "Rs${_cateringCost.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                ),
                                const SizedBox(height: 8),
                                _buildSummaryRow(
                                  "Service Fee",
                                  "Rs${_serviceFee.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
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
                                      "Rs${_totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
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
                                      "Advance Required (25%)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "Rs${_advanceRequired.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
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

          // Sticky Bottom Action Bar
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

  Widget _buildFormCard({required String title, required Widget child}) {
    return Container(
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
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
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: _inputDecoration(hint: hint, prefixIcon: prefixIcon),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint, IconData? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, size: 20, color: Colors.grey)
          : null,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 1.5),
      ),
    );
  }

  Widget _buildShiftTile(String label) {
    bool isSelected = _selectedShift == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedShift = label),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF5F3FF) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
