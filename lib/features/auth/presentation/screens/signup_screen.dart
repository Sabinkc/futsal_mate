import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/authentication_textfield.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/common/utils.dart';
// import 'package:futsalmate/features/auth/data/firebase_authservice.dart';
import 'package:futsalmate/features/auth/data/loggedinstate_sharedpref.dart';
import 'package:futsalmate/features/auth/domain/auth_controller.dart';
import 'package:futsalmate/features/auth/presentation/screens/signin_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/landing_screen.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'dart:developer' as logger;

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final FirebaseAuthservice firebaseAuth = FirebaseAuthservice();
    final signupProvider = ref.watch(authProvider);
    return KeyboardDismisser(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              spacing: screenHeight * 0.02,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
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
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                  prefixIcon: Icons.lock_outline,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CommonColors.greyColor),
                  ),
                  child: Row(
                    spacing: 20,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: CommonColors.greyColor,
                      ),
                      DropdownButton(
                        focusColor: Colors.black,
                        underline: SizedBox.shrink(),
                        elevation: 0,
                        style: TextStyle(
                          color: CommonColors.greyColor,

                          fontSize: 18,
                        ),
                        value: signupProvider.signupAddress,
                        items: [
                          DropdownMenuItem(
                            value: "koteshwor",
                            child: Text("Koteshwor"),
                          ),
                          DropdownMenuItem(
                            value: "tinkune",
                            child: Text("Tinkune"),
                          ),
                          DropdownMenuItem(
                            value: "shankhamul",
                            child: Text("Shankhamul"),
                          ),
                          DropdownMenuItem(
                            value: "jadibuti",
                            child: Text("Jadibuti"),
                          ),
                          DropdownMenuItem(
                            value: "lokanthali",
                            child: Text("Lokanthali"),
                          ),
                        ],
                        onChanged: (value) {
                          ref.read(authProvider).updateSignupAddress(value!);
                        },
                      ),
                    ],
                  ),
                ),
                // CommonAuthenticationTextField(
                //   prefixIcon: Icons.local_attraction_outlined,
                //   hintText: "Address",
                //   controller: addressController,
                // ),
                CommonAuthenticationTextField(
                  prefixIcon: Icons.phone_outlined,
                  hintText: "Phone Number",
                  controller: phoneController,
                ),
                SizedBox(height: screenHeight * 0.001),
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
                        if (emailController.text.trim().isEmpty ||
                            passwordController.text.trim().isEmpty ||
                            confirmPasswordController.text.trim().isEmpty ||
                            userNameController.text.trim().isEmpty ||
                            phoneController.text.trim().isEmpty) {
                          Utils.showCommonSnackBar(
                            context,
                            color: CommonColors.errorColor,
                            content: "All fields are required!",
                          );
                        } else if (passwordController.text.trim() !=
                            confirmPasswordController.text.trim()) {
                          Utils.showCommonSnackBar(
                            context,
                            color: CommonColors.errorColor,
                            content: "Passwords donot match!",
                          );
                        } else {
                          await ref
                              .read(authProvider)
                              .signUp(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                          final User? user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            return;
                          }
                          await FirebaseFirestore.instance
                              .collection('userProfile')
                              .doc(user.uid)
                              .set({
                                "userName": userNameController.text.trim(),
                                "email": emailController.text.trim(),
                                "address": signupProvider.signupAddress,
                                "phone": phoneController.text.trim(),
                              });
                          final sharedPref = LoggedinstateSharedpref();
                          sharedPref.setUserUid(user.uid);
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
                                builder: (context) => LandingScreen(),
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
                            color: CommonColors.errorColor,
                            content: e.toString(),
                          );
                        }
                      }
                    },
                    child: signupProvider.isSignUpLoading == true
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Signup",

                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.001),
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
