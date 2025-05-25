
import 'package:flutter/material.dart';

import '../../../../components/rounded_input_field.dart';

class CommunitiesDashBoard extends StatefulWidget {
  final String userName;
  final String imageUrl;
  const CommunitiesDashBoard({
    Key? key,
    required this.userName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<CommunitiesDashBoard> createState() => _CommunitiesDashBoardState();
}

class _CommunitiesDashBoardState extends State<CommunitiesDashBoard> {
  @override
  Widget build(BuildContext context) {
    return DashboardPage(imageUrl: widget.imageUrl);
  }
}

class DashboardPage extends StatelessWidget {
  final String? imageUrl; // Add this line
  DashboardPage({super.key, this.imageUrl}); 

  final TextEditingController _searchEventController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Container(
                    width: 50,
                    decoration: const BoxDecoration(
                      backgroundBlendMode: BlendMode.lighten,
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
                  const SizedBox(
                    width: 220,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                        ? NetworkImage(imageUrl!)
                        : null,
                    child: (imageUrl == null || imageUrl!.isEmpty)
                        ? const Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.black,
                          )
                        : null,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 0, 79),
                        Color.fromARGB(255, 84, 84, 254)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(image: AssetImage('assets/edu.png'),width: 200,height: 80,),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.notifications_active_outlined,
                                    size: 35,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          const Text(
                            "Explore Communities",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          const Text(
                            "Exploration is the key to new doors",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedInputField(
                              preicon: const Icon(Icons.search_rounded),
                              suficon: const Icon(Icons.mic),
                              labelText: ' Search ',
                              height: 5,
                              obscureText: false,
                              borderRadius: 10.0,
                              controller: _searchEventController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Technical Domains",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Click for more    ",
                    style: TextStyle(fontSize: 12,),
                  ),
                ],
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            color: Colors.white,
                            child: SizedBox(
                              width: 110,
                              height: 140,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: (30),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset("assets/Oval.png"),
                                      )),
                                  const Text("KTS"),
                                  const Text(
                                    "CS Department",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: (30),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/Oval (1).png"),
                                          )),
                                      const Text("GDSE"),
                                      const Text(
                                        "CSE Department",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )),
                          
                          Card(
                            color: Colors.white,
                            child: SizedBox(
                              width: 110,
                              height: 140,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: (30),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset("assets/Oval (2).png"),
                                      )),
                                  const Text("DSTL"),
                                  const Text(
                                    "CSE Department",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: (30),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/Oval (3).png"),
                                          )),
                                      const Text("NSCC KIET"),
                                      const Text(
                                        "CS Department",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )),
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: (30),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/Oval (4).png"),
                                          )),
                                      const Text("DevUp"),
                                      const Text(
                                        "CSIT Department",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )),
                          
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: (30),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/Oval (5).png"),
                                          )),
                                      const Text("Innogeeks"),
                                      const Text(
                                        "IT Department",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Cultural",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Click for more    ",
                    style: TextStyle(fontSize: 12,),
                  ),
                ],
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: (30),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/Oval (13).png"),
                                          )),
                                      const Text("Impeecables"),
                                      const Text(
                                        "KIET",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )),
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: (30),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/Oval (11).png"),
                                          )),
                                      const Text("KMC"),
                                      const Text(
                                        "Music Club",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )),
                          Card(
                            color: Colors.white,
                            child: SizedBox(
                              width: 110,
                              height: 140,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: (30),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset("assets/Oval (12).png"),
                                      )),
                                  const Text("TEDx"),
                                  const Text(
                                    "Club",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: (30),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/Oval (14).png"),
                                          )),
                                      const Text("Dance Club"),
                                      const Text(
                                        "Dance Club",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )),
                          Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: (30),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/Oval (15).png"),
                                          )),
                                      const Text("Ayushman Club"),
                                      const Text(
                                        "Pharmacy KIET",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),
                                    ]),
                              )),
                          Card(
                            color: Colors.white,
                            child: SizedBox(
                              width: 110,
                              height: 140,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                      radius: (30),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child:
                                            Image.asset("assets/Oval (16).png"),
                                      )),
                                  const Text("Movie Society"),
                                  const Text(
                                    "KIET",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),
                                ],
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
                height: 20,
              ),
             const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Other Clubs",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Click for more    ",
                    style: TextStyle(fontSize: 12,),
                  ),
                ],
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ArticlePage(
                            //       s: 'a2',
                            //     ),
                            //   ),
                            // ),
                            child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 110,
                                  height: 140,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                            radius: (30),
                                            backgroundColor: Colors.white,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                  "assets/Oval (23).png"),
                                            )),
                                        const Text("The JODO KARATE",textAlign: TextAlign.center,),
                                        const Text(
                                          "Club",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 11),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey,
                                        ),
                                      ]),
                                )),
                          ),
                          GestureDetector(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ArticlePage(
                            //       s: 'a1',
                            //     ),
                            //   ),
                            // ),
                            child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 110,
                                  height: 140,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                            radius: (30),
                                            backgroundColor: Colors.white,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                  "assets/Oval (22).png"),
                                            )),
                                        const Text("Finance Club"),
                                        const Text(
                                          "KOSM",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey,
                                        ),
                                      ]),
                                )),
                          ),
                          GestureDetector(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ArticlePage(
                            //       s: 'a3',
                            //     ),
                            //   ),
                            // ),
                            child: Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                        radius: (30),
                                        backgroundColor: Colors.white,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                              "assets/Oval (24).png"),
                                        )),
                                    const Text("Case Club"),
                                    const Text(
                                      "Student",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ArticlePage(
                            //       s: 'a4',
                            //     ),
                            //   ),
                            // ),
                            child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 110,
                                  height: 140,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                            radius: (30),
                                            backgroundColor: Colors.white,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                  "assets/Oval (26).png"),
                                            )),
                                        const Text("Uddeshhya"),
                                        const Text(
                                          "Social Services",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey,
                                        ),
                                      ]),
                                )),
                          ),
                          GestureDetector(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ArticlePage(
                            //       s: 'a5',
                            //     ),
                            //   ),
                            // ),
                            child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 110,
                                  height: 140,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                            radius: (30),
                                            backgroundColor: Colors.white,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                  "assets/Oval (25).png"),
                                            )),
                                        const Text("E-Cell"),
                                        const Text(
                                          "KIET",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey,
                                        ),
                                      ]),
                                )),
                          ),
                          GestureDetector(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ArticlePage(
                            //       s: 'a6',
                            //     ),
                            //   ),
                            // ),
                            child: Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 110,
                                height: 140,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                        radius: (30),
                                        backgroundColor: Colors.white,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                              "assets/Oval (22).png"),
                                        )),
                                    const Text("Dramatic Club"),
                                    const Text(
                                      "KIET",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
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
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
