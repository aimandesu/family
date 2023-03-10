// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD_rcCdOx4oQjoZ16qqOeJ0LZfWtKKpsjM',
    appId: '1:741997275356:web:e97ed02e47842a72ac6c19',
    messagingSenderId: '741997275356',
    projectId: 'family-d444f',
    authDomain: 'family-d444f.firebaseapp.com',
    databaseURL: 'https://family-d444f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'family-d444f.appspot.com',
    measurementId: 'G-T1MPMVJ5F0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB92cr4uiT9Wp3L0hQqxrOa7G3nYGb5fKI',
    appId: '1:741997275356:android:c2666327ff65ad6cac6c19',
    messagingSenderId: '741997275356',
    projectId: 'family-d444f',
    databaseURL: 'https://family-d444f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'family-d444f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDen5m8i5jT8Mui8GXjI2dUGCWALY4TvA0',
    appId: '1:741997275356:ios:2a7c2b25b31b23beac6c19',
    messagingSenderId: '741997275356',
    projectId: 'family-d444f',
    databaseURL: 'https://family-d444f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'family-d444f.appspot.com',
    iosClientId: '741997275356-p5ik7nhq510upg9g6qn913c6hokmt9gg.apps.googleusercontent.com',
    iosBundleId: 'com.example.family',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDen5m8i5jT8Mui8GXjI2dUGCWALY4TvA0',
    appId: '1:741997275356:ios:2a7c2b25b31b23beac6c19',
    messagingSenderId: '741997275356',
    projectId: 'family-d444f',
    databaseURL: 'https://family-d444f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'family-d444f.appspot.com',
    iosClientId: '741997275356-p5ik7nhq510upg9g6qn913c6hokmt9gg.apps.googleusercontent.com',
    iosBundleId: 'com.example.family',
  );
}