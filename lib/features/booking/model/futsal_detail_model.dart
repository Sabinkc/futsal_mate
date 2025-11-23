// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
// import 'dart:developer' as logger;

// class FutsalDetailModel extends ChangeNotifier {
//   List<FutsalDetailItemModel> futsalDetails = [];
//   bool isFetchFutsalLoading = false;

//   Future<void> fetchFutsalDetails() async {
//     isFetchFutsalLoading = true;
//     notifyListeners();

//     try {
//       QuerySnapshot query = await FirebaseFirestore.instance
//           .collection("futsals")
//           .get();

//       futsalDetails = query.docs
//           .map((doc) {
//             final data = doc.data() as Map<String, dynamic>?;

//             if (data == null) {
//               logger.log("Skipped null data for doc ID: ${doc.id}");
//               return null;
//             }

//             // Safely handle operatingHours
//             final operatingHoursRaw = data["operatingHours"];
//             String startTime = '';
//             String endTime = '';

//             if (operatingHoursRaw is Map<String, dynamic>) {
//               startTime = operatingHoursRaw["start"] ?? '';
//               endTime = operatingHoursRaw["end"] ?? '';
//             } else {
//               logger.log(
//                 "Invalid or missing 'operatingHours' for doc ID: ${doc.id}",
//               );
//             }

//             try {
//               return FutsalDetailItemModel(
//                 futsalId: data["futsalId"] ?? '',
//                 name: data["name"] ?? '',
//                 imageUrl: data["imageUrl"] ?? '',
//                 address: data["address"] ?? '',
//                 city: data["city"] ?? '',
//                 location: data["location"] ?? '',
//                 description: data["description"] ?? '',
//                 ownerEmail: data["ownerEmail"] ?? '',
//                 ownerPhone: data["ownerPhone"] ?? '',
//                 pricePerHour: (data["pricePerHour"] ?? 0).toInt(),
//                 isVerified: data["isVerified"] ?? false,
//                 status: data["status"] ?? '',
//                 rating: (data["rating"] ?? 0).toDouble(),
//                 totalRatings: (data["totalRatings"] ?? 0).toInt(),
//                 totalBookings: (data["totalBookings"] ?? 0).toInt(),
//                 startTime: startTime,
//                 endTime: endTime,
//                 latitude: data['latitude'] ?? "",
//                 longitude: data['longitude'] ?? "",
//               );
//             } catch (e) {
//               logger.log("Error parsing document ${doc.id}: $e");
//               return null;
//             }
//           })
//           .whereType<FutsalDetailItemModel>()
//           .toList();

//       logger.log("Successfully fetched ${futsalDetails.length} futsals.");
//     } catch (e, stackTrace) {
//       logger.log("Error fetching futsal details: ${e.toString()}");
//       logger.log("StackTrace: $stackTrace");
//     } finally {
//       isFetchFutsalLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
import 'package:futsalmate/features/booking/model/location_calculator.dart';
import 'dart:developer' as logger;

import 'package:futsalmate/features/booking/model/location_shared_pref.dart';

class FutsalDetailModel extends ChangeNotifier {
  List<FutsalDetailItemModel> futsalDetails = [];
  List<FutsalDetailItemModel> _originalFutsalDetails = [];
  bool isFetchFutsalLoading = false;

  // Current user location
  double? _currentLatitude;
  double? _currentLongitude;

  // Set current user location from SharedPreferences
  Future<void> setUserLocationFromPrefs() async {
    try {
      final latStr = await LocationSharedPref.getLatitude();
      final longStr = await LocationSharedPref.getLongitude();

      if (latStr.isNotEmpty &&
          latStr != "null" &&
          longStr.isNotEmpty &&
          longStr != "null") {
        _currentLatitude = double.tryParse(latStr);
        _currentLongitude = double.tryParse(longStr);

        logger.log(
          "📍 User location set: $_currentLatitude, $_currentLongitude",
        );

        if (_currentLatitude != null && _currentLongitude != null) {
          _sortFutsalsByDistance();
        }
      } else {
        logger.log("📍 No user location found in SharedPreferences");
      }
    } catch (e) {
      logger.log("❌ Error setting user location: $e");
    }
  }

  // Check if user location is available
  bool get hasUserLocation =>
      _currentLatitude != null && _currentLongitude != null;

