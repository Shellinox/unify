import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/auth/auth.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/provider/theme_provider.dart';
import 'package:unify/widgets/snackbar.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final postController = TextEditingController();
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add post"),
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            TextField(
              textAlignVertical: TextAlignVertical.top,
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
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
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
                if (postController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      content: const Text(
                        "Post can't be empty",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else if (titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      content: const Text(
                        "Title can't be empty",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  final post = {
                    "profilePic": "lib/assets/images/profile.jpg",
                    "date": Timestamp.now(),
                    "heading": titleController.text.toString().trim(),
                    "content": postController.text.toString().trim(),
                    "disLikes": [],
                    "likes": [],
                    "UserID": FirebaseAuth.instance.currentUser!.email,
                    "comments":0
                  };
                  Provider.of<PostProvider>(context, listen: false)
                      .addPost(post);
                  postController.clear();
                  titleController.clear();
                  showSnackbar(context, "Post shared successfully");
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                  );
                }
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
      ),
    );
  }
}
