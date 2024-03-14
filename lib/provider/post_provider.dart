import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final posts = FirebaseFirestore.instance.collection("Posts");

  void addPost(Map<String, dynamic> post) async {
    await posts.add(post);
    notifyListeners();
  }

  void deletePost(Map<String, dynamic> post, String postID) {
    posts.doc(postID).delete();
    notifyListeners();
  }


  // void addComment(Map<String, dynamic> comment, String postID) {
  //   posts.doc(postID).set();
  //   notifyListeners();
  // }
}
