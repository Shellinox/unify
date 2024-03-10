import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/Screens/homepage.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/provider/theme_provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final postController = TextEditingController();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          TextFormField(
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            minLines: null,
            maxLength: 35,
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: context.watch<ThemeProvider>().isDarkMode
                  ? Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white54)
                  : Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54),
              contentPadding: const EdgeInsets.all(16),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 5,
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              maxLength: 180,
              maxLines: null,
              minLines: null,
              expands: true,
              controller: postController,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                hintStyle: context.watch<ThemeProvider>().isDarkMode
                    ? Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white54)
                    : Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black54),
                contentPadding: const EdgeInsets.all(14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              final post = {
                "profilePic": "lib/assets/images/profile.jpg",
                "date": DateTime.now(),
                "heading": titleController.text,
                "content": postController.text,
                "isLiked": false,
                "isDisliked": false,
                "dislikeCount": 0,
                "likeCount": 0,
                "comments": []
              };
              Provider.of<PostProvider>(context, listen: false).addPost(post);
              postController.clear();
              titleController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  content: const Text(
                    "Post shared successfully",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Homepage(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(3)),
              child: const Center(
                child: Text(
                  "Share",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
