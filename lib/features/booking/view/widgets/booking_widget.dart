// import 'package:flutter/material.dart';
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
                data.containsKey('bookingDate') &&
                data.containsKey('timeSlot') &&
                data['bookingDate'] == today;
          })
          .map((doc) => doc['timeSlot'] as String)
          .toSet();

      _bookedTomorrow = allDocs
          .where((doc) {
            final data = doc.data();
            return data['futsalId'] == widget.futsalDetail.futsalId &&
                data.containsKey('bookingDate') &&
                data.containsKey('timeSlot') &&
                data['bookingDate'] == tomorrow;
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonColors.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // TODO: Implement booking submission logic here
            },
            child: const Text(
              "Confirm Booking Date & Time",
              style: TextStyle(color: Colors.white),
            ),
          ),
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
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
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
                        // Handle slot selection logic here (e.g. update selectedSlot)
                      },
                backgroundColor: isBooked ? Colors.grey : Colors.grey.shade200,
                disabledColor: Colors.grey, // color for booked slot
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: isBooked
                        ? Colors.grey.shade600
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
