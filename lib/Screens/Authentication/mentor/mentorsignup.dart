import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/rounded_input_field.dart';
import '../forgetpassword.dart';
import 'mentorsignin.dart';

class MentorSignUpPage extends StatefulWidget {
  const MentorSignUpPage({Key? key}) : super(key: key);

  @override
  State<MentorSignUpPage> createState() => _MentorSignUpPageState();
}

class _MentorSignUpPageState extends State<MentorSignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  bool _showPassword = false;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
                      'Mentor Registration',
                      style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 16.0),
                    RoundedInputField(
                      labelText: 'Username',
                      obscureText: false,
                      borderRadius: 40.0,
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 16.0),
                    RoundedInputField(
                      labelText: 'Email',
                      obscureText: false,
                      borderRadius: 40.0,
                      controller: _userEmailController,
                    ),
                    const SizedBox(height: 16.0),
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
                    const SizedBox(height: 10.0),
                    if (_isLoading) // Show CircularProgressIndicator if _isLoading is true
                      const CircularProgressIndicator(),
                    if (!_isLoading) // Show button only when not loading

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _performSignUp,
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            fixedSize: const Size(180, 50),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (contrxt) => const MentorSignInPage()),
                            (route) => false);
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: 'Already have an account? '),
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 22,
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

  // Import PlatformException
  void _performSignUp() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String email = _userEmailController.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      _showErrorDialog("Enter The Required Fields");
      return;
    }
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      // Check if the email is already in use
      bool emailInUse = await _isEmailInUse(email);
      if (emailInUse) {
        // Email is already in use, show warning dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Warning'),
              content: const Text(
                  'The email address is already in use by another account.'),
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
        return;
      }

      // Email is not in use, proceed with user creation
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user's display name
      await userCredential.user?.updateDisplayName(username);
      await FirebaseFirestore.instance
          .collection('mentors')
          .doc(userCredential.user!.uid)
          .set({
        'username': username,
        'email': email,

        // Add other user data fields if needed
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'user': [false, false, true, false], //[admin,student,club,mentor]

        // Add other user data fields if needed
      });

      // Show snackbar to indicate successful sign-up
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully. Please log in.'),
          duration: Duration(seconds: 3), // Adjust duration as needed
        ),
      );

      // Navigate to SignInPage after successful sign-up
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MentorSignInPage()),
      );
    } catch (e) {
      // Show error dialog for any other errors
      _showErrorDialog(e.toString());
    }finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  Future<bool> _isEmailInUse(String email) async {
    try {
      // Query Firestore to check if the email already exists in the 'users' collection
      var querySnapshot = await FirebaseFirestore.instance
          .collection('mentors')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle any potential errors
      print('Error checking if email is in use: $e');
      return true; // Assume email is in use to be safe
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Up Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
