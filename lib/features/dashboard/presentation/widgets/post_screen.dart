import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/common/utils.dart';
import 'package:futsalmate/features/dashboard/data/dropdown_list.dart';
import 'package:futsalmate/features/feed/domain/feed_controller.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final TextEditingController postedByController = TextEditingController();
  final TextEditingController gameTimeController = TextEditingController();
  final TextEditingController noOfPlayersController = TextEditingController();
  final TextEditingController futslaNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final postRefR = ref.read(postController);
      postRefR.resetType();
      postRefR.resetLocation();
      postRefR.resetSillLevel();
      postRefR.resetPosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedRef = ref.watch(feedController);
    final feedRefR = ref.read(feedController);
    final postRef = ref.watch(postController);
    final postRefR = ref.read(postController);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: screenHeight * 0.8,
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
                    Text("Posted By"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: postedByController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    Text("Game Time"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: gameTimeController,
                        decoration: InputDecoration(border: InputBorder.none),
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
                    Text("Type"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton(
                        value: postRef.selectedType,
                        underline: SizedBox.shrink(),
                        items: [
                          DropdownMenuItem(
                            value: "opponent",
                            child: Text(DropdownList.type[0]),
                          ),
                          DropdownMenuItem(
                            value: "teammate",
                            child: Text(DropdownList.type[1]),
                          ),
                        ],
                        onChanged: (value) {
                          postRefR.updateType(value!);
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    Text("No of players"),
                    Container(
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: noOfPlayersController,
                        decoration: InputDecoration(border: InputBorder.none),
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
                        controller: futslaNameController,
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
                          value: postRef.selectedLocation,
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
                          onChanged: (value) {
                            postRefR.updateLocation(value!);
                          },
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
                        controller: contactNoController,
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
                          value: postRef.selectedSkillLevel,
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
                          onChanged: (value) {
                            postRefR.updateSkillLevel(value!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (postRef.selectedType == "teammate")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          alignment: Alignment.centerLeft,
                          child: DropdownButton(
                            value: postRef.selectedPosition,
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
                            onChanged: (value) {
                              postRefR.updatePosition(value!);
                            },
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
                onPressed: () async {
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    final uid = user!.uid;
                    feedRefR.post(
                      uid,
                      postedByController.text.trim(),
                      gameTimeController.text.trim(),
                      postRefR.selectedType,
                      noOfPlayersController.text.trim(),
                      futslaNameController.text.trim(),
                      postRefR.selectedLocation,
                      contactNoController.text.trim(),
                      postRefR.selectedSkillLevel,
                      postRefR.selectedPosition,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                      Utils.showCommonSnackBar(
                        context,
                        content: "Requirements posted successfully!",
                        color: CommonColors.primaryColor,
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Utils.showCommonSnackBar(context, content: "$e");
                    }
                  } finally {
                    feedRefR.isPosting = false;
                  }
                },
                child: feedRef.isPosting == true
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Post", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
