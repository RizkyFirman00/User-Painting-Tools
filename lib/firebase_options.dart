// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyB1RvuOTilf8roFk6DZ2d1iCUoZ9Xcfe0c',
    appId: '1:420190579067:web:e6ce8ae9d7f30d9806b5de',
    messagingSenderId: '420190579067',
    projectId: 'tools-painting',
    authDomain: 'tools-painting.firebaseapp.com',
    storageBucket: 'tools-painting.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWRuZnQUAPHj0emwJdui5oJ_ioA6XFcOU',
    appId: '1:420190579067:android:32ada7cedb4ba49b06b5de',
    messagingSenderId: '420190579067',
    projectId: 'tools-painting',
    storageBucket: 'tools-painting.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBF_CaS4mr9raF81yzwFfZQNJ4-5JnW6Qc',
    appId: '1:420190579067:ios:2608fe9c0197b6f106b5de',
    messagingSenderId: '420190579067',
    projectId: 'tools-painting',
    storageBucket: 'tools-painting.appspot.com',
    iosClientId: '420190579067-igvgvbf9k62l6esl8u6i0qe0q06bt5kh.apps.googleusercontent.com',
    iosBundleId: 'com.paintingtools.usertools.userPaintingTools',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBF_CaS4mr9raF81yzwFfZQNJ4-5JnW6Qc',
    appId: '1:420190579067:ios:2608fe9c0197b6f106b5de',
    messagingSenderId: '420190579067',
    projectId: 'tools-painting',
    storageBucket: 'tools-painting.appspot.com',
    iosClientId: '420190579067-igvgvbf9k62l6esl8u6i0qe0q06bt5kh.apps.googleusercontent.com',
    iosBundleId: 'com.paintingtools.usertools.userPaintingTools',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB1RvuOTilf8roFk6DZ2d1iCUoZ9Xcfe0c',
    appId: '1:420190579067:web:a83269746f7f641006b5de',
    messagingSenderId: '420190579067',
    projectId: 'tools-painting',
    authDomain: 'tools-painting.firebaseapp.com',
    storageBucket: 'tools-painting.appspot.com',
  );
}