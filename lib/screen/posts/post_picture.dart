import 'package:flutter/material.dart';

class PostPicture extends StatelessWidget {
  const PostPicture({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 1,
      width: size.width * 1,
      color: Colors.grey.shade900,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Image.network(
            // "https://i.pinimg.com/originals/5c/71/cd/5c71cdbf20cd3b99d70f6ecb77c5954c.jpg",
            "https://picsum.photos/250?image=9"
            // "https://i.pinimg.com/736x/98/78/7a/98787a7df9cd04c434699ebbdccae34c.jpg",
            ),
      ),
    );
  }
}
