import 'dart:async';

import 'package:diet/Homepage/homepage.dart';
import 'package:diet/controllers/auth_service.dart';
import 'package:diet/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Navigating to the login screen after 3 minutes
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const CheckUserLoggedInOrNot(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class CheckUserLoggedInOrNot extends StatelessWidget {
  const CheckUserLoggedInOrNot({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // User is logged in
          return const MyHomePage();
        } else {
          // User is not logged in, check if phone or email auth
          return FutureBuilder<bool>(
            future: AuthService.isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == true) {
                  // User is logged in with phone auth
                  return const MyHomePage();
                } else {
                  // User is not logged in with phone auth, use email auth
                  return const LoginScreens();
                }
              } else {
                // Future is still loading
                return const CircularProgressIndicator();
              }
            },
          );
        }
      },
    );
  }
}
