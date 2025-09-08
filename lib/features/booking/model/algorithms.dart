// import 'dart:math';
// import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
// import 'package:futsalmate/features/booking/model/place_model.dart';

// class Algorithms {
//   double _degreesToRadians(double deg) => deg * (pi / 180);

//   double haversineDistanceKm(
//     double lat1,
//     double lon1,
//     double lat2,
//     double lon2,
//   ) {
//     const R = 6371.0; // km
//     final dLat = _degreesToRadians(lat2 - lat1);
//     final dLon = _degreesToRadians(lon2 - lon1);
//     final a =
//         sin(dLat / 2) * sin(dLat / 2) +
//         cos(_degreesToRadians(lat1)) *
//             cos(_degreesToRadians(lat2)) *
//             sin(dLon / 2) *
//             sin(dLon / 2);
//     final c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     return R * c;
//   }

//   List<FutsalDetailItemModel> sortByNearest(
//     List<FutsalDetailItemModel> list,
//     double refLat,
//     double refLon,
//   ) {
//     list.sort((a, b) {
//       final distA = haversineDistanceKm(
//         refLat,
//         refLon,
//         double.parse(a.latitude),
//         double.parse(a.latitude),
//       );
//       final distB = haversineDistanceKm(
//         refLat,
//         refLon,
//         double.parse(a.latitude),
//         double.parse(a.latitude),
//       );
//       return distA.compareTo(distB); // ascending: nearest first
//     });
//     return list;
//   }
// }
