import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/dashboard/data/dropdown_list.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: screenHeight * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          spacing: 15,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Post Requirements",
                  style: TextStyle(color: CommonColors.primaryColor),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel_outlined),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text("Type"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton(
                        value: "opponent",
                        underline: SizedBox.shrink(),
                        items: [
                          DropdownMenuItem(
                            value: "opponent",
                            child: Text(DropdownList.type[0]),
                          ),
                          DropdownMenuItem(
                            value: "teammate",
                            child: Text(DropdownList.type[0]),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    Text("Position"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton(
                          value: "midfielder",
                          underline: SizedBox.shrink(),
                          items: [
                            DropdownMenuItem(
                              value: "goalkeeper",
                              child: Text(DropdownList.futsalPositions[0]),
                            ),
                            DropdownMenuItem(
                              value: "defender",
                              child: Text(DropdownList.futsalPositions[1]),
                            ),
                            DropdownMenuItem(
                              value: "winger",
                              child: Text(DropdownList.futsalPositions[2]),
                            ),
                            DropdownMenuItem(
                              value: "midfielder",
                              child: Text(DropdownList.futsalPositions[3]),
                            ),
                            DropdownMenuItem(
                              value: "pivot",
                              child: Text(DropdownList.futsalPositions[4]),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text("Futsal Name"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("Location"),
                    ),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton(
                          value: "koteshwor",
                          underline: SizedBox.shrink(),
                          items: [
                            DropdownMenuItem(
                              value: "koteshwor",
                              child: Text(DropdownList.availiableAddresses[0]),
                            ),
                            DropdownMenuItem(
                              value: "tinkune",
                              child: Text(DropdownList.availiableAddresses[1]),
                            ),
                            DropdownMenuItem(
                              value: "shankhamul",
                              child: Text(DropdownList.availiableAddresses[2]),
                            ),
                            DropdownMenuItem(
                              value: "jadibuti",
                              child: Text(DropdownList.availiableAddresses[3]),
                            ),
                            DropdownMenuItem(
                              value: "lokanthali",
                              child: Text(DropdownList.availiableAddresses[4]),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text("Contact Number"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    Text("Skill Level"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton(
                          value: "low",
                          underline: SizedBox.shrink(),
                          items: [
                            DropdownMenuItem(
                              value: "low",
                              child: Text(DropdownList.skillLevel[0]),
                            ),
                            DropdownMenuItem(
                              value: "medium",
                              child: Text(DropdownList.skillLevel[1]),
                            ),
                            DropdownMenuItem(
                              value: "high",
                              child: Text(DropdownList.skillLevel[2]),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: screenHeight * 0.05,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text("Post", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
