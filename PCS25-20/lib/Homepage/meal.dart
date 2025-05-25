import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Sample Coach data model
class Coach {
  final String name;
  final String experience;

  final bool isVeg;
  final String photoUrl;

  final String? Intro;
  final List<Comment> comments;

  Coach({
    required this.name,
    required this.experience,
    required this.isVeg,
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

class MealScreens extends StatefulWidget {
  @override
  State<MealScreens> createState() => _MealScreensState();
}

class _MealScreensState extends State<MealScreens> {
  String _selectedFilter = 'All'; // Default filter
  // Sample coach list data
  final List<Coach> coaches = [
    Coach(
      name: 'Leafy Greens',
      experience: ' 30 minutes to 1 hour',
      isVeg: true,
      // Replace with the coach's actual rating
      // Replace with the validation status for this coach
      photoUrl: 'assets/food2.jpg',
      Intro:
          'Leafy greens are a category of vegetables characterized by their green leaves, which are edible and often used in various culinary dishes. These vegetables are valued for their high nutritional content, including vitamins, minerals, fiber, and antioxidants. Leafy greens are known for their health benefits and are an essential component of a balanced diet. Some common examples of leafy greens include:',

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
      name: 'Healthy Snacks',
      experience: '15 minutes to 1 hour',
      isVeg: true,
// Replace with the coach's actual rating

      photoUrl: 'assets/food2.jpg',

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
      name: 'Whole Wheat Products',
      experience: '15 minutes to 1 hour',
      isVeg: false,
      // Replace with the coach's actual rating
      photoUrl: 'assets/food3.jpg',
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
      name: 'Herbs and Spices',
      experience: '830 min',
      isVeg: true,
      photoUrl: 'assets/food4.jpg',
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
      name: 'Healthy Fats',
      experience: '830 min',
      isVeg: true,
      photoUrl: 'assets/food3.jpg',
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
      name: 'Lean Proteins',
      experience: '830 min',
      isVeg: true,
      photoUrl: 'assets/food1.jpg',
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
      name: 'Vegetables',
      experience: '830 min',
      isVeg: true,
      photoUrl: 'assets/food2.jpg',
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
            'Meal',
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
                      _selectedFilter = 'vege';
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(101, 227, 131, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'vegetables',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'leafy';
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(101, 227, 131, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text('leafy',
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
                    color: const Color.fromRGBO(101, 227, 131, 1),
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
                          coaches[index].isVeg == 'true')) {
                    return Card(
                      color: const Color.fromRGBO(135, 250, 135, 1),
                      margin: const EdgeInsets.all(5.0),
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
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            coaches[index].name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ${coaches[index].experience}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                ' ${coaches[index].name}',
                                style: const TextStyle(color: Colors.black),
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
                    return const SizedBox.shrink();
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
        title: const Text(
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
          : const Center(child: Text('Coach details not available')),
    );
  }

  Widget buildCoachDetails() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.black,
        child: Container(
          padding: const EdgeInsets.all(7.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(220, 232, 223, 1),
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
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 18,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.coach.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Experience: ${widget.coach.experience}',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: showFullContent ? null : 200,
              width: double.infinity,
              decoration: BoxDecoration(
                //  color: const Color.fromRGBO(255, 231, 165, 0.1),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color.fromARGB(255, 189, 180, 117),
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
                            style: const TextStyle(
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
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
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
              child: const Column(
                children: [
                  // Add your heading here
                  Text(
                    'Kale',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  // Add your text content here
                  Text(
                    'Nutritional Benefits:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Kale is a nutrient powerhouse, containing high levels of vitamins A, C, and K, as well as calcium, potassium, and antioxidants like beta-carotene and quercetin',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Health Benefits:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Kale has been associated with various health benefits, including improved heart health, lowered blood pressure, and reduced inflammation. It is also beneficial for eye health and may help protect against age-related macular degeneration',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Usage:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Kale can be enjoyed raw in salads, baked into kale chips, sautéed as a side dish, or blended into smoothies for an added nutritional boost',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
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
              child: const Column(
                children: [
                  // Add your heading here
                  Text(
                    'Spinach',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  // Add your text content here
                  Text(
                    'Nutritional Benefits:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Spinach is rich in vitamins A, C, and K, as well as folate, iron, and magnesium. It also contains antioxidants such as lutein and zeaxanthin, which are beneficial for eye health',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Health Benefits:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Spinach is known for its potential to reduce the risk of chronic diseases such as heart disease and certain cancers. It also supports bone health due to its vitamin K content and aids digestion with its fiber content.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Usage:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Spinach can be eaten raw in salads, added to smoothies, or cooked in various dishes such as stir-fries, soups, and omelets.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
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
              child: const Column(
                children: [
                  // Add your heading here
                  Text(
                    'Swiss Chard',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  // Add your text content here
                  Text(
                    'Nutritional Benefits:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Swiss chard is packed with vitamins A, C, and K, as well as magnesium, potassium, and iron. It also contains antioxidants such as beta-carotene and flavonoids, which help protect cells from damage',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Health Benefits:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Swiss chard supports bone health, aids in digestion, and may help regulate blood sugar levels due to its fiber and magnesium content. It also beneficial for eye health and may reduce the risk of chronic diseases.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Usage:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // You can adjust the color as needed
                    ),
                  ),
                  Text(
                    'Swiss chard can be cooked similarly to spinach or kale by sautéing, steaming, or adding it to soups and stews. Its colorful stems and leaves make it a visually appealing addition to dishes.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // You can adjust the color as needed
                    ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rating Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRatingItem('Effectiveness', 4.5),
                  _buildRatingItem('Accessibility', 4.8),
                  _buildRatingItem('Popularity', 3.2),
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
                          const Divider(
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
            const SizedBox(
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
                    child: const Row(
                      children: [
                        Icon(
                          Icons.link,
                          color: Colors.green,
                        ),
                        SizedBox(
                            width: 8), // Add some space between icon and text
                        Text(
                          'LINK',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      // Set text color to dark
                      side: const BorderSide(
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
            const SizedBox(width: 10),
            Text(
              comment.userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Row(
          children: [
            Row(),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          comment.comment,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
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
