import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';

class CommonAuthenticationTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  const CommonAuthenticationTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: CommonColors.greyColor),
        hintText: hintText,
        hintStyle: TextStyle(color: CommonColors.greyColor),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CommonColors.greyColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CommonColors.greyColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CommonColors.greyColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CommonColors.primaryColor, width: 1),
        ),
      ),
    );
  }
}
