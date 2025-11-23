import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'dart:developer' as logger;

import 'package:futsalmate/features/auth/data/loggedinstate_sharedpref.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  bool _loading = true;
  List<Map<String, dynamic>> _bookings = [];
  List<Map<String, dynamic>> _filteredBookings = [];
  final TextEditingController _searchController = TextEditingController();
  Map<String, String> _futsalNames = {}; // Cache for futsal names

  // Get current user UID from SharedPreferences
  Future<String> get _currentUserId async {
    try {
      final sharedPref = LoggedinstateSharedpref();
      final uid = await sharedPref.getUserUid();
      return uid;
    } catch (e) {
      logger.log("❌ Error getting user UID: $e");
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMyBookings();
  }

  Future<void> _loadMyBookings() async {
    try {
      final userId = await _currentUserId;
      if (userId.isEmpty) {
        logger.log("❌ No user ID found");
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
        return;
      }

      logger.log("🔍 Loading bookings for user: $userId");

      // Fetch bookings for the current user
      final snapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      // Convert to list and sort manually by createdAt descending
      _bookings = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          ...data,
          'createdAt': data['createdAt']?.toDate(),
          'updatedAt': data['updatedAt']?.toDate(),
        };
      }).toList();

      // Manual sorting by createdAt descending
      _bookings.sort((a, b) {
        final DateTime? aDate = a['createdAt'];
        final DateTime? bDate = b['createdAt'];
        if (aDate == null) return 1;
        if (bDate == null) return -1;
        return bDate.compareTo(aDate);
      });

      _filteredBookings = _bookings;

      logger.log("✅ Loaded ${_bookings.length} bookings for user $userId");

      // Load futsal names for all bookings
      await _loadFutsalNames();

      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    } catch (e, stackTrace) {
      logger.log("❌ Error loading booking history: $e", stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  // Load futsal names for all unique futsal IDs in bookings
  Future<void> _loadFutsalNames() async {
    try {
      // Get all unique futsal IDs from bookings
      final Set<String?> futsalIds = _bookings
          .map((booking) => booking['futsalId']?.toString())
          .where((id) => id != null && id.isNotEmpty)
          .toSet();

      if (futsalIds.isEmpty) return;

      logger.log("🔍 Loading futsal names for ${futsalIds.length} futsals");

      // Fetch futsal details for all unique IDs
      final snapshot = await FirebaseFirestore.instance
          .collection('futsals')
          .where(FieldPath.documentId, whereIn: futsalIds.toList())
          .get();

      // Create a map of futsalId -> futsalName
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final futsalName = data['name']?.toString() ?? 'Unknown Futsal';
        _futsalNames[doc.id] = futsalName;
      }

      logger.log("✅ Loaded ${_futsalNames.length} futsal names");
    } catch (e, stackTrace) {
      logger.log("❌ Error loading futsal names: $e", stackTrace: stackTrace);
    }
  }

  // Get futsal name from cache or return fallback
  String _getFutsalName(String futsalId) {
    return _futsalNames[futsalId] ?? 'Loading...';
  }

  Future<void> _cancelBooking(
    String bookingId,
    String timeSlot,
    String date,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cancel Booking"),
        content: Text(
          "Are you sure you want to cancel your booking for $timeSlot on $date?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes, Cancel"),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      if (mounted) {
        setState(() {
          _loading = true;
        });
      }

      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .update({
            'status': 'cancelled',
            'updatedAt': FieldValue.serverTimestamp(),
            'cancelledAt': FieldValue.serverTimestamp(),
          });

      logger.log("✅ Booking cancelled: $bookingId");

      // Reload bookings to reflect changes
      await _loadMyBookings();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Booking cancelled successfully"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e, stackTrace) {
      logger.log("❌ Error cancelling booking: $e", stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to cancel booking"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _filterBookings(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBookings = _bookings;
      });
    } else {
      setState(() {
        _filteredBookings = _bookings.where((booking) {
          final futsalId = booking['futsalId']?.toString() ?? '';
          final futsalName = _getFutsalName(futsalId).toLowerCase();

          return futsalName.contains(query.toLowerCase()) ||
              booking['customerName']?.toString().toLowerCase().contains(
                    query.toLowerCase(),
                  ) ==
                  true ||
              booking['timeSlot']?.toString().toLowerCase().contains(
                    query.toLowerCase(),
                  ) ==
                  true ||
              booking['bookingDate']?.toString().toLowerCase().contains(
                    query.toLowerCase(),
                  ) ==
                  true;
        }).toList();
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  String _formatDateTime(DateTime? date) {
    if (date == null) return 'N/A';
    return "${_formatDate(date)} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  bool _isCancellable(Map<String, dynamic> booking) {
    final status = booking['status']?.toString().toLowerCase() ?? '';
    final bookingDate = booking['bookingDate']?.toString() ?? '';
    final timeSlot = booking['timeSlot']?.toString() ?? '';

    // Only allow cancellation for pending/confirmed bookings that are in the future
    if (status == 'cancelled' || status == 'completed') {
      return false;
    }

    // Check if the booking is in the future
    try {
      final now = DateTime.now();
      final bookingDateTime = _parseBookingDateTime(bookingDate, timeSlot);
      return bookingDateTime.isAfter(now);
    } catch (e) {
      return false;
    }
  }

  DateTime _parseBookingDateTime(String date, String timeSlot) {
    final dateParts = date.split('-');
    final timeParts = timeSlot.split(':');

    return DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final isCancellable = _isCancellable(booking);
    final futsalId = booking['futsalId']?.toString() ?? 'N/A';
    final futsalName = _getFutsalName(futsalId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with Futsal Name and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        futsalName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      if (futsalName == 'Loading...')
                        const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking['status'] ?? 'pending'),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    (booking['status'] ?? 'pending').toString().toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Booking details
            _buildDetailRow('Date', booking['bookingDate'] ?? 'N/A'),
            _buildDetailRow('Time Slot', booking['timeSlot'] ?? 'N/A'),
            _buildDetailRow('Amount', 'Rs. ${booking['amount'] ?? '0'}'),

            // Customer info
            if (booking['customerName'] != null &&
                booking['customerName'] != 'Guest User')
              _buildDetailRow('Customer', booking['customerName'] ?? 'N/A'),

            if (booking['customerPhone'] != null &&
                booking['customerPhone'] != 'N/A')
              _buildDetailRow('Phone', booking['customerPhone'] ?? 'N/A'),

            // Payment status
            Row(
              children: [
                const Text(
                  'Payment: ',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getPaymentStatusColor(
                      booking['paymentStatus'] ?? 'pending',
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    (booking['paymentStatus'] ?? 'pending')
                        .toString()
                        .toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Timestamps
            _buildDetailRow('Booked At', _formatDateTime(booking['createdAt'])),

            // Notes if available
            if (booking['notes'] != null &&
                booking['notes'].toString().isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Notes:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    booking['notes'].toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),

            // Cancel button for cancellable bookings
            if (isCancellable) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _cancelBooking(
                    booking['id'],
                    booking['timeSlot'] ?? '',
                    booking['bookingDate'] ?? '',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    "Cancel Booking",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],

            // Cancellation message for cancelled bookings
            if (booking['status']?.toString().toLowerCase() == 'cancelled') ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info, color: Colors.red, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "This booking was cancelled",
                        style: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search by futsal name, date, time...",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterBookings('');
                                },
                              )
                            : null,
                      ),
                      onChanged: _filterBookings,
                    ),
                  ),
                ),

                // Results count
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _searchController.text.isEmpty
                            ? "My bookings (${_bookings.length})"
                            : "Found ${_filteredBookings.length} booking${_filteredBookings.length != 1 ? 's' : ''}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            _filterBookings('');
                          },
                          child: Text(
                            "Clear",
                            style: TextStyle(color: CommonColors.primaryColor),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Bookings List
                Expanded(
                  child: _filteredBookings.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _searchController.text.isEmpty
                                    ? Icons.event_note
                                    : Icons.search_off,
                                size: 80,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _searchController.text.isEmpty
                                    ? "You have no bookings yet"
                                    : "No bookings found for '${_searchController.text}'",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (_searchController.text.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Book a futsal",
                                      style: TextStyle(
                                        color: CommonColors.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadMyBookings,
                          child: ListView.builder(
                            itemCount: _filteredBookings.length,
                            itemBuilder: (context, index) {
                              return _buildBookingCard(
                                _filteredBookings[index],
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
