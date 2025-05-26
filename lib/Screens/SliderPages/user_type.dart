   import 'package:flutter/material.dart';

import '../Authentication/admin/adminsignin.dart';
import '../Authentication/club/clubsignin.dart';
import '../Authentication/mentor/mentorsignin.dart';
import '../Authentication/students/studentsignin.dart';

class UserType extends StatefulWidget {
  const UserType({super.key});

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(
                  255, 24, 96, 252),Color.fromARGB(255, 255, 255, 224), Color.fromARGB(255, 209, 232, 247)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),),
        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Login As",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentSignInPage(),
                                      ),
                                    ),
                                    child: Card(
                                        color: Colors.white,
                                        child: SizedBox(
                                          width: 110,
                                          height: 140,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ClipRRect(
                                                  child: Image.asset(
                                                      "assets/Saly13.png"),
                                                ),
                                                const Text("Student",style: TextStyle(fontWeight: FontWeight.bold),),
                                              ]),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ClubSignInPage(),
                                      ),
                                    ),
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: 110,
                                        height: 140,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              
                                              child: Image.asset(
                                                  "assets/Group of diverse people.png"),
                                            ),
                                            const Text("Club",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MentorSignInPage(),
                                      ),
                                    ),
                                    child: Card(
                                        color: Colors.white,
                                        child: SizedBox(
                                          width: 110,
                                          height: 140,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ClipRRect(
                                                  
                                                  child: Image.asset(
                                                      "assets/Saly10.png"),
                                                ),
                                                const Text("Mentor",style: TextStyle(fontWeight: FontWeight.bold),),
                                              ]),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AdminSignInPage(),
                                      ),
                                    ),
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: 110,
                                        height: 140,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              child: Image.asset(
                                                  "assets/admin.png",),
                                            ),
                                            const Text("Admin",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
      ),
    );
  }
}
   
   
            