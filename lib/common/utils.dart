import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';

class Utils {
  static void showCommonSnackBar(
    BuildContext context, {
    String content = "null",
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CommonColors.scaffoldBackgroundColor,
        duration: Duration(milliseconds: 500),
        content: Text(
          content,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
