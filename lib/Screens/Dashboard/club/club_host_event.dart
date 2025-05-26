import 'package:flutter/material.dart';

class ClubHostEvent extends StatefulWidget {
  final String imageUrl;
  final String clubname;
  const ClubHostEvent({
    Key? key,
    required this.imageUrl,
    required this.clubname,
  }) : super(key: key);

  @override
  State<ClubHostEvent> createState() => _ClubHostEventState();
}

class _ClubHostEventState extends State<ClubHostEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 24, 96, 252),
              Color.fromARGB(255, 255, 255, 224),
              Color.fromARGB(255, 209, 232, 247),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SizedBox(
          width: 400,
          height: 1000,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10,),
                    IconButton(
                      alignment: Alignment.centerLeft,
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 26,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 5,),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      backgroundImage: (widget.imageUrl.isNotEmpty)
                          ? NetworkImage(widget.imageUrl)
                          : null,
                      child: (widget.imageUrl.isEmpty)
                          ? const Icon(
                              Icons.account_circle,
                              size: 50,
                              color: Colors.black,
                            )
                          : null,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.clubname, // Replace with student's name
                        style: const TextStyle(
                          fontSize: 20.0,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Host Event",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
