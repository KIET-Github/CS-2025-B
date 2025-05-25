import 'dart:async';

import 'package:diet/Homepage/homepage.dart';
import 'package:flutter/material.dart';

class VerificationSuccessScreen extends StatefulWidget {
  State<VerificationSuccessScreen> createState() =>
      _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState extends State<VerificationSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Navigating to the login screen after 3 minutes
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
      );
    });
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(187, 222, 251, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Icon(
              Icons.check_circle,
              shadows: [
                Shadow(blurRadius: 500, color: Colors.white),
              ],
              size: 150,
              color: Color.fromRGBO(18, 167, 225, 1.000),
            ),
          ],
        ),
      ),
    );
  }
}
