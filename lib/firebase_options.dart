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
    apiKey: 'AIzaSyBgKbpgVPfqj8txEItRkmoFx4bzrp2DC4k',
    appId: '1:684068065529:web:e11bb2026aa7af1a905228',
    messagingSenderId: '684068065529',
    projectId: 'cosmocare-c2fec',
    authDomain: 'cosmocare-c2fec.firebaseapp.com',
    storageBucket: 'cosmocare-c2fec.appspot.com',
    measurementId: 'G-YLVK7LGXYL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdH7obDZj0lmtBrSvxlCZCeoWjhnmO0jQ',
    appId: '1:684068065529:android:6d3ae49cb0c6fb8a905228',
    messagingSenderId: '684068065529',
    projectId: 'cosmocare-c2fec',
    storageBucket: 'cosmocare-c2fec.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBplJwyIJMQ9PVDgNFdG_-Llz5Ut29uR8',
    appId: '1:684068065529:ios:17901ccd13b5f75c905228',
    messagingSenderId: '684068065529',
    projectId: 'cosmocare-c2fec',
    storageBucket: 'cosmocare-c2fec.appspot.com',
    iosClientId: '684068065529-fl95gpcgk71b05qsf9278hn1t5d6ijgg.apps.googleusercontent.com',
    iosBundleId: 'com.example.appRelease2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBplJwyIJMQ9PVDgNFdG_-Llz5Ut29uR8',
    appId: '1:684068065529:ios:17901ccd13b5f75c905228',
    messagingSenderId: '684068065529',
    projectId: 'cosmocare-c2fec',
    storageBucket: 'cosmocare-c2fec.appspot.com',
    iosClientId: '684068065529-fl95gpcgk71b05qsf9278hn1t5d6ijgg.apps.googleusercontent.com',
    iosBundleId: 'com.example.appRelease2',
  );
}
