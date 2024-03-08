import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/widgets/saved_post_tile.dart';

class SavedPosts extends StatefulWidget {
  const SavedPosts({super.key});

  @override
  State<SavedPosts> createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {
  @override
  Widget build(BuildContext context) {
    final savedPostList = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Posts"),
        centerTitle: true,
      ),
      body: savedPostList.savedPosts.isEmpty
          ? const Center(
              child: Text("No saved posts"),
            )
          : ListView.builder(
              itemCount: savedPostList.savedPosts.length,
              itemBuilder: ((context, index) {
                final post = savedPostList.savedPosts[index];
                return SavedPostTile(
                  imgPath: post!['profilePic'],
                  heading: post['heading'],
                  content: post['content'],
                  date: post['date'],
                );
              }),
            ),
    );
  }
}
