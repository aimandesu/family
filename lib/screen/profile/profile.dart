import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/providers/profile_provider.dart';
import 'package:family/screen/posts/posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post_provider.dart';

class Profile extends StatelessWidget {
  static const routeName = "/profile";
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: size.width * 1,
            height: size.height * 0.3,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: Provider.of<ProfileProvider>(context, listen: false)
                  .fetchProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                // color: Colors.blue,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data!.first['image']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data!.first['name'] as String,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "About You",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                Text(
                                  snapshot.data!.first['about'],
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Expanded(
            child: SizedBox(
                height: size.height * 0.7,
                // width: size.width * 1,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: Provider.of<PostProvider>(context, listen: false)
                        .readOwnPost(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Posts Found',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                            ),
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return GridView.builder(
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              // if (snapshot.data![index]['username'] == 'aiman') {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    Posts.routeName,
                                    arguments: {
                                      'dateTime': (snapshot.data![index]
                                              ['dateTime'] as Timestamp)
                                          .toDate(),
                                      'username': snapshot.data![index]
                                          ['username'],
                                      // newPostsIncoming(context)[index].dateTime,
                                      'status': snapshot.data![index]['status'],
                                      // newPostsIncoming(context)[index].status,
                                    },
                                  );
                                },
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius: BorderRadius.circular(20.0),
                                        // ),
                                        child: SizedBox(
                                          child: Stack(
                                            children: [
                                              Image(
                                                image: NetworkImage(
                                                  snapshot.data![index]['image']
                                                      [0],
                                                ),
                                                // FileImage(
                                                //   newPostsIncoming(
                                                //           context)[index]
                                                //       .image![0],
                                                // ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.update,
                                                      size: size.height * 0.05,
                                                    ),
                                                    Icon(
                                                      Icons.delete_forever,
                                                      size: size.height * 0.05,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
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
                                        image: NetworkImage(
                                          snapshot.data![index]['image'][0],
                                        ),
                                        // FileImage(
                                        //   newPostsIncoming(context)[index]
                                        //       .image![0],
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            // },
                            );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })

                // FutureBuilder(
                //   future: Provider.of<PostProvider>(context, listen: false)
                //       .fetchPostsFuture(),
                //   builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {

                //   },
                // ),
                ),
          ),
        ],
      ),
    );
  }
}
