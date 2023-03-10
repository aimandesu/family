// import 'dart:convert';
// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {
  Stream<List<Map<String, dynamic>>> readMessage() => FirebaseFirestore.instance
      .collection('post/1QZo9ZMPTv4E6xfXxooE/messages')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
      );

  Future<List<Map<String, dynamic>>> readUserInfo() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final String currentUser = auth.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('user')
        .where('userUID', isNotEqualTo: currentUser)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  } //buat friends list by username in user doc nnti

  // Future<bool> findIfChatAvailable(String username, String usernameTo) async {
  //   // String usernameTo = "";

  //   bool result = false;

  //   final collectionUsers = FirebaseFirestore.instance.collection('chat');

  //   final eachChat = await collectionUsers.doc().get();
  //   eachChat.data()?.forEach((key, value) {
  //     print(key);
  //     print(value);
  //     // if (key == 'data[$username]' && key == 'data[$usernameTo]') result = true;
  //   });
  //   return result;
  // }

  void sendMessage(
    // String username,
    // String usernameTo,
    String doc,
    String token,
    String message,
    String userUID,
  ) async {
    // late bool isChatBefore;

    // final user = FirebaseAuth.instance.currentUser;
    // final userData = await FirebaseFirestore.instance
    //     .collection('user')
    //     .doc(user!.uid)
    //     .get();

    // final username = userData['username']; //our user

    // final usernameToMessage = await FirebaseFirestore.instance
    //     .collection('user')
    //     .where('token', isEqualTo: token)
    //     .get();
    // final usernameTo = usernameToMessage.docs.first['username'];

    // isChatBefore =
    //     await findIfChatAvailable(username, usernameTo); //default false

    // if (!isChatBefore) {
    //   FirebaseFirestore.instance
    //       .collection('chat/$username-$usernameTo-chat')
    //       .add({
    //     'data': {
    //       "$username": {
    //         "text": [],
    //       },
    //       "$usernameTo": {
    //         "text": [],
    //       }
    //     }
    //   });
    // }

    FirebaseFirestore.instance.collection('chat').doc(doc).set({});

    final putLast = FirebaseFirestore.instance
        .collection('chat')
        .doc(doc)
        .collection("messages")
        .doc();

    putLast.set({
      'text': message,
      'username': doc,
      'createdAt': Timestamp.now(),
      'userUID': userUID,
    });

    // try {
    //   await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
    //       headers: <String, String>{
    //         'Content-Type': 'application/json',
    //         'Authorization':
    //             'key=AAAArMJ76Nw:APA91bHkk4vQ4pqiFQUmwTPt9-pe-WU2jI1NFsWelhgfmqHyTv2V2-HIzF2irImg86HPJcGGL-DKLl_cUWAb4LzxzgCQ6weU9EXTHUEIcbYmZVed98zqXjvelGGv3-SI7Mw0U8EfTlbg'
    //       },
    //       body: jsonEncode(<String, dynamic>{
    //         'priority': 'high',
    //         'data': <String, dynamic>{
    //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    //           'status': 'done',
    //           'body': message,
    //           'title': 'new message',
    //         },
    //         "notification": <String, dynamic>{
    //           "title": 'new message',
    //           "body": message,
    //           "android channel id": "dbmessage",
    //         },
    //         "to": token,
    //       }));
    // } catch (e) {
    //   print("e on chat_provider: $e");
    // }
  }
}
