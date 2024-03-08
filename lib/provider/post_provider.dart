import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final Map<int, Map<String,dynamic>> savedPosts = {};

  final List<Map<String, dynamic>> posts = [
    {
      "profilePic": "lib/assets/images/profile.jpg",
      "date": DateTime.now(),
      "heading": "This is the heading of the post",
      "content":
          "i college students and no one else. In this app you can post text based posts anonymously about any topic you like.There will be a screen where all posts will be displayed, a screen where polls will be displayed, a contact developer screen and a make post/poll screen.",
      "isSaved": false,
      "saveCount": 0,
      "likeCount": 0,
      "isLiked": false
    },
  ];

  void addPost(Map<String, dynamic> post) {
    posts.add(post);
    notifyListeners();
  }

  void deletePost(Map<String, dynamic> post) {
    posts.remove(post);
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

  void savePost(int index) {
    posts[index]["isSaved"] = !posts[index]["isSaved"];
    if (posts[index]["isSaved"]) {
      posts[index]["saveCount"]++;
    } else {
      posts[index]["saveCount"]--;
    }
    notifyListeners();
  }

  void addsavePosts(Map<String, dynamic> post, int index) {
    if (posts[index]["isSaved"]) {
      savedPosts[index] = post;
    } else {
      savedPosts.remove(index);
    }
    notifyListeners();
  }
}
