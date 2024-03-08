import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/widgets/post_tile.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final postList = Provider.of<PostProvider>(context).posts;
    return ListView.builder(
      itemCount: postList.length,
      itemBuilder: ((context, index) {
        final post = postList[index];
        return PostTile(
          imgPath: post['profilePic'],
          heading: post['heading'],
          content: post['content'],
          date: post['date'],
          index: index,
        );
      }),
    );
  }
}
