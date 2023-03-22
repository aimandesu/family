import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class LoginSignProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  Future<void> createUser(
    String username, //should be from firebase
    String email,
    String password,
    File imageFile,
    String name,
    String about,
  ) async {
    UserCredential userCredential;
    String? token;

    userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await FirebaseMessaging.instance.getToken().then((value) => token = value);

    final userSignUp = FirebaseFirestore.instance
        .collection('user')
        .doc(userCredential.user!.uid);

    // if (await findUserAvailable(username)) {
    //   return true;
    // }

    String pathToTake = username;
    String urlImage = "";

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory = referenceRoot.child('$pathToTake/');

    try {
      Reference referenceImageToUpload =
          referenceDirectory.child('profile/$pathToTake-profile');
      await referenceImageToUpload.putFile(imageFile);
      urlImage = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      print(e);
    } finally {
      final user = UserModel(
        userUID: userCredential.user!.uid,
        username: username,
        email: email,
        name: name,
        password: password,
        token: token as String,
        image: urlImage,
        about: about,
      );

      final json = user.toJson();

      await userSignUp.set(json);
    }
    // final json = {
    //   'username': username,
    //   'email': email,
    //   'password': password,
    // };

    // return false;
  }

  Future<bool> findUserAvailable(String username) async {
    final collectionUsers = FirebaseFirestore.instance.collection('user');
    final userAvailable =
        await collectionUsers.doc(username).get(); //this dapatkan one by one
    return userAvailable.exists;
  }

  void loginUser(String email, String password) async {
    if (email == '' && password == '') {
      return;
    }

    // UserCredential userCredential;

    // userCredential =
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    //   bool decision = false;
    //   String? getEmail;
    //   String? getPassword;
    //   final collectionUser = FirebaseFirestore.instance.collection('user');
    //   final eachUser = await collectionUser.doc(userCredential.user!.uid).get();
    //   eachUser.data()?.forEach((key, value) {
    //     if ((key == 'email' && value.toString() == email)) {
    //       getEmail = value.toString();
    //     }

    //     if ((key == 'password' && value.toString() == password)) {
    //       getPassword = value.toString();
    //     }
    //   });

    //   if (getEmail != null && getPassword != null) {
    //     decision = true;
    //   }

    //   return decision;
  }
}
