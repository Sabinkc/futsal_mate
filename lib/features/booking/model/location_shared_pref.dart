import 'package:shared_preferences/shared_preferences.dart';

class LocationSharedPref {
  static void setLocation(String lat, String long) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("latitude", lat);
    pref.setString("longitude", long);
  }

  static getLatitude() async {
    final pref = await SharedPreferences.getInstance();
    String lat = pref.getString("latitude").toString();
    return lat;
  }

  static getLongitude() async {
    final pref = await SharedPreferences.getInstance();
    String long = pref.getString("longitude").toString();
    return long;
  }
}
