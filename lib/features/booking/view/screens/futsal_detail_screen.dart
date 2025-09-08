// import 'package:flutter/material.dart';
// import 'package:futsalmate/common/colors.dart';
// import 'package:futsalmate/features/booking/model/available_time_converter.dart';
// import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
// import 'package:futsalmate/features/booking/view/widgets/booking_widget.dart';

// class FutsalDetailScreen extends StatelessWidget {
//   final FutsalDetailItemModel futsalDetail;
//   const FutsalDetailScreen({super.key, required this.futsalDetail});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: Text("Futsal Details", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: CommonColors.primaryColor,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(
//             futsalDetail.imageUrl,
//             height: height * 0.3,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               spacing: 10,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(futsalDetail.name),
//                 Text("Location: Shankhamul"),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Fee: Rs.${futsalDetail.pricePerHour}"),
//                     Text("Rating: 4.1"),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text("Availability:"),

//                 SizedBox(height: 20),
//                 // SizedBox(
//                 //   width: double.infinity,
//                 //   child: ElevatedButton(
//                 //     onPressed: () {
//                 //       showModalBottomSheet(
//                 //         context: context,
//                 //         isScrollControlled: true,
//                 //         builder: (context) {
//                 //           // return BookingWidget(futsalDetail: futsalDetail);
//                 //         },
//                 //       );
//                 //     },
//                 //     child: Text("Book"),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
import 'package:futsalmate/features/booking/view/widgets/booking_widget.dart';

class FutsalDetailScreen extends StatelessWidget {
  final FutsalDetailItemModel futsalDetail;

  const FutsalDetailScreen({super.key, required this.futsalDetail});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: const Text(
          "Futsal Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Futsal Image
            Image.network(
              futsalDetail.imageUrl,
              height: height * 0.3,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: height * 0.3,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    futsalDetail.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${futsalDetail.location}, ${futsalDetail.city}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Fee & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price: Rs. ${futsalDetail.pricePerHour}/hr",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${futsalDetail.rating.toStringAsFixed(1)}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Operating Hours
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Open: ${futsalDetail.startTime} - ${futsalDetail.endTime}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  if (futsalDetail.description.isNotEmpty) ...[
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      futsalDetail.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Contact Info
                  const Text(
                    "Contact",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Phone: ${futsalDetail.ownerPhone}"),
                  Text("Email: ${futsalDetail.ownerEmail}"),
                  const SizedBox(height: 20),

                  // Book Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CommonColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // showModalBottomSheet(
                        //   context: context,
                        //   isScrollControlled: true,
                        //   shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        //   ),
                        //   builder: (context) {
                        //     return BookingWidget(futsalDetail: futsalDetail);
                        //   },
                        // );
                      },
                      child: const Text(
                        "Book Now",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
