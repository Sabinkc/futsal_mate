// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:futsalmate/common/colors.dart';
// import 'package:futsalmate/features/history/controller/my_history_controller.dart';

// class MyPostsScreen extends ConsumerStatefulWidget {
//   const MyPostsScreen({super.key});

//   @override
//   ConsumerState<MyPostsScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends ConsumerState<MyPostsScreen> {
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () async {
//       final feedRefR = ref.read(myPostController);
//       await feedRefR.fetchMyPosts();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final feedRef = ref.watch(myPostController);
//     final feedRefR = ref.read(myPostController);
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: Text("My Posts", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: CommonColors.primaryColor,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: () async {
//                   await feedRefR.fetchMyPosts();
//                 },
//                 child: feedRef.isFetchMyPostLoading == true
//                     ? Center(
//                         child: CircularProgressIndicator(
//                           color: CommonColors.primaryColor,
//                         ),
//                       )
//                     : feedRef.myPosts.isEmpty
//                     ? Center(child: Text("No posts available right now"))
//                     : ListView.builder(
//                         itemCount: feedRef.myPosts.length,
//                         itemBuilder: (context, index) {
//                           // return Text("hello");
//                           return Padding(
//                             padding: EdgeInsets.symmetric(vertical: 10),
//                             child: Container(
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   color: CommonColors.greyColor,
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   spacing: 10,
//                                   children: [
//                                     Row(
//                                       spacing: 10,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           spacing: 10,
//                                           children: [
//                                             CircleAvatar(
//                                               backgroundColor:
//                                                   CommonColors.lightGreyColor,
//                                               child: Icon(Icons.person_outline),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].postedBy
//                                                   .toString(),
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ],
//                                         ),
//                                         InkWell(
//                                           onTap: () async {
//                                             await feedRefR.deletePost(
//                                               feedRef.myPosts[index].docId!,
//                                             );
//                                           },
//                                           child: Icon(Icons.delete_outline),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       spacing: 5,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Type:",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].type
//                                                   .toString(),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Position:",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].position
//                                                   .toString(),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       spacing: 5,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Futsal Name:",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].futsalName
//                                                   .toString(),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Location:",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].location
//                                                   .toString(),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       spacing: 5,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Contact:",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].contactNo
//                                                   .toString(),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "No of players:",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].noOfPlayers
//                                                   .toString(),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       spacing: 5,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Game Time:",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].gameTime
//                                                   .toString(),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "Skill Level:",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               feedRef.myPosts[index].skillLevel
//                                                   .toString(),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/common/utils.dart';
import 'package:futsalmate/features/history/controller/my_history_controller.dart';

class MyPostsScreen extends ConsumerStatefulWidget {
  const MyPostsScreen({super.key});

  @override
  ConsumerState<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends ConsumerState<MyPostsScreen> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text("My Posts", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Posts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Manage your futsal posts",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await feedRefR.fetchMyPosts();
                },
                child: feedRef.isFetchMyPostLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: CommonColors.primaryColor,
                        ),
                      )
                    : feedRef.myPosts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.post_add,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "No posts available",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Create your first post to find players!",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: feedRef.myPosts.length,
                        itemBuilder: (context, index) {
                          final post = feedRef.myPosts[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header with user info and delete button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: CommonColors.primaryColor
                                                .withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            size: 20,
                                            color: CommonColors.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          post.postedBy,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final confirmed = await showDialog<bool>(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text("Delete Post"),
                                            content: const Text(
                                              "Are you sure you want to delete this post?",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(
                                                  ctx,
                                                ).pop(false),
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(ctx).pop(true),
                                                child: const Text("Delete"),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirmed == true) {
                                          await feedRefR.deletePost(
                                            post.docId!,
                                          );
                                          if (context.mounted) {
                                            Utils.showCommonSnackBar(
                                              context,
                                              content:
                                                  "Post deleted successfully",
                                              color: CommonColors.primaryColor,
                                            );
                                          }
                                          // Reload posts after deletion
                                          await feedRefR.fetchMyPosts();
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.delete_outline,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Post details in two columns
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left Column
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildDetailItem(
                                            icon: Icons.sports_soccer,
                                            label: "Type",
                                            value: post.type,
                                          ),
                                          const SizedBox(height: 8),
                                          _buildDetailItem(
                                            icon: Icons.location_on,
                                            label: "Location",
                                            value: post.location,
                                          ),
                                          const SizedBox(height: 8),
                                          _buildDetailItem(
                                            icon: Icons.schedule,
                                            label: "Game Time",
                                            value: post.gameTime,
                                          ),
                                          if (post.position.isNotEmpty) ...[
                                            const SizedBox(height: 8),
                                            _buildDetailItem(
                                              icon: Icons.sports,
                                              label: "Position",
                                              value: post.position,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    // Right Column
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildDetailItem(
                                            icon: Icons.people,
                                            label: "Players",
                                            value: post.noOfPlayers,
                                          ),
                                          const SizedBox(height: 8),
                                          _buildDetailItem(
                                            icon: Icons.star,
                                            label: "Skill Level",
                                            value: post.skillLevel,
                                          ),
                                          const SizedBox(height: 8),
                                          _buildDetailItem(
                                            icon: Icons.phone,
                                            label: "Contact",
                                            value: post.contactNo,
                                          ),
                                          const SizedBox(height: 8),
                                          _buildDetailItem(
                                            icon: Icons.place,
                                            label: "Futsal",
                                            value: post.futsalName,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: CommonColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: CommonColors.primaryColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
