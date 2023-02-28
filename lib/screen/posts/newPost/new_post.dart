import 'dart:io';

import 'package:family/models/post_models.dart';
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

    if (imageFile == null) {
      return;
    }

    setState(() {
      _takePhoto!.add(File(imageFile.path));
    });
    // final savedImage = await File(imageFile!.path);
  }

  void _removePicture(int index) {
    setState(() {
      _takePhoto = _takePhoto!..removeAt(index);
    });
    Navigator.of(context).pop();
  }

  // Future<void> _selectPicture() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var postModel = PostModel(
      username: '',
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
                  color: Theme.of(context).colorScheme.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: size.height * 0.075,
                          ),
                          child: TextFormField(
                            controller: statusController,
                            style: const TextStyle(),
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
              child: SizedBox(
                width: size.width * 1,
                height: size.height * 0.7,
                child: _takePhoto!.isEmpty
                    ? IconButton(
                        iconSize: size.height * 0.2,
                        onPressed: _takePicture,
                        icon: const Icon(Icons.photo),
                      )
                    : ListView.builder(
                        itemCount: _takePhoto!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 60),
                                    child: Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: SizedBox(
                                        height: 70,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextButton(
                                            onPressed: () =>
                                                _removePicture(index),
                                            child: const Text(
                                              'Remove picture',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image(
                              width: size.width * 1,
                              image: FileImage(_takePhoto![index]),
                            ),
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
                color: Theme.of(context).colorScheme.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: _takePicture,
                          icon: const Icon(Icons.camera),
                        ),
                        const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.map),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.photo),
                        ),
                      ],
                    ),
                    IconButton(
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
