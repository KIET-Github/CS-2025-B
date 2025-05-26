// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../components/cards.dart';
import '../../../../components/rounded_input_field.dart';
import 'apply.dart';

class HiringDashboard extends StatefulWidget {
    final String userName;
  final String imageUrl;
  const HiringDashboard({
    Key? key,
    required this.userName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<HiringDashboard> createState() => _HiringDashboardState();
}

class _HiringDashboardState extends State<HiringDashboard> {
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
      body: Container(
        width: 400,
        height: 1000,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 2),
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
                  const SizedBox(width: 220),
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
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 10),
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
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Get Hired!",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                          const Text(
                            "Exploration is the key to new doors",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
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
              const SizedBox(height: 10),
              const Text(
                "  Clubs Hiring Now",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ApplicationFormPage(club:"KTS"),
                              ),
                            );
                          },
                          child: buildClubCard(
                              "assets/Oval.png", "KTS", "CS Department")),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ApplicationFormPage(club:"GDS"),
                            ),
                          );
                        },
                        child: buildClubCard(
                            "assets/Oval (1).png", "GDSE", "CSE Department"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ApplicationFormPage(club:"DSTL"),
                            ),
                          );
                        },
                        child: buildClubCard(
                            "assets/Oval (2).png", "DSTL", "CSE Department"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "  Trending",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              JobList(), // This is where we add the trending jobs from Firestore.
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class JobList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('clubshiring').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final jobDocs = snapshot.data?.docs ?? [];

        return ListView.builder(
          shrinkWrap: true, // Use shrinkWrap for embedding ListView in Column
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jobDocs.length,
          itemBuilder: (context, index) {
            final jobData = jobDocs[index].data() as Map<String, dynamic>;
            return CustomListTile(
              logo: jobData['logo'] ?? '',
              title: jobData['title'] ?? 'No Title',
              subTitle: jobData['subTitle'] ?? 'No Subtitle',
              year: jobData['year'] ?? 'No Year',
              status: jobData['status'] ?? 'No Status',
            );
          },
        );
      },
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String logo;
  final String title;
  final String subTitle;
  final String year;
  final String status;

  const CustomListTile({
    super.key,
    required this.logo,
    required this.title,
    required this.subTitle,
    required this.year,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(logo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        color: status == 'Applied' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      year,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApplicationFormPage(club: title),
                ),
              );
            },
            child: Container(
              width: 100,
              height: 25,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 33, 103, 243),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  "Apply Now",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
