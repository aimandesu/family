import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../providers/post_provider.dart';

class PostComment extends StatefulWidget {
  final DateTime dateTime;
  final String username;

  const PostComment({
    super.key,
    required this.username,
    required this.dateTime,
  });

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  bool isExpanded = false;
  bool isPostOpen = false;
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
        color: Theme.of(context).colorScheme.surface,
        backdropTapClosesPanel: false,
        defaultPanelState:
            size.width > width ? PanelState.OPEN : PanelState.CLOSED,
        backdropEnabled: size.width > width ? false : true,
        isDraggable: size.width > width ? false : true,
        onPanelOpened: () => setState(() {
          isExpanded = true;
          isPostOpen = true;
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
              icon: isExpanded
                  ? Container()
                  : const Icon(
                      Icons.comment,
                    ),
            ),
          ],
        ),
        // color: Colors.white,
        minHeight: size.height * 0.05,
        // maxHeight: size.width > width ? size.height * 0.7 : size.height * 0.4,
        maxHeight: size.width > width
            ? size.height > 800
                ? size.height * 0.6
                : size.height * 0.68
            : size.height * 0.6,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        panel:
            //  isExpanded
            //     ?
            Stack(
          children: [
            // isExpanded
            //     ? size.width > width
            //         ? Container()
            //         : isPostOpen
            //             ? const PostCaption()
            //             : Container()
            //     : Container(),
            isExpanded
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      // height: size.height * 0.05,
                      child: IconButton(
                        onPressed: () {
                          _pc.close();
                          setState(() {
                            isPostOpen = false;
                          });
                        },
                        icon: size.width > width
                            ? const Icon(null)
                            : const Icon(
                                Icons.arrow_back_ios,
                              ),
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
                  isPostOpen || size.width > width
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: size.width > width
                                ? size.height * 0.55
                                : size.height * 0.47,
                            width: size.width > width
                                ? size.width * 3 / 7 * 0.97
                                : size.width * 1,
                            child: FutureBuilder(
                              future: Provider.of<PostProvider>(context,
                                      listen: false)
                                  .readPostIndividual(
                                      widget.username, widget.dateTime),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.first['comment']!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'No comments',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot
                                        .data!.first['comment']!.isNotEmpty) {
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        snapshot.data!.first['comment']!.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          snapshot
                                              .data!.first['comment']![index],
                                          style: const TextStyle(),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      : Container(),
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
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        color: Theme.of(context).colorScheme.onSecondary,
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
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                                decoration: InputDecoration.collapsed(
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                                  hintText: "Comment",
                                ),
                                maxLines: null,
                              ),
                            ),
                          ),
                          const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.send,
                            ),
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
