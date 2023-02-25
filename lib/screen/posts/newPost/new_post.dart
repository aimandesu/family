import 'dart:io';

import 'package:family/providers/post_models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/post_provider.dart';

class NewPost extends StatefulWidget {
  static const routeName = "/new-post";

  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _form = GlobalKey<FormState>();
  final statusController = TextEditingController();

  List<File>? _takePhoto = [];

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      _takePhoto!.add(File(imageFile!.path));
    });
    // final savedImage = await File(imageFile!.path);
  }

  // Future<void> _selectPicture() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var postModel = PostModel(
      dateTime: DateTime.now(),
      status: statusController.text,
      image: _takePhoto,
      comment: [],
    );

    Size size = MediaQuery.of(context).size;

    void newPost() {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      postProvider.addPost(postModel);
      Navigator.of(context).pop();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _form,
              child: Positioned(
                top: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 5,
                    top: 5,
                    bottom: 5,
                  ),
                  width: size.width * 1,
                  color: Colors.blue.shade900,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: size.height * 0.075,
                          ),
                          child: TextFormField(
                            controller: statusController,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            decoration:
                                const InputDecoration.collapsed(hintText: null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90,
              child: Container(
                width: size.width * 1,
                height: size.height * 0.7,
                child: _takePhoto!.isEmpty
                    ? IconButton(
                        iconSize: size.height * 0.2,
                        onPressed: () {},
                        icon: const Icon(Icons.no_photography),
                      )
                    : ListView.builder(
                        itemCount: _takePhoto!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Image(
                            width: size.width * 1,
                            image: FileImage(_takePhoto![index]),
                          );
                        },
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                margin: const EdgeInsets.all(10),
                width: size.width * 1,
                color: Colors.blue.shade900,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          color: Colors.blue,
                          onPressed: _takePicture,
                          icon: const Icon(Icons.camera),
                        ),
                        IconButton(
                          color: Colors.blue,
                          onPressed: () {},
                          icon: const Icon(Icons.photo),
                        ),
                      ],
                    ),
                    IconButton(
                      color: Colors.blue,
                      onPressed: newPost,
                      icon: const Icon(Icons.post_add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
