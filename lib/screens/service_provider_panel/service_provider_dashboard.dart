import 'package:flutter/material.dart';
import 'service_provider_registration_screen.dart';
import 'package:event_heaven/screens/auth_onboarding/welcome_screen.dart';

class ServiceProviderDashboardScreen extends StatefulWidget {
  const ServiceProviderDashboardScreen({super.key});

  @override
  State<ServiceProviderDashboardScreen> createState() =>
      _ServiceProviderDashboardScreenState();
}

class _ServiceProviderDashboardScreenState
    extends State<ServiceProviderDashboardScreen> {
  int _currentIndex = 0;

  // --- DUMMY STATE DATA ---
  final String _vendorCategory = "Car Rental & DJ Services";
  final bool _isVerifiedByAdmin = true;

  // Mutable list of services so editing works live in UI
  final List<Map<String, dynamic>> _myServices = [
    {
      'title': 'Royal Luxury Car Rentals',
      'category': 'Car Rental',
      'coverage': 'Gujranwala & Lahore',
      'minRate': '20000',
      'maxRate': '60000',
      'rateRange': 'Rs 20,000 - 60,000 / Event',
      'experience': '5+ Years Experience',
      'description':
          'Premium fleet including Prado, Civic, and Mercedes for wedding convoys.',
      'status': 'Active / Live',
      'statusColor': Colors.green,
    },
    {
      'title': 'SoundMasters DJ & Lighting',
      'category': 'Sound & Stage Setup',
      'coverage': 'Gujranwala',
      'minRate': '35000',
      'maxRate': '90000',
      'rateRange': 'Rs 35,000 - 90,000 / Event',
      'experience': '4 Years Experience',
      'description':
          'High-end JBL audio systems, laser lights, and fog machines for grand events.',
      'status': 'Active / Live',
      'statusColor': Colors.green,
    },
  ];

  // Mutable Profile Data
  Map<String, dynamic> _profileData = {
    'name': 'Risal Ahmad',
    'email': 'risal.ahmad@example.com',
    'phone': '+92 300 1234567',
    'cities': 'Gujranwala, Lahore',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeDashboardTab(),
            _buildMyServicesTab(),
            _buildBookingsAndChatsTab(),
            _buildProfileAndSettingsTab(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF8B5CF6),
          unselectedItemColor: Colors.grey.shade500,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.design_services_rounded),
              label: "My Services",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // TAB 1: HOME / DASHBOARD TAB
  // ===========================================================================
  Widget _buildHomeDashboardTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP GRADIENT HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
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
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar & Greeting (Tap Avatar to Go to Profile Tab)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 3; // Switch to Profile Tab
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: const Color(0xFFF3E8FF),
                              child: Text(
                                _profileData['name'][0].toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xFF8B5CF6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome, ${_profileData['name']}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _isVerifiedByAdmin
                                          ? const Color(0xFF22C55E)
                                          : const Color(0xFFF59E0B),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      _isVerifiedByAdmin
                                          ? "Live Provider ✓"
                                          : "Pending Admin Approval",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "($_vendorCategory)",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Top-Right "+ Add Service" Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ServiceProviderRegistrationScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Add Service",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. OVERVIEW ANALYTICS METRICS (2x2 GRID)
                const Text(
                  "Service Overview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: "Total Bookings",
                        value: "34",
                        badge: "+15%",
                        badgeColor: Colors.green,
                        icon: Icons.event_available_rounded,
                        iconColor: const Color(0xFF8B5CF6),
                        iconBgColor: const Color(0xFFF3E8FF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Total Earnings",
                        value: "Rs 1.2M",
                        badge: "+22%",
                        badgeColor: Colors.green,
                        icon: Icons.account_balance_wallet_rounded,
                        iconColor: const Color(0xFF22C55E),
                        iconBgColor: const Color(0xFFDCFCE7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: "Rating",
                        value: "4.9 ★",
                        badge: "+0.3",
                        badgeColor: Colors.blue,
                        icon: Icons.star_rounded,
                        iconColor: const Color(0xFFF59E0B),
                        iconBgColor: const Color(0xFFFEF3C7),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Pending Slips",
                        value: "2 Pending",
                        badge: "Action Req",
                        badgeColor: Colors.orange,
                        icon: Icons.receipt_long_rounded,
                        iconColor: const Color(0xFFEC4899),
                        iconBgColor: const Color(0xFFFCE7F3),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // 3. QUICK ACTIONS GRID
                const Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickActionButton(
                        title: "Manage Services",
                        icon: Icons.design_services_rounded,
                        gradientColors: [
                          const Color(0xFF8B5CF6),
                          const Color(0xFFA855F7),
                        ],
                        onTap: () {
                          setState(() {
                            _currentIndex = 1; // Go to My Services
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildQuickActionButton(
                        title: "Client Chats",
                        icon: Icons.chat_bubble_outline_rounded,
                        gradientColors: [
                          const Color(0xFFEC4899),
                          const Color(0xFFF43F5E),
                        ],
                        onTap: () {
                          setState(() {
                            _currentIndex = 2; // Go to Bookings & Chats
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // 4. RECENT BOOKING REQUESTS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Service Requests",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 2; // Go to Bookings
                        });
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: Color(0xFF8B5CF6),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Booking Item 1 (Pending Payment Verification)
                _buildBookingCard(
                  clientName: "Usman Raza",
                  eventType: "Wedding Convoy",
                  serviceName: "Prado & Civic Luxury Fleet",
                  dateAndShift: "Sept 18, 2026 | Full Day",
                  amount: "Rs 45,000",
                  status: "Pending Payment",
                  statusColor: const Color(0xFFF59E0B),
                  actionButtonLabel: "View Receipt & Verify",
                  actionButtonColor: const Color(0xFF8B5CF6),
                  onActionTap: () => _showPaymentVerificationModal(
                    context,
                    clientName: "Usman Raza",
                    amount: "Rs 45,000",
                  ),
                ),
                const SizedBox(height: 12),

                // Booking Item 2 (Confirmed)
                _buildBookingCard(
                  clientName: "Hamza Malik",
                  eventType: "Mehndi Night DJ & Sound",
                  serviceName: "SoundMasters DJ & Stage Lights",
                  dateAndShift: "Sept 24, 2026 | Night Shift",
                  amount: "Rs 60,000",
                  status: "Confirmed ✓",
                  statusColor: const Color(0xFF22C55E),
                  actionButtonLabel: "Chat with Client",
                  actionButtonColor: const Color(0xFFEC4899),
                  onActionTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
                const SizedBox(height: 12),

                // Booking Item 3 (Confirmed)
                _buildBookingCard(
                  clientName: "Bilal Tariq",
                  eventType: "Valima Photography",
                  serviceName: "Royal Cine Studio Setup",
                  dateAndShift: "Oct 02, 2026 | Night Shift",
                  amount: "Rs 85,000",
                  status: "Confirmed ✓",
                  statusColor: const Color(0xFF22C55E),
                  actionButtonLabel: "Chat with Client",
                  actionButtonColor: const Color(0xFFEC4899),
                  onActionTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 2: MY SERVICES TAB (MANAGE OFFERINGS, RATES & PACKAGES)
  // ===========================================================================
  Widget _buildMyServicesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Offered Services",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    "Manage your service packages & rates",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ServiceProviderRegistrationScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 16, color: Colors.white),
                label: const Text(
                  "New Service",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Render dynamic service cards
          ..._myServices.map((service) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildServiceManagementCard(service: service),
            );
          }),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 3: BOOKINGS & CHATS TAB
  // ===========================================================================
  Widget _buildBookingsAndChatsTab() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: const TabBar(
              labelColor: Color(0xFF8B5CF6),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF8B5CF6),
              indicatorWeight: 3,
              tabs: [
                Tab(
                  icon: Icon(Icons.calendar_month_rounded, size: 20),
                  text: "Service Orders",
                ),
                Tab(
                  icon: Icon(Icons.chat_bubble_outline_rounded, size: 20),
                  text: "Client Messages",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Sub Tab 1: Service Orders List
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildBookingCard(
                      clientName: "Usman Raza",
                      eventType: "Wedding Convoy",
                      serviceName: "Prado & Civic Luxury Fleet",
                      dateAndShift: "Sept 18, 2026 | Full Day",
                      amount: "Rs 45,000",
                      status: "Pending Payment",
                      statusColor: const Color(0xFFF59E0B),
                      actionButtonLabel: "View Receipt & Verify",
                      actionButtonColor: const Color(0xFF8B5CF6),
                      onActionTap: () => _showPaymentVerificationModal(
                        context,
                        clientName: "Usman Raza",
                        amount: "Rs 45,000",
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildBookingCard(
                      clientName: "Hamza Malik",
                      eventType: "Mehndi Night DJ & Sound",
                      serviceName: "SoundMasters DJ & Stage Lights",
                      dateAndShift: "Sept 24, 2026 | Night Shift",
                      amount: "Rs 60,000",
                      status: "Confirmed ✓",
                      statusColor: const Color(0xFF22C55E),
                      actionButtonLabel: "View Booking Slip",
                      actionButtonColor: Colors.grey.shade700,
                      onActionTap: () {},
                    ),
                  ],
                ),

                // Sub Tab 2: Client Chat List
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildChatTile(
                      name: "Usman Raza",
                      lastMessage:
                          "Is fuel included in Prado booking for Sept 18?",
                      time: "11:15 AM",
                      unreadCount: 1,
                    ),
                    _buildChatTile(
                      name: "Hamza Malik",
                      lastMessage:
                          "I have sent the 50% advance deposit receipt.",
                      time: "Yesterday",
                      unreadCount: 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 4: PROFILE & SETTINGS TAB (EDIT PROFILE, CNIC & LOGOUT)
  // ===========================================================================
  Widget _buildProfileAndSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          // Vendor Info Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: const Color(0xFFF3E8FF),
                  child: Text(
                    _profileData['name'][0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B5CF6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _profileData['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _vendorCategory,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Verified Service Provider ✓",
                    style: TextStyle(
                      color: Color(0xFF16A34A),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Options List
          Container(
            padding: const EdgeInsets.all(10),
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
              children: [
                _buildSettingsTile(
                  icon: Icons.person_outline_rounded,
                  title: "Edit Vendor Profile",
                  subtitle: "Business name, phone, coverage cities",
                  onTap: () => _showEditProfileBottomSheet(),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.badge_outlined,
                  title: "CNIC & Work Proof Documents",
                  subtitle: "View verified legal identity & portfolio proof",
                  onTap: () => _showCnicDocumentsModal(),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.lock_outline_rounded,
                  title: "Change Password & Security",
                  subtitle: "Update account login credentials",
                  onTap: () => _showChangePasswordBottomSheet(),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: "Order Alerts & Notifications",
                  subtitle: "Real-time updates for new bookings",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Notification preferences updated successfully.",
                        ),
                        backgroundColor: Color(0xFF8B5CF6),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Logout Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                _showLogoutDialog(context);
              },
              icon: const Icon(Icons.logout_rounded, color: Colors.white),
              label: const Text(
                "LOGOUT FROM ACCOUNT",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SUB-SCREENS & MODALS FOR EDITING SERVICES & PROFILE
  // ===========================================================================

  void _showEditServiceBottomSheet(Map<String, dynamic> service) {
    final titleC = TextEditingController(text: service['title']);
    final coverageC = TextEditingController(text: service['coverage']);
    final minRateC = TextEditingController(text: service['minRate']);
    final maxRateC = TextEditingController(text: service['maxRate']);
    final descC = TextEditingController(text: service['description'] ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Edit Service Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleC,
                decoration: InputDecoration(
                  labelText: "Service Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: coverageC,
                decoration: InputDecoration(
                  labelText: "Coverage Areas / City",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minRateC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Min Rate (Rs.)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: maxRateC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Max Rate (Rs.)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descC,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    setState(() {
                      service['title'] = titleC.text.trim();
                      service['coverage'] = coverageC.text.trim();
                      service['minRate'] = minRateC.text.trim();
                      service['maxRate'] = maxRateC.text.trim();
                      service['rateRange'] =
                          "Rs ${minRateC.text.trim()} - ${maxRateC.text.trim()} / Event";
                      service['description'] = descC.text.trim();
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Service details updated successfully!"),
                        backgroundColor: Color(0xFF22C55E),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    "Save Service Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

  void _showManageRatesModal(Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Manage Rates: ${service['title']}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(
                Icons.local_offer_rounded,
                color: Color(0xFF8B5CF6),
              ),
              title: const Text("Standard Event Package"),
              subtitle: Text("Base Charge: ${service['rateRange']}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Rate tier editing simulated."),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("New rate tier package added!"),
                      backgroundColor: Color(0xFF8B5CF6),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "Add Custom Rate Tier",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileBottomSheet() {
    final nameC = TextEditingController(text: _profileData['name']);
    final phoneC = TextEditingController(text: _profileData['phone']);
    final citiesC = TextEditingController(text: _profileData['cities']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Vendor Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameC,
              decoration: InputDecoration(
                labelText: "Business / Full Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneC,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: citiesC,
              decoration: InputDecoration(
                labelText: "Coverage Cities",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  setState(() {
                    _profileData['name'] = nameC.text.trim();
                    _profileData['phone'] = phoneC.text.trim();
                    _profileData['cities'] = citiesC.text.trim();
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Vendor profile updated!"),
                      backgroundColor: Color(0xFF8B5CF6),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCnicDocumentsModal() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Verified Legal Work Proof"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "• CNIC Front & Back: Verified ✓",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "• Portfolio / Experience Proof: Approved ✓",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Provider CNIC: 34101-5510928-3",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordBottomSheet() {
    final oldC = TextEditingController();
    final newC = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Change Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: oldC,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Current Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newC,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password updated successfully!"),
                      backgroundColor: Color(0xFF8B5CF6),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  "Update Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // REUSABLE HELPER WIDGETS & MODALS
  // ===========================================================================

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String badge,
    required Color badgeColor,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required String title,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required String clientName,
    required String eventType,
    required String serviceName,
    required String dateAndShift,
    required String amount,
    required String status,
    required Color statusColor,
    required String actionButtonLabel,
    required Color actionButtonColor,
    required VoidCallback onActionTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
                clientName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "$eventType • $serviceName",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 14,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                dateAndShift,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
                ),
              ),
              const Spacer(),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: onActionTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: actionButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                actionButtonLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceManagementCard({required Map<String, dynamic> service}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E8FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.handyman_rounded,
                  color: Color(0xFF8B5CF6),
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['title'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      "${service['category']} • ${service['coverage']}",
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                service['experience'],
                style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
              ),
              Text(
                service['rateRange'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showEditServiceBottomSheet(service),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF8B5CF6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Edit Details",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8B5CF6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showManageRatesModal(service),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Manage Rates",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile({
    required String name,
    required String lastMessage,
    required String time,
    required int unreadCount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFF3E8FF),
          child: Text(
            name[0],
            style: const TextStyle(
              color: Color(0xFF8B5CF6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xFF8B5CF6),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$unreadCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF8B5CF6), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E293B),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: Colors.grey,
      ),
    );
  }

  // Payment Verification Modal Dialog
  void _showPaymentVerificationModal(
    BuildContext context, {
    required String clientName,
    required String amount,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Manual Advance Payment Verification",
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "Review transfer deposit slip uploaded by $clientName ($amount)",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // Receipt Mockup Container
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.receipt_long_rounded,
                    size: 48,
                    color: Color(0xFF8B5CF6),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Service Advance Payment Deposit Slip",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF334155),
                    ),
                  ),
                  Text(
                    "Transaction ID: TXN-551092834",
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Reject Deposit",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Service Booking Payment Verified!"),
                          backgroundColor: Color(0xFF22C55E),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Approve Payment",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Confirm Logout"),
        content: const Text(
          "Are you sure you want to log out of Service Provider Portal?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
