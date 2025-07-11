import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/features/auth/data/loggedinstate_sharedpref.dart';
import 'package:futsalmate/features/feed/data/post_item_model.dart';
import 'dart:developer' as logger;

class MyPostsModel extends ChangeNotifier {
  List<PostItemModel> myPosts = [];
  bool isFetchMyPostLoading = false;

  Future<void> fetchMyPosts() async {
    isFetchMyPostLoading = true;
    notifyListeners();

    try {
      final sharedPref = LoggedinstateSharedpref();
      final uid = await sharedPref.getUserUid();

      logger.log("passed uid: $uid");

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: uid)
          .get();

      myPosts = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PostItemModel(
          docId: doc.id,
          uid: data["uid"] ?? '',
          postedBy: data["postedBy"] as String? ?? 'Unknown',
          gameTime: data["gameTime"] ?? '',
          type: data["type"] ?? '',
          noOfPlayers: data["noOfPlayers"] ?? '',
          futsalName: data["futsalName"] ?? '',
          location: data["location"] ?? '',
          contactNo: data["contactNo"] ?? '',
          skillLevel: data["skillLevel"] ?? '',
          position: data["position"] ?? '',
        );
      }).toList();
      logger.log("myPosts: $myPosts");
    } catch (e) {
      logger.log("Error fetching posts: $e");
      myPosts = []; // Clear posts on error
    } finally {
      isFetchMyPostLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePost(String docId) async {
    await FirebaseFirestore.instance.collection('posts').doc(docId).delete();

    myPosts.removeWhere((doc) => doc.docId == docId);
    notifyListeners();
  }
}
