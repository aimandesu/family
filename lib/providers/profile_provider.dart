import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String username = "";

  Future<String> getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    return userdata["username"];
  }

  Future<List<Map<String, dynamic>>> fetchProfile() async {
    username = await getUser();
    return FirebaseFirestore.instance
        .collection('user')
        .where("username", isEqualTo: username)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
