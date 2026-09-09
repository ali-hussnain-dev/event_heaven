import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPaymentReceiptScreen extends StatefulWidget {
  final Map<String, dynamic> bookingDetails;

  const UserPaymentReceiptScreen({super.key, required this.bookingDetails});

  @override
  State<UserPaymentReceiptScreen> createState() =>
      _UserPaymentReceiptScreenState();
}

class _UserPaymentReceiptScreenState extends State<UserPaymentReceiptScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tidController = TextEditingController();

  bool _isReceiptAttached = false;
  String _selectedFileName = '';
  bool _isSubmitting = false;

  late Map<String, dynamic> _providerAccounts;

  @override
  void initState() {
    super.initState();
    _initializeProviderAccounts();
  }

  void _initializeProviderAccounts() {
    final Map<String, dynamic>? rawAccounts =
        widget.bookingDetails['paymentAccounts'] as Map<String, dynamic>?;

    _providerAccounts =
        rawAccounts ??
        {
          'Bank Name': 'Meezan Bank Limited',
          'Account Title':
              widget.bookingDetails['venueTitle'] ?? 'Royal Palace Admin',
          'Account Number': '01020304050607',
          'IBAN': 'PK36MEZN0001020304050607',
          'JazzCash / EasyPaisa': '0300 1234567',
        };
  }

  @override
  void dispose() {
    _tidController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "$label copied to clipboard!",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF8B5CF6),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  // Simulated local receipt attachment (No Image Picker package required)
  void _simulateAttachReceipt() {
    setState(() {
      _isReceiptAttached = true;
      _selectedFileName =
          "payment_receipt_${DateTime.now().millisecondsSinceEpoch}.jpg";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Payment receipt image selected successfully!"),
        backgroundColor: const Color(0xFF16A34A),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  void _submitReceipt() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_isReceiptAttached) {
      _showSnackBar(
        "Please attach a payment receipt screenshot.",
        isError: true,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isSubmitting = false);

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF16A34A),
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Receipt Uploaded!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "TID: ${_tidController.text.trim()}\nYour advance receipt has been submitted successfully. Venue owner will verify and confirm your booking.",
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
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  "View My Bookings",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
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
    final int advanceRequired =
        widget.bookingDetails['advanceRequired'] ?? 25000;
    final int totalAmount = widget.bookingDetails['totalAmount'] ?? 100000;
    final String venueTitle =
        widget.bookingDetails['venueTitle'] ?? "Royal Palace Hall";

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Gradient Header
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
                              "Advance Payment",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Glass Card Header
                        Container(
                          padding: const EdgeInsets.all(18),
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
                              Text(
                                "Payment for $venueTitle",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Advance Required (25%):",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Rs. ${advanceRequired.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.white24, height: 16),
                              Text(
                                "Total Estimated Bill: Rs. ${totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content Section
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Payment Accounts List
                          _buildCardWrapper(
                            title: "1. Owner / Provider Payment Methods",
                            child: Column(
                              children: _providerAccounts.entries.map((entry) {
                                bool isCopyable =
                                    entry.key.contains('Number') ||
                                    entry.key.contains('IBAN') ||
                                    entry.key.contains('JazzCash');

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              entry.key,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            SelectableText(
                                              entry.value,
                                              style: const TextStyle(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isCopyable)
                                        GestureDetector(
                                          onTap: () => _copyToClipboard(
                                            entry.value,
                                            entry.key,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5F3FF),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.copy_rounded,
                                                  size: 14,
                                                  color: Color(0xFF8B5CF6),
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Copy",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF8B5CF6),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 2. Proof Submission Fields
                          _buildCardWrapper(
                            title: "2. Submit Payment Proof",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Transaction ID (TID) / Reference No. *",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _tidController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Enter 11-12 digit TID (e.g. 9823102938)",
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.confirmation_number_outlined,
                                      color: Color(0xFF8B5CF6),
                                      size: 20,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFF8FAFC),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF8B5CF6),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  validator: (v) =>
                                      v == null || v.trim().isEmpty
                                      ? "Transaction ID is required"
                                      : null,
                                ),
                                const SizedBox(height: 16),

                                const Text(
                                  "Upload Payment Receipt Screenshot *",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                GestureDetector(
                                  onTap: _simulateAttachReceipt,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _isReceiptAttached
                                            ? const Color(0xFF16A34A)
                                            : const Color(
                                                0xFF8B5CF6,
                                              ).withOpacity(0.5),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: _isReceiptAttached
                                        ? Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  8,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFDCFCE7),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons
                                                      .insert_drive_file_rounded,
                                                  color: Color(0xFF16A34A),
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _selectedFileName,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Color(
                                                          0xFF1E293B,
                                                        ),
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const Text(
                                                      "Receipt attached successfully",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF16A34A,
                                                        ),
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Icon(
                                                Icons.check_circle_rounded,
                                                color: Color(0xFF16A34A),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFF5F3FF),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.cloud_upload_rounded,
                                                  color: Color(0xFF8B5CF6),
                                                  size: 32,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              const Text(
                                                "Tap to Attach Receipt Screenshot",
                                                style: TextStyle(
                                                  color: Color(0xFF8B5CF6),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                "Simulates local file attachment",
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
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

          // Submit Button
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
                    onPressed: _isSubmitting ? null : _submitReceipt,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            "Submit Payment Receipt",
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

  Widget _buildCardWrapper({required String title, required Widget child}) {
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
              fontSize: 15.5,
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
}
