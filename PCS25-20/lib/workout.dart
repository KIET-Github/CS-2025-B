import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Sample Coach data model
class Coach {
  final String name;
  final String experience;

  final double rating;

  final String photoUrl;

  final String? Intro;
  final List<Comment> comments;

  Coach({
    required this.name,
    required this.experience,
    required this.rating,
    required this.photoUrl,
    required this.Intro,
    required this.comments,
  });
}

class Comment {
  final String userName;
  final String userPhotoUrl;

  final String comment;

  Comment({
    required this.userName,
    required this.userPhotoUrl,
    required this.comment,
  });
}

class UserProfile {
  final String userName;
  final String userPhotoUrl;

  UserProfile({
    required this.userName,
    required this.userPhotoUrl,
  });
}

class workoutScreens extends StatefulWidget {
  @override
  State<workoutScreens> createState() => _workoutScreensState();
}

class _workoutScreensState extends State<workoutScreens> {
  String _selectedFilter = 'All'; // Default filter
  // Sample coach list data
  final List<Coach> coaches = [
    Coach(
      name: 'Cardio Workout',
      experience: ' 30 minutes to 1 hour',

      rating: 4.7, // Replace with the coach's actual rating
      // Replace with the validation status for this coach
      photoUrl: 'assets/cardio.png',
      Intro:
          'Cardiovascular exercises typically involve continuous, rhythmic movements that elevate the heart rate. Depending on the intensity, duration can vary from shorter high-intensity sessions to longer steady-state activities like jogging or cycling',

      comments: [
        Comment(
          userName: 'Serena Williams',
          userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
          // Replace with Alice's rating for Jane Smith
          comment:
              'I love my morning runs! Cardio workouts keep me energized throughout the day and help me maintain a healthy weight',
        ),
        Comment(
          userName: 'Dwayne "The Rock" Johnson',
          userPhotoUrl:
              'assets/coach.png', // Replace with Alice's rating for Jane Smith
          comment:
              'Cardio is the foundation of my daily workouts. Whether its hitting the treadmill or outdoor sprints, its all about pushing past your limits and embracing the grind',
        ),
        // Add more comments as needed
      ],
    ),
    Coach(
      name: 'CrossFit',
      experience: '15 minutes to 1 hour',

      rating: 4.7, // Replace with the coach's actual rating

      photoUrl: 'assets/crossfit.png',

      Intro:
          'Strength training workouts involve exercises that target specific muscle groups using resistance, such as weights or body weight. The duration can vary based on the number of sets, repetitions, and rest periods between exercises.',
      comments: [
        Comment(
          userName: 'Alice',
          userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
          // Replace with Alice's rating for Jane Smith
          comment:
              'Strength training has transformed my body! I feel stronger, more confident, and love seeing the progress Ive made in the gym',
        ),
        Comment(
          userName: 'Alice',
          userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
          // Replace with Alice's rating for Jane Smith
          comment:
              'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
        ),
        // Add more comments as needed
      ],
    ),
    Coach(
      name: 'Strength Training',
      experience: '15 minutes to 1 hour',

      rating: 4.7, // Replace with the coach's actual rating
      photoUrl: 'assets/exer.png',
      Intro:
          'Strength training workouts involve exercises that target specific muscle groups using resistance, such as weights or body weight. The duration can vary based on the number of sets, repetitions, and rest periods between exercises.',
      comments: [
        Comment(
          userName: 'Alice',
          userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
          // Replace with Alice's rating for Jane Smith
          comment:
              'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
        ),
        // Add more comments as needed
      ],
    ),
    Coach(
      name: 'Cardio',
      experience: '830 min',
      rating: 4.7, // Replace with the coach's actual rating
      photoUrl: 'assets/cardio.png',
      Intro: 'my name is John',
      comments: [
        Comment(
          userName: 'Alice',
          userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
          // Replace with Alice's rating for Jane Smith
          comment:
              'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
        ),
        // Add more comments as needed
      ],
    ),
    Coach(
      name: 'Cardio',
      experience: '830 min',
      rating: 4.7, // Replace with the coach's actual rating
      photoUrl: 'assets/cardio.png',
      Intro: 'my name is John',
      comments: [
        Comment(
          userName: 'Alice',
          userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
          // Replace with Alice's rating for Jane Smith
          comment:
              'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
        ),
        // Add more comments as needed
      ],
    ),
    Coach(
      name: 'Cardio',
      experience: '830 min',
      rating: 4.7, // Replace with the coach's actual rating
      photoUrl: 'assets/cardio.png',
      Intro: 'my name is John',
      comments: [
        Comment(
          userName: 'Alice',
          userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
          // Replace with Alice's rating for Jane Smith
          comment:
              'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
        ),
        // Add more comments as needed
      ],
    ),
    Coach(
      name: 'Cardio',
      experience: '830 min',
      rating: 4.7, // Replace with the coach's actual rating
      photoUrl: 'assets/verify.png',
      Intro: 'my name is John',
      comments: [
        Comment(
          userName: 'Alice',
          userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL

          comment:
              'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
        ),
        // Add more comments as needed
      ],
    ),

    // Add more coach details as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green.shade400,
          title: const Text(
            'Workout',
            style: TextStyle(
                color: Color.fromARGB(255, 248, 246, 246),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            // Filter Container
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'CrossFit';
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'CrossFit',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'Cardio';
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text('Cardio',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: DropdownButton<String>(
                      value: _selectedFilter,
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFilter = newValue!;
                          // Implement filtering logic here based on the selected filter
                        });
                      },
                      items: <String>['All', 'Cardio', 'CrossFit', 'Strength']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            // Coach List
            Expanded(
              child: ListView.builder(
                itemCount: coaches.length,
                itemBuilder: (BuildContext context, int index) {
                  // Check if the coach should be displayed based on the selected filter
                  if (_selectedFilter == 'All' ||
                      (_selectedFilter == 'CrossFit' &&
                          coaches[index].experience == 'CrossFit') ||
                      (_selectedFilter == 'Cardio' &&
                          coaches[index].name == 'Cardio') ||
                      (_selectedFilter == '4' &&
                          coaches[index].rating == '4')) {
                    return Card(
                      color: Color.fromRGBO(135, 250, 135, 1),
                      margin: EdgeInsets.all(5.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(coaches[index].photoUrl),
                                radius: 30,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 12,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        '${coaches[index].rating}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            coaches[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ${coaches[index].experience}',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                ' ${coaches[index].name}',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                ' ${coaches[index].rating}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          // Validation tick
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CoachDetailsScreen(coach: coaches[index]),
                              ),
                            );
                          },
                        ),
                      ]),
                    );
                  } else {
                    // Don't show the coach if it doesn't match the selected filter
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ));
  }
}

