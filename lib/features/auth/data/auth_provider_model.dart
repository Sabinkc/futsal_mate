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

  bool isSignUpLoading = false;
  Future signUp(String email, String password) async {
    try {
      isSignUpLoading = true;
      notifyListeners();
      await firebaseAuth.signUp(email, password);
    } catch (e) {
      rethrow;
    } finally {
      isSignUpLoading = false;
      notifyListeners();
    }
  }

  String signupAddress = "koteshwor";
  void updateSignupAddress(String value) {
    signupAddress = value;
    notifyListeners();
  }
}
