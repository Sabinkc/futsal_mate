import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:futsalmate/features/auth/data/loggedinstate_sharedpref.dart';
import 'dart:developer' as logger;

import 'package:futsalmate/features/dashboard/data/profile_data_model.dart';

class ProfileProviderModel extends ChangeNotifier {
  String location = "koteshwor";
  void updateLocation(String value) {
    location = value;
    notifyListeners();
  }

  String futsalPosition = "";
  void updatePosition(String value) {
    futsalPosition = value;
    notifyListeners();
  }

  String skillLevel = "";
  void updateSkillLevel(String value) {
    skillLevel = value;
    notifyListeners();
  }

  void clearProfileProvider() {
    location = "koteshwor";
    futsalPosition = "";
    skillLevel = "";
    notifyListeners();
  }

  ProfileDataModel profile = ProfileDataModel(
    userName: "",
    phone: "",
    age: "",
    address: "",
    position: "",
    skillLevel: "",
  );
  bool isProfileLoading = false;
  Future getProfile() async {
    isProfileLoading = true;
    notifyListeners();
    try {
      final sharedPref = LoggedinstateSharedpref();
      final uid = await sharedPref.getUserUid();
      final userProfile = await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(uid)
          .get();
      logger.log("uid: $uid");
      if (!userProfile.exists) {
        logger.log('⚠️ No profile document found for UID');
        return;
      }
      final data = userProfile.data() as Map<String, dynamic>;
      profile = ProfileDataModel(
        userName: data["userName"] ?? "Unknown",
        phone: data["phone"] ?? "Unknown",
        age: data["age"] ?? "Unknown",
        address: data["address"] ?? "koteshwor",
        position: data["positon"] ?? "",
        skillLevel: data["skillLevel"] ?? "",
      );
      location = data["address"] ?? "koteshwor";
      futsalPosition = data["position"] ?? "";
      skillLevel = data["skillLevel"] ?? "";
      logger.log(profile.toString());
    } catch (e) {
      rethrow;
    } finally {
      isProfileLoading = false;
      notifyListeners();
    }
  }

  bool isUpdateProfileLoading = false;
  Future updateProfile(
    String userName,
    String phone,
    String age,
    String address,
    String position,
    String skillLevel,
  ) async {
    isUpdateProfileLoading = true;
    notifyListeners();
    try {
      final sharedPref = LoggedinstateSharedpref();
      final uid = await sharedPref.getUserUid();
      await FirebaseFirestore.instance.collection('userProfile').doc(uid).set({
        "userName": userName,
        "phone": phone,
        "age": age,
        "address": address,
        "position": position,
        "skillLevel": skillLevel,
      });
    } catch (e) {
      logger.log(e.toString());
      rethrow;
    } finally {
      isUpdateProfileLoading = false;
      notifyListeners();
    }
  }
}
