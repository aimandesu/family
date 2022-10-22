import 'package:family/responsive.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  static const routeName = "/profile";
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.line_axis))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: size.width * 1,
            height: size.height * 0.3,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: size.height * 0.2,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Text("Aiman"),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(color: Colors.blue),
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: size.height * 0.7,
              // width: size.width * 1,
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GridTile(
                    child: Container(
                      height: size.height * 0.2,
                      color: Colors.red,
                      margin: const EdgeInsets.all(1),
                      child: FittedBox(
                        child:
                            Image.network('https://picsum.photos/250?image=9'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
