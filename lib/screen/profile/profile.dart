import 'package:family/screen/posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post_models.dart';
import '../../providers/post_provider.dart';

class Profile extends StatelessWidget {
  static const routeName = "/profile";
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<PostModel> newPostsIncoming(BuildContext context) {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      return postProvider.fetchPosts();
    }

    return Scaffold(
      appBar: AppBar(
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.settings))
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
                          // color: Colors.blue,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://picsum.photos/250?image=9"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const Text(
                        "Aiman",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "About You",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Hey this is me ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: size.height * 0.7,
              // width: size.width * 1,
              child: GridView.builder(
                itemCount: newPostsIncoming(context).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Posts.routeName,
                        arguments: {
                          'dateTime': newPostsIncoming(context)[index].dateTime,
                          'status': newPostsIncoming(context)[index].status,
                        },
                      );
                    },
                    child: GridTile(
                      child: Container(
                        height: size.height * 0.2,
                        margin: const EdgeInsets.all(1),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image(
                            image: FileImage(
                              newPostsIncoming(context)[index].image![0],
                            ),
                          ),
                        ),
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
