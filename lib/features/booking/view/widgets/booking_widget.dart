// import 'package:flutter/material.dart';
// import 'package:futsalmate/features/booking/model/available_time_converter.dart';
// import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';

// class BookingWidget extends StatelessWidget {
//   final FutsalDetailItemModel futsalDetail;
//   const BookingWidget({super.key, required this.futsalDetail});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     return Container(
//       height: height * 0.8,
//       decoration: BoxDecoration(color: Colors.white),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           spacing: 10,
//           children: [
//             Text("Choose Timing", style: TextStyle(fontSize: 18)),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   crossAxisCount: 3,
//                 ),
//                 itemCount: futsalDetail.availability.length,
//                 itemBuilder: (context, index) {
//                   bool isAvailable = futsalDetail.availability[index] == "1"
//                       ? true
//                       : false;
//                   return Container(
//                     height: 20,
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10),
//                       color: isAvailable ? Colors.grey : Colors.white,
//                     ),
//                     child: Center(
//                       child: Text(
//                         AvailableTimeConverter.availableTime[index],
//                         style: TextStyle(
//                           color: isAvailable ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(onPressed: () {}, child: Text("Book")),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
