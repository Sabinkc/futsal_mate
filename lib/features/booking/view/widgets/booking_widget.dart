import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
import 'dart:developer' as logger;

class BookingWidget extends StatefulWidget {
  final FutsalDetailItemModel futsalDetail;
  const BookingWidget({super.key, required this.futsalDetail});

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  bool _loading = true;
  Set<String> _bookedToday = {};
  Set<String> _bookedTomorrow = {};
  String? _selectedSlot;
  String? _selectedDay;

  final List<String> _timeSlots = [
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
  ];

  @override
  void initState() {
    super.initState();
    _loadBookedSlots();
  }

  Future<void> _loadBookedSlots() async {
    String today = _formatDate(DateTime.now());
    String tomorrow = _formatDate(DateTime.now().add(Duration(days: 1)));

    logger.log("🔍 Scanning all bookings...");
    logger.log("Target Futsal ID: ${widget.futsalDetail.futsalId}");
    logger.log("Dates: Today = $today, Tomorrow = $tomorrow");

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .get();
      final allDocs = snapshot.docs;

      logger.log("📄 Total bookings found: ${allDocs.length}");

      _bookedToday = allDocs
          .where((doc) {
            final data = doc.data();
            return data['futsalId'] == widget.futsalDetail.futsalId &&
                data['bookingDate'] == today &&
                data.containsKey('timeSlot');
          })
          .map((doc) => doc['timeSlot'] as String)
          .toSet();

      _bookedTomorrow = allDocs
          .where((doc) {
            final data = doc.data();
            return data['futsalId'] == widget.futsalDetail.futsalId &&
                data['bookingDate'] == tomorrow &&
                data.containsKey('timeSlot');
          })
          .map((doc) => doc['timeSlot'] as String)
          .toSet();

      logger.log("✅ Booked Today Slots: $_bookedToday");
      logger.log("✅ Booked Tomorrow Slots: $_bookedTomorrow");

      setState(() {
        _loading = false;
      });
    } catch (e, stackTrace) {
      logger.log("❌ Error scanning bookings: $e", stackTrace: stackTrace);
      setState(() {
        _loading = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> _confirmBooking(String slot, String day) async {
    String bookingDate = _formatDate(
      day == "Today" ? DateTime.now() : DateTime.now().add(Duration(days: 1)),
    );

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Confirm Booking"),
        content: Text(
          "Do you want to book the slot $slot on $day ($bookingDate)?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text("Confirm"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final docRef = FirebaseFirestore.instance.collection("bookings").doc();

      await docRef.set({
        "futsalId": widget.futsalDetail.futsalId,
        "timeSlot": slot,
        "bookingDate": bookingDate,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
        "customerName": "Guest User",
        "customerEmail": "guest@example.com",
        "customerPhone": "N/A",
        "amount": widget.futsalDetail.pricePerHour,
        "status": "pending",
        "paymentStatus": "pending",
        "notes": "Booked via app",
      });

      logger.log("✅ Booking created for $slot on $bookingDate");
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booked $slot on $day successfully")),
      );

      // Refresh
      _loadBookedSlots();
    } catch (e) {
      Navigator.pop(context);
      logger.log("❌ Error creating booking: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Booking failed. Try again.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select Time Slot",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildDaySlotRow("Today", _bookedToday),
          SizedBox(height: 12),
          _buildDaySlotRow("Tomorrow", _bookedTomorrow),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDaySlotRow(String label, Set<String> booked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _timeSlots.map((slot) {
            final isBooked = booked.contains(slot);
            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(
                  color: isBooked ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: false,
              onSelected: isBooked
                  ? null
                  : (_) {
                      _confirmBooking(slot, label);
                    },
              backgroundColor: isBooked ? Colors.grey : Colors.green.shade100,
              disabledColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isBooked
                      ? Colors.grey.shade600
                      : Colors.green.shade300,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
