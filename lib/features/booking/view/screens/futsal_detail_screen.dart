import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';

class FutsalDetailScreen extends StatelessWidget {
  const FutsalDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final heigt = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("Futsal Details", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/futsal.jpeg",
            height: heigt * 0.3,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Elite Futsal"),
                Text("Location: Shankhamul"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Fee: Rs.1000"), Text("Rating: 4.1")],
                ),
                SizedBox(height: 10),
                Text("Availability:"),
                Text("Today"),

                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text("7 A.M. - 8 A.M.")),
                        ),
                      );
                    },
                  ),
                ),
                Text("Tomorrow"),

                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text("7 A.M. - 8 A.M.")),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: Text("Book")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
