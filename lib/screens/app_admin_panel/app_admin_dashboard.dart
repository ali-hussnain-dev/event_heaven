import 'package:flutter/material.dart';
import 'package:event_heaven/screens/auth_onboarding/welcome_screen.dart';

class SystemAdminDashboardScreen extends StatefulWidget {
  const SystemAdminDashboardScreen({super.key});

  @override
  State<SystemAdminDashboardScreen> createState() =>
      _SystemAdminDashboardScreenState();
}

class _SystemAdminDashboardScreenState
    extends State<SystemAdminDashboardScreen> {
  int _currentIndex = 0;

  // --- DUMMY STATE DATA FOR SYSTEM ADMIN ---
  final String _adminName = "Risal Ahmad";
  final String _adminRole = "System Super Admin";

  int _pendingVenuesCount = 3;
  int _pendingVendorsCount = 2;

  // Mock Directory Data for Toggling Status
  final List<Map<String, dynamic>> _directoryItems = [
    {
      "title": "Royal Palace Banquet Hall",
      "subtitle": "Owner: Risal Ahmad • Gujranwala",
      "type": "Venue Listing",
      "isLive": true,
    },
    {
      "title": "SoundMasters DJ & Lighting",
      "subtitle": "Vendor: Husnain Akhtar • Gujranwala",
      "type": "Service Provider",
      "isLive": true,
    },
    {
      "title": "Grand Crystal Marquee",
      "subtitle": "Owner: Ali Husnain • Lahore",
      "type": "Venue Listing",
      "isLive": true,
    },
    {
      "title": "Old Town Lawn Marquee",
      "subtitle": "Owner: Unverified User • Sialkot",
      "type": "Venue Listing",
      "isLive": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    int totalPending = _pendingVenuesCount + _pendingVendorsCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildOverviewTab(),
            _buildPendingApprovalsTab(),
            _buildMasterDirectoryTab(),
            _buildAdminSettingsTab(),
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
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF8B5CF6),
          unselectedItemColor: Colors.grey.shade500,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: "Overview",
            ),
            BottomNavigationBarItem(
              icon: totalPending > 0
                  ? Badge(
                      label: Text("$totalPending"),
                      backgroundColor: const Color(0xFFEC4899),
                      child: const Icon(Icons.verified_user_rounded),
                    )
                  : const Icon(Icons.verified_user_rounded),
              label: "Approvals",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.storefront_rounded),
              label: "Directory",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings_rounded),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // TAB 1: OVERVIEW METRICS TAB
  // ===========================================================================
  Widget _buildOverviewTab() {
    int totalPending = _pendingVenuesCount + _pendingVendorsCount;

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
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFFF3E8FF),
                    child: Icon(
                      Icons.shield_outlined,
                      color: Color(0xFF8B5CF6),
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _adminName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _adminRole,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "System Control",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. OPERATIONAL METRICS (2x2 GRID)
                const Text(
                  "Platform Health & Statistics",
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
                        title: "Total Registered",
                        value: "1,240",
                        badge: "Customers",
                        badgeColor: Colors.blue,
                        icon: Icons.people_alt_rounded,
                        iconColor: const Color(0xFF8B5CF6),
                        iconBgColor: const Color(0xFFF3E8FF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Active Venues",
                        value: "42 Live",
                        badge: "Verified",
                        badgeColor: Colors.green,
                        icon: Icons.apartment_rounded,
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
                        title: "Active Vendors",
                        value: "68 Live",
                        badge: "Providers",
                        badgeColor: Colors.purple,
                        icon: Icons.design_services_rounded,
                        iconColor: const Color(0xFFEC4899),
                        iconBgColor: const Color(0xFFFCE7F3),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Pending Reviews",
                        value: "$totalPending Pending",
                        badge: "Action Req",
                        badgeColor: Colors.orange,
                        icon: Icons.pending_actions_rounded,
                        iconColor: const Color(0xFFF97316),
                        iconBgColor: const Color(0xFFFFEDD5),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // 3. URGENT APPROVALS ALERT CARD
                if (totalPending > 0)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFF97316).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          color: Color(0xFFF97316),
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$totalPending Legal Verifications Pending",
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9A3412),
                                ),
                              ),
                              const Text(
                                "Review uploaded CNIC & Property Registry copies",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFFC2410C),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() => _currentIndex = 1),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF97316),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Review",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 2: PENDING APPROVALS TAB (VERIFICATION QUEUE & MODAL)
  // ===========================================================================
  Widget _buildPendingApprovalsTab() {
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
                  icon: Icon(Icons.apartment_rounded, size: 20),
                  text: "Venue Requests",
                ),
                Tab(
                  icon: Icon(Icons.work_outline_rounded, size: 20),
                  text: "Vendor Requests",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Sub Tab 1: Venue Approval Requests
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildApprovalRequestCard(
                      applicantName: "Risal Ahmad (Owner)",
                      businessTitle: "Royal Palace Banquet Hall",
                      categoryCity: "Banquet Hall • Gujranwala",
                      submittedDate: "Sept 03, 2026",
                      cnicNumber: "34101-1234567-1",
                      docType: "Property Registry & Owner CNIC",
                      onReviewTap: () => _showDocumentVerificationModal(
                        context,
                        title: "Royal Palace Banquet Hall",
                        owner: "Risal Ahmad",
                        cnic: "34101-1234567-1",
                        docType: "Property Registry & CNIC Copies",
                        isVenue: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildApprovalRequestCard(
                      applicantName: "Ali Husnain (Manager)",
                      businessTitle: "Grand Crystal Marquee",
                      categoryCity: "Event Complex • Lahore",
                      submittedDate: "Sept 02, 2026",
                      cnicNumber: "35202-9876543-3",
                      docType: "SECP Business License & CNIC",
                      onReviewTap: () => _showDocumentVerificationModal(
                        context,
                        title: "Grand Crystal Marquee",
                        owner: "Ali Husnain",
                        cnic: "35202-9876543-3",
                        docType: "SECP Business License & CNIC",
                        isVenue: true,
                      ),
                    ),
                  ],
                ),

                // Sub Tab 2: Vendor Approval Requests
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildApprovalRequestCard(
                      applicantName: "Husnain Akhtar",
                      businessTitle: "Royal Luxury Car Rentals",
                      categoryCity: "Car Rental • Gujranwala & Lahore",
                      submittedDate: "Sept 01, 2026",
                      cnicNumber: "34101-5554433-2",
                      docType: "Visiting Card & CNIC Copies",
                      onReviewTap: () => _showDocumentVerificationModal(
                        context,
                        title: "Royal Luxury Car Rentals",
                        owner: "Husnain Akhtar",
                        cnic: "34101-5554433-2",
                        docType: "Visiting Card & CNIC Copies",
                        isVenue: false,
                      ),
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
  // TAB 3: MASTER DIRECTORY TAB (SUSPEND/ACTIVATE TOGGLE)
  // ===========================================================================
  Widget _buildMasterDirectoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Live Platform Directory",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const Text(
            "Manage active listings & suspend non-compliant accounts",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _directoryItems.length,
            itemBuilder: (context, index) {
              final item = _directoryItems[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
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
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item["isLive"]
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item["isLive"]
                            ? Icons.check_circle_rounded
                            : Icons.block_rounded,
                        color: item["isLive"]
                            ? const Color(0xFF16A34A)
                            : Colors.red,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            item["subtitle"],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          item["isLive"] = !item["isLive"];
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              item["isLive"]
                                  ? "${item['title']} Activated!"
                                  : "${item['title']} Suspended!",
                            ),
                            backgroundColor: item["isLive"]
                                ? const Color(0xFF22C55E)
                                : Colors.red,
                          ),
                        );
                      },
                      child: Text(
                        item["isLive"] ? "Suspend" : "Activate",
                        style: TextStyle(
                          color: item["isLive"]
                              ? Colors.red
                              : const Color(0xFF8B5CF6),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 4: ADMIN SETTINGS & AUDIT LOGS TAB
  // ===========================================================================
  Widget _buildAdminSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          // Admin Info Header Card
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
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: Color(0xFFF3E8FF),
                  child: Icon(
                    Icons.shield_rounded,
                    size: 42,
                    color: Color(0xFF8B5CF6),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _adminName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _adminRole,
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
                    "Master System Access ✓",
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

          // Settings List
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
                  icon: Icons.security_rounded,
                  title: "Master RBAC Security Rules",
                  subtitle: "Firestore access roles & permissions",
                  onTap: () {},
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.history_rounded,
                  title: "System Audit Logs",
                  subtitle: "Track administrative verification actions",
                  onTap: () {},
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.rate_review_outlined,
                  title: "Moderate User Reviews",
                  subtitle: "Filter flagged customer feedback",
                  onTap: () => _showReviewModerationModal(context),
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
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout_rounded, color: Colors.white),
              label: const Text(
                "LOGOUT FROM ADMIN PANEL",
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
  // REUSABLE HELPER WIDGETS & MODAL DIALOGS
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

  Widget _buildApprovalRequestCard({
    required String applicantName,
    required String businessTitle,
    required String categoryCity,
    required String submittedDate,
    required String cnicNumber,
    required String docType,
    required VoidCallback onReviewTap,
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
                businessTitle,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Pending Review",
                  style: TextStyle(
                    color: Color(0xFFF97316),
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "$categoryCity • $submittedDate",
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 6),
          Text(
            "Applicant: $applicantName (CNIC: $cnicNumber)",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton.icon(
              onPressed: onReviewTap,
              icon: const Icon(
                Icons.remove_red_eye_rounded,
                size: 16,
                color: Colors.white,
              ),
              label: const Text(
                "Review Legal Documents",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
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

  // Document Verification Review Modal with Rejection Reason Field
  void _showDocumentVerificationModal(
    BuildContext context, {
    required String title,
    required String owner,
    required String cnic,
    required String docType,
    required bool isVenue,
  }) {
    final TextEditingController rejectionReasonController =
        TextEditingController();

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
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Legal Document Verification",
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
            Text(
              "Review submitted registry & CNIC for $title ($owner)",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // Document Mockup Container
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.badge_outlined,
                    size: 46,
                    color: Color(0xFF8B5CF6),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    docType,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF334155),
                    ),
                  ),
                  Text(
                    "Verified CNIC: $cnic",
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Optional Rejection Reason Field
            TextField(
              controller: rejectionReasonController,
              decoration: InputDecoration(
                hintText: "Rejection Reason (Required if rejecting request)",
                hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (rejectionReasonController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a rejection reason!"),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }
                      Navigator.pop(ctx);
                      setState(() {
                        if (isVenue && _pendingVenuesCount > 0) {
                          _pendingVenuesCount--;
                        } else if (!isVenue && _pendingVendorsCount > 0) {
                          _pendingVendorsCount--;
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Listing Verification Rejected!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Reject Request",
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
                      setState(() {
                        if (isVenue && _pendingVenuesCount > 0) {
                          _pendingVenuesCount--;
                        } else if (!isVenue && _pendingVendorsCount > 0) {
                          _pendingVendorsCount--;
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Listing Approved & Live on Platform!"),
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
                      "Approve & Publish",
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

  // Moderate Flagged User Reviews Dialog
  void _showReviewModerationModal(BuildContext context) {
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
            const Text(
              "Flagged Reviews Moderation",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Review reported feedback from customers or venue owners",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "User: Anonymous Client",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("★ 1.0", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\"The venue owner charged extra money at the event time.\"",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text("Dismiss Flag"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Flagged Review Deleted!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      "Delete Review",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
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
          "Are you sure you want to exit System Admin Panel?",
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
