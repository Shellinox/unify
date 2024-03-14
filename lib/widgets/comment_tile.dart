import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    super.key,
    required this.comment,
    required this.date,
    required this.commentBy,
  });
  final String comment;
  final String date;
  final String commentBy;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      leading: const CircleAvatar(
        backgroundImage: AssetImage("lib/assets/images/profile.jpg"),
      ),
      title: Text(comment,
          style:
              Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14,fontWeight: FontWeight.w600)),
      subtitle: Text(date),
    );
  }
}
