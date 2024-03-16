import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final posts = FirebaseFirestore.instance.collection("Posts");
  int count = 0;

  void addPost(Map<String, dynamic> post) async {
    await posts.add(post);
    notifyListeners();
  }

  void deletePost(Map<String, dynamic> post, String postID) {
    posts.doc(postID).delete();
    notifyListeners();
  }

  int getCount(String postID) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postID)
        .collection("Comments").snapshots().length;
    notifyListeners();
    return count;
  }
}
