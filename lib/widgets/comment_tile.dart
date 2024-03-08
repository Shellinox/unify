import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/comment_provider.dart';

class CommentTile extends StatelessWidget {
  const CommentTile(
      {super.key,
      required this.comment,
      required this.date,
      required this.isLiked,
      required this.index});
  final String comment;
  final DateTime date;
  final bool isLiked;
  final int index;

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    return ListTile(
      onTap: () {
        commentProvider.likeUnlikeComment(index);
      },
      titleAlignment: ListTileTitleAlignment.center,
      leading: const CircleAvatar(
        backgroundImage: AssetImage("lib/assets/images/profile.jpg"),
      ),
      title: Text(comment),
      subtitle: Text(date.toString()),
      trailing: commentProvider.comments[index]["isLiked"]
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
