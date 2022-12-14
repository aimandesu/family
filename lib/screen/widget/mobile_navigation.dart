import 'package:family/screen/main/main_screen.dart';
import 'package:family/screen/profile/profile.dart';
import 'package:flutter/material.dart';

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
          color: Colors.grey.shade900,
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
                Navigator.of(context).pushNamed(MainScreen.routeName);
              },
              icon: const Icon(Icons.feed),
              color: Colors.white,
            ),
            const IconButton(
              onPressed: null,
              icon: Icon(Icons.post_add),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Profile.routeName);
              },
              icon: const Icon(Icons.people),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
