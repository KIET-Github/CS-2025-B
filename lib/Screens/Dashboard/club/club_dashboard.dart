import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edubridge/Screens/Authentication/club/clubsignin.dart';
import 'package:edubridge/Screens/Dashboard/club/club_event.dart';
import 'package:edubridge/Screens/Dashboard/club/club_hiring.dart';
import 'package:edubridge/Screens/Dashboard/club/club_host_event.dart';
import 'package:edubridge/Screens/Dashboard/club/club_permission.dart';
import 'package:edubridge/Screens/Dashboard/club/club_report.dart';
import 'package:edubridge/Screens/Dashboard/club/clubdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClubDashboard extends StatefulWidget {
  const ClubDashboard({super.key});

  @override
  State<ClubDashboard> createState() => _ClubDashboardState();
}

class _ClubDashboardState extends State<ClubDashboard> {
  @override
  Widget build(BuildContext context) {
    return const DashboardPage();
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _clubName = "";
  String _president = "";
  String _vicePrecident = "";
  String email = "";
  String? imageUrl;
  String? userId;
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      _fetchClubDetails();
    }
  }

  Future<void> _fetchClubDetails() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('clubs')
          .doc(userId)
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        _clubName = data['clubname'] ?? '';

        _president = data['president'] ?? '';
        _vicePrecident = data['vicePrecident'] ?? '';

        email = data['email'] ?? '';

        setState(() {});
      }
    } catch (e) {
      print('Error fetching student details: $e');
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      width: 400,
          height: 1000,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 24, 96, 252),
            Color.fromARGB(255, 255, 255, 224),
            Colors.white
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: _fetchClubDetails, // Function to refresh data
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity, // Use double.infinity to fill the width
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('clubs')
                            .doc(userId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                      
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Error loading data.'));
                          }
                      
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return const Center(
                                child: Text('No data available.'));
                          }
                      
                          final data =
                              snapshot.data!.data() as Map<String, dynamic>;
                      
                          imageUrl = data['imageUrl'] ?? '';
                      
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    (imageUrl != null && imageUrl!.isNotEmpty)
                                        ? NetworkImage(imageUrl!)
                                        : null,
                                child: (imageUrl == null || imageUrl!.isEmpty)
                                    ? const Icon(
                                        Icons.account_circle,
                                        size: 25,
                                        color: Colors.black,
                                      )
                                    : null,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(width: 5,),
                      Flexible(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            const Text(
                              'Welcome, ', // Replace with student's name
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              _clubName, // Replace with student's name
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 25,
                          )),
                      IconButton(
                          onPressed: () => logOut(context),
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                            size: 25,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 150,
                                height: 175,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text("Club Id"),
                                      const Text("KIET21",style: TextStyle(color: Colors.orange),),
                                      const Text("Mail"),
                                      Text(email,style: const TextStyle(color: Colors.orange),),
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.blue),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ClubDataPage(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ]),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Card(
                            color: Colors.white,
                            child: SizedBox(
                              width: 150,
                              height: 175,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text("Upcoming Event"),
                                  CircleAvatar(
                                      radius: (30),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                            "assets/home_page.jpeg"),
                                      )),
                                  ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.blue),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        "Innotech-2023",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ClubHostEvent(clubname:_clubName,imageUrl:imageUrl!),
                                            ),
                                          );
                                },
                                child: Card(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: 100,
                                      height: 150,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              
                                              child: Image.asset(
                                                  "assets/1.png"),
                                            ),
                                            const Text("Host"),
                                            const Text("Event"),
                                          ]),
                                    )),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ClubEvents(clubname:_clubName,imageUrl:imageUrl!),
                                            ),
                                          );
                                },
                                child: Card(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: 100,
                                      height: 150,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              
                                              child: Image.asset(
                                                  "assets/32.png"),
                                            ),
                                            const SizedBox(height: 5,),
                                            const Text("Events"),
                                          ]),
                                    )),
                              ),
                              
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                             
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ClubPermissions(clubname:_clubName,imageUrl:imageUrl!),
                                            ),
                                          );
                                },
                                child: Card(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: 100,
                                      height: 150,
                                      child: Column(
                                          mainAxisAlignment:
                                             MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              
                                              child: Image.asset(
                                                  "assets/33.png"),
                                            ),
                                            const Text("Permissions"),
                                          ]),
                                    )),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ClubReports(clubname:_clubName,imageUrl:imageUrl!),
                                            ),
                                          );
                                },
                                child: Card(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: 100,
                                      height: 150,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              
                                              child: Image.asset(
                                                  "assets/34.png"),
                                            ),
                                            const Text("Report"),
                                          ]),
                                    )),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ClubHiring(clubname:_clubName,imageUrl:imageUrl!),
                                            ),
                                          );
                                },
                                child: Card(
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: 100,
                                    height: 150,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                           
                                            child: Image.asset(
                                                "assets/2.png"),
                                          ),
                                          const Text("Hiring"),
                                        ]),
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   Stack(
                    alignment: Alignment.center,
                    children: [
                      
                      Card(
                        child: SizedBox(
                          width: 350,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Club Coordinators",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    color: Colors.red,
                                    child: SizedBox(
                                        width: 80,
                                        height: 25,
                                        child: Center(
                                            child: Text(
                                          _president,
                                          style: const TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                   Card(
                                    color: Colors.green,
                                    child: SizedBox(
                                        width: 80,
                                        height: 25,
                                        child: Center(
                                            child: Text(
                                          _vicePrecident,
                                          style: const TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          ),
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
          backgroundColor: Colors.blue,
          title: const Text(
            'Are you sure?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You will be redirected to login page.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                        builder: ((context) => const ClubSignInPage())),
                    (route) => false); // Navigate to login
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
