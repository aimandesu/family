import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  // String username = "";

  // void getUsername() async {
  //   username = await getUser();
  // }

  // Future<String> getUser() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   final userData = await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(user!.uid)
  //       .get();

  //   return userData['username'];
  // }

  Stream<List<Map<String, dynamic>>> readComment(
      String username, DateTime dateTime) async* {
    yield* FirebaseFirestore.instance
        .collection('post')
        .where("username", isEqualTo: username)
        .where("dateTime", isEqualTo: dateTime)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  void updateCount(String doc, String repliesDocs) {
    final mainComment = db.collection('post').doc(doc);
    final addReplies = mainComment.collection('replies');

    int repliesCount = 0;
    String replyID = "";

    addReplies.doc(repliesDocs).get().then((value) {
      value.data()!.forEach((key, value) {
        if (key == "reply") {
          // final int theKey = key;
          for (int i = 0; i < value.length; i++) {
            repliesCount++;
          }
        }

        if (key == "replyID") {
          replyID = value;
          mainComment.get().then((value) {
            value.data()!.forEach((key, value) {
              if (key == "comment") {
                // final int theKey = key;
                for (int i = 0; i < value.length; i++) {
                  if (value[i]['replyID'] == replyID) {
                    mainComment.update({
                      "comment": FieldValue.arrayRemove([
                        {
                          "comment": value[i]['comment'],
                          "username": value[i]['username'],
                          "replyID": value[i]['replyID'],
                          "replyCount": value[i]['replyCount'],
                          // "reply": [],
                        }
                      ])
                    });
                    mainComment.update({
                      "comment": FieldValue.arrayUnion([
                        {
                          "comment": value[i]['comment'],
                          "username": value[i]['username'],
                          "replyID": value[i]['replyID'],
                          "replyCount": repliesCount,
                          // "reply": [],
                        }
                      ])
                    });
                  }
                }
              }
            });
          });
        }
      });
    });
  }

  void addComment(String username, String comment, bool isOpenReply, String doc,
      String repliesDoc) {
    if (comment.isEmpty) {
      return;
    }

    final mainComment = db.collection('post').doc(doc);
    final addReplies = mainComment.collection('replies');
    // getUsername();

    if (isOpenReply) {
      addReplies.doc(repliesDoc).update({
        "reply": FieldValue.arrayUnion([
          {
            "comment": comment,
            "username": username,
            // "replyID": value.id,
            // "postID": doc,
          }
        ])
      });

      updateCount(doc, repliesDoc);

      // addReplies.add({"reply": []}).then((value) {
      //   addReplies.doc(value.id).update({
      //     "reply": FieldValue.arrayUnion([
      //       {
      //         "comment": comment,
      //         "username": "bruh",
      //         // "replyID": value.id,
      //         // "postID": doc,
      //       }
      //     ])
      //   });

      //   mainComment.set({"replyID": value.id});
      // });
    } else {
      // mainComment.update({
      //   "comment": FieldValue.arrayUnion([
      //     {
      //       "comment": comment,
      //       "username": 'lol',
      //       // "replyID": "",
      //       // "reply": [],
      //     }
      //   ])
      // });

      addReplies.add({"reply": []}).then((value) {
        addReplies.doc(value.id).set({
          "reply": [],
          "replyID": value.id,
          // "postID": doc,
        });
        mainComment.update({
          "comment": FieldValue.arrayUnion([
            {
              "comment": comment,
              "username": username,
              "replyID": value.id,
              "replyCount": 0,
              // "reply": [],
            }
          ])
        });
      });
    }
  }

  Stream<List<Map<String, dynamic>>> fetchReplies(
      String docPost, String docReplies) async* {
    // print(docPost);
    yield* FirebaseFirestore.instance
        .collection('post')
        .doc(docPost)
        .collection('replies')
        // .where("postID", isEqualTo: docPost)
        .where("replyID", isEqualTo: docReplies)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    // .get()
    // .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // int fetchRepliesAmount(String docPost, String docReplies) {
  //   int replies = 0;
  //   fetchReplies(docPost, docReplies).then((value) {
  //     if (value.isNotEmpty) {
  //       replies = value.length;
  //     }
  //   });
  //   return replies;
  // }
}
