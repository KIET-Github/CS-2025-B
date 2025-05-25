// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:edubridge/Screens/Authentication/students/studentsignin.dart';

import 'profile.dart';

class StudentDashboard extends StatefulWidget {
  final String userName;
  final String imageUrl;
  const StudentDashboard({
    Key? key,
    required this.userName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String? userId;
  String? libraryId;
  String? mobileNumber;
  

  @override
  void initState() {
    super.initState();
    // Fetch the user ID
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      _fetchStudentDetails(userId!);
    }
  }

  Future<void> _fetchStudentDetails(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('students')
          .doc(userId)
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          libraryId = data['libraryId'] ?? 'Not Available';
          mobileNumber = data['mobileNumber'] ?? 'Not Available';
          
        });
      }
    } catch (e) {
      print('Error fetching student details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Container(
        width: 400,
        height: 1000,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 24, 96, 252),
              Color.fromARGB(255, 255, 255, 224),
              Color.fromARGB(255, 209, 232, 247)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                        ? NetworkImage(widget.imageUrl!)
                        : null,
                    child: (widget.imageUrl == null || widget.imageUrl!.isEmpty)
                        ? const Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.black,
                          )
                        : null,
                  ),
                  Text(
                    'Welcome, ${widget.userName}', // Replace with student's name
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () => logOut(context),
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: 150,
                          height: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Library Id"),
                              Text(libraryId ?? 'Fetching...'),
                              const Text("Mobile Number"),
                              Text(mobileNumber ?? 'Fetching...'),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.blue),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileDetailsPage(userId: userId!),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: 150,
                          height: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Upcoming Event"),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset("assets/home_page.jpeg"),
                                ),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.blue),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Innotech-2023",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 12),
                      Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: 90,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                child: Image.asset("assets/1.png"),
                              ),
                              const Text("Event"),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: 90,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                child: Image.asset("assets/2.png"),
                              ),
                              const Text("Club Data"),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: 90,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset("assets/31.png"),
                                ),
                              ),
                              const Text("Mentors"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "Latest Hirings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const Column(
                children: [
                  SizedBox(height: 10.0),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: Colors.white,
                          title: Text('Event 1'),
                          subtitle: Text('Details of Event 1'),
                        ),
                        SizedBox(height: 5),
                        ListTile(
                          tileColor: Colors.white,
                          title: Text('Event 2'),
                          subtitle: Text('Details of Event 2'),
                        ),
                        SizedBox(height: 80),
                        // Add more events as needed
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 20,
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Are you sure?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You will be redirected to login page.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the Dialog
              },
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                _signOut(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const StudentSignInPage())),
                  (route) => false,
                ); // Navigate to login
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }
}
