import 'package:flutter/material.dart';
import 'venue_owner_registration_screen.dart';
import 'package:event_heaven/screens/auth_onboarding/welcome_screen.dart';

class VenueOwnerDashboardScreen extends StatefulWidget {
  const VenueOwnerDashboardScreen({super.key});

  @override
  State<VenueOwnerDashboardScreen> createState() =>
      _VenueOwnerDashboardScreenState();
}

class _VenueOwnerDashboardScreenState extends State<VenueOwnerDashboardScreen> {
  int _currentIndex = 0;

  // --- DUMMY STATE DATA ---
  final String _ownerRole = "Hall Admin";
  final bool _isVerifiedByAdmin = true;

  // Mutable list of venues so editing works live in UI
  final List<Map<String, dynamic>> _myVenues = [
    {
      'title': 'Royal Palace Banquet Hall',
      'category': 'Banquet Hall',
      'city': 'Gujranwala',
      'address': 'GT Road, Near Standard College, Gujranwala',
      'capacity': '150 - 500 Guests',
      'minCapacity': '150',
      'maxCapacity': '500',
      'baseRent': '150000',
      'description':
          'Luxurious hall with elegant interior and central air conditioning.',
      'status': 'Active / Live',
      'statusColor': Colors.green,
    },
    {
      'title': 'Grand Crystal Marquee',
      'category': 'Marquee',
      'city': 'Lahore',
      'address': 'Main Boulevard, Gulberg III, Lahore',
      'capacity': '300 - 1000 Guests',
      'minCapacity': '300',
      'maxCapacity': '1000',
      'baseRent': '250000',
      'description':
          'Spacious marquee equipped with heavy generator backup and grand chandeliers.',
      'status': 'Active / Live',
      'statusColor': Colors.green,
    },
  ];

