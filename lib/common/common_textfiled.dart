import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';

class CommonTextField extends StatelessWidget {
  final String labelName;
  final TextEditingController controller;
  const CommonTextField({
    super.key,
    required this.labelName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        // hintText: hintText,
        label: Text(labelName),
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
