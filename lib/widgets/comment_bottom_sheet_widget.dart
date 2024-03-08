import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/comment_provider.dart';
import 'package:unify/widgets/comment_tile.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
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
            child: commentProvider.comments.isEmpty
                ? const Center(
                    child: Text("No comments"),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount: commentProvider.comments.length,
                      itemBuilder: (context, idx) {
                        return CommentTile(
                          comment: commentProvider.comments[idx]['comment'],
                          date: commentProvider.comments[idx]['time'],
                          isLiked: commentProvider.comments[idx]["isLiked"],
                          index: idx,
                        );
                      },
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              padding: MediaQuery.of(context).viewInsets,
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add a comment",
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  suffix: IconButton(
                    onPressed: () {
                      commentProvider.addComment({
                        "comment": commentController.text,
                        "time": DateTime.now(),
                        "isLiked": false
                      });
                      commentController.clear();
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
