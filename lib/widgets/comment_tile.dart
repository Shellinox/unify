import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/post_provider.dart';

class CommentTile extends StatelessWidget {
  const CommentTile(
      {super.key,
      required this.comment,
      required this.date,
      required this.isLiked,
      required this.commentIndex, required this.postIndex});
  final String comment;
  final DateTime date;
  final bool isLiked;
  final int commentIndex;
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return ListTile(
      onTap: () {
       postProvider.likeComment(postIndex, commentIndex);
      },
      titleAlignment: ListTileTitleAlignment.center,
      leading: const CircleAvatar(
        backgroundImage: AssetImage("lib/assets/images/profile.jpg"),
      ),
      title: Text(comment),
      subtitle: Text(date.toString()),
      trailing: postProvider.posts[postIndex]["comments"][commentIndex]["isCommentLiked"]
          ? const Icon(
              Icons.favorite_rounded,
              size: 15,
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_outline_rounded,
              size: 15,
            ),
    );
  }
}
