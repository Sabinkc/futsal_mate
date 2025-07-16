import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/booking/controller/booking_controller.dart';
import 'package:futsalmate/features/booking/model/algorithms.dart';
import 'package:futsalmate/features/booking/model/location_shared_pref.dart';
import 'package:futsalmate/features/booking/model/place_model.dart';
import 'dart:developer' as logger;

class TestScreen extends ConsumerWidget {
  TestScreen({super.key});
  final algorithm = Algorithms();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detRefR = ref.read(futsalDetailController);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Test Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final places = detRefR.futsalDetails;
            // final userLat = 27.7;
            // final userLon = 85.3;
            String userLatStr = await LocationSharedPref.getLatitude();
            String userLonStr = await LocationSharedPref.getLongitude();
            double userLat = double.parse(userLatStr);
            double userLon = double.parse(userLonStr);
            logger.log("userLat: $userLat");
            logger.log("userLong: $userLon");
            final sorted = algorithm.sortByNearest(places, userLat, userLon);
            for (var p in sorted) {
              final d = algorithm.haversineDistanceKm(
                userLat,
                userLon,
                double.parse(p.latitude),
                double.parse(p.longitude),
              );
              logger.log('${p.name}: ${d.toStringAsFixed(1)} km');
            }
          },
          child: Text("Test"),
        ),
      ),
    );
  }
}
