import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/auth/data/firebase_authservice.dart';
import 'package:futsalmate/features/auth/presentation/screens/signup_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final FirebaseAuthservice firebaseAuth = FirebaseAuthservice();
    return KeyboardDismisser(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              spacing: screenHeight * 0.03,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.2),
                Align(
                  alignment: Alignment.center,
                  child: const Text(
                    "Welcome to Futsal Mates",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                SizedBox(
                  height: screenHeight * 0.06,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("All fields are required")),
                          );
                        } else {
                          final user = await firebaseAuth.signIn(
                            emailController.text,
                            passwordController.text,
                          );
                          // logger.log(user.toString());
                          // if (context.mounted) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text(user.toString())),
                          //   );
                          // }
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => DashboardScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                    child: Text("SignIn"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: CommonColors.greyColor),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: CommonColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
