import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/history/controller/my_history_controller.dart';

class MyPostsScreen extends ConsumerStatefulWidget {
  const MyPostsScreen({super.key});

  @override
  ConsumerState<MyPostsScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<MyPostsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final feedRefR = ref.read(myPostController);
      await feedRefR.fetchMyPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedRef = ref.watch(myPostController);
    final feedRefR = ref.read(myPostController);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("My Posts", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      // body: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Expanded(
      //         child: RefreshIndicator(
      //           onRefresh: () async {
      //             await feedRefR.fetchMyPosts();
      //           },
      //           child: feedRef.isFetchMyPostLoading == true
      //               ? Center(
      //                   child: CircularProgressIndicator(
      //                     color: CommonColors.primaryColor,
      //                   ),
      //                 )
      //               : feedRef.myPosts.isEmpty
      //               ? Center(child: Text("No posts available right now"))
      //               : ListView.builder(
      //                   itemCount: feedRef.myPosts.length,
      //                   itemBuilder: (context, index) {
      //                     return Padding(
      //                       padding: EdgeInsets.symmetric(vertical: 10),
      //                       child: Container(
      //                         height: 200,
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(8),
      //                           border: Border.all(
      //                             color: CommonColors.greyColor,
      //                           ),
      //                         ),
      //                         child: Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child: Column(
      //                             spacing: 10,
      //                             children: [
      //                               Row(
      //                                 spacing: 10,
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.spaceBetween,
      //                                 children: [
      //                                   Row(
      //                                     children: [
      //                                       CircleAvatar(
      //                                         backgroundColor:
      //                                             CommonColors.lightGreyColor,
      //                                         child: Icon(Icons.person_outline),
      //                                       ),
      //                                       Expanded(
      //                                         child: Text(
      //                                           feedRef.myPosts[index].postedBy,
      //                                           maxLines: 1,
      //                                           overflow: TextOverflow.ellipsis,
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                   Icon(Icons.delete_outline),
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
      //                                       Text(feedRef.myPosts[index].type),
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
      //                                       Text(
      //                                         feedRef.myPosts[index].position,
      //                                       ),
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
      //                                       Text(
      //                                         feedRef.myPosts[index].futsalName,
      //                                       ),
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
      //                                       Text(
      //                                         feedRef.myPosts[index].location,
      //                                       ),
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
      //                                       Text(
      //                                         feedRef.myPosts[index].contactNo,
      //                                       ),
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
      //                                       Text(
      //                                         feedRef
      //                                             .myPosts[index]
      //                                             .noOfPlayers,
      //                                       ),
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
      //                                       Text(
      //                                         feedRef.myPosts[index].gameTime,
      //                                       ),
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
      //                                       Text(
      //                                         feedRef.myPosts[index].skillLevel,
      //                                       ),
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
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
