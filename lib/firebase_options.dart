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
    apiKey: 'AIzaSyDqsMa-qblVH-gwJbnYbmqPi9dxSV4Yx3A',
    appId: '1:882926243833:web:5da9943901d58b1f6e3728',
    messagingSenderId: '882926243833',
    projectId: 'linea-profundizacion-2',
    authDomain: 'linea-profundizacion-2.firebaseapp.com',
    storageBucket: 'linea-profundizacion-2.appspot.com',
    measurementId: 'G-TJ25LB9J86',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVgnHEIoucmhhmeYFqe3_w14l-ZZJ_z5Q',
    appId: '1:882926243833:android:8d45fb2dcd9a35716e3728',
    messagingSenderId: '882926243833',
    projectId: 'linea-profundizacion-2',
    storageBucket: 'linea-profundizacion-2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsmIGGMZRJbTAYHjIvEaO0HRvJ0Fi7xpY',
    appId: '1:882926243833:ios:1814bfeef248f5ba6e3728',
    messagingSenderId: '882926243833',
    projectId: 'linea-profundizacion-2',
    storageBucket: 'linea-profundizacion-2.appspot.com',
    iosClientId: '882926243833-7iuakn2oupuoon2c83reth5ocjmc31l8.apps.googleusercontent.com',
    iosBundleId: 'com.example.lineaDeProfundizacion2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBsmIGGMZRJbTAYHjIvEaO0HRvJ0Fi7xpY',
    appId: '1:882926243833:ios:1814bfeef248f5ba6e3728',
    messagingSenderId: '882926243833',
    projectId: 'linea-profundizacion-2',
    storageBucket: 'linea-profundizacion-2.appspot.com',
    iosClientId: '882926243833-7iuakn2oupuoon2c83reth5ocjmc31l8.apps.googleusercontent.com',
    iosBundleId: 'com.example.lineaDeProfundizacion2',
  );
}
