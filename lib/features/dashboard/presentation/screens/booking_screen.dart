import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/booking/controller/booking_controller.dart';
import 'package:futsalmate/features/booking/view/screens/futsal_detail_screen.dart';
import 'dart:developer' as logger;

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final futsalRefR = ref.read(futsalDetailController);
      await futsalRefR.fetchFutsalDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final futsalRef = ref.watch(futsalDetailController);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                // TODO: Implement filter
              },
              child: const Text(
                "Filter",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: futsalRef.isFetchFutsalLoading
          ? Center(
              child: CircularProgressIndicator(
                color: CommonColors.primaryColor,
              ),
            )
          : ListView.builder(
              itemCount: futsalRef.futsalDetails.length,
              itemBuilder: (context, index) {
                final futsal = futsalRef.futsalDetails[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      logger.log("futsal detail: $futsal");
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              FutsalDetailScreen(futsalDetail: futsal),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // Image section
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              futsal.imageUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Info section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  futsal.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Address: ${futsal.address}, ${futsal.city}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Price: Rs. ${futsal.pricePerHour}/hr",
                                  style: const TextStyle(color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Hours: ${futsal.startTime} - ${futsal.endTime}",
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
