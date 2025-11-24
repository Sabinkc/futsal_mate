// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:futsalmate/features/auth/data/loggedinstate_sharedpref.dart';
// import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
// import 'dart:developer' as logger;

// class BookingWidget extends StatefulWidget {
//   final FutsalDetailItemModel futsalDetail;
//   const BookingWidget({super.key, required this.futsalDetail});

//   @override
//   State<BookingWidget> createState() => _BookingWidgetState();
// }

// class _BookingWidgetState extends State<BookingWidget> {
//   bool _loading = true;
//   Set<String> _bookedToday = {};
//   Set<String> _bookedTomorrow = {};

//   final List<String> _timeSlots = [
//     '07:00',
//     '08:00',
//     '09:00',
//     '10:00',
//     '11:00',
//     '12:00',
//     '13:00',
//     '14:00',
//     '15:00',
//     '16:00',
//     '17:00',
//     '18:00',
//     '19:00',
//     '20:00',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadBookedSlots();

//   }

//   Future<void> _loadBookedSlots() async {
//     String today = _formatDate(DateTime.now());
//     String tomorrow = _formatDate(DateTime.now().add(Duration(days: 1)));

//     logger.log("🔍 Scanning all bookings...");
//     logger.log("Target Futsal ID: ${widget.futsalDetail.futsalId}");
//     logger.log("Dates: Today = $today, Tomorrow = $tomorrow");

//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('bookings')
//           .get();
//       final allDocs = snapshot.docs;

//       logger.log("📄 Total bookings found: ${allDocs.length}");

//       _bookedToday = allDocs
//           .where((doc) {
//             final data = doc.data();
//             return data['futsalId'] == widget.futsalDetail.futsalId &&
//                 data['bookingDate'] == today &&
//                 data.containsKey('timeSlot');
//           })
//           .map((doc) => doc['timeSlot'] as String)
//           .toSet();

//       _bookedTomorrow = allDocs
//           .where((doc) {
//             final data = doc.data();
//             return data['futsalId'] == widget.futsalDetail.futsalId &&
//                 data['bookingDate'] == tomorrow &&
//                 data.containsKey('timeSlot');
//           })
//           .map((doc) => doc['timeSlot'] as String)
//           .toSet();

//       logger.log("✅ Booked Today Slots: $_bookedToday");
//       logger.log("✅ Booked Tomorrow Slots: $_bookedTomorrow");

//       // Check if widget is still mounted before calling setState
//       if (mounted) {
//         setState(() {
//           _loading = false;
//         });
//       }
//     } catch (e, stackTrace) {
//       logger.log("❌ Error scanning bookings: $e", stackTrace: stackTrace);
//       // Check if widget is still mounted before calling setState
//       if (mounted) {
//         setState(() {
//           _loading = false;
//         });
//       }
//     }
//   }

//   String _formatDate(DateTime date) {
//     return "${date.year.toString().padLeft(4, '0')}-"
//         "${date.month.toString().padLeft(2, '0')}-"
//         "${date.day.toString().padLeft(2, '0')}";
//   }

//   // Check if a time slot is in the future
//   bool _isTimeSlotInFuture(String day, String timeSlot) {
//     final now = DateTime.now();
//     final currentTime = TimeOfDay.fromDateTime(now);

//     if (day == "Today") {
//       // Parse the time slot
//       final timeParts = timeSlot.split(':');
//       final slotHour = int.parse(timeParts[0]);
//       final slotMinute = int.parse(timeParts[1]);
//       final slotTime = TimeOfDay(hour: slotHour, minute: slotMinute);

//       // Compare with current time
//       return slotTime.hour > currentTime.hour ||
//           (slotTime.hour == currentTime.hour &&
//               slotTime.minute > currentTime.minute);
//     } else if (day == "Tomorrow") {
//       // All tomorrow slots are in the future
//       return true;
//     }

//     return false;
//   }

