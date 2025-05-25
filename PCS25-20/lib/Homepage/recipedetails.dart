import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class recipeDetailsScreen extends StatefulWidget {
  final dynamic coach;
  recipeDetailsScreen({required this.coach});

  @override
  State<recipeDetailsScreen> createState() => _recipeDetailsScreenState();
}

class _recipeDetailsScreenState extends State<recipeDetailsScreen> {
  bool showFullContent = false;

  void navigateToChatScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const ChatScreen(),
    //   ),
    // );
  }

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
      body: widget.coach != null
          ? SingleChildScrollView(
              child: buildCoachDetails(),
            )
          : const Center(child: Text('recipe details not available')),
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
                Color.fromRGBO(204, 206, 204, 1),
                Color.fromRGBO(255, 255, 255, 0.9),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(widget.coach.photoUrl),
                            radius: 80,
                          ),
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
                              children: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            widget.coach.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(children: [
                          if (widget.coach.isValidated)
                            Icon(Icons.circle, color: Colors.green)
                          else
                            Icon(Icons.circle, color: Colors.red),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [],
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
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Recipe',
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
                              'No intro available',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingredients Required',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '1. Quinoa: 1 cup\n'
                      '2. Water or vegetable broth: 2 cups (used for cooking quinoa)\n'
                      '3. Vegetables (you can customize based on your preferences, but commonly used ones include):\n'
                      '   - Bell pepper: 1, diced\n'
                      '   - Cucumber: 1, diced\n'
                      '   - Red onion: 1/2, finely chopped\n'
                      '   - Cherry tomatoes: 1 cup, halved\n'
                      '4. Fresh herbs:\n'
                      '   - Parsley: 1/4 cup, chopped\n'
                      '   - Cilantro: 1/4 cup, chopped\n'
                      '5. Dressing:\n'
                      '   - Lemon juice: Juice of 1 lemon\n'
                      '   - Olive oil: 2 tablespoons\n'
                      '6. Salt and pepper to taste',
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
                      'Suggestions',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String youtubeLink =
                            "https://youtu.be/nzNQ5lTmg1Q?si=z5zG0UfFglXEQMAl";
                        launch(youtubeLink);
                        //    Navigator.push(context, MaterialPageRoute(builder: (context)=>CallPage(callID: "1")));
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserComment(Comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(Comment.userPhotoUrl),
              radius: 15,
            ),
            const SizedBox(width: 10),
            Text(
              Comment.userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          Comment.comment,
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
