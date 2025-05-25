// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../components/cards.dart';
import '../../../../components/rounded_input_field.dart';

class MentorsDashBoardPage extends StatefulWidget {
  final String userName;
  final String imageUrl;
  const MentorsDashBoardPage({
    Key? key,
    required this.userName,
    required this.imageUrl,
  }) : super(key: key);
  @override
  State<MentorsDashBoardPage> createState() => _MentorsDashBoardPageState();
}

class _MentorsDashBoardPageState extends State<MentorsDashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return DashboardPage(imageUrl: widget.imageUrl, userName: widget.userName);
  }
}

class DashboardPage extends StatelessWidget {
  final String? imageUrl;
  final String? userName; // Add this line
  DashboardPage({super.key, this.imageUrl, this.userName});

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
                              Image(
                                image: AssetImage('assets/edu.png'),
                                width: 200,
                                height: 80,
                              ),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.notifications_active_outlined,
                                    size: 35,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          Text(
                            "Hello,$userName!",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                          const Text(
                            "Find the right Mentor for you.",
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
              const Text(
                "    Top Mentors",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildMentorCard(
                                  "assets/Oval.png", "KTS", "CS Department"),
                              buildMentorCard("assets/Oval (1).png", "GDSE",
                                  "CSE Department"),
                              buildMentorCard("assets/Oval (2).png", "DSTL",
                                  "CSE Department"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildMentorCard("assets/Oval (3).png", "NSCC KIET",
                                  "CS Department"),
                              buildMentorCard("assets/Oval (4).png", "DevUp",
                                  "CSIT Department"),
                              buildMentorCard("assets/Oval (5).png", "Innogeeks",
                                  "IT Department"),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
