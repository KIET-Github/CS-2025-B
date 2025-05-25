import 'package:diet/Elogin_screen.dart';
import 'package:diet/controllers/auth_service.dart';
import 'package:diet/otp_screen.dart';
import 'package:flutter/material.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        // Background Container
        Container(
          color: Color.fromRGBO(18, 167, 225, 0.190),
        ),
        Column(
          children: [
            Container(
              child: Image.asset(
                'assets/Secondary Logo.png',
                width: 300,
                height: 300,
              ),
            ),
            // Foreground Container

            Container(
              padding:
                  EdgeInsetsDirectional.symmetric(vertical: 15, horizontal: 2),
              margin:
                  EdgeInsetsDirectional.symmetric(vertical: 0, horizontal: 15),
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
                      'Hi Welcome! ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(18, 167, 225, 1.000),
                      ),
                    ),
                    const Text(
                      'Submit your Phone Number ',
                      style: TextStyle(
                        color: Color.fromRGBO(18, 167, 225, 1.000),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color.fromRGBO(18, 167, 225, 1.000),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Login or Sign up',
                            style: TextStyle(
                                color: Color.fromRGBO(18, 167, 225, 1.000)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color.fromRGBO(18, 167, 225, 1.000),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          prefixText: "+91 ",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 11, 11, 11)),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        style:
                            const TextStyle(color: Color.fromRGBO(7, 7, 7, 1)),
                        validator: (value) {
                          if (value!.length != 10)
                            return "Invalid phone number";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthService.sentOtp(
                                phone: _phoneController.text,
                                errorStep: () => ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        "Error in sending otp",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                18, 167, 225, 1.000)),
                                      ),
                                      backgroundColor: Colors.red,
                                    )),
                                nextStep: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OtpVerificationScreen(),
                                    ),
                                  );
                                });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(18, 167, 225, 1.000),
                        ),
                        child: const Text(
                          'Get OTP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color.fromRGBO(18, 167, 225, 1.000),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'or',
                            style: TextStyle(
                                color: Color.fromRGBO(18, 167, 225, 1.000)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color.fromRGBO(18, 167, 225, 1.000),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ELoginScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(18, 167, 225, 1.000),
                        ),
                        child: const Text(
                          'Continue with your Email ID',
                          style: TextStyle(color: Colors.white),
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
    );
  }
}
