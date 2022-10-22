import 'package:family/responsive.dart';
import 'package:family/screen/menu/menu.dart';
import 'package:flutter/material.dart';

import '../home/home.dart';
import '../widget/mobile_navigation.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/feed";
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int width = 630;
    //800 starts menu to go to bottom
    return Scaffold(
      body: Responsive(
        mobile: Stack(
          children: const [
            Home(),
            MobileNavigation(),
          ],
        ),
        tablet: Row(
          children: [
            Expanded(
              flex: size.width > width ? 2 : 3,
              child: const Menu(),
            ),
            Expanded(
              flex: size.width > width ? 6 : 7,
              child: const Home(),
            ),
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: size.width > width ? 2 : 3,
              child: const Menu(),
            ),
            Expanded(
              flex: size.width > width ? 6 : 7,
              child: const Home(),
            ),
          ],
        ),
      ),
    );
  }
}
