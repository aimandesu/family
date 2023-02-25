import 'package:flutter/material.dart';

import 'post_models.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _posts = [];

  List<PostModel> get posts {
    return [..._posts];
  }

  void addPost(PostModel postModel) {
    _posts.add(postModel);
    notifyListeners();
  }

  List<PostModel> fetchPosts() {
    return posts;
  }

  PostModel fetchPostIndividual(DateTime dateTime) {
    return posts.firstWhere((element) => element.dateTime == dateTime);
  }

  //we going to change to future build
  Future<PostModel> fetchPostIndividualFuture(DateTime dateTime) async {
    return posts.firstWhere((element) => element.dateTime == dateTime);
  }

  void removePost(PostModel postModel) {
    //in this place, we will get like id from the user, then well we can delete that,
    //which mean therers going to be check up whos it belogngs to
    // posts.firstWhere((element) => element.dateTime == postModel.dateTime);
    posts.removeWhere((element) => element.dateTime == postModel.dateTime);
  }
}
