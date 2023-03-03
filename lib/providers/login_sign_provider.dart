import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginSignProvider with ChangeNotifier {
  Future<bool> createUser(
    String username,
    String email,
    String password,
  ) async {
    final userSignUp =
        FirebaseFirestore.instance.collection('user').doc(username);

    // if (await findUserAvailable(username)) {
    //   return true;
    // }

    final user = UserModel(
      username: username,
      email: email,
      name: '',
      password: password,
    );

    final json = user.toJson();

    // final json = {
    //   'username': username,
    //   'email': email,
    //   'password': password,
    // };

    await userSignUp.set(json);
    return false;
  }

  Future<bool> findUserAvailable(String username) async {
    final collectionUsers = FirebaseFirestore.instance.collection('user');
    final userAvailable =
        await collectionUsers.doc(username).get(); //this dapatkan one by one
    return userAvailable.exists;
  }

  Future<bool> loginUser(String username, String password) async {
    if (username == '' && password == '') {
      return false;
    }

    bool decision = false;
    String? getUsername;
    String? getPassword;
    final collectionUser = FirebaseFirestore.instance.collection('user');
    final eachUser = await collectionUser.doc(username).get();
    eachUser.data()?.forEach((key, value) {
      if ((key == 'username' && value.toString() == username)) {
        getUsername = value.toString();
      }

      if ((key == 'password' && value.toString() == password)) {
        getPassword = value.toString();
      }
    });

    if (getUsername != null && getPassword != null) {
      decision = true;
    }

    return decision;
  }
}
