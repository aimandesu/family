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
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    requestPermission();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollToBottom();
    // });
    initInfo();
  }

  // void scrollToBottom() {
  //   Future.delayed(const Duration(milliseconds: 200)).then((_) {
  //     if (!_scrollController.hasClients) return;
  //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //   });
  // }

  void initInfo() {
    // onmessage
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message title: ${message.notification!.title}');
      // print('Message info: ${message.notification!.body}');

      // if (message.notification != null) {
      //   print('Message also contained a notification: ${message.notification}');
      // }
    });

    //on launch and onresume replacement
    //on resume when tap on notification
    //on kill when the background app not active, it promps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('got message onmessageopenedApp ${message.data}');
      // print('Message title: ${message.notification!.title}');
      // print('Message info: ${message.notification!.body}');
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // NotificationSettings settings =
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print('User granted permission');
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   print('User granted provisional permission');
    // } else {
    //   print('User declined or has not accepted permission');
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final token = routeArgs['token'];
    final doc = routeArgs['doc'];

    final usernameTo = routeArgs['usernameTo'];
    final username = routeArgs['username'];
    final userUID = routeArgs['userUID'];
    // print("token:$token");
    // print('chat/$username-$usernameTo-chat/message');
    //nanti sini akan ada send message part yg need to use chat provider
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text(
              usernameTo,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chat/$doc/messages")
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  return ListView.builder(
                    reverse: true,
                    // controller: _scrollController,
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
            username: username,
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
