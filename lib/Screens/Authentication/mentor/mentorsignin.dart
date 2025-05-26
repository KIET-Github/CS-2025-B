import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edubridge/Screens/Dashboard/mentors/mentor_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/rounded_input_field.dart';
import '../forgetpassword.dart';
import 'mentorsignup.dart';

class MentorSignInPage extends StatefulWidget {
  const MentorSignInPage({Key? key}) : super(key: key);

  @override
  State<MentorSignInPage> createState() => _MentorSignInPageState();
}

class _MentorSignInPageState extends State<MentorSignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Variable to track loading state
  bool _showPassword = false;
  Future<void> _signInWithEmailAndPassword() async {
    // Check if email and password fields are empty
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text('Please enter email and password.'),
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
      return; // Exit the method if fields are empty
    }

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
      if (userEmail != null && await _isAllowed(userEmail)) {
        // Navigate to the admin home page
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MentorDashboard()),
            (route) => false);
      } else {
        // Not an admin, show error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('You are not authorized to access.'),
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

  Future<bool> _isAllowed(String email) async {
    try {
      // Query Firestore to check if the user is an admin
      final adminSnapshot = await FirebaseFirestore.instance
          .collection('mentors')
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

  void _navigateToAdminSignup() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (contrxt) => const MentorSignUpPage()),
        (route) => false);
  }

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
              color: Color.fromARGB(255, 97, 96, 96)),
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
          child: _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Show CircularProgressIndicator if loading
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          'Mentor Sign In',
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
                        const SizedBox(height: 19.0),
                        RoundedInputField(
                          labelText: 'Password',
                          obscureText: !_showPassword,
                          borderRadius: 40.0,
                          controller: _passwordController,
                          suffixIcon: IconButton(
                            icon: Icon(_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
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
                                    builder: (context) =>
                                        const ForgotPassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _signInWithEmailAndPassword,
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
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: _navigateToAdminSignup,
                          // child: const Text('Create New Admin Account'),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(text: 'Create New Mentor Account \n'),
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
                      ],
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
