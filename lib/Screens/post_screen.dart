import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/provider/theme_provider.dart';
import 'package:unify/widgets/post_tile.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postList = Provider.of<PostProvider>(context).posts;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        forceMaterialTransparency: true,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: themeProvider.isDarkMode
                ? const Icon(
                    Icons.dark_mode_rounded,
                    size: 20,
                  )
                : const Icon(
                    Icons.light_mode,
                    size: 20,
                  ),
          )
        ],
      ),
      body: postList.isEmpty
          ? const Center(
              child: Text("no posts"),
            )
          : ListView.builder(
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
            ),
    );
  }
}
