import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> readComment(
      String username, DateTime dateTime) async* {
    yield* FirebaseFirestore.instance
        .collection('post')
        .where("username", isEqualTo: username)
        .where("dateTime", isEqualTo: dateTime)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  void addComment(
      String comment, bool isOpenReply, String doc, String repliesDoc) {
    if (comment.isEmpty) {
      return;
    }

    final mainComment = db.collection('post').doc(doc);
    final addReplies = mainComment.collection('replies');

    if (isOpenReply) {
      addReplies.doc(repliesDoc).update({
        "reply": FieldValue.arrayUnion([
          {
            "comment": comment,
            "username": "bruh",
            // "replyID": value.id,
            // "postID": doc,
          }
        ])
      });
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
              "username": 'lol',
              "replyID": value.id,
              // "reply": [],
            }
          ])
        });
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchReplies(
      String docPost, String docReplies) {
    // print(docPost);
    return FirebaseFirestore.instance
        .collection('post')
        .doc(docPost)
        .collection('replies')
        // .where("postID", isEqualTo: docPost)
        .where("replyID", isEqualTo: docReplies)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  int fetchRepliesAmount(String docPost, String docReplies) {
    int replies = 0;
    fetchReplies(docPost, docReplies).then((value) {
      if (value.isNotEmpty) {
        replies = value.length;
      }
    });
    return replies;
  }
}
