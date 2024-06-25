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
    apiKey: 'AIzaSyCol9COa5W0m7ZpbWSd-9LjfD4n6-wuBy4',
    appId: '1:714323818450:web:399622cff15050dabdfa0b',
    messagingSenderId: '714323818450',
    projectId: 'skin-a696b',
    authDomain: 'skin-a696b.firebaseapp.com',
    storageBucket: 'skin-a696b.appspot.com',
    measurementId: 'G-Q9F7LNR4VW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3AtFQNnPVQMLHlr1Zff8b4DvLM8EaNRU',
    appId: '1:714323818450:android:81386418975f9ec0bdfa0b',
    messagingSenderId: '714323818450',
    projectId: 'skin-a696b',
    storageBucket: 'skin-a696b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXAuGOBWxAksW9yc4yiGA4dvE2m2EQk5k',
    appId: '1:714323818450:ios:77fea0c9f972302bbdfa0b',
    messagingSenderId: '714323818450',
    projectId: 'skin-a696b',
    storageBucket: 'skin-a696b.appspot.com',
    iosClientId: '714323818450-2oe0c9agjt77rge0mgeuje232o7m0ghc.apps.googleusercontent.com',
    iosBundleId: 'com.example.det',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDXAuGOBWxAksW9yc4yiGA4dvE2m2EQk5k',
    appId: '1:714323818450:ios:77fea0c9f972302bbdfa0b',
    messagingSenderId: '714323818450',
    projectId: 'skin-a696b',
    storageBucket: 'skin-a696b.appspot.com',
    iosClientId: '714323818450-2oe0c9agjt77rge0mgeuje232o7m0ghc.apps.googleusercontent.com',
    iosBundleId: 'com.example.det',
  );
}