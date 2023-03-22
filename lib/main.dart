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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'providers/comment_provider.dart';
import 'screen/search/search.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //maybe here boleh go to tekan and to the message?
  //idk whats the point of this
}

Future<bool> getTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('UserTheme') ?? false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final themeColor = await getTheme();
  // print(themeColor);
  runApp(MyApp(
    isDark: themeColor,
  ));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.getInitialMessage();

  // await SharedPreferences.getInstance();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
}

//ignore: must_be_immutable
class MyApp extends StatefulWidget {
  bool isDark;
  MyApp({super.key, required this.isDark});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // SharedPreferences? prefs;
  // bool changeColor = false;

  Brightness dark = Brightness.dark;

  void changeTheme() async {
    setState(() {
      widget.isDark = !widget.isDark;
    });
    await saveUserTheme(widget.isDark);
    // print(changeColor);
  }

  Future<void> saveUserTheme(bool chosenTheme) async {
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('UserTheme', chosenTheme);
  }

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
        ),
        ChangeNotifierProvider(
          create: (ctx) => CommentProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: widget.isDark ? dark : Brightness.light,
            primary: Colors.pink,
            onPrimary: Colors.white,
            secondary: Colors.purple,
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
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // return const SignUp();
              if (snapshot.hasData) {
                return const MainScreen();
              } else {
                return Login(
                  changeTheme: changeTheme,
                );
              }
            }),
        routes: {
          Profile.routeName: (context) => const Profile(),
          // MainScreen.routeName: (context) => const MainScreen(),
          Chat.routeName: (context) => const Chat(),
          ChatTarget.routeName: (context) => const ChatTarget(),
          Posts.routeName: (context) => const Posts(),
          NewPost.routeName: (context) => const NewPost(),
          Search.routeName: (context) => const Search(),
          // SignUp.routeName: (context) => const SignUp(),
          // CommentReply.routeName: (context) => const CommentReply(),
        },
      ),
    );
  }
}