  Future<void> fetchFutsalDetails() async {
    isFetchFutsalLoading = true;
    notifyListeners();

    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection("futsals")
          .get();

      _originalFutsalDetails = query.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>?;

            if (data == null) {
              logger.log("Skipped null data for doc ID: ${doc.id}");
              return null;
            }

            // Safely handle operatingHours
            final operatingHoursRaw = data["operatingHours"];
            String startTime = '';
            String endTime = '';

            if (operatingHoursRaw is Map<String, dynamic>) {
              startTime = operatingHoursRaw["start"] ?? '';
              endTime = operatingHoursRaw["end"] ?? '';
            } else {
              logger.log(
                "Invalid or missing 'operatingHours' for doc ID: ${doc.id}",
              );
            }

            try {
              return FutsalDetailItemModel(
                futsalId: data["futsalId"] ?? '',
                name: data["name"] ?? '',
                imageUrl: data["imageUrl"] ?? '',
                address: data["address"] ?? '',
                city: data["city"] ?? '',
                location: data["location"] ?? '',
                description: data["description"] ?? '',
                ownerEmail: data["ownerEmail"] ?? '',
                ownerPhone: data["ownerPhone"] ?? '',
                pricePerHour: (data["pricePerHour"] ?? 0).toInt(),
                isVerified: data["isVerified"] ?? false,
                status: data["status"] ?? '',
                rating: (data["rating"] ?? 0).toDouble(),
                totalRatings: (data["totalRatings"] ?? 0).toInt(),
                totalBookings: (data["totalBookings"] ?? 0).toInt(),
                startTime: startTime,
                endTime: endTime,
                latitude: data['latitude'] ?? 0,
                longitude: data['longitude'] ?? 0,
              );
            } catch (e) {
              logger.log("Error parsing document ${doc.id}: $e");
              return null;
            }
          })
          .whereType<FutsalDetailItemModel>()
          .toList();

      // Try to set user location and sort
      await setUserLocationFromPrefs();

      // If no user location, use original order
      if (!hasUserLocation) {
        futsalDetails = _originalFutsalDetails;
        logger.log("ℹ️ No user location available, using default order");
      }

      logger.log("✅ Successfully fetched ${futsalDetails.length} futsals.");
      if (hasUserLocation) {
        logger.log("📍 Futsals sorted by distance from user location");
      }
    } catch (e, stackTrace) {
      logger.log("❌ Error fetching futsal details: ${e.toString()}");
      logger.log("StackTrace: $stackTrace");
    } finally {
      isFetchFutsalLoading = false;
      notifyListeners();
    }
  }

  // Sort futsals by distance using Haversine formula
  void _sortFutsalsByDistance() {
    if (!hasUserLocation) return;

    futsalDetails = List.from(_originalFutsalDetails)
      ..sort((a, b) {
        final double? distanceA = _calculateDistanceToFutsal(a);
        final double? distanceB = _calculateDistanceToFutsal(b);

        // Handle futsals with missing or invalid coordinates
        if (distanceA == null && distanceB == null) return 0;
        if (distanceA == null) return 1; // Put missing coordinates at the end
        if (distanceB == null) return -1; // Put missing coordinates at the end

        return distanceA.compareTo(distanceB);
      });

    logger.log("🔄 Sorted ${futsalDetails.length} futsals by distance");
    notifyListeners();
  }

  // Calculate distance to a futsal using Haversine formula
  double? _calculateDistanceToFutsal(FutsalDetailItemModel futsal) {
    if (_currentLatitude == null || _currentLongitude == null) {
      return null;
    }

    // Convert num to double for calculations
    final futsalLat = futsal.latitude.toDouble();
    final futsalLong = futsal.longitude.toDouble();

    // Check if coordinates are valid (not 0,0 which might be default)
    if (futsalLat == 0.0 && futsalLong == 0.0) {
      return null;
    }

    return LocationCalculator.calculateDistance(
      _currentLatitude!,
      _currentLongitude!,
      futsalLat,
      futsalLong,
    );
  }

  // Get distance for a specific futsal (for display)
  String getDistanceForFutsal(FutsalDetailItemModel futsal) {
    if (!hasUserLocation) return "Enable location";

    final distance = _calculateDistanceToFutsal(futsal);
    if (distance == null) return "Distance unknown";

    if (distance < 1) {
      return "${(distance * 1000).toStringAsFixed(0)} m"; // Convert to meters
    } else {
      return "${distance.toStringAsFixed(1)} km";
    }
  }

  // Check if a futsal has valid coordinates
  bool hasValidCoordinates(FutsalDetailItemModel futsal) {
    return futsal.latitude.toDouble() != 0.0 &&
        futsal.longitude.toDouble() != 0.0;
  }

  // Manually refresh sorting (useful when location changes)
  Future<void> refreshSorting() async {
    await setUserLocationFromPrefs();
  }

  // Reset to original order (without distance sorting)
  void resetSorting() {
    futsalDetails = _originalFutsalDetails;
    notifyListeners();
  }

  // Get user location for debugging
  String get userLocationInfo {
    if (!hasUserLocation) return "No location set";
    return "Lat: $_currentLatitude, Long: $_currentLongitude";
  }
}
