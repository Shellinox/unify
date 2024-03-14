import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/theme_provider.dart';
import 'package:unify/services/date_formatter.dart';
import 'package:unify/services/firebase_sign_in.dart';
import 'package:unify/widgets/post_tile.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          ),
          IconButton(
              onPressed: () {
                FirebaseAuthMethod(FirebaseAuth.instance).logout(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Posts")
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No posts yet"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, postIndex) {
                  final post = snapshot.data!.docs[postIndex];
                  return PostTile(
                    imgPath: post['profilePic'],
                    heading: post['heading'],
                    content: post['content'],
                    date: formatDate(post["date"]),
                    postID: post.id,
                    likes: List<String>.from(post["likes"] ?? []),
                    disLikes: List<String>.from(post["disLikes"] ?? []),
                    user: FirebaseAuth.instance.currentUser!.email.toString(),
                  );
                }),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error.toString()}"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
