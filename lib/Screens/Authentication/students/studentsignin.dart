import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edubridge/Screens/Dashboard/students/homepage_student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/rounded_input_field.dart';
import '../forgetpassword.dart';
import 'studentsignup.dart';

class StudentSignInPage extends StatefulWidget {
  const StudentSignInPage({super.key});

  @override
  State<StudentSignInPage> createState() => _StudentSignInPageState();
}

class _StudentSignInPageState extends State<StudentSignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
          title: const Center(
        child: Text(
          'EduBridge',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 22, 13, 53)),
        ),
      )),
      body: SingleChildScrollView(
        child: Container(
           width: 400,
            height: 800,
          decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(
                    255, 24, 96, 252),Color.fromARGB(255, 255, 255, 224), Color.fromARGB(255, 209, 232, 247)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:  _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Show CircularProgressIndicator if loading
              : Column(
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const Text(
                      'Student Sign In',
                      style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 16.0),
                    RoundedInputField(
                      labelText: 'Email',
                      obscureText: false,
                      borderRadius: 40.0,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16.0),
                    RoundedInputField(
                      labelText: 'Password',
                      obscureText: !_showPassword,
                      borderRadius: 40.0,
                      controller: _passwordController,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _performLogin,
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        fixedSize: const Size(180, 50),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: _navigateToUserSignIn,
                      // child: const Text('Create New Admin Account'),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: 'Create New User Account \n'),
                            TextSpan(
                              text: 'Register Now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToUserSignIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (contrxt) => const StudentSignUpPage()),
        (route) => false);
  }

  void _performLogin() async {
    
    setState(() {
      _isLoading = true; // Set loading state to true
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Check if the signed-in user is an admin
      String? userEmail = userCredential.user?.email;
      if (userEmail != null && await _isStudent(userEmail)) {
        // Navigate to the admin home page
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const StudentHomePage()),
            (route) => false);
      } else {
        // Not an admin, show error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'You are not authorized to access the admin panel.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Show error message if sign-in fails
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to sign in: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false; // Set loading state to false
      });
    }
  }

  Future<bool> _isStudent(String email) async {
    try {
      // Query Firestore to check if the user is an admin
      final adminSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('email', isEqualTo: email)
          .get();

      // If the query returns any documents, it means the user is an admin
      return adminSnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle any errors that occur during the query
      print('Error checking admin status: $e');
      return false;
    }
  }
}