//   Future<void> _confirmBooking(String slot, String day) async {
//     String bookingDate = _formatDate(
//       day == "Today" ? DateTime.now() : DateTime.now().add(Duration(days: 1)),
//     );

//     // Check if the time slot is in the future
//     if (!_isTimeSlotInFuture(day, slot)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Cannot book past time slots. Please select a future time.",
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Confirm Booking"),
//         content: Text(
//           "Do you want to book the slot $slot on $day ($bookingDate)?",
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, false),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, true),
//             child: const Text("Confirm"),
//           ),
//         ],
//       ),
//     );

//     if (confirm != true) return;

//     try {
//       final docRef = FirebaseFirestore.instance.collection("bookings").doc();

//       final sharedPref = LoggedinstateSharedpref();
//       final uid = await sharedPref.getUserUid();

//       await docRef.set({
//         "futsalId": widget.futsalDetail.futsalId,
//         "timeSlot": slot,
//         "bookingDate": bookingDate,
//         "createdAt": FieldValue.serverTimestamp(),
//         "updatedAt": FieldValue.serverTimestamp(),
//         "customerName": "Guest User",
//         "customerEmail": "guest@example.com",
//         "customerPhone": "N/A",
//         "amount": widget.futsalDetail.pricePerHour,
//         "status": "pending",
//         "paymentStatus": "pending",
//         "notes": "Booked via app",
//         "userId": uid, // ADD THIS FIELD - crucial for My Bookings screen
//       });

//       logger.log("✅ Booking created for $slot on $bookingDate for user: $uid");

//       // Close the bottom sheet first
//       if (mounted) {
//         Navigator.pop(context);
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Booked $slot on $day successfully")),
//       );

//       // Don't call _loadBookedSlots() here since the widget is disposed
//       // The next time the widget opens, it will load fresh data
//     } catch (e) {
//       // Only try to close if still mounted
//       if (mounted) {
//         Navigator.pop(context);
//       }
//       logger.log("❌ Error creating booking: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Booking failed. Try again.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return const SizedBox(
//         height: 200,
//         child: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         top: 16,
//         left: 16,
//         right: 16,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Select Time Slot",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           _buildDaySlotRow("Today", _bookedToday),
//           const SizedBox(height: 12),
//           _buildDaySlotRow("Tomorrow", _bookedTomorrow),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _buildDaySlotRow(String label, Set<String> booked) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: _timeSlots.map((slot) {
//             final isBooked = booked.contains(slot);
//             final isPastTime =
//                 label == "Today" && !_isTimeSlotInFuture(label, slot);
//             final isDisabled = isBooked || isPastTime;

//             String disabledReason = '';
//             if (isBooked) {
//               disabledReason = 'Already booked';
//             } else if (isPastTime) {
//               disabledReason = 'Time has passed';
//             }

//             return ChoiceChip(
//               label: Text(
//                 slot,
//                 style: TextStyle(
//                   color: isDisabled ? Colors.white : Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               selected: false,
//               onSelected: isDisabled
//                   ? null
//                   : (_) {
//                       _confirmBooking(slot, label);
//                     },
//               backgroundColor: isDisabled ? Colors.grey : Colors.green.shade100,
//               disabledColor: Colors.grey,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 side: BorderSide(
//                   color: isDisabled
//                       ? Colors.grey.shade600
//                       : Colors.green.shade300,
//                 ),
//               ),
//               tooltip: isDisabled ? disabledReason : 'Book $slot',
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/auth/data/loggedinstate_sharedpref.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
import 'package:futsalmate/features/dashboard/data/profile_provider_model.dart';
import 'dart:developer' as logger;

import 'package:futsalmate/features/dashboard/domain/profile_controller.dart';

class BookingWidget extends ConsumerStatefulWidget {
  final FutsalDetailItemModel futsalDetail;
  const BookingWidget({super.key, required this.futsalDetail});

