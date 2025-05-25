// import 'package:aa_application/home_screen.dart';

import 'package:diet/Homepage/homepage.dart';
import 'package:diet/Homepage/meal.dart';
import 'package:diet/controllers/authFunctions.dart';
import 'package:diet/verification_screen.dart';
import 'package:diet/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool login = false;
  int myindex = 0;
  List<Widget> widgetList = [
    MyHomePage(),
    workoutScreens(),
    MealScreens(),
    LoginScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login/Signup Screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(18, 167, 225, 1.000),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(18, 167, 225, 0.190),
          ),
          Column(
            children: [
              Container(
                child: Image.asset(
                  'assets/Secondary Logo.png',
                  width: 300,
                  height: 200,
                ),
              ),
              Container(
                height: 430,
                padding:
                    EdgeInsetsDirectional.symmetric(vertical: 1, horizontal: 2),
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
                  child: Form(
                    key: _formKey,
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
                          'Submit your Details ',
                          style: TextStyle(
                            color: Color.fromRGBO(18, 167, 225, 1.000),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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
                                  color: Color.fromRGBO(18, 167, 225, 1.000),
                                ),
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
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              login
                                  ? Container()
                                  : SizedBox(
                                      height: 50,
                                      child: TextFormField(
                                        key: const ValueKey('fullname'),
                                        controller: fullnameController,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Full Name',
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter Full Name';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  key: const ValueKey('email'),
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    border: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              // SizedBox(
                              //   height: 20,
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  key: const ValueKey('password'),
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black)),
                                  ),
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return 'Please enter a password with a minimum length of 6 characters';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Container(
                                height: 40,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    print('Button pressed');
                                    print(
                                        'Full Name: ${fullnameController.text}');
                                    print('Email: ${emailController.text}');
                                    print(
                                        'Password: ${passwordController.text}');

                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      print('Form validated');
                                      _formKey.currentState?.save();
                                      print('Form saved');

                                      if (login) {
                                        print('Attempting login');
                                        await AuthServices.signinUser(
                                            emailController.text,
                                            passwordController.text,
                                            context);

                                        User? currentUser =
                                            FirebaseAuth.instance.currentUser;
                                        if (currentUser != null) {
                                          print(
                                              'User logged in: ${currentUser.displayName} (${currentUser.email})');
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationSuccessScreen(),
                                            ),
                                          );
                                        } else {
                                          print('User login failed');
                                        }
                                      } else {
                                        print('Attempting signup');
                                        await AuthServices.signupUser(
                                            emailController.text,
                                            passwordController.text,
                                            fullnameController.text,
                                            context);

                                        User? currentUser =
                                            FirebaseAuth.instance.currentUser;
                                        if (currentUser != null) {
                                          print(
                                              'User signed up: ${currentUser.displayName} (${currentUser.email})');
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationSuccessScreen(),
                                            ),
                                          );
                                        } else {
                                          print('User signup failed');
                                        }
                                      }
                                    } else {
                                      print('Form validation failed');
                                      // Additional debug information
                                      if (emailController.text.isEmpty ||
                                          !emailController.text.contains('@')) {
                                        print('Email validation failed');
                                      }
                                      if (passwordController.text.length < 6) {
                                        print('Password validation failed');
                                      }
                                      // Add similar checks for other fields
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(18, 167, 225, 1.000),
                                  ),
                                  child: Text(
                                    login ? 'Login' : 'Signup',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set text color to white
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    login = !login;
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (conntext)=>MyHomePage()));
                                },
                                child: Text(
                                  login
                                      ? "Don't have an account? Signup"
                                      : "Already have an account? Login",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 246, 247, 248),
        currentIndex: myindex,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
          for (int i = 0; i < 4; i++) {
            if (index == i) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widgetList[i]),
              );
            }
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: " ",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded), label: " "),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_sharp),
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: " ",
          ),
        ],
      ),
    );
  }
}
