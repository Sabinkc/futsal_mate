import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthservice {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(String email, String password) async {
    final UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  Future<UserCredential?> signIn(String email, String password) async {
    final UserCredential user = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
