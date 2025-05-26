import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/helper.dart';
import '../../components/rounded_input_field.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontoller = TextEditingController();
  
  forgotpass(context,String email) {
  Timer? timer; // Declare timer as nullable

  if (email == "") {
    return Helper.customAlertBox(context, "Enter an Email To Reset");
  } else {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      showDialog(
          context: context,
          builder: (BuildContext builderContext) {
            timer = Timer(const Duration(seconds: 5), () {
              Navigator.of(context).pop(); // == First dialog closed
            });

            return const AlertDialog(
              title: Text('Request Sent'),
              content: SingleChildScrollView(
                child: Text('Check Your Email Account'),
              ),
            );
          }).then((val) {
        if (timer != null && timer!.isActive) { // Check if timer is not null
          timer!.cancel(); // Cancel timer if it's active
        }
      }).then((value) {
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      return Helper.customAlertBox(context, e.code.toString());
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(
                  255, 24, 96, 252),Color.fromARGB(255, 255, 255, 224), Color.fromARGB(255, 209, 232, 247)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            RoundedInputField(
              labelText: 'Email',
              obscureText: false,
              borderRadius: 40.0,
              controller: emailcontoller,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                forgotpass(context,emailcontoller.text.toString());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Change color as needed
              ),
              child: const Text('Reset Password'),
            ),
          ]),
        ),
      ),
    );
  }
}