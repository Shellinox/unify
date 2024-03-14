import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unify/services/date_formatter.dart';
import 'package:unify/widgets/comment_tile.dart';

class CommentSheet extends StatelessWidget {
  CommentSheet({super.key, required this.postID});
  final String postID;
  final currentUser = FirebaseAuth.instance.currentUser!;
  void addComment(String comment) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postID)
        .collection("Comments")
        .add({
      "Comment": comment,
      "Comment by": currentUser.email,
      "time": Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Comments",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc(postID)
                      .collection("Comments")
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
          
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((doc) {
                        final commentData = doc.data();
                        return CommentTile(
                          comment: commentData["Comment"],
                          date: formatDate(commentData["time"]),
                          commentBy: commentData["Comment by"],
                        );
                      }).toList(),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              padding: MediaQuery.of(context).viewInsets,
              child: TextField(
                autofocus: true,
                controller: commentController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add a comment",
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  suffix: IconButton(
                    onPressed: () {
                      if (commentController.text.toString().isNotEmpty) {
                        addComment(commentController.text.toString());
                        commentController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
