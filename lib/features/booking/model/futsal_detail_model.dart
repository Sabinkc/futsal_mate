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

      futsalDetails = query.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return FutsalDetailItemModel(
          imgeUrl: data["imageUrl"] as String,
          name: data["name"] as String,
          location: data["location"] as String,
          fee: data["fee"] as String,
          openingTime: data["openingTime"] as String,
          openingHours: data["openingHours"] as String,
          availability: (data["availability"] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
        );
      }).toList();

      logger.log("futsalDetails: $futsalDetails");
    } catch (e) {
      logger.log("Error fetching FutsalDetailItemModel: ${e.toString()}");
    } finally {
      isFetchFutsalLoading = false;
      notifyListeners();
    }
  }
}
