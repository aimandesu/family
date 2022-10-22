import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                  'Kami suka makan nasi ayam di balik timur Japan kerana rasanya yang enak '),
              SizedBox(
                height: size.height * 0.5,
                width: size.width * 1,
                // margin: const EdgeInsets.all(5),
                child: FittedBox(
                  fit: size.width < 550 ? BoxFit.fill : BoxFit.fitHeight,
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ),
              Row(
                children: const [Icon(Icons.comment)],
              )
            ],
          ),
        );
      },
    );
  }
}
