import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsalmate/features/feed/data/post_item_model.dart';
import 'dart:developer' as logger;

class FeedModel extends ChangeNotifier {
  bool isPosting = false;

  Future post(
    String uid,
    String postedBy,
    String gameTime,
    String type,
    String noOfPlayers,
    String futsalName,
    String location,
    String contactNo,
    String skillLevel,
    String position,
  ) async {
    isPosting = true;
    notifyListeners();
    await FirebaseFirestore.instance.collection("posts").add({
      "uid": uid,
      "postedBy": postedBy,
      "gameTime": gameTime,
      "type": type,
      "noOfPlayers": noOfPlayers,
      "futsalName": futsalName,
      "location": location,
      "contactNo": contactNo,
      "skillLevel": skillLevel,
      "position": position,
      "timeStamp": FieldValue.serverTimestamp(),
    });
    isPosting = false;
    notifyListeners();
  }

  List<PostItemModel> posts = [];
  bool isFetchPostLoading = false;

  Future<void> fetchPosts() async {
    isFetchPostLoading = true;
    notifyListeners();
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection("posts")
          .orderBy("timeStamp", descending: true)
          .get();

      posts = query.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PostItemModel(
          uid: data["uid"],
          postedBy: data["postedBy"] as String,
          gameTime: data["gameTime"],
          type: data["type"],
          noOfPlayers: data["noOfPlayers"],
          futsalName: data["futsalName"],
          location: data["location"],
          contactNo: data["contactNo"],
          skillLevel: data["skillLevel"],
          position: data["position"],
        );
      }).toList();
      logger.log("posts: $posts");
    } catch (e) {
      logger.log(e.toString());
    } finally {
      isFetchPostLoading = false;
      notifyListeners();
    }
  }
}
