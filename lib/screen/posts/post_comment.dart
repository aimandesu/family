import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/screen/posts/commentReply/comment_reply.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../providers/comment_provider.dart';

class PostComment extends StatefulWidget {
  final DateTime dateTime;
  final String username;

  const PostComment({
    super.key,
    required this.username,
    required this.dateTime,
  });

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  bool isExpanded = false;
  bool isPostOpen = false;
  bool isOpenReply = false;
  int width = 630;

  // List<dynamic> replies = [];
  String doc = "";
  String repliesDoc = "";
  final PanelController _pc = PanelController();
  final commentController = TextEditingController();
  String enteredComment = "";
  String username = "";

  void getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    username = userData['username'];
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SlidingUpPanel(
        color: Theme.of(context).colorScheme.primary,
        backdropTapClosesPanel: false,
        defaultPanelState:
            size.width > width ? PanelState.OPEN : PanelState.CLOSED,
        backdropEnabled: size.width > width ? false : true,
        isDraggable: size.width > width ? false : true,
        onPanelOpened: () => setState(() {
          isExpanded = true;
          isPostOpen = true;
        }),
        onPanelClosed: () => setState(() {
          isExpanded = false;
        }),
        controller: _pc,
        collapsed: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => _pc.open(),
              icon: isExpanded
                  ? Container()
                  : Icon(
                      Icons.comment,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
            ),
          ],
        ),
        // color: Colors.white,
        minHeight: size.height * 0.05,
        // maxHeight: size.width > width ? size.height * 0.7 : size.height * 0.4,
        maxHeight: size.width > width
            ? size.height > 800
                ? size.height * 0.6
                : size.height * 0.68
            : size.height * 0.6,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        panel:
            //  isExpanded
            //     ?
            Stack(
          children: [
            // isExpanded
            //     ? size.width > width
            //         ? Container()
            //         : isPostOpen
            //             ? const PostCaption()
            //             : Container()
            //     : Container(),
            isExpanded
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      // height: size.height * 0.05,
                      child: IconButton(
                        onPressed: () {
                          if (isOpenReply) {
                            // print("yes");
                            setState(() {
                              isOpenReply = !isOpenReply;
                              // replies = [];
                            });
                          } else {
                            _pc.close();
                            setState(() {
                              isPostOpen = false;
                            });
                          }
                        },
                        icon: size.width > width
                            ? const Icon(null)
                            : Icon(Icons.arrow_back_ios,
                                color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  isPostOpen || size.width > width
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: size.width > width
                                ? size.height * 0.55
                                : size.height * 0.47,
                            width: size.width > width
                                ? size.width * 3 / 7 * 0.97
                                : size.width * 1,
                            child: StreamBuilder(
                              stream: Provider.of<CommentProvider>(context,
                                      listen: false)
                                  .readComment(
                                      widget.username, widget.dateTime),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  doc = snapshot.data!.first['postID'];
                                  // repliesDoc = snapshot.data!.first['replyID'];
                                }

                                if (snapshot.hasData &&
                                    snapshot.data!.first['comment']!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No comments',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot
                                        .data!.first['comment']!.isNotEmpty) {
                                  return !isOpenReply
                                      // && replies.isEmpty
                                      ? ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: snapshot
                                              .data!.first['comment']!.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                snapshot.data!.first[
                                                        'comment']![index]
                                                    ['username'],
                                              ),
                                              subtitle: Text(
                                                snapshot.data!.first[
                                                        'comment']![index]
                                                    ['comment'],
                                                style: const TextStyle(),
                                              ),
                                              trailing: TextButton(
                                                onPressed: () {
                                                  // final reply = snapshot.data!
                                                  //         .first['comment']![
                                                  //     index]['reply'];
                                                  repliesDoc = snapshot.data!
                                                          .first['comment']![
                                                      index]['replyID'];
                                                  // print(repliesDoc);

                                                  setState(() {
                                                    // replies = reply;

                                                    isOpenReply = !isOpenReply;
                                                  });

                                                  // print(snapshot.data!
                                                  //         .first['comment']![index]
                                                  //     ['reply']);
                                                  // Navigator.of(context)
                                                  //     .pushNamed(
                                                  //         CommentReply
                                                  //             .routeName,
                                                  //         arguments: reply);
                                                },
                                                child: SizedBox(
                                                  width: size.width * 0.13,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .first['comment']![
                                                                index]
                                                                ['replyCount']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const Text(
                                                        " • reply",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : CommentReply(
                                          postDoc: doc, repliesDoc: repliesDoc);
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                // if (snapshot.hasData &&
                                //     snapshot.data!.first['comment']!.isEmpty) {
                                //   return Center(
                                //     child: Text(
                                //       'No comments',
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           fontStyle: FontStyle.italic,
                                //           fontSize: 20,
                                //           color: Theme.of(context)
                                //               .colorScheme
                                //               .onPrimary),
                                //     ),
                                //   );
                                // } else if (snapshot.hasData &&
                                //     snapshot
                                //         .data!.first['comment']!.isNotEmpty) {
                                //   return ListView.builder(
                                //     padding: EdgeInsets.zero,
                                //     itemCount:
                                //         snapshot.data!.first['comment']!.length,
                                //     itemBuilder: (context, index) {
                                //       return ListTile(
                                //         title: Text(
                                //           snapshot
                                //               .data!.first['comment']![index],
                                //           style: const TextStyle(),
                                //         ),
                                //       );
                                //     },
                                //   );
                                // } else {
                                //   return const Center(
                                //     child: CircularProgressIndicator(),
                                //   );
                                // }
                              },
                            ),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      height: size.width > width
                          ? size.width * 0.06
                          : size.height * 0.06,
                      width: size.width > width
                          ? size.width * 3 / 7 * 0.97
                          : size.width * 1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        color: Theme.of(context).colorScheme.onSecondary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: size.height * 1,
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              // width: size.width * 0.9,
                              child: TextField(
                                controller: commentController,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration.collapsed(
                                  hintStyle: TextStyle(color: Colors.black),
                                  hintText: "Comment",
                                ),
                                maxLines: null,
                                onChanged: (value) {
                                  setState(() {
                                    enteredComment = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: enteredComment.trim().isEmpty
                                ? null
                                : () {
                                    // final comment = commentController.text;

                                    Provider.of<CommentProvider>(context,
                                            listen: false)
                                        .addComment(
                                      username,
                                      enteredComment,
                                      isOpenReply,
                                      doc,
                                      repliesDoc,
                                    );

                                    commentController.clear();
                                  },
                            icon: const Icon(
                              Icons.send,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

        // : Row(
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           setState(() {
        //             isExpanded = !isExpanded;
        //           });
        //         },
        //         icon: Icon(Icons.comment),
        //       ),
        //       Icon(Icons.heart_broken),
        //     ],
        //   ),
      ),
    );
  }
}
