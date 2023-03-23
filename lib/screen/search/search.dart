import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  static const routeName = "/search";

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchKey = "";
  String username = "";

  void getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    username = userData['username'];
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: TextField(
                decoration: const InputDecoration.collapsed(
                  hintText: "Username",
                ),
                onChanged: (value) {
                  setState(() {
                    searchKey = value;
                  });
                },
              ),
            ),
          ),
          searchKey == ""
              ? const Center(
                  child: Text('Type keyword in username container'),
                )
              : StreamBuilder<List<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .where('username', isGreaterThanOrEqualTo: searchKey)
                      .where('username',
                          isLessThanOrEqualTo: '$searchKey\uf7ff')
                      .where('username', isNotEqualTo: username)
                      .snapshots()
                      .map((snapshot) =>
                          snapshot.docs.map((doc) => doc.data()).toList()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: SizedBox(
                          height: size.height * 1,
                          width: size.width * 1,
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: ListTile(
                                    leading: Image.network(
                                        snapshot.data![i]['image']),
                                    title: Text(snapshot.data![i]['username']),
                                  ),
                                );
                              }),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      return const Center(
                        child: Text("user with the username is not available"),
                      );
                    } else {
                      return Container();
                    }
                    // // snapshot.data is QuerySnapshot than I access .docs to get List<QueryDocumentSnapshot>
                    // var docs = snapshot.data.docs;
                    // // Accessing single QueryDocumentSnapshot and then using .data() getting its map.
                    // final user = docs[0].data()!;
                    // return Padding(
                    //   padding: const EdgeInsets.only(left: 15),
                    //   child: Text(
                    //     "${user["username"]}.",
                    //   ),
                    // );
                  }),
        ]),
      ),
    );
  }
}
