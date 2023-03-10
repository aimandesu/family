import 'package:family/providers/chat_provider.dart';
import 'package:family/providers/login_sign_provider.dart';
import 'package:family/providers/post_provider.dart';
import 'package:family/screen/chat/chat.dart';
import 'package:family/screen/chat/chat_target.dart';
import 'package:family/screen/login/login.dart';
import 'package:family/screen/main/main_screen.dart';
import 'package:family/screen/posts/newPost/new_post.dart';
import 'package:family/screen/posts/posts.dart';
import 'package:family/screen/profile/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //maybe here boleh go to tekan and to the message?
  //idk whats the point of this
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.getInitialMessage();
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
        ),
        ChangeNotifierProvider(
          create: (ctx) => LoginSignProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ChatProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.orange,
            onPrimary: Colors.blue,
            secondary: Colors.transparent,
            onSecondary: Colors.pink,
            error: Colors.red,
            onError: Colors.green,
            background: Colors.yellow,
            onBackground: Colors.teal,
            surface: Colors.blueGrey,
            onSurface: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Login(),
        routes: {
          Profile.routeName: (context) => const Profile(),
          MainScreen.routeName: (context) => const MainScreen(),
          Posts.routeName: (context) => const Posts(),
          NewPost.routeName: (context) => const NewPost(),
          Chat.routeName: (context) => const Chat(),
          ChatTarget.routeName: (context) => const ChatTarget(),
        },
      ),
    );
  }
}
