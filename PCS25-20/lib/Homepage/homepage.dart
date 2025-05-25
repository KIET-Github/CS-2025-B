import 'package:diet/Homepage/Services.dart';
import 'package:diet/Homepage/fitnessmotivation.dart';
import 'package:diet/Homepage/food_list.dart';
import 'package:diet/Homepage/meal.dart';
import 'package:diet/screens/fitness_form.dart';
import 'package:diet/workout.dart';
import 'package:flutter/material.dart';
// import 'coachServices.dart';
import 'list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int myindex = 0;
  List<Widget> widgetList = [
    const MyHomePage(),
    // workoutScreens(),
    // MealScreens(),
    FitnessForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              const SizedBox(height: 30),
              const Row(
                children: [
                  SizedBox(width: 10),
                  // const  CircleAvatar(
                  //     backgroundImage: AssetImage('assets/hello.jpg'),
                  //   ),
                  // const  SizedBox(width: 8),
                  Text(
                    '👋 Hello User',
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),

                  SizedBox(
                    width: 43,
                    height: 43,
                    child: Icon(
                      Icons.notifications_sharp,
                      size: 35,
                      color: Colors.black, // Adjust color as needed
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: const Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "  Welcome To",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          height: 1.5, // line height = 30px / font size = 1.5
                          letterSpacing: 0.0,
                          //textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "  Diet Healthmate",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          height: 1.5, // line height = 30px / font size = 1.5
                          letterSpacing: 0.0,
                          //textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListsScreen(),
              const SizedBox(height: 3),
              const Services(),
              const SizedBox(height: 3),
              foodList(),
              const SizedBox(height: 3),
              const fitnessmotivation(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 248, 249, 250),
        currentIndex: myindex,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
          for (int i = 0; i < 2; i++) {
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
          // BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: " "),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.restaurant),
          //   label: " ",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: " ",
          ),
        ],
      ),
    );
  }
}
