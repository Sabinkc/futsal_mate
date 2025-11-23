import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
import 'dart:developer' as logger;

class FutsalDetailModel extends ChangeNotifier {
  List<FutsalDetailItemModel> futsalDetails = [];
  bool isFetchFutsalLoading = false;

  Future<void> fetchFutsalDetails() async {
    isFetchFutsalLoading = true;
    notifyListeners();

    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection("futsals")
          .get();

      futsalDetails = query.docs
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
                latitude: data['latitude'] ?? "",
                longitude: data['longitude'] ?? "",
              );
            } catch (e) {
              logger.log("Error parsing document ${doc.id}: $e");
              return null;
            }
          })
          .whereType<FutsalDetailItemModel>()
          .toList();

      logger.log("Successfully fetched ${futsalDetails.length} futsals.");
    } catch (e, stackTrace) {
      logger.log("Error fetching futsal details: ${e.toString()}");
      logger.log("StackTrace: $stackTrace");
    } finally {
      isFetchFutsalLoading = false;
      notifyListeners();
    }
  }
}
