import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCqw92bjI4CcDOIBUNMPyEE5KuIQSwTFTA',
    appId: '1:167483585714:web:021138f2f3959e5a9285ab',
    messagingSenderId: '167483585714',
    projectId: 'lvystor',
    authDomain: 'lvystor.firebaseapp.com',
    databaseURL: 'https://lvystor.firebaseio.com',
    storageBucket: 'lvystor.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqw92bjI4CcDOIBUNMPyEE5KuIQSwTFTA',
    appId: '1:167483585714:android:021138f2f3959e5a9285ab',
    messagingSenderId: '167483585714',
    projectId: 'lvystor',
    databaseURL: 'https://lvystor.firebaseio.com',
    storageBucket: 'lvystor.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqw92bjI4CcDOIBUNMPyEE5KuIQSwTFTA',
    appId: '1:167483585714:ios:021138f2f3959e5a9285ab',
    messagingSenderId: '167483585714',
    projectId: 'lvystor',
    databaseURL: 'https://lvystor.firebaseio.com',
    storageBucket: 'lvystor.firebasestorage.app',
    iosBundleId: 'com.example.lvystor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqw92bjI4CcDOIBUNMPyEE5KuIQSwTFTA',
    appId: '1:167483585714:macos:021138f2f3959e5a9285ab',
    messagingSenderId: '167483585714',
    projectId: 'lvystor',
    databaseURL: 'https://lvystor.firebaseio.com',
    storageBucket: 'lvystor.firebasestorage.app',
    iosBundleId: 'com.example.lvystor',
  );
}
