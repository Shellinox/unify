import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/widgets/comment_tile.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet(
      {super.key, required this.postIndex});
  final int postIndex;


  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
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
            child: postProvider.posts[postIndex]["comments"].isEmpty
                ? const Center(
                    child: Text("No comments"),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount:
                          postProvider.posts[postIndex]["comments"].length,
                      itemBuilder: (context, commentIndex) {
                        return CommentTile(
                          comment: postProvider.posts[postIndex]["comments"]
                              [commentIndex]["comment"],
                          date: postProvider.posts[postIndex]["comments"]
                              [commentIndex]["date"],
                          isLiked: postProvider.posts[postIndex]["comments"]
                              [commentIndex]["isCommentLiked"],
                          commentIndex: commentIndex,
                          postIndex: postIndex,
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
                      final comment = {
                        "comment":commentController.text,
                        "date":DateTime.now(),
                        "isCommentLiked":false
                      };
                      postProvider.addComment(comment, postIndex);
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
