// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:futsalmate/common/colors.dart';
// import 'package:futsalmate/common/utils.dart';
// import 'package:futsalmate/features/dashboard/data/dropdown_list.dart';
// import 'package:futsalmate/features/feed/domain/feed_controller.dart';

// class PostScreen extends ConsumerStatefulWidget {
//   const PostScreen({super.key});

//   @override
//   ConsumerState<PostScreen> createState() => _PostScreenState();
// }

// class _PostScreenState extends ConsumerState<PostScreen> {
//   final TextEditingController postedByController = TextEditingController();
//   final TextEditingController gameTimeController = TextEditingController();
//   final TextEditingController noOfPlayersController = TextEditingController();
//   final TextEditingController futslaNameController = TextEditingController();
//   final TextEditingController contactNoController = TextEditingController();

//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () {
//       final postRefR = ref.read(postController);
//       postRefR.resetType();
//       postRefR.resetLocation();
//       postRefR.resetSillLevel();
//       postRefR.resetPosition();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final feedRef = ref.watch(feedController);
//     final feedRefR = ref.read(feedController);
//     final postRef = ref.watch(postController);
//     final postRefR = ref.read(postController);
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.white,
//       ),
//       height: screenHeight * 0.8,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           spacing: 15,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Post Requirements",
//                   style: TextStyle(color: CommonColors.primaryColor),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(Icons.cancel_outlined),
//                   ),
//                 ),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Text("Posted By"),
//                     Container(
//                       width: screenWidth * 0.35,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: CommonColors.greyColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextField(
//                         controller: postedByController,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   spacing: 10,
//                   children: [
//                     Text("Game Time"),
//                     Container(
//                       width: screenWidth * 0.35,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: CommonColors.greyColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextField(
//                         controller: gameTimeController,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Text("Type"),
//                     Container(
//                       width: screenWidth * 0.35,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: CommonColors.greyColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: DropdownButton(
//                         value: postRef.selectedType,
//                         underline: SizedBox.shrink(),
//                         items: [
//                           DropdownMenuItem(
//                             value: "opponent",
//                             child: Text(DropdownList.type[0]),
//                           ),
//                           DropdownMenuItem(
//                             value: "teammate",
//                             child: Text(DropdownList.type[1]),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           postRefR.updateType(value!);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   spacing: 10,
//                   children: [
//                     Text("No of players"),
//                     Container(
//                       width: screenWidth * 0.35,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: CommonColors.greyColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextField(
//                         controller: noOfPlayersController,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Text("Futsal Name"),
//                     Container(
//                       width: screenWidth * 0.35,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: CommonColors.greyColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextField(
//                         controller: futslaNameController,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   spacing: 10,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Text("Location"),
//                     ),
//                     Container(
//                       width: screenWidth * 0.35,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: CommonColors.greyColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: DropdownButton(
//                           value: postRef.selectedLocation,
//                           underline: SizedBox.shrink(),
//                           items: [
//                             DropdownMenuItem(
//                               value: "koteshwor",
//                               child: Text(DropdownList.availiableAddresses[0]),
//                             ),
//                             DropdownMenuItem(
//                               value: "tinkune",
//                               child: Text(DropdownList.availiableAddresses[1]),
//                             ),
//                             DropdownMenuItem(
//                               value: "shankhamul",
//                               child: Text(DropdownList.availiableAddresses[2]),
//                             ),
//                             DropdownMenuItem(
//                               value: "jadibuti",
//                               child: Text(DropdownList.availiableAddresses[3]),
//                             ),
//                             DropdownMenuItem(
//                               value: "lokanthali",
//                               child: Text(DropdownList.availiableAddresses[4]),
//                             ),
//                           ],
//                           onChanged: (value) {
//                             postRefR.updateLocation(value!);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Text("Contact Number"),
//                     Container(
//                       width: screenWidth * 0.35,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: CommonColors.greyColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextField(
//                         controller: contactNoController,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   spacing: 10,
//                   children: [
//                     Text("Skill Level"),
//                     Container(
//                       width: screenWidth * 0.35,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: CommonColors.greyColor),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: DropdownButton(
//                           value: postRef.selectedSkillLevel,
//                           underline: SizedBox.shrink(),
//                           items: [
//                             DropdownMenuItem(
//                               value: "low",
//                               child: Text(DropdownList.skillLevel[0]),
//                             ),
//                             DropdownMenuItem(
//                               value: "medium",
//                               child: Text(DropdownList.skillLevel[1]),
//                             ),
//                             DropdownMenuItem(
//                               value: "high",
//                               child: Text(DropdownList.skillLevel[2]),
//                             ),
//                           ],
//                           onChanged: (value) {
//                             postRefR.updateSkillLevel(value!);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             if (postRef.selectedType == "teammate")
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     spacing: 10,
//                     children: [
//                       Text("Position"),
//                       Container(
//                         width: screenWidth * 0.35,
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: CommonColors.greyColor),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: DropdownButton(
//                             value: postRef.selectedPosition,
//                             underline: SizedBox.shrink(),
//                             items: [
//                               DropdownMenuItem(
//                                 value: "goalkeeper",
//                                 child: Text(DropdownList.futsalPositions[0]),
//                               ),
//                               DropdownMenuItem(
//                                 value: "defender",
//                                 child: Text(DropdownList.futsalPositions[1]),
//                               ),
//                               DropdownMenuItem(
//                                 value: "winger",
//                                 child: Text(DropdownList.futsalPositions[2]),
//                               ),
//                               DropdownMenuItem(
//                                 value: "midfielder",
//                                 child: Text(DropdownList.futsalPositions[3]),
//                               ),
//                               DropdownMenuItem(
//                                 value: "pivot",
//                                 child: Text(DropdownList.futsalPositions[4]),
//                               ),
//                             ],
//                             onChanged: (value) {
//                               postRefR.updatePosition(value!);
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             Spacer(),
//             SizedBox(
//               height: screenHeight * 0.05,
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: CommonColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () async {
//                   if (postedByController.text.trim().isEmpty ||
//                       gameTimeController.text.trim().isEmpty ||
//                       noOfPlayersController.text.trim().isEmpty ||
//                       futslaNameController.text.trim().isEmpty ||
//                       contactNoController.text.trim().isEmpty) {
//                     Utils.showCommonSnackBar(
//                       context,
//                       color: CommonColors.errorColor,
//                       content: "All fields are required",
//                     );
//                     return;
//                   }
//                   try {
//                     final user = FirebaseAuth.instance.currentUser;
//                     final uid = user!.uid;
//                     feedRefR.post(
//                       uid,
//                       postedByController.text.trim(),
//                       gameTimeController.text.trim(),
//                       postRefR.selectedType,
//                       noOfPlayersController.text.trim(),
//                       futslaNameController.text.trim(),
//                       postRefR.selectedLocation,
//                       contactNoController.text.trim(),
//                       postRefR.selectedSkillLevel,
//                       postRefR.selectedPosition,
//                     );

//                     if (context.mounted) {
//                       Navigator.pop(context);
//                       Utils.showCommonSnackBar(
//                         context,
//                         content: "Requirements posted successfully!",
//                         color: CommonColors.primaryColor,
//                       );
//                     }
//                   } catch (e) {
//                     if (context.mounted) {
//                       Utils.showCommonSnackBar(context, content: "$e");
//                     }
//                   } finally {
//                     feedRefR.isPosting = false;
//                   }
//                 },
//                 child: feedRef.isPosting == true
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text("Post", style: TextStyle(color: Colors.white)),
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: screenHeight * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Post Requirements",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CommonColors.primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 20, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 20),

            // Form Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Row 1: Posted By & Game Time
                    _buildFormRow(
                      leftWidget: _buildTextField(
                        "Posted By",
                        postedByController,
                      ),
                      rightWidget: _buildTextField(
                        "Game Time",
                        gameTimeController,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Row 2: Type & No of Players
                    _buildFormRow(
                      leftWidget: _buildDropdown(
                        "Type",
                        postRef.selectedType,
                        [
                          DropdownMenuItem(
                            value: "opponent",
                            child: Text(DropdownList.type[0]),
                          ),
                          DropdownMenuItem(
                            value: "teammate",
                            child: Text(DropdownList.type[1]),
                          ),
                        ],
                        (value) => postRefR.updateType(value!),
                      ),
                      rightWidget: _buildTextField(
                        "No of players",
                        noOfPlayersController,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Row 3: Futsal Name & Location
                    _buildFormRow(
                      leftWidget: _buildTextField(
                        "Futsal Name",
                        futslaNameController,
                      ),
                      rightWidget: _buildDropdown(
                        "Location",
                        postRef.selectedLocation,
                        [
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
                        (value) => postRefR.updateLocation(value!),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Row 4: Contact Number & Skill Level
                    _buildFormRow(
                      leftWidget: _buildTextField(
                        "Contact Number",
                        contactNoController,
                      ),
                      rightWidget: _buildDropdown(
                        "Skill Level",
                        postRef.selectedSkillLevel,
                        [
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
                        (value) => postRefR.updateSkillLevel(value!),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Position (only for teammate)
                    if (postRef.selectedType == "teammate")
                      _buildDropdown(
                        "Position",
                        postRef.selectedPosition,
                        [
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
                        (value) => postRefR.updatePosition(value!),
                      ),
                  ],
                ),
              ),
            ),

            // Post Button
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CommonColors.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (postedByController.text.trim().isEmpty ||
                      gameTimeController.text.trim().isEmpty ||
                      noOfPlayersController.text.trim().isEmpty ||
                      futslaNameController.text.trim().isEmpty ||
                      contactNoController.text.trim().isEmpty) {
                    Utils.showCommonSnackBar(
                      context,
                      color: CommonColors.errorColor,
                      content: "All fields are required",
                    );
                    return;
                  }
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
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Post",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildFormRow({
    required Widget leftWidget,
    required Widget rightWidget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: leftWidget),
        const SizedBox(width: 16),
        Expanded(child: rightWidget),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter $label",
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<DropdownMenuItem<String>> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButton(
            value: value,
            underline: const SizedBox.shrink(),
            isExpanded: true,
            items: items,
            onChanged: onChanged,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
