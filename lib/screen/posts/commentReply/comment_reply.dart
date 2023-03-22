import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/comment_provider.dart';

class CommentReply extends StatefulWidget {
  static const routeName = "/comment-reply";
  final String repliesDoc;
  final String postDoc;
  const CommentReply(
      {super.key, required this.postDoc, required this.repliesDoc});

  @override
  State<CommentReply> createState() => _CommentReplyState();
}

class _CommentReplyState extends State<CommentReply> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // print(widget.repliesDoc);

    // final replyList =
    //     ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    // print(replyList[0]["comment"]);
    // print(replyList[0]["username"]);

    return SizedBox(
      height: size.height * 0.3,
      child: StreamBuilder(
        stream: Provider.of<CommentProvider>(context, listen: false)
            .fetchReplies(widget.postDoc, widget.repliesDoc),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.first['reply']!.isEmpty) {
            return Center(
              child: Text(
                'No comments',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.data!.first['reply']!.isNotEmpty) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data!.first['reply'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data!.first['reply']![index]['username'],
                    ),
                    subtitle: Text(
                      snapshot.data!.first['reply']![index]['comment'],
                      style: const TextStyle(),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
