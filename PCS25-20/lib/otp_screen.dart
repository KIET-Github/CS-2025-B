import 'package:diet/controllers/auth_service.dart';
import 'package:diet/verification_screen.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            height: 1000,
            color: Color.fromRGBO(18, 167, 225, 0.190),
          ),
          Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: Image.asset(
                    'assets/Secondary Logo.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: 15, horizontal: 2),
                margin: EdgeInsetsDirectional.symmetric(
                    vertical: 0, horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(18, 167, 225, 1.000),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '6 Digit code has been sent to your number',
                        style: TextStyle(
                          color: Color.fromRGBO(18, 167, 225, 1.000),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _otpController,
                          decoration: const InputDecoration(
                            labelText: 'OTP',
                            prefixIcon: Icon(
                              Icons.security,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value!.length != 6) return "Invalid OTP";
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AuthService.loginWithOtp(
                                otp: _otpController.text,
                              ).then((value) {
                                if (value == "Success") {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VerificationSuccessScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Wrong otp",
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                              18, 167, 225, 1.000),
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromRGBO(18, 167, 225, 1.000),
                          ),
                          child: const Text(
                            'Verify OTP',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: Color.fromRGBO(18, 167, 225, 1.000),
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(text: 'If you did not receive a code! '),
                            TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                color: Color.fromRGBO(18, 167, 225, 1.000),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {
                            // Add your button's functionality here
                          },
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Change Mobile Number',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
