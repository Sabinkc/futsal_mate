// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:futsalmate/features/booking/controller/booking_controller.dart';
// import 'package:futsalmate/features/booking/model/algorithms.dart';
// import 'package:futsalmate/features/booking/model/location_shared_pref.dart';
// import 'package:futsalmate/features/booking/model/place_model.dart';
// import 'dart:developer' as logger;

// class TestScreen extends ConsumerWidget {
//   TestScreen({super.key});
//   final algorithm = Algorithms();
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final detRefR = ref.read(futsalDetailController);
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back),
//         ),
//         title: Text("Test Screen"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final places = detRefR.futsalDetails;
//             // final userLat = 27.7;
//             // final userLon = 85.3;
//             String userLatStr = await LocationSharedPref.getLatitude();
//             String userLonStr = await LocationSharedPref.getLongitude();
//             double userLat = double.parse(userLatStr);
//             double userLon = double.parse(userLonStr);
//             logger.log("userLat: $userLat");
//             logger.log("userLong: $userLon");
//             final sorted = algorithm.sortByNearest(places, userLat, userLon);
//             for (var p in sorted) {
//               final d = algorithm.haversineDistanceKm(
//                 userLat,
//                 userLon,
//                 double.parse(p.latitude),
//                 double.parse(p.longitude),
//               );
//               logger.log('${p.name}: ${d.toStringAsFixed(1)} km');
//             }
//           },
//           child: Text("Test"),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  // Define your two points in Nepal
  static const LatLng _origin = LatLng(27.7172, 85.3240); // Kathmandu
  static const LatLng _destination = LatLng(27.6727, 85.4298); // Dhulikhel

  // Launch Google Maps with driving directions between the two coordinates
  Future<void> _openMapsWithDirections() async {
    final origin = '${_origin.latitude},${_origin.longitude}';
    final dest = '${_destination.latitude},${_destination.longitude}';
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=$origin'
      '&destination=$dest'
      '&travelmode=driving',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch map directions URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Test",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1.3),
              ),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(initialCenter: _origin, initialZoom: 13),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.example.kitchen_ecommerce",
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _origin,
                    child: const Icon(
                      Icons.location_city_outlined,
                      color: Colors.red,
                    ),
                  ),
                  Marker(
                    point: _destination,
                    child: const Icon(Icons.flag_outlined, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: _openMapsWithDirections,
              icon: const Icon(Icons.directions),
              label: const Text('Get Directions'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
