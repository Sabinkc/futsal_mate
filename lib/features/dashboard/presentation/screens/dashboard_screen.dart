import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/dashboard/presentation/widgets/post_screen.dart';
import 'package:futsalmate/features/feed/domain/feed_controller.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final feedRefR = ref.read(feedController);
      await feedRefR.fetchPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final feedRef = ref.watch(feedController);
    final feedRefR = ref.read(feedController);
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
                onRefresh: () async {
                  await feedRefR.fetchPosts();
                },
                child: feedRef.isFetchPostLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: CommonColors.primaryColor,
                        ),
                      )
                    : feedRef.posts.isEmpty
                    ? Center(child: Text("No posts available right now"))
                    : ListView.builder(
                        itemCount: feedRef.posts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: CommonColors.greyColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              CommonColors.lightGreyColor,
                                          child: Icon(Icons.person_outline),
                                        ),
                                        Expanded(
                                          child: Text(
                                            feedRef.posts[index].postedBy,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      spacing: 5,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Type:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(feedRef.posts[index].type),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Position:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(feedRef.posts[index].position),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      spacing: 5,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Futsal Name:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              feedRef.posts[index].futsalName,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Location:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(feedRef.posts[index].location),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      spacing: 5,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Contact:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              feedRef.posts[index].contactNo,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "No of players:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              feedRef.posts[index].noOfPlayers,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      spacing: 5,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Game Time:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(feedRef.posts[index].gameTime),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Skill Level:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              feedRef.posts[index].skillLevel,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
}
