import 'package:flutter/cupertino.dart';

class LocationModel extends ChangeNotifier {
  String longitude = "27.7";
  String latitude = "85.3";

  void updateLocation(String lat, String long) {
    longitude = long;
    latitude = lat;
    notifyListeners();
  }
}
