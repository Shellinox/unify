import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> comments = [];
  void addComment(Map<String, dynamic> comment) {
    comments.add(comment);
    notifyListeners();
  }

  void deleteComment(Map<String, dynamic> comment) {
    comments.remove(comment);
    notifyListeners();
  }

  void likeUnlikeComment(int index) {
    comments[index]["isLiked"] = !comments[index]["isLiked"];
    notifyListeners();
  }
}
