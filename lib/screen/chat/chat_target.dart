import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/screen/chat/message_bubble.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'new_message.dart';

class ChatTarget extends StatefulWidget {
  static const routeName = "/chat_target";
  const ChatTarget({super.key});

  @override
  State<ChatTarget> createState() => _ChatTargetState();
}

class _ChatTargetState extends State<ChatTarget> {
  @override
  void initState() {
    super.initState();
    requestPermission();
    initInfo();
  }

  void initInfo() {
    // onmessage
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    //on launch and onresume replacement
    //on resume when tap on notification
    //on kill when the background app not active, it promps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final token = routeArgs['token'];
    final doc = routeArgs['doc'];

    // final usernameTo = routeArgs['usernameTo'];
    // final username = routeArgs['username'];
    final userUID = routeArgs['userUID'];
    // print('chat/$username-$usernameTo-chat/message');
    //nanti sini akan ada send message part yg need to use chat provider
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chat/$doc/messages")
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        isMe: snapshot.data!.docs[index]['userUID'] == userUID,
                        message: snapshot.data!.docs[index]['text'],
                        username: snapshot.data!.docs[index]['username'],
                      ); //message bubble
                    },
                  );
                }
              },
            ),
          ),
          NewMessage(
            // username: username,
            // usernameTo: usernameTo,
            doc: doc,
            token: token,
            userUID: userUID,
          ),
        ],
      ),
    );
  }
}
