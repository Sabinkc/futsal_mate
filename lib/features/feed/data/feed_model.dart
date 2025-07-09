import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
}
