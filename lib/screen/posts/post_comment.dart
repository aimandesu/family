import 'package:family/screen/posts/post_caption.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PostComment extends StatefulWidget {
  const PostComment({super.key});

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  bool isExpanded = false;
  int width = 630;
  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SlidingUpPanel(
        defaultPanelState:
            size.width > width ? PanelState.OPEN : PanelState.CLOSED,
        backdropEnabled: size.width > width ? false : true,
        isDraggable: size.width > width ? false : true,
        onPanelOpened: () => setState(() {
          isExpanded = true;
        }),
        onPanelClosed: () => setState(() {
          isExpanded = false;
        }),
        controller: _pc,
        collapsed: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => _pc.open(),
              icon: isExpanded ? Container() : const Icon(Icons.comment),
            ),
          ],
        ),
        // color: Colors.white,
        minHeight: size.height * 0.05,
        maxHeight: size.width > width ? size.height * 0.7 : size.height * 0.6,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        panel:
            //  isExpanded
            //     ?
            Stack(
          children: [
            isExpanded
                ? size.width > width
                    ? Container()
                    : const PostCaption()
                : Container(),
            isExpanded
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      // height: size.height * 0.05,
                      child: IconButton(
                        onPressed: () => _pc.close(),
                        icon: size.width > width
                            ? const Icon(null)
                            : const Icon(Icons.arrow_back_ios),
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
                    height: size.width > width
                        ? size.height * 0.55
                        : size.height * 0.27,
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      height: size.width > width
                          ? size.width * 0.06
                          : size.height * 0.06,
                      width: size.width > width
                          ? size.width * 3 / 7 * 0.97
                          : size.width * 1,
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
                              // width: size.width * 0.9,
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
