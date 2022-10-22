import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.blue),
      child: const Text("1"),
    );
  }
}
