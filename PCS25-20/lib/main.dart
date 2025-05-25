// import 'package:aa_application/home_screen.dart';

import 'package:diet/Homepage/homepage.dart';
import 'package:diet/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: FirebaseOptions(
  //     apiKey: 'AIzaSyAC6PGAQwvbUIrtQZ0_csarsi0lBrhMFqU',
  //     appId: '1:881656851044:android:863a9a14c6a5ce84c04d71',
  //     messagingSenderId: '881656851044',
  //     projectId: 'aaapplication-ca3a0',
  //     storageBucket: 'aaapplication-ca3a0.appspot.com',
  //   ));
  //   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet and workout',
      home: MyHomePage(),
    );
  }
}
