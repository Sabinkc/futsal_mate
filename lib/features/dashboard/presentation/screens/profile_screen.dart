import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/common/common_textfiled.dart';
import 'package:futsalmate/common/utils.dart';
import 'package:futsalmate/features/dashboard/data/dropdown_list.dart';
import 'package:futsalmate/features/dashboard/domain/profile_controller.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final profileRef = ref.read(profileProvider);
      profileRef.clearProfileProvider();
      await profileRef.getProfile();
      userNameController.text = profileRef.profile.userName;
      phoneController.text = profileRef.profile.phone;
      ageController.text = profileRef.profile.age;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final profileProviderRef = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          spacing: screenHeight * 0.02,
          children: [
            CommonTextField(
              controller: userNameController,
              labelName: "User Name",
            ),

            CommonTextField(
              controller: phoneController,
              labelName: "Phone Number",
            ),
            CommonTextField(controller: ageController, labelName: "Age"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CommonColors.greyColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location:',
                    style: TextStyle(
                      // color: CommonColors.greyColor,
                      fontSize: 18,
                    ),
                  ),
                  DropdownButton(
                    focusColor: Colors.black,
                    underline: SizedBox.shrink(),
                    elevation: 0,
                    style: TextStyle(
                      color: CommonColors.greyColor,

                      fontSize: 18,
                    ),
                    value: profileProviderRef.location,
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
                      ref.read(profileProvider).updateLocation(value!);
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CommonColors.greyColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Position:',
                    style: TextStyle(
                      // color: CommonColors.greyColor,
                      fontSize: 18,
                    ),
                  ),
                  DropdownButton(
                    focusColor: Colors.black,
                    underline: SizedBox.shrink(),
                    elevation: 0,
                    style: TextStyle(
                      color: CommonColors.greyColor,

                      fontSize: 18,
                    ),
                    value: profileProviderRef.futsalPosition,
                    items: [
                      DropdownMenuItem(value: "", child: Text("Not set yet")),
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
                      ref.read(profileProvider).updatePosition(value!);
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CommonColors.greyColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Skill Level:',
                    style: TextStyle(
                      // color: CommonColors.greyColor,
                      fontSize: 18,
                    ),
                  ),
                  DropdownButton(
                    focusColor: Colors.black,
                    underline: SizedBox.shrink(),
                    elevation: 0,
                    style: TextStyle(
                      color: CommonColors.greyColor,

                      fontSize: 18,
                    ),
                    value: profileProviderRef.skillLevel,
                    items: [
                      DropdownMenuItem(value: "", child: Text("Not set yet")),
                      DropdownMenuItem(
                        value: "low",
                        child: Text(DropdownList.skillLevel[0]),
                      ),
                      DropdownMenuItem(
                        value: "mid",
                        child: Text(DropdownList.skillLevel[1]),
                      ),
                      DropdownMenuItem(
                        value: "high",
                        child: Text(DropdownList.skillLevel[2]),
                      ),
                    ],
                    onChanged: (value) {
                      ref.read(profileProvider).updateSkillLevel(value!);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.055,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  try {
                    await profileProviderRef.updateProfile(
                      userNameController.text.trim(),
                      phoneController.text.trim(),
                      ageController.text.trim(),
                      profileProviderRef.location,
                      profileProviderRef.futsalPosition,
                      profileProviderRef.skillLevel,
                    );
                    if (context.mounted) {
                      Navigator.pop(context);
                      Utils.showCommonSnackBar(
                        context,
                        content: "Profile updated successully!",
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Utils.showCommonSnackBar(
                        context,
                        color: CommonColors.errorColor,
                        content: e.toString(),
                      );
                    }
                  }
                },
                child: profileProviderRef.isUpdateProfileLoading == true
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Save changes",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
