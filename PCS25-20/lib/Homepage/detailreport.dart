import 'package:diet/Homepage/homepage.dart';
import 'package:diet/Homepage/login_screen.dart';
import 'package:diet/Homepage/meal.dart';
import 'package:diet/workout.dart';
import 'package:flutter/material.dart';

class DetailReport extends StatefulWidget {
  const DetailReport({super.key});

  @override
  State<DetailReport> createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  int myindex = 0;
  List<Widget> widgetList = [
    MyHomePage(),
    workoutScreens(),
    MealScreens(),
    const LoginScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Report",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text("Detail Report"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 246, 248, 249),
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
