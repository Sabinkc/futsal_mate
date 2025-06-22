import 'package:flutter/cupertino.dart';

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
}
