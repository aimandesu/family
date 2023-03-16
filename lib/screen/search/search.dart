import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  static const routeName = "/search";

  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("test"),
      ),
    );
  }
}
