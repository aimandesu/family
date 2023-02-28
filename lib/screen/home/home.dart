import 'package:family/models/post_models.dart';
import 'package:family/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../posts/posts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  List<PostModel> _newPostsIncoming(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return postProvider.fetchPosts();
  }

  List<PostModel> _retrievePostClicked(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    return postProvider.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: _newPostsIncoming(context).length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: Colors.blue.shade900,
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  _newPostsIncoming(context)[index].status.toString(),
                  style: const TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
              SizedBox(
                //outside box
                height: size.height * 0.5,
                width: size.width * 1,
                // margin: const EdgeInsets.all(5),
                child: FittedBox(
                  fit: size.width < 550 ? BoxFit.fill : BoxFit.contain,
                  child: SizedBox(
                    height: size.height * 0.5,
                    width: size.width * 1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _newPostsIncoming(context)[index]
                          .image!
                          .length, //this loop how many picture in posts structure
                      itemBuilder: (context, i) {
                        //this one will loop how many times the picture is available
                        return Image(
                          width: size.width * 1,
                          image: FileImage(
                              _newPostsIncoming(context)[index].image![i]),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: (() {
                      Navigator.of(context)
                          .pushNamed(Posts.routeName, arguments: {
                        'dateTime':
                            _retrievePostClicked(context)[index].dateTime,
                        'status': _retrievePostClicked(context)[index].status,
                      });
                    }),
                    icon: const Icon(
                      Icons.comment,
                      // color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