  // Mutable Profile Data
  final Map<String, dynamic> _profileData = {
    'name': 'Risal Ahmad',
    'email': 'risal.ahmad@example.com',
    'phone': '+92 300 1234567',
    'hours': '9:00 AM - 10:00 PM',
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
            _buildMyVenuesTab(),
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
              icon: Icon(Icons.storefront_rounded),
              label: "My Venues",
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
                              backgroundColor: const Color(0xFFFCE7F3),
                              child: Text(
                                _profileData['name'][0].toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xFFEC4899),
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
                                          ? "Live on Platform ✓"
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
                                    "($_ownerRole)",
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

                    // Top-Right "+ Add Venue" Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const VenueOwnerRegistrationScreen(),
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
                              "Add Venue",
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
                  "Business Overview",
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
                        value: "48",
                        badge: "+12%",
                        badgeColor: Colors.green,
                        icon: Icons.calendar_today_rounded,
                        iconColor: const Color(0xFF8B5CF6),
                        iconBgColor: const Color(0xFFF3E8FF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Revenue",
                        value: "Rs 2.4M",
                        badge: "+18%",
                        badgeColor: Colors.green,
                        icon: Icons.payments_rounded,
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
                        title: "Avg Rating",
                        value: "4.8 ★",
                        badge: "+0.2",
                        badgeColor: Colors.blue,
                        icon: Icons.star_rounded,
                        iconColor: const Color(0xFFF59E0B),
                        iconBgColor: const Color(0xFFFEF3C7),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Pending Receipts",
                        value: "3 Pending",
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
                        title: "Manage Venues",
                        icon: Icons.storefront_rounded,
                        gradientColors: [
                          const Color(0xFF8B5CF6),
                          const Color(0xFFA855F7),
                        ],
                        onTap: () {
                          setState(() {
                            _currentIndex = 1; // Go to My Venues
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildQuickActionButton(
                        title: "Messages",
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

                // 4. RECENT BOOKINGS STREAM
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Booking Requests",
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
                  clientName: "Sarah Ali",
                  eventType: "Birthday Party",
                  venueName: "Royal Palace Banquet",
                  dateAndShift: "June 20, 2026 | Day Shift",
                  amount: "Rs 35,000",
                  status: "Pending Payment",
                  statusColor: const Color(0xFFF59E0B),
                  actionButtonLabel: "View Receipt & Verify",
                  actionButtonColor: const Color(0xFF8B5CF6),
                  onActionTap: () => _showPaymentVerificationModal(
                    context,
                    clientName: "Sarah Ali",
                    amount: "Rs 35,000",
                  ),
                ),
                const SizedBox(height: 12),

                // Booking Item 2 (Confirmed)
                _buildBookingCard(
                  clientName: "Ahmed Khan",
                  eventType: "Wedding Event",
                  venueName: "Grand Crystal Marquee",
                  dateAndShift: "June 15, 2026 | Night Shift",
                  amount: "Rs 150,000",
                  status: "Confirmed ✓",
                  statusColor: const Color(0xFF22C55E),
                  actionButtonLabel: "Chat with Client",
                  actionButtonColor: const Color(0xFFEC4899),
                  onActionTap: () {
                    setState(() {
                      _currentIndex = 2; // Jump to chats
                    });
                  },
                ),
                const SizedBox(height: 12),

                // Booking Item 3 (Confirmed)
                _buildBookingCard(
                  clientName: "Hassan Ahmed",
                  eventType: "Corporate Seminar",
                  venueName: "Royal Palace Banquet",
                  dateAndShift: "June 25, 2026 | Night Shift",
                  amount: "Rs 80,000",
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
  // TAB 2: MY VENUES TAB (MANAGE VENUES, MENUS & PACKAGES)
  // ===========================================================================
  Widget _buildMyVenuesTab() {
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
                    "My Listed Venues",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    "Manage hall details, pricing & menus",
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
                          const VenueOwnerRegistrationScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 16, color: Colors.white),
                label: const Text(
                  "New Listing",
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

          // Render dynamic venues list
          ..._myVenues.map((venue) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildVenueManagementCard(venue: venue),
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
                  text: "All Bookings",
                ),
                Tab(
                  icon: Icon(Icons.chat_bubble_outline_rounded, size: 20),
                  text: "Customer Messages",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Sub Tab 1: Bookings List
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildBookingCard(
                      clientName: "Sarah Ali",
                      eventType: "Birthday Party",
                      venueName: "Royal Palace Banquet",
                      dateAndShift: "June 20, 2026 | Day Shift",
                      amount: "Rs 35,000",
                      status: "Pending Payment",
                      statusColor: const Color(0xFFF59E0B),
                      actionButtonLabel: "View Receipt & Verify",
                      actionButtonColor: const Color(0xFF8B5CF6),
                      onActionTap: () => _showPaymentVerificationModal(
                        context,
                        clientName: "Sarah Ali",
                        amount: "Rs 35,000",
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildBookingCard(
                      clientName: "Ahmed Khan",
                      eventType: "Wedding Event",
                      venueName: "Grand Crystal Marquee",
                      dateAndShift: "June 15, 2026 | Night Shift",
                      amount: "Rs 150,000",
                      status: "Confirmed ✓",
                      statusColor: const Color(0xFF22C55E),
                      actionButtonLabel: "View Booking Slip",
                      actionButtonColor: Colors.grey.shade700,
                      onActionTap: () {},
                    ),
                  ],
                ),

                // Sub Tab 2: Customer Chat List
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildChatTile(
                      name: "Ali Husnain",
                      lastMessage:
                          "Is catering service included in 12th Oct booking?",
                      time: "10:30 AM",
                      unreadCount: 2,
                    ),
                    _buildChatTile(
                      name: "Husnain Akhtar",
                      lastMessage:
                          "I have uploaded the advance payment transfer receipt.",
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
  // TAB 4: PROFILE & SETTINGS TAB (EDIT PROFILE, VIEW DOCUMENTS, LOGOUT)
  // ===========================================================================
  Widget _buildProfileAndSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          // Owner Info Card
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
                  backgroundColor: const Color(0xFFF5F3FF),
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
                  "Hall Owner / Venue Manager",
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
                    "Identity Verified ✓",
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

          // Profile Options Group
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
                  title: "Edit Personal Details",
                  subtitle: "Name, phone number, operating hours",
                  onTap: () => _showEditProfileBottomSheet(),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.badge_outlined,
                  title: "CNIC & Legal Documents",
                  subtitle: "View verified registry & CNIC copies",
                  onTap: () => _showCnicDocumentsModal(),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.lock_outline_rounded,
                  title: "Change Password & Security",
                  subtitle: "Update account login password",
                  onTap: () => _showChangePasswordBottomSheet(),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: "Booking Notifications",
                  subtitle: "Alerts for new booking requests",
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
  // SUB-SCREENS & MODALS FOR EDITING VENUES & PROFILE
  // ===========================================================================

  void _showEditVenueBottomSheet(Map<String, dynamic> venue) {
    final titleC = TextEditingController(text: venue['title']);
    final addressC = TextEditingController(text: venue['address']);
    final minCapC = TextEditingController(text: venue['minCapacity'] ?? '150');
    final maxCapC = TextEditingController(text: venue['maxCapacity'] ?? '500');
    final rentC = TextEditingController(text: venue['baseRent'] ?? '150000');
    final descC = TextEditingController(text: venue['description'] ?? '');

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
                    "Edit Venue Details",
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
                  labelText: "Venue Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressC,
                decoration: InputDecoration(
                  labelText: "Street Address",
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
                      controller: minCapC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Min Capacity",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: maxCapC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Max Capacity",
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
                controller: rentC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Base Rent (Rs.)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
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
                      venue['title'] = titleC.text.trim();
                      venue['address'] = addressC.text.trim();
                      venue['minCapacity'] = minCapC.text.trim();
                      venue['maxCapacity'] = maxCapC.text.trim();
                      venue['capacity'] =
                          "${minCapC.text.trim()} - ${maxCapC.text.trim()} Guests";
                      venue['baseRent'] = rentC.text.trim();
                      venue['description'] = descC.text.trim();
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Venue updated successfully!"),
                        backgroundColor: Color(0xFF22C55E),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    "Save Venue Changes",
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

  void _showManageMenusModal(Map<String, dynamic> venue) {
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
                  "Manage Menus: ${venue['title']}",
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
                Icons.restaurant_menu_rounded,
                color: Color(0xFF8B5CF6),
              ),
              title: const Text("Standard Wedding Menu"),
              subtitle: const Text(
                "Chicken Biryani, Qorma, Naan, Kheer - Rs. 1,200/head",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Menu item editing simulated."),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.restaurant_menu_rounded,
                color: Color(0xFFEC4899),
              ),
              title: const Text("VIP Royal Menu"),
              subtitle: const Text(
                "Mutton Roast, Chicken Shinwari, Sweet Bar - Rs. 2,200/head",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Menu item editing simulated."),
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
                      content: Text("New menu package added successfully!"),
                      backgroundColor: Color(0xFF8B5CF6),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "Add New Menu Package",
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
    final hoursC = TextEditingController(text: _profileData['hours']);

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
                  "Edit Personal Details",
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
                labelText: "Full Name",
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
              controller: hoursC,
              decoration: InputDecoration(
                labelText: "Operating Hours",
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
                    _profileData['hours'] = hoursC.text.trim();
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile details updated!"),
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
        title: const Text("Verified Legal Documents"),
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
              "• Venue Property Registry: Approved ✓",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Owner CNIC: 34101-9842104-9",
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
                      content: Text("Password changed successfully!"),
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
    required String venueName,
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
            "$eventType • $venueName",
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

  Widget _buildVenueManagementCard({required Map<String, dynamic> venue}) {
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
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
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
                      venue['title'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      "${venue['category']} - ${venue['city']}",
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
                "Capacity: ${venue['capacity']}",
                style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
              ),
              Text(
                "Rs. ${venue['baseRent']} / Event",
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
                  onPressed: () => _showEditVenueBottomSheet(venue),
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
                  onPressed: () => _showManageMenusModal(venue),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Manage Menus",
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
          backgroundColor: const Color(0xFFFCE7F3),
          child: Text(
            name[0],
            style: const TextStyle(
              color: Color(0xFFEC4899),
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
                  "Manual Payment Verification",
                  style: TextStyle(
                    fontSize: 17,
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
              "Review transfer slip uploaded by $clientName ($amount)",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // Receipt Image Mockup Container
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
                    "Advance Payment Slip Image",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF334155),
                    ),
                  ),
                  Text(
                    "Transaction ID: TXN-984210491",
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
                      "Reject Slip",
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
                          content: Text("Booking Verified & Confirmed!"),
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
          "Are you sure you want to log out of Venue Owner Portal?",
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
