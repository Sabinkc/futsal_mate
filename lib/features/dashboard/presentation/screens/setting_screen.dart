import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/common/utils.dart';
import 'package:futsalmate/features/auth/data/firebase_authservice.dart';
import 'package:futsalmate/features/auth/data/loggedinstate_sharedpref.dart';
import 'package:futsalmate/features/auth/presentation/screens/signin_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/profile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: screenHeight * 0.03,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[200],
                child: Icon(Icons.person, size: 40),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Confirm Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.of(ctx).pop(), // No: just close
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop(); // Close dialog first
                          // Then perform logout action
                          try {
                            final firebaseAuth = FirebaseAuthservice();
                            final sharedPref = LoggedinstateSharedpref();
                            await firebaseAuth.signOut();
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false,
                              );
                            }
                            sharedPref.clearUserUid();
                          } catch (e) {
                            if (context.mounted) {
                              Utils.showCommonSnackBar(
                                context,
                                content: e.toString(),
                                color: CommonColors.errorColor,
                              );
                            }
                          }
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                color: CommonColors.lightGreyColor,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: Icon(Icons.logout_outlined),
                  title: Text("Log Out"),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: Container(
                color: CommonColors.lightGreyColor,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: Icon(Icons.person_outline),
                  title: Text("My Profile"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
