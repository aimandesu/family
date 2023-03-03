import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post_provider.dart';

class PostPicture extends StatelessWidget {
  final DateTime dateTime;
  final String username;

  const PostPicture(
      {super.key, required this.username, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 1,
      width: size.width * 1,
      child: FutureBuilder(
        future: Provider.of<PostProvider>(context, listen: false)
            .readPostIndividual(username, dateTime),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data!.first['image'].length);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.first['image'].length,
              // postProvider
              //     .fetchPostIndividual(dateTime)
              //     .image!
              //     .length, //this loop how many picture in posts structure
              itemBuilder: (context, i) {
                //this one will loop how many times the picture is available
                return Image(
                  width: size.width * 1,
                  image: NetworkImage(
                    snapshot.data!.first['image'][i],
                  ),
                  // FileImage(
                  //   postProvider.fetchPostIndividual(dateTime).image![i],
                  // ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
