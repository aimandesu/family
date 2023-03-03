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
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final DateTime dateTime = arguments['dateTime'] as DateTime;
    final String status = arguments['status'] as String;
    final String username = arguments['username'] as String;

    Size size = MediaQuery.of(context).size;
    int width = 630;
    return SafeArea(
      child: Scaffold(
          body: Responsive(
        mobile: Stack(
          children: [
            PostPicture(username: username, dateTime: dateTime),
            PostCaption(status: status),
            PostComment(username: username, dateTime: dateTime),
          ],
        ),
        tablet: Row(
          children: [
            Expanded(
              flex: size.width > width ? 4 : 5,
              child: PostPicture(username: username, dateTime: dateTime),
            ),
            Expanded(
              flex: size.width > width ? 3 : 4,
              child: Stack(
                children: [
                  PostCaption(status: status),
                  PostComment(username: username, dateTime: dateTime),
                ],
              ),
            ),
          ],
        ),
        desktop: Container(color: Colors.red),
      )),
    );
  }
}
