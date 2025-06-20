import 'package:shared_preferences/shared_preferences.dart';

class LoggedinstateSharedpref {
  void setUserUid(String uid) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("uid", uid);
  }

  Future<String> getUserUid() async {
    final pref = await SharedPreferences.getInstance();
    String uid = pref.getString("uid") ?? "";
    return uid;
  }

  void clearUserUid() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove("uid");
  }

  Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    String uid = pref.getString("uid") ?? "";
    if (uid != "") {
      return true;
    } else {
      return false;
    }
  }
}
