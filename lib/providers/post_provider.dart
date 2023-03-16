import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      final userPost = FirebaseFirestore.instance.collection('post');

      final json = postModel.toJson(imageFileUrl);
      await userPost.add(json).then((value) => userPost.doc(value.id).update({
            "postID": value.id,
          }));

      // var collection = FirebaseFirestore.instance.collection('test');
      // var docRef = await collection.add({
      //   "test": 'bruh',
      // });
      // var documentId = docRef.id;
      // print(documentId);
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

  Future<String> getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();

    return userData['username'];
  }

  Stream<List<Map<String, dynamic>>> readPost() async* {
    //there is async* and yield* or yield
    // print("here:$username");

    // final username = await getUser();

    yield* FirebaseFirestore.instance
        .collection('post')
        // .where("username", isNotEqualTo: username)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

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

  Future<List<Map<String, dynamic>>> readOwnPost() async {
    final username = await getUser();
    return FirebaseFirestore.instance
        .collection('post')
        .where('username', isEqualTo: username)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  // .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  void removePost(PostModel postModel) {
    //in this place, we will get like id from the user, then well we can delete that,
    //which mean therers going to be check up whos it belogngs to
    // posts.firstWhere((element) => element.dateTime == postModel.dateTime);
    posts.removeWhere((element) => element.dateTime == postModel.dateTime);
  }
}
