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
    apiKey: 'AIzaSyCAS2hl06Svlrw0Zom5N1zoiRiA9U9qFzs',
    appId: '1:856973057878:web:ca740ed5c81cf45b00c0f7',
    messagingSenderId: '856973057878',
    projectId: 'health-care-f0096',
    authDomain: 'health-care-f0096.firebaseapp.com',
    storageBucket: 'health-care-f0096.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnpA3KU7EJBK2naNuxjNxbu8iOeY47myw',
    appId: '1:856973057878:android:de7386991592440500c0f7',
    messagingSenderId: '856973057878',
    projectId: 'health-care-f0096',
    storageBucket: 'health-care-f0096.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABu7NBIjwW2LDzdmev2e_9j1Sl6ItVTlU',
    appId: '1:856973057878:ios:ab9498b37ca8874e00c0f7',
    messagingSenderId: '856973057878',
    projectId: 'health-care-f0096',
    storageBucket: 'health-care-f0096.appspot.com',
    iosBundleId: 'com.fandiaziz.bleClient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABu7NBIjwW2LDzdmev2e_9j1Sl6ItVTlU',
    appId: '1:856973057878:ios:fee620daddc978bb00c0f7',
    messagingSenderId: '856973057878',
    projectId: 'health-care-f0096',
    storageBucket: 'health-care-f0096.appspot.com',
    iosBundleId: 'com.fandiaziz.bleClient.RunnerTests',
  );
}