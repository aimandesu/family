import 'package:family/responsive.dart';
import 'package:family/screen/posts/post_caption.dart';
import 'package:family/screen/posts/post_comment.dart';
import 'package:family/screen/posts/post_picture.dart';
import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  static const routeName = "/posts";
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int width = 630;
    return Scaffold(
        body: Responsive(
      mobile: Stack(
        children: const [
          PostPicture(),
          PostComment(),
        ],
      ),
      tablet: Row(
        children: [
          Expanded(
            flex: size.width > width ? 4 : 5,
            child: const PostPicture(),
          ),
          Expanded(
            flex: size.width > width ? 3 : 4,
            child: Stack(
              children: const [
                PostCaption(),
                PostComment(),
              ],
            ),
          ),
        ],
      ),
      desktop: Container(color: Colors.red),
    ));
  }
}
