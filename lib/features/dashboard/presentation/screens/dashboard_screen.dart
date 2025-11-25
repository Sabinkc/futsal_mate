// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:futsalmate/common/colors.dart';
// import 'package:futsalmate/features/booking/model/location_shared_pref.dart';
// import 'package:futsalmate/features/dashboard/domain/location_controller.dart';
// import 'package:futsalmate/features/dashboard/presentation/widgets/post_screen.dart';
// import 'package:futsalmate/features/feed/domain/feed_controller.dart';
// import 'package:geolocator/geolocator.dart';

// class DashboardScreen extends ConsumerStatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends ConsumerState<DashboardScreen> {
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () async {
//       final feedRefR = ref.read(feedController);
//       await feedRefR.fetchPosts();
//       final locRefR = ref.read(locationController);
//       Position? position = await getCurrentLocation();

//       if (position != null) {
//         LocationSharedPref.setLocation(
//           position.latitude.toString(),
//           position.longitude.toString(),
//         );
//         locRefR.updateLocation(
//           position.latitude.toString(),
//           position.longitude.toString(),
//         );
//       } else {
//         LocationSharedPref.setLocation("27.7", "85.3");
//       }
//     });
//     super.initState();
//   }

//   Future<Position?> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled
//       return Future.error('Location services are disabled.');
//     }

//     // Check location permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever
//       return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.',
//       );
//     }

//     // Get the current location
//     return await Geolocator.getCurrentPosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final feedRef = ref.watch(feedController);
//     final feedRefR = ref.read(feedController);
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
//                 onRefresh: () async {
//                   await feedRefR.fetchPosts();
//                 },
//                 child: feedRef.isFetchPostLoading == true
//                     ? Center(
//                         child: CircularProgressIndicator(
//                           color: CommonColors.primaryColor,
//                         ),
//                       )
//                     : feedRef.posts.isEmpty
//                     ? Center(child: Text("No posts available right now"))
//                     : ListView.builder(
//                         itemCount: feedRef.posts.length,
//                         itemBuilder: (context, index) {
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
//                                       children: [
//                                         CircleAvatar(
//                                           backgroundColor:
//                                               CommonColors.lightGreyColor,
//                                           child: Icon(Icons.person_outline),
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             feedRef.posts[index].postedBy,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
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
//                                             Text(feedRef.posts[index].type),
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
//                                             Text(feedRef.posts[index].position),
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
//                                               feedRef.posts[index].futsalName,
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
//                                             Text(feedRef.posts[index].location),
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
//                                               feedRef.posts[index].contactNo,
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
//                                               feedRef.posts[index].noOfPlayers,
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
//                                             Text(feedRef.posts[index].gameTime),
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
//                                               feedRef.posts[index].skillLevel,
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
import 'package:futsalmate/features/booking/model/location_shared_pref.dart';
import 'package:futsalmate/features/dashboard/domain/location_controller.dart';
import 'package:futsalmate/features/dashboard/presentation/widgets/post_screen.dart';
import 'package:futsalmate/features/feed/domain/feed_controller.dart';
import 'package:geolocator/geolocator.dart';

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
      final locRefR = ref.read(locationController);
      Position? position = await getCurrentLocation();

      if (position != null) {
        LocationSharedPref.setLocation(
          position.latitude.toString(),
          position.longitude.toString(),
        );
        locRefR.updateLocation(
          position.latitude.toString(),
          position.longitude.toString(),
        );
      } else {
        LocationSharedPref.setLocation("27.7", "85.3");
      }
    });
    super.initState();
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // Get the current location
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final feedRef = ref.watch(feedController);
    final feedRefR = ref.read(feedController);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Requirements Button
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const PostScreen(),
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: CommonColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: CommonColors.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Post Requirements",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Feed Title
            const Text(
              "Recent Posts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Find players and teams near you",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // Posts List
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
                              "Be the first to post requirements!",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: feedRef.posts.length,
                        itemBuilder: (context, index) {
                          final post = feedRef.posts[index];
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
                                // Header with user info
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
                                    Expanded(
                                      child: Text(
                                        post.postedBy,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
