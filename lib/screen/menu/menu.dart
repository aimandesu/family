import 'package:family/screen/profile/profile.dart';
import 'package:family/screen/widget/notification_badge.dart';
import 'package:family/screen/widget/setting.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isOpenSetting = false;

  @override
  Widget build(BuildContext context) {
    void closeSetting() {
      setState(() {
        isOpenSetting = false;
      });
    }

    // Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            // color: Colors.limeAccent.shade700,
            color: Colors.grey.shade900,
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () => Navigator.of(context).pushNamed(Profile.routeName),
              ),
              const ListTile(
                title: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const ListTile(
                title: Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: NotificationBadge(),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    onTap: () => setState(() {
                      isOpenSetting = true;
                    }),
                    title: const Text(
                      'Setting',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        isOpenSetting ? Setting(closeSetting: closeSetting) : Container(),
      ],
    );
  }
}
