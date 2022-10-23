import 'package:family/responsive.dart';
import 'package:family/screen/posts/post_comment.dart';
import 'package:family/screen/posts/post_picture.dart';
import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  static const routeName = "/posts";
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Responsive(
      mobile: Stack(
        children: const [
          PostPicture(),
          PostComment(),
        ],
      ),
      tablet: Container(
        color: Colors.black,
      ),
      desktop: Container(color: Colors.red),
    ));
  }
}