class CoachDetailsScreen extends StatefulWidget {
  final Coach coach;

  CoachDetailsScreen({required this.coach});

  @override
  State<CoachDetailsScreen> createState() => _CoachDetailsScreenState();
}

class _CoachDetailsScreenState extends State<CoachDetailsScreen> {
  bool showFullContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // ignore: unnecessary_null_comparison
      body: widget.coach != null
          ? SingleChildScrollView(
              child: buildCoachDetails(),
            )
          : Center(child: Text('Coach details not available')),
    );
  }

  Widget buildCoachDetails() {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Container(
        color: Colors.black,
        child: Container(
          padding: EdgeInsets.all(7.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(169, 204, 178, 1),
                Color.fromRGBO(255, 255, 255, 0.9),
              ],
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20), // Set the border radius
              ), // Set the background color of the container
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(widget.coach.photoUrl),
                        radius: 50,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.amber,
                              ),
                              Text(
                                '${widget.coach.rating}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.coach.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Experience: ${widget.coach.experience}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'Rating: ${widget.coach.rating}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement video call functionality
                        },
                        child: const Text('Detail',
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 142, 222, 144),
                          surfaceTintColor:
                              const Color.fromARGB(255, 140, 139, 139),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: showFullContent ? null : 200,
              width: double.infinity,
              decoration: BoxDecoration(
                //  color: const Color.fromRGBO(255, 231, 165, 0.1),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color.fromRGBO(135, 250, 135, 1),
                  ],
                  stops: [0.0, 0.9887],
                  transform: GradientRotation(102.95 * 3.14159265359 / 180),
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Detail',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.coach.Intro != null
                        ? Text(
                            widget.coach.Intro!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: showFullContent ? null : 5,
                          )
                        : const Text(
                            'No Detail available',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showFullContent = !showFullContent;
                          });
                        },
                        child: Text(
                          showFullContent ? 'Read Less' : 'Read More',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duration',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'As mentioned, a cardio workout can range from 20 minutes to an hour or more. Beginners might start with shorter sessions and gradually increase the duration as their fitness improves. The American Heart Association recommends at least 150 minutes of moderate-intensity aerobic activity or 75 minutes of vigorous-intensity aerobic activity per week for adults\n\n'
                    '➢ 30 minutes\n'
                    '➢ 1 hour\n'
                    '➢ 1 hour 30 minutes\n'
                    '➢ 2 hours',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Opinions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  for (int i = 0; i < widget.coach.comments.length; i++)
                    Column(
                      children: [
                        _buildUserComment(widget.coach.comments[i]),
                        if (i <
                            widget.coach.comments.length -
                                1) // Check if it's not the last comment
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20), // Set the border radius
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String youtubeLink =
                          "https://youtu.be/cZyHgKtK75A?si=jfF3KSP9pzDtuPPK";
                      launch(youtubeLink);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.link,
                          color: Colors.green,
                        ),
                        const SizedBox(
                            width: 8), // Add some space between icon and text
                        const Text(
                          'LINK',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      // Set text color to dark
                      side: BorderSide(
                          color: Colors.grey), // Set the dark boundary color
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildUserComment(Comment comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(comment.userPhotoUrl),
              radius: 15,
            ),
            SizedBox(width: 10),
            Text(
              comment.userName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Row(),
          ],
        ),
        SizedBox(height: 5),
        Text(
          comment.comment,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildRatingItem(String label, double rating) {
    int totalStars = 5;
    double starSize = 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Row(
              children: List.generate(
                totalStars,
                (index) => Icon(
                  Icons.star,
                  color: index < rating.ceil() ? Colors.yellow : Colors.grey,
                  size: starSize,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              rating.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
