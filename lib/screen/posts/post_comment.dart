import 'package:flutter/material.dart';

class PostComment extends StatefulWidget {
  const PostComment({super.key});

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: isExpanded ? size.height * 0.4 : size.height * 0.05,
        width: size.width * 1,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: isExpanded
            ? Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: size.height * 0.05,
                        child: IconButton(
                          onPressed: () => setState(() {
                            isExpanded = !isExpanded;
                          }),
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.29,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("comment $index"),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: size.width * 0.9,
                                    child: TextFormField(
                                      decoration:
                                          const InputDecoration.collapsed(
                                        hintText: "Comment",
                                      ),
                                    ),
                                  ),
                                ),
                                const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.send),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    icon: Icon(Icons.comment),
                  ),
                  Icon(Icons.heart_broken),
                ],
              ),
      ),
    );
  }
}
