import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginSignProvider with ChangeNotifier {
  Future<void> createUser(
    String username,
    String email,
    String password,
  ) async {
    final userSignUp =
        FirebaseFirestore.instance.collection('user').doc(username);

    final user = UserModel(
      username: username,
      email: email,
      name: 'li',
      password: password,
    );

    final json = user.toJson();

    // final json = {
    //   'username': username,
    //   'email': email,
    //   'password': password,
    // };

    await userSignUp.set(json);
  }
}
