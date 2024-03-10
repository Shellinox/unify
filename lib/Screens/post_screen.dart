import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/widgets/post_tile.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postList = Provider.of<PostProvider>(context).posts;
    return ListView.builder(
      itemCount: postList.length,
      itemBuilder: ((context, postIndex) {
        final post = postList[postIndex];
        return PostTile(
          imgPath: post['profilePic'],
          heading: post['heading'],
          content: post['content'],
          date: post['date'],
          postIndex: postIndex,
        );
      }),
    );
  }
}
