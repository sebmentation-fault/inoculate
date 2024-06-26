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
    apiKey: 'AIzaSyAov7V6iae8MvnhujTXZK6f0O9WLMHM39U',
    appId: '1:831325880216:web:31e928c020acadbd1c35ed',
    messagingSenderId: '831325880216',
    projectId: 'fake-news-inoculation-game',
    authDomain: 'fake-news-inoculation-game.firebaseapp.com',
    databaseURL: 'https://fake-news-inoculation-game-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fake-news-inoculation-game.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZWQLFHp4o0Vp56E9KUBqWAiBTP7Uip6A',
    appId: '1:831325880216:android:fcc805b9ce2124ec1c35ed',
    messagingSenderId: '831325880216',
    projectId: 'fake-news-inoculation-game',
    databaseURL: 'https://fake-news-inoculation-game-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fake-news-inoculation-game.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpB5UVx78d1mUidOVO9GDd5shefmWqFqc',
    appId: '1:831325880216:ios:c1302070b889d14e1c35ed',
    messagingSenderId: '831325880216',
    projectId: 'fake-news-inoculation-game',
    databaseURL: 'https://fake-news-inoculation-game-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fake-news-inoculation-game.appspot.com',
    iosBundleId: 'com.example.inoculate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDpB5UVx78d1mUidOVO9GDd5shefmWqFqc',
    appId: '1:831325880216:ios:62b2e750d2e6222c1c35ed',
    messagingSenderId: '831325880216',
    projectId: 'fake-news-inoculation-game',
    databaseURL: 'https://fake-news-inoculation-game-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fake-news-inoculation-game.appspot.com',
    iosBundleId: 'com.example.inoculate.RunnerTests',
  );
}
