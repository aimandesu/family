import 'package:family/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  // static const routeName = "/chat";
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child:
        // Container(
        //   child: Text('hope this works'),
        // ),
        child: StreamBuilder(
          stream:
              Provider.of<ChatProvider>(context, listen: false).readMessage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.data!.length);
              // print(snapshot.data);
              // print(snapshot.data![1]['text']);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data![index]['text']);
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
