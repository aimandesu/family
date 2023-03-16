import 'package:family/screen/posts/newPost/new_post.dart';
import 'package:family/screen/profile/profile.dart';
import 'package:flutter/material.dart';

import '../chat/chat.dart';
import '../search/search.dart';

class MobileNavigation extends StatelessWidget {
  const MobileNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 15,
      right: 15,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Search.routeName);
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NewPost.routeName);
              },
              icon: Icon(
                Icons.post_add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Chat.routeName);
              },
              icon: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Profile.routeName);
              },
              icon: Icon(
                Icons.people,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
