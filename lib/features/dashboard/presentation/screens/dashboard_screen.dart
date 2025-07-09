// import 'package:flutter/material.dart';
// import 'package:futsalmate/common/colors.dart';
// import 'package:futsalmate/features/dashboard/presentation/widgets/post_screen.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Feed", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: CommonColors.primaryColor,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                   isScrollControlled: true,
//                   context: context,
//                   builder: (context) {
//                     return PostScreen();
//                   },
//                 );
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: screenHeight * 0.05,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: CommonColors.primaryColor),
//                 ),
//                 child: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.add_outlined),
//                       Text("Post Requirements"),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),

//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: () async {},
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10),
//                       child: Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: CommonColors.greyColor),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             spacing: 10,
//                             children: [
//                               Row(
//                                 spacing: 10,
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor:
//                                         CommonColors.lightGreyColor,
//                                     child: Icon(Icons.person_outline),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "John Doe",
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 spacing: 5,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Type:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text("Teammate"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Position:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text("Midfielder"),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 spacing: 5,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Futsal Name:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text("Elite Futsal"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Location:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text("Shankhamul"),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 spacing: 5,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Contact:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text("9812060688"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "No of players:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text("2"),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 spacing: 5,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Game Time:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text("Today, 9:30 A.M."),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "Skill Level:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text("Medium"),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/dashboard/presentation/widgets/post_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return PostScreen();
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: CommonColors.primaryColor),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_outlined),
                      Text("Post Requirements"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('timeStamp', descending: true)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No posts available."));
                    }

                    final posts = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final data =
                            posts[index].data() as Map<String, dynamic>;

                        return ListTile(
                          title: Text(data['futsalName']),
                          subtitle: Text(
                            "Need: ${data['position']} (${data['noOfPlayers']})",
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
