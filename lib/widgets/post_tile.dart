import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/theme_provider.dart';
import 'package:unify/widgets/alert_Dialog.dart';
import 'package:unify/widgets/comment_bottom_sheet_widget.dart';
import 'package:unify/widgets/snackbar.dart';

class PostTile extends StatefulWidget {
  const PostTile(
      {super.key,
      required this.imgPath,
      required this.heading,
      required this.content,
      required this.date,
      required this.postID,
      required this.likes,
      required this.disLikes,
      required this.user,
      required this.commentsCount});
  final String imgPath;
  final String heading;
  final String content;
  final String date;
  final String postID;
  final List<String> likes;
  final List<String> disLikes;
  final String user;
  final int commentsCount;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  bool isDisliked = false;

  @override
  void initState() {
    isLiked = widget.likes.contains(currentUser.email);
    isDisliked = widget.disLikes.contains(currentUser.email);
    super.initState();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postref =
        FirebaseFirestore.instance.collection("Posts").doc(widget.postID);
    if (isLiked) {
      postref.update({
        "likes": FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postref.update({
        "likes": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void toggledislike() {
    setState(() {
      isDisliked = !isDisliked;
    });
    DocumentReference postref =
        FirebaseFirestore.instance.collection("Posts").doc(widget.postID);
    if (isDisliked) {
      postref.update({
        "disLikes": FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postref.update({
        "disLikes": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.imgPath),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.heading,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget.date,
                        style: themeProvider.isDarkMode
                            ? Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white54)
                            : Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                  const Spacer(),
                  currentUser.email == widget.user
                      ? IconButton(
                          onPressed: () {
                            showAlert(
                                context,
                                "Are you sure you want to delete the post",
                                "Delete post?",
                                "Delete", () {
                              FirebaseFirestore.instance
                                  .collection("Posts")
                                  .doc(widget.postID)
                                  .delete();
                              showSnackbar(context, "Post deleted");
                              Navigator.of(context).pop();
                            });
                          },
                          icon: const Icon(Icons.delete),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.content,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialButton(
                    icondata: isLiked
                        ? Icon(
                            Icons.thumb_up_alt,
                            color: Theme.of(context).primaryColor,
                          )
                        : const Icon(Icons.thumb_up_alt_outlined),
                    count: widget.likes.length,
                    onTap: isDisliked ? () {} : toggleLike,
                  ),
                  SocialButton(
                    icondata: isDisliked
                        ? Icon(
                            Icons.thumb_down,
                            color: Theme.of(context).primaryColor,
                          )
                        : const Icon(Icons.thumb_down_off_alt),
                    count: widget.disLikes.length,
                    onTap: isLiked ? () {} : toggledislike,
                  ),
                  SocialButton(
                    icondata: const Icon(Icons.comment_outlined),
                    count: widget.commentsCount,
                    onTap: () {
                      showModalBottomSheet(
                        enableDrag: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => SizedBox(
                          height: 600,
                          child: CommentSheet(
                            postID: widget.postID,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 0.1,
                  )
                ],
              ),
              const Divider()
            ],
          ),
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key,
      required this.icondata,
      required this.count,
      required this.onTap});
  final Icon icondata;
  final int count;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onTap,
          icon: icondata,
        ),
        Text("$count"),
      ],
    );
  }
}
