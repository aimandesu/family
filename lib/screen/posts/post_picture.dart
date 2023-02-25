import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post_provider.dart';

class PostPicture extends StatelessWidget {
  final DateTime dateTime;

  const PostPicture({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 1,
      width: size.width * 1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: postProvider
            .fetchPostIndividual(dateTime)
            .image!
            .length, //this loop how many picture in posts structure
        itemBuilder: (context, i) {
          //this one will loop how many times the picture is available
          return Image(
            width: size.width * 1,
            image: FileImage(
              postProvider.fetchPostIndividual(dateTime).image![i],
            ),
          );
        },
      ),
    );
  }
}
