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
    apiKey: 'AIzaSyDz7LU36T5tJw2bx-o6zUIyKf0n4Jr2Atg',
    appId: '1:559354982479:web:9e127e862e7c80723a7a3a',
    messagingSenderId: '559354982479',
    projectId: 'salonyuser',
    authDomain: 'salonyuser.firebaseapp.com',
    storageBucket: 'salonyuser.appspot.com',
    measurementId: 'G-PHR67W99CQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCI-G6YMnxkYZaRZHcG_7I7ixbz_Z9qcQI',
    appId: '1:559354982479:android:cfa4a943152d96503a7a3a',
    messagingSenderId: '559354982479',
    projectId: 'salonyuser',
    storageBucket: 'salonyuser.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7tQD9d-eleQrDzXGVe7Nq_DEjAx87SmU',
    appId: '1:559354982479:ios:c3589d34d5b139633a7a3a',
    messagingSenderId: '559354982479',
    projectId: 'salonyuser',
    storageBucket: 'salonyuser.appspot.com',
    iosBundleId: 'com.gofresha.app',
  );
}
