import 'package:flutter/cupertino.dart';
import 'package:futsalmate/features/auth/data/firebase_authservice.dart';

class AuthProviderModel extends ChangeNotifier {
  final firebaseAuth = FirebaseAuthservice();
  bool isSignInLoading = false;
  Future signIn(String email, String password) async {
    try {
      isSignInLoading = true;
      notifyListeners();
      await firebaseAuth.signIn(email, password);
    } catch (e) {
      rethrow;
    } finally {
      isSignInLoading = false;
      notifyListeners();
    }
  }
}
