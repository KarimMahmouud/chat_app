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
    apiKey: 'AIzaSyBH6AOmk9hnQqadJ4buRJuSlXyFr1rZjmI',
    appId: '1:279212255480:web:c528f6f7c93857cd1db30d',
    messagingSenderId: '279212255480',
    projectId: 'chat-12bb7',
    authDomain: 'chat-12bb7.firebaseapp.com',
    storageBucket: 'chat-12bb7.appspot.com',
    measurementId: 'G-SQZ7G3QE2S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8MiyGztXgTxS6z5jVh7B0XLIp0wRBnG0',
    appId: '1:279212255480:android:7e21ca805d26a4ed1db30d',
    messagingSenderId: '279212255480',
    projectId: 'chat-12bb7',
    storageBucket: 'chat-12bb7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSFOJpgQf9t3aVo_EeOSuMj1mUzM7rhIY',
    appId: '1:279212255480:ios:52260924c1aea3841db30d',
    messagingSenderId: '279212255480',
    projectId: 'chat-12bb7',
    storageBucket: 'chat-12bb7.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSFOJpgQf9t3aVo_EeOSuMj1mUzM7rhIY',
    appId: '1:279212255480:ios:beb40b6873de66c51db30d',
    messagingSenderId: '279212255480',
    projectId: 'chat-12bb7',
    storageBucket: 'chat-12bb7.appspot.com',
    iosBundleId: 'com.example.chat.RunnerTests',
  );
}
