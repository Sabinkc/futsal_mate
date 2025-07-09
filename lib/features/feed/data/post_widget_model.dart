import 'package:flutter/material.dart';

class PostWidgetModel extends ChangeNotifier {
  String selectedType = "teammate";
  updateType(String type) {
    selectedType = type;
    notifyListeners();
  }

  resetType() {
    selectedType = "teammate";
    notifyListeners();
  }

  String selectedLocation = "koteshwor";
  updateLocation(String location) {
    selectedLocation = location;
    notifyListeners();
  }

  resetLocation() {
    selectedLocation = "koteshwor";
    notifyListeners();
  }

  String selectedSkillLevel = "low";
  updateSkillLevel(String level) {
    selectedSkillLevel = level;
    notifyListeners();
  }

  resetSillLevel() {
    selectedSkillLevel = "low";
    notifyListeners();
  }

  String selectedPosition = "midfielder";
  updatePosition(String position) {
    selectedPosition = position;
    notifyListeners();
  }

  resetPosition() {
    selectedPosition = "midfielder";
    notifyListeners();
  }
}
