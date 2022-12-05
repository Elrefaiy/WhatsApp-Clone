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
    apiKey: 'AIzaSyAwXHvql26Sd2UnKG4Lipd67kAHEenaTkA',
    appId: '1:788113031823:web:a8528057188540ee8666fa',
    messagingSenderId: '788113031823',
    projectId: 'whatsapp-clone-61959',
    authDomain: 'whatsapp-clone-61959.firebaseapp.com',
    storageBucket: 'whatsapp-clone-61959.appspot.com',
    measurementId: 'G-6HWYVK31R0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsFeUVNi8FlEYnfUY2tyV71qfHjEO2Tr0',
    appId: '1:788113031823:android:02e364df7898a21d8666fa',
    messagingSenderId: '788113031823',
    projectId: 'whatsapp-clone-61959',
    storageBucket: 'whatsapp-clone-61959.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_uoiZiWJuQa6WGiDx15XlXFkZiSAxaTo',
    appId: '1:788113031823:ios:a53fcb3f920d6a878666fa',
    messagingSenderId: '788113031823',
    projectId: 'whatsapp-clone-61959',
    storageBucket: 'whatsapp-clone-61959.appspot.com',
    iosClientId: '788113031823-m39rk0s2es8bh27fhnjmnhuk4dlkuib7.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_uoiZiWJuQa6WGiDx15XlXFkZiSAxaTo',
    appId: '1:788113031823:ios:a53fcb3f920d6a878666fa',
    messagingSenderId: '788113031823',
    projectId: 'whatsapp-clone-61959',
    storageBucket: 'whatsapp-clone-61959.appspot.com',
    iosClientId: '788113031823-m39rk0s2es8bh27fhnjmnhuk4dlkuib7.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappClone',
  );
}
