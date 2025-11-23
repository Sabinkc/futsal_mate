import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/history/view/screens/my_bookings_screen.dart';
import 'package:futsalmate/features/history/view/screens/my_posts_screen.dart';

class MyHistoryScreen extends StatelessWidget {
  const MyHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My History", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => MyPostsScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("My post", style: TextStyle()),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => MyBookingsScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("My bookings"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
