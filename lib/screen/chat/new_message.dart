import 'package:family/providers/chat_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  final String username;
  // final String usernameTo;
  final String doc;
  final String token;
  final String userUID;
  const NewMessage({
    super.key,
    required this.username,
    // required this.usernameTo,
    required this.doc,
    required this.token,
    required this.userUID,
  });

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              width: 1.5, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      // margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Send messages'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
              onPressed: _enteredMessage.trim().isEmpty
                  ? null
                  : () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .sendMessage(
                        widget.username,
                        // widget.usernameTo,
                        widget.doc,
                        widget.token,
                        _enteredMessage,
                        widget.userUID,
                      );
                      _controller.clear();
                    },
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
    );
  }
}
