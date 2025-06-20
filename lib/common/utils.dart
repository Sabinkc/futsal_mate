import 'package:flutter/material.dart';

class Utils {
  static void showCommonSnackBar(
    BuildContext context, {
    String content = "null",
    Color color = Colors.purple,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
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
