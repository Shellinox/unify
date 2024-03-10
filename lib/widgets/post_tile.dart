import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unify/provider/post_provider.dart';
import 'package:unify/provider/theme_provider.dart';
import 'package:unify/widgets/comment_bottom_sheet_widget.dart';

class PostTile extends StatelessWidget {
  const PostTile(
      {super.key,
      required this.imgPath,
      required this.heading,
      required this.content,
      required this.date,
      required this.postIndex});
  final String imgPath;
  final String heading;
  final String content;
  final DateTime date;
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(imgPath),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heading,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        date.toString(),
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
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialButton(
                    icondata: postProvider.posts[postIndex]["isLiked"]
                        ? Icon(
                            Icons.thumb_up_alt,
                            color: Theme.of(context).primaryColor,
                          )
                        : const Icon(Icons.thumb_up_alt_outlined),
                    count: postProvider.posts[postIndex]["likeCount"],
                    onTap: () {
                      if (postProvider.posts[postIndex]["isDisliked"]) {
                        postProvider.dislikePost(postIndex);
                        postProvider.likePost(postIndex);
                      } else {
                        postProvider.likePost(postIndex);
                      }
                    },
                  ),
                  SocialButton(
                    icondata: postProvider.posts[postIndex]["isDisliked"]
                        ? Icon(
                            Icons.thumb_down,
                            color: Theme.of(context).primaryColor,
                          )
                        : const Icon(Icons.thumb_down_off_alt),
                    count: postProvider.posts[postIndex]["dislikeCount"],
                    onTap: () {
                      if (postProvider.posts[postIndex]["isLiked"]) {
                        postProvider.likePost(postIndex);
                        postProvider.dislikePost(postIndex);
                      } else {
                        postProvider.dislikePost(postIndex);
                      }
                    },
                  ),
                  SocialButton(
                    icondata: const Icon(Icons.comment_outlined),
                    count: postProvider.posts[postIndex]["comments"].length,
                    onTap: () {
                      showModalBottomSheet(
                          enableDrag: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SizedBox(
                                height: 600,
                                child: CommentSheet(
                                  postIndex: postIndex,
                                ),
                              ));
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
