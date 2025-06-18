import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/common/authentication_textfield.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/common/utils.dart';
import 'package:futsalmate/features/auth/data/firebase_authservice.dart';
import 'package:futsalmate/features/auth/presentation/screens/signin_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'dart:developer' as logger;

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.03,
                    // bottom: screenHeight * 0.01,
                  ),
                  child: Image.asset(
                    "assets/images/futsalmate_logo.webp",
                    height: screenHeight * 0.1,
                  ),
                ),
                // SizedBox(height: screenHeight * 0.1),
                // ),
                Text(
                  "SignUp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                CommonAuthenticationTextField(
                  prefixIcon: Icons.person_outline,
                  hintText: "User Name",
                  controller: userNameController,
                ),
                CommonAuthenticationTextField(
                  prefixIcon: Icons.email_outlined,
                  hintText: "Email",
                  controller: emailController,
                ),
                CommonAuthenticationTextField(
                  hintText: "Password",
                  controller: passwordController,
                  prefixIcon: Icons.lock_outline,
                ),
                CommonAuthenticationTextField(
                  prefixIcon: Icons.person_outline,
                  hintText: "Address",
                  controller: addressController,
                ),
                CommonAuthenticationTextField(
                  prefixIcon: Icons.person_outline,
                  hintText: "Phone Number",
                  controller: phoneController,
                ),
                SizedBox(height: screenHeight * 0.01),
                SizedBox(
                  height: screenHeight * 0.06,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CommonColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          Utils.showCommonSnackBar(
                            context,
                            content: "All fields are required!",
                          );
                        } else {
                          final user = await firebaseAuth.signUp(
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
                        logger.log(e.toString());
                        if (context.mounted) {
                          Utils.showCommonSnackBar(
                            context,
                            content: e.toString(),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Signup",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: CommonColors.greyColor,
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CommonColors.primaryColor,
                        ),
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
