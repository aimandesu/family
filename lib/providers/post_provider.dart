import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/post_models.dart';

class PostProvider with ChangeNotifier {
  final List<PostModel> _posts = [];

  List<PostModel> get posts {
    return [..._posts];
  }

  void addPost(PostModel postModel) {
    _posts.add(postModel);
    notifyListeners();
  }

  Future<void> createPost(PostModel postModel) async {
    if (postModel.image!.isEmpty) return;

    String pathToTake = postModel.username;
    String dateTimePost = DateTime.now().toIso8601String();

    List<String> imageFileUrl = [];

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory = referenceRoot.child('post/');

    try {
      for (int i = 0; i < postModel.image!.length; i++) {
        // String filePathName = postModel.image![i].path;
        Reference referenceImageToUpload =
            referenceDirectory.child('$pathToTake/$dateTimePost/$i');
        await referenceImageToUpload.putFile(postModel.image![i]);
        final urlImages = await referenceImageToUpload.getDownloadURL();
        imageFileUrl.add(urlImages);
        // print(imageFileUrl.length);
      }
    } catch (e) {
      // print(e);
    } finally {
      final userPost = FirebaseFirestore.instance.collection('post').doc();

      final json = postModel.toJson(imageFileUrl);
      await userPost.set(json);
    }

    notifyListeners();
  }

  List<PostModel> fetchPosts() {
    return posts;
  }

  //change to future build
  Future<List<PostModel>> fetchPostsFuture() async {
    return posts;
  }

  Stream<List<Map<String, dynamic>>> readPost() => FirebaseFirestore.instance
      .collection('post')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  PostModel fetchPostIndividual(DateTime dateTime) {
    return posts.firstWhere((element) => element.dateTime == dateTime);
  }

  Future<List<Map<String, dynamic>>> readPostIndividual(
          String username, DateTime dateTime) =>
      FirebaseFirestore.instance
          .collection('post')
          .where('username', isEqualTo: username)
          .where('dateTime', isEqualTo: dateTime)
          .get()
          .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  //we going to change to future build
  Future<PostModel> fetchPostIndividualFuture(DateTime dateTime) async {
    return posts.firstWhere((element) => element.dateTime == dateTime);
  }

  Future<List<Map<String, dynamic>>> readOwnPost() => FirebaseFirestore.instance
      .collection('post')
      .where('username', isEqualTo: 'aiman')
      .get()
      .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  // .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  void removePost(PostModel postModel) {
    //in this place, we will get like id from the user, then well we can delete that,
    //which mean therers going to be check up whos it belogngs to
    // posts.firstWhere((element) => element.dateTime == postModel.dateTime);
    posts.removeWhere((element) => element.dateTime == postModel.dateTime);
  }
}
