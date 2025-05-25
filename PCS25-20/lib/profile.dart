import 'package:diet/Homepage/homepage.dart';
import 'package:diet/Homepage/login_screen.dart';
import 'package:diet/Homepage/meal.dart';
import 'package:diet/workout.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  @override
  State<profileScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<profileScreen> {
  int myindex = 0;
  List<Widget> widgetList = [
    MyHomePage(),
    workoutScreens(),
    // MealScreens(),
    LoginScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text(
          'PROFILE',
          style: TextStyle(
              color: Color.fromARGB(255, 248, 246, 246),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(135, 250, 135, 1),
              Color.fromRGBO(255, 255, 255, 0.9),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 130,
                  width: 150,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/coach.png',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9,
            ),
            Container(
              width: 350,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              width: 350,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Goal',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              width: 350,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Height',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              width: 350,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Weight',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              width: 350,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Age',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              width: 350,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Any disease',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              width: 350,
              height: 100,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Detail about your health and height',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 45,
              width: 350,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 248, 249, 250),
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
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: " ",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded), label: " "),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_sharp),
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
