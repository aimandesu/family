import 'package:flutter/material.dart';

import '../posts/posts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Kami suka makan nasi ayam di balik timur Japan kerana rasanya yang enak Kami suka makan nasi ayam di balik timur Japan kerana rasanya yang enak Kami suka makan nasi ayam di balik timur Japan kerana rasanya yang enak ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.5,
                width: size.width * 1,
                // margin: const EdgeInsets.all(5),
                child: FittedBox(
                  fit: size.width < 550 ? BoxFit.fill : BoxFit.contain,
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: (() {
                      Navigator.of(context).pushNamed(Posts.routeName);
                    }),
                    icon: const Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
