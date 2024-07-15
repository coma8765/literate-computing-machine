// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:todo/src/core/core.dart';

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
        return isProduction ? androidProduction : androidDevelopment;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyABCXpG8oDXtnVVIQ732YUEQWaJsRBpXho',
    appId: '1:568139536946:web:537821e2dfd17664567a2b',
    messagingSenderId: '568139536946',
    projectId: 'dev-coma8765-todos',
    authDomain: 'dev-coma8765-todos.firebaseapp.com',
    storageBucket: 'dev-coma8765-todos.appspot.com',
    measurementId: 'G-4EBBQXBH45',
  );

  static const FirebaseOptions androidProduction = FirebaseOptions(
    apiKey: 'AIzaSyDprveJB251_90wiG8BZGD_4y76Neewvjo',
    appId: '1:568139536946:android:c3099e3d96b05266567a2b',
    messagingSenderId: '568139536946',
    projectId: 'dev-coma8765-todos',
    storageBucket: 'dev-coma8765-todos.appspot.com',
  );

  static const FirebaseOptions androidDevelopment = FirebaseOptions(
    apiKey: 'AIzaSyDprveJB251_90wiG8BZGD_4y76Neewvjo',
    appId: '1:568139536946:android:3ca25407c950ea5f567a2b',
    messagingSenderId: '568139536946',
    projectId: 'dev-coma8765-todos',
    storageBucket: 'dev-coma8765-todos.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC20bGw9QgnYK2miLpUZCwBoCXiZSj8xz4',
    appId: '1:568139536946:ios:53bef15af2b9d8aa567a2b',
    messagingSenderId: '568139536946',
    projectId: 'dev-coma8765-todos',
    storageBucket: 'dev-coma8765-todos.appspot.com',
    iosBundleId: 'dev.coma8765.todo',
  );
}
