import 'package:edubridge/Screens/Authentication/admin/adminsignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return  const DashboardPage();
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Container(
        decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(
                  255, 24, 96, 252),Color.fromARGB(255, 255, 255, 224), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),),
        child: Padding(
        
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: [
              const SizedBox(
                height: 50,
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                  CircleAvatar(
                      radius: (30),
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/home_page.jpeg"),
                      )),
                      
                  const Text(
                    'Welcome, Admin', // Replace with student's name
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
        
                  ),
                  IconButton(
                    onPressed: () => logOut(context),
                    icon: const Icon(Icons.logout_outlined,color: Colors.white,size: 30,),),
                    
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.grey[200],
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Details:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('Name: Admin'),
                    Text('Roll Number: 12345'),
                    Text('Class: 10th'),
                    // Add more details as needed
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Events:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: ListView(
                          children: [
                            const ListTile(
                              title: Text('Event 1'),
                              subtitle: Text('Details of Event 1'),
                            ),
                            const ListTile(
                              title: Text('Event 2'),
                              subtitle: Text('Details of Event 2'),
                            ),
                            // Add more events as needed
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
          title: const Text('Are you sure?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will be redirected to login page.',style: TextStyle(color: Colors.white,),),
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
                        builder: ((context) => const AdminSignInPage())),(route)=>false);// Navigate to login
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
