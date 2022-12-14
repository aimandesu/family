import 'package:flutter/material.dart';

class PostCaption extends StatelessWidget {
  const PostCaption({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxHeight: size.height * 0.13,
        ),
        // height: size.height * 0.1, //should be flexiable
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: const Offset(2, 1),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
            child:
                // Column(
                //   children: [
                // const Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "Status",
                //     style: TextStyle(fontSize: 25),
                //   ),
                // ),
                // SizedBox(
                //   height: size.height * 0.2,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         flex: 2,
                //         child: Container(
                //           margin: const EdgeInsets.all(5),
                //           height: size.height * 0.075,
                //           decoration: const BoxDecoration(
                //             shape: BoxShape.circle,
                //             image: DecorationImage(
                //               image: NetworkImage(
                //                   "https://picsum.photos/250?image=9"),
                //               fit: BoxFit.contain,
                //             ),
                //           ),
                //         ),
                //       ),
                //       const Expanded(
                //         flex: 4,
                //         child: Text("Kamisato Ayaka"),
                //       ),
                //     ],
                //   ),
                // ),
                Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(5),
            child: const Text(
              "Saya suka makan nasi ayamayam Saya suka makan nasi ayamayam Saya suka makan nasi ayamayam Saya suka makan nasi ayamayam Saya suka makan nasi ayamayam Saya suka makan nasi ayamayam Saya suka makan nasi ayamayam Saya suka makan nasi ayamayam Saya suka makan nasi ayamayam",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        )
            //   ],
            // ),
            ),
      ),
    );
  }
}
