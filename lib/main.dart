import 'package:family/providers/post_provider.dart';
import 'package:family/screen/login/login.dart';
import 'package:family/screen/main/main_screen.dart';
import 'package:family/screen/posts/newPost/new_post.dart';
import 'package:family/screen/posts/posts.dart';
import 'package:family/screen/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PostProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.grey.shade900,
        ),
        debugShowCheckedModeBanner: false,
        home: const Login(),
        routes: {
          Profile.routeName: (context) => const Profile(),
          MainScreen.routeName: (context) => const MainScreen(),
          Posts.routeName: (context) => const Posts(),
          NewPost.routeName: (context) => const NewPost(),
        },
      ),
    );
  }
}
