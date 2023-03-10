import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/providers/chat_provider.dart';
import 'package:family/screen/chat/chat_target.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  static const routeName = "/chat";
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var appBar2 = AppBar();

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;
    late String username;
    late String userUID;

    Future<String> userData() async {
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();
      return userData['username'];
    }

    Future<String> userDataUID() async {
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();
      return userData['userUID'];
    }

    Future<String> findChatAvailable(String username, String usernameTo) async {
      // String doc = "$username-$usernameTo-chat";

      final collectionUsers = FirebaseFirestore.instance.collection('chat');
      // .doc("${username}ChatWith$usernameTo");
      final userAvailable =
          await collectionUsers.doc("${username}ChatWith$usernameTo").get();
      // print('chat/$username-$usernameTo-chat/message');
      // collectionUsers.get().then((doc) {
      if (userAvailable.exists) {
        return "${username}ChatWith$usernameTo";
      } else {
        return "${usernameTo}ChatWith$username";
      }
      // });
      // if (userAvailable.exists) {
      //   return 'chat/$username-$usernameTo-chat/message';
      // } else {

      // }
      // return toSend;
    }

    void navigateRoute(String token, String doc, String userUID) {
      Navigator.of(context).pushNamed(ChatTarget.routeName, arguments: {
        'token': token,
        'doc': doc,
        // 'usernameTo': usernameTo,
        // 'username': username,
        'userUID': userUID,
      });
    }

    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar2,
      body: SafeArea(
        // child:
        // Container(
        //   child: Text('hope this works'),
        // ),
        child: FutureBuilder(
          future:
              Provider.of<ChatProvider>(context, listen: false).readUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: (mediaQuery.size.height - paddingTop) * 0.05,
                    child: const Text(
                      'Friends List',
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: (mediaQuery.size.height - paddingTop) * 0.95,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // return Container(
                        //   child: Text(snapshot.data![index]['username']),
                        // );
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.offline_pin),
                            title: Text(snapshot.data![index]['username']),
                            onTap: () async {
                              username = await userData();
                              userUID = await userDataUID();
                              navigateRoute(
                                snapshot.data![index]['token'],
                                await findChatAvailable(username,
                                    snapshot.data![index]['username']),
                                // snapshot.data![index]
                                //     ['username'], //this is usernameTo
                                // username,
                                userUID,
                              );
                              // print(snapshot.data![index]['token']);
                              // print(snapshot.data![index]['username']);
                              // print(username);
                              // print(userUID);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
