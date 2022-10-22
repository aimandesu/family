import 'package:family/screen/profile/profile.dart';
import 'package:family/screen/widget/notification_badge.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.limeAccent.shade700,
        border: Border.all(
          color: Colors.pink.shade100,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.lightGreen.shade900,
              ),
            ),
            onTap: () => Navigator.of(context).pushNamed(Profile.routeName),
          ),
          ListTile(
            title: Text(
              'Post',
              style: TextStyle(
                color: Colors.lightGreen.shade900,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Notifications',
              style: TextStyle(
                color: Colors.lightGreen.shade900,
              ),
            ),
            trailing: const NotificationBadge(),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                title: Text(
                  'Setting',
                  style: TextStyle(
                    color: Colors.lightGreen.shade900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
