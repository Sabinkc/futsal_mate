import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/auth/presentation/screens/signup_screen.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
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
                    onPressed: () {},
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
