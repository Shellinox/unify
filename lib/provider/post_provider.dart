import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final Map<int, Map<String, dynamic>> savedPosts = {};

  final List<Map<String, dynamic>> posts = [
    {
      "profilePic": "lib/assets/images/profile.jpg",
      "date": DateTime.now(),
      "heading": "This is the heading of the post",
      "content":
          "i college students and no one else. In this app you can post text based posts anonymously about any topic you like.There will be a screen where all posts will be displayed, a screen where polls will be displayed, a contact developer screen and a make post/poll screen.",
      "isSaved": false,
      "dislikeCount": 0,
      "likeCount": 0,
      "isLiked": false,
      "isDisliked": false,
      "comments": []
    },
  ];

  void addPost(Map<String, dynamic> post) {
    posts.add(post);
    notifyListeners();
  }

  void deletePost(Map<String, dynamic> post, int postIndex) {
    posts.removeAt(postIndex);
    notifyListeners();
  }

  void addComment(Map<String, dynamic> comment, int postIndex) {
    posts[postIndex]["comments"].add(comment);
    notifyListeners();
  }

  void deleteComment(
      Map<String, dynamic> comment, int postIndex, int commmentIndex) {
    posts[postIndex]["comments"].removeAt(commmentIndex);
    notifyListeners();
  }

  void likeComment(int postIndex, int commentIndex) {
    posts[postIndex]["comments"][commentIndex]["isCommentLiked"] =
        !posts[postIndex]["comments"][commentIndex]["isCommentLiked"];
    notifyListeners();
  }

  void likePost(int index) {
    posts[index]["isLiked"] = !posts[index]["isLiked"];
    if (posts[index]["isLiked"]) {
      posts[index]["likeCount"]++;
    } else {
      posts[index]["likeCount"]--;
    }

    notifyListeners();
  }

  void dislikePost(int index) {
    posts[index]["isDisliked"] = !posts[index]["isDisliked"];
    if (posts[index]["isDisliked"]) {
      posts[index]["dislikeCount"]++;
    } else {
      posts[index]["dislikeCount"]--;
    }

    notifyListeners();
  }
}
