import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PostComment extends StatefulWidget {
  const PostComment({super.key});

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  bool isExpanded = false;
  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SlidingUpPanel(
        backdropEnabled: true,
        onPanelOpened: () => setState(() {
          isExpanded = true;
        }),
        onPanelClosed: () => setState(() {
          isExpanded = false;
        }),
        controller: _pc,
        collapsed: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => _pc.open(),
                icon: const Icon(Icons.comment),
              ),
            ],
          ),
        ),
        // color: Colors.white,
        minHeight: size.height * 0.05,
        maxHeight: size.height * 0.4,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        panel:
            //  isExpanded
            //     ?
            Stack(
          children: [
            isExpanded
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: IconButton(
                        onPressed: () => _pc.close(),
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.27,
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
                              decoration: const InputDecoration.collapsed(
                                hintText: "Comment",
                              ),
                              maxLines: null,
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

        // : Row(
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           setState(() {
        //             isExpanded = !isExpanded;
        //           });
        //         },
        //         icon: Icon(Icons.comment),
        //       ),
        //       Icon(Icons.heart_broken),
        //     ],
        //   ),
      ),
    );
  }
}
