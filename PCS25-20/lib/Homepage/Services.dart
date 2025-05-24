import 'package:diet/Homepage/Detail_screen.dart';
import 'package:diet/Homepage/Calorie_Calculator_Screen.dart';
import 'package:diet/Homepage/detailreport.dart';
import 'package:flutter/material.dart';
import 'dart:core';

// import 'package:zego_zimkit/zego_zimkit.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8, left: 16),
        child: Container(
          width: 358,
          height: 160, // Adjusted height to accommodate content
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                offset: Offset(0, 4),
                blurRadius: 5.4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0, left: 12.0),
                    child: Text(
                      "Ask any Question",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.375,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      const SizedBox(height: 14),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              // final Uri url = Uri(
                              //   scheme: "tel",
                              //   path: "9390586835",
                              // );
                              // if (await canLaunch(url.toString())) {
                              //   await launch(url.toString());
                              // } else {
                              //   print("Cannot launch call");
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color.fromRGBO(211, 211, 211, 2.0),
                                  width: 6),
                              fixedSize: const Size(70, 50),
                              backgroundColor:
                                  Color.fromARGB(253, 252, 252, 252),
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.trending_up,
                                color: Colors.green, size: 23),
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 85,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                "Progress",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.357,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(width: 20,),
                      const SizedBox(height: 14),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const ChatGPTScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color.fromRGBO(211, 211, 211, 2.0),
                                  width: 6),
                              fixedSize: const Size(70, 50),
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.chat,
                                color: Colors.green, size: 23),
                          ),
                          const SizedBox(height: 3),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 85,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                "Chat",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.357,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //  const SizedBox(width: 20,),
                      const SizedBox(height: 14),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CalorieCalculatorScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromRGBO(211, 211, 211, 2.0),
                                width: 6,
                              ),
                              fixedSize: const Size(70, 50),
                              backgroundColor:
                                  const Color.fromRGBO(211, 211, 211, 2.0),
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                                Icons
                                    .local_fire_department, // You can choose any icon
                                color: Colors.green,
                                size: 23),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CalorieCalculatorScreen(),
                                ),
                              );
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 75,
                                child: const Text(
                                  "Calorie",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.357,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // const  SizedBox(width: 20,),
                      // SizedBox(height: 4,),
                      const SizedBox(height: 15),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color.fromRGBO(211, 211, 211, 2.0),
                                  width: 6),
                              fixedSize: const Size(70, 50),
                              backgroundColor:
                                  const Color.fromRGBO(211, 211, 211, 2.0),
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.details,
                                color: Colors.green, size: 23),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(),
                                ),
                              );
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 75,
                                child: const Text(
                                  "Detail",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.357,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ])
              ],
            ),
          ),
        ));
  }
}
