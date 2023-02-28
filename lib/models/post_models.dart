import 'dart:io';

class PostModel {
  final String username;
  final DateTime dateTime;
  final String status;
  final List<File>? image;
  final List<String>? comment;

  PostModel({
    required this.username,
    required this.dateTime,
    required this.status,
    required this.image,
    required this.comment,
  });
}
