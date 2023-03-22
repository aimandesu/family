import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:family/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../posts/posts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<PostModel> _newPostsIncoming(BuildContext context) {
  bool? isTheColorDark;

  Future<void> isDark() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isTheColorDark = pref.getBool(
        "UserTheme"); //maybe kena setstate if dia boleh auto change from menu?
  }

  @override
  void initState() {
    super.initState();
    isDark();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: Provider.of<PostProvider>(context).readPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // final user = snapsot.data;
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: isTheColorDark != null && isTheColorDark == true
                        ? const Color.fromARGB(255, 31, 29, 29)
                        : Colors.white,
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: isTheColorDark != null && isTheColorDark == true
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: isTheColorDark != null && isTheColorDark == true
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    // borderRadius: const BorderRadius.all(
                    //   Radius.circular(25),
                    // ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.5),
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset:
                    //         const Offset(0, 3), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(
                      //   //outside box
                      //   // height: size.height * 0.5,
                      //   width: size.width * 1,
                      // margin: const EdgeInsets.all(5),
                      // child:
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // _newPostsIncoming(context)[index].status.toString(),
                            snapshot.data![index]['status'],
                            style: TextStyle(
                              color: isTheColorDark != null &&
                                      isTheColorDark == true
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: size.width < 550 ? BoxFit.fill : BoxFit.contain,
                        child: SizedBox(
                          // color: Colors.blue,
                          height: size.height * 0.4,
                          width: size.width * 1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (snapshot.data![index]['image']
                                    as List<dynamic>)
                                .length,
                            // itemCount: _newPostsIncoming(context)[index]
                            //     .image!
                            //     .length, //this loop how many picture in posts structure
                            itemBuilder: (context, i) {
                              //this one will loop how many times the picture is available
                              return Image(
                                width: size.width * 1,
                                image: NetworkImage(
                                  snapshot.data![index]['image'][i],
                                ),
                                // image: FileImage(
                                //     _newPostsIncoming(context)[index].image![i]),
                              );
                            },
                          ),
                        ),
                      ),

                      // ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Posts.routeName, arguments: {
                                'dateTime': (snapshot.data![index]['dateTime']
                                        as Timestamp)
                                    .toDate(),
                                'username': snapshot.data![index]['username'],
                                // _retrievePostClicked(context)[index].dateTime,
                                'status': snapshot.data![index]['status'],
                                // _retrievePostClicked(context)[index].status,
                              });
                            },
                            icon: Icon(
                              Icons.comment,
                              color: isTheColorDark != null &&
                                      isTheColorDark == true
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("No post has been made so far"),
            );
          }
        });
  }
}
