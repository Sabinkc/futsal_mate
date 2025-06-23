import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Center(
        child: Image.network(
          'https://drive.google.com/uc?export=view&id=1gpR8826VzQchyND3QKZl7Q4KemEMYEAt',
        ),
      ),
    );
  }
}