  @override
  ConsumerState<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends ConsumerState<BookingWidget> {
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
    Future.delayed(Duration.zero, () async {
      _loadBookedSlots();
      final profileData = ref.read(profileProvider);
      await profileData.getProfile();
      _loadBookedSlots();
    });
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

      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    } catch (e, stackTrace) {
      logger.log("❌ Error scanning bookings: $e", stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  bool _isTimeSlotInFuture(String day, String timeSlot) {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    if (day == "Today") {
      final timeParts = timeSlot.split(':');
      final slotHour = int.parse(timeParts[0]);
      final slotMinute = int.parse(timeParts[1]);
      final slotTime = TimeOfDay(hour: slotHour, minute: slotMinute);

      return slotTime.hour > currentTime.hour ||
          (slotTime.hour == currentTime.hour &&
              slotTime.minute > currentTime.minute);
    } else if (day == "Tomorrow") {
      return true;
    }

    return false;
  }

  Future<void> _confirmBooking(String slot, String day) async {
    String bookingDate = _formatDate(
      day == "Today" ? DateTime.now() : DateTime.now().add(Duration(days: 1)),
    );

    if (!_isTimeSlotInFuture(day, slot)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Cannot book past time slots. Please select a future time.",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Booking"),
        content: Text(
          "Do you want to book the slot $slot on $day ($bookingDate)?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final docRef = FirebaseFirestore.instance.collection("bookings").doc();

      final sharedPref = LoggedinstateSharedpref();
      final uid = await sharedPref.getUserUid();

      // FIX: Use a different variable name to avoid conflict
      final profileData = ref.read(profileProvider);
      final profile = profileData.profile;

      // Use profile data if available, otherwise fallback to guest data
      final String customerName = profile.userName.isNotEmpty
          ? profile.userName
          : "Guest User";
      final String customerPhone = profile.phone.isNotEmpty
          ? profile.phone
          : "N/A";
      final String customerEmail =
          "user@example.com"; // You might want to add email to your profile model

      await docRef.set({
        "futsalId": widget.futsalDetail.futsalId,
        "timeSlot": slot,
        "bookingDate": bookingDate,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
        "customerName": customerName,
        "customerEmail": customerEmail,
        "customerPhone": customerPhone,
        "amount": widget.futsalDetail.pricePerHour,
        "status": "pending",
        "paymentStatus": "pending",
        "notes": "Booked via app",
        "userId": uid,
      });

      logger.log("✅ Booking created for $slot on $bookingDate for user: $uid");
      logger.log(
        "📞 Customer details - Name: $customerName, Phone: $customerPhone",
      );

      if (mounted) {
        Navigator.pop(context);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booked $slot on $day successfully")),
      );
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
      }
      logger.log("❌ Error creating booking: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking failed. Try again.")),
      );
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
          const SizedBox(height: 16),
          _buildDaySlotRow("Today", _bookedToday),
          const SizedBox(height: 12),
          _buildDaySlotRow("Tomorrow", _bookedTomorrow),
          const SizedBox(height: 20),
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _timeSlots.map((slot) {
            final isBooked = booked.contains(slot);
            final isPastTime =
                label == "Today" && !_isTimeSlotInFuture(label, slot);
            final isDisabled = isBooked || isPastTime;

            String disabledReason = '';
            if (isBooked) {
              disabledReason = 'Already booked';
            } else if (isPastTime) {
              disabledReason = 'Time has passed';
            }

            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(
                  color: isDisabled ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: false,
              onSelected: isDisabled
                  ? null
                  : (_) {
                      _confirmBooking(slot, label);
                    },
              backgroundColor: isDisabled ? Colors.grey : Colors.green.shade100,
              disabledColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isDisabled
                      ? Colors.grey.shade600
                      : Colors.green.shade300,
                ),
              ),
              tooltip: isDisabled ? disabledReason : 'Book $slot',
            );
          }).toList(),
        ),
      ],
    );
  }
}
