import 'package:diet/Homepage/recipedetails.dart';
import 'package:flutter/material.dart';
import 'dart:core';

// import 'package:aa_application/Homepage/coachServices.dart';
// import 'package:aa_application/Homepage/homepage.dart';
// import 'package:aa_application/login_screen.dart';
class Coach {
  final String name;

  final String rating;
  final bool isValidated;
  final String photoUrl;
  final String phoneNumber;
  final String? Intro;
  final String fee;
  final String game;
  final List<Comment> comments;

  Coach({
    required this.name,
    required this.rating,
    required this.isValidated,
    required this.photoUrl,
    required this.fee,
    required this.game,
    required this.Intro,
    required this.phoneNumber,
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

class foodList extends StatefulWidget {
  @override
  _foodListState createState() => _foodListState();
}

class _foodListState extends State<foodList> {
  bool isPressed = false;

  final List<Coach> coaches = [
    Coach(
        name: 'Quino Salad',
        rating: '', // Replace with the coach's actual rating
        isValidated: true, // Replace with the validation status for this coach
        photoUrl: 'assets/food3.jpg',
        fee: "Veg",
        game: 'Cricket',
        Intro:
            'Rinse the quinoa under cold water in a fine mesh strainer to remove any bitterness.In a medium saucepan, bring the water or vegetable broth to a boil. Add the quinoa and reduce the heat to low. Cover and simmer for about 15-20 minutes, or until all the liquid is absorbed and the quinoa is fluffy. Remove from heat and let it cool.In a large bowl ,combine the cooked quinoa, bell pepper, cucumber, red onion, cherry tomatoes, parsley, and cilantro.In a small bowl, whisk together the lemon juice, olive oil, salt, and pepper. Pour the dressing over the quinoa salad and toss until everything is well combined.Taste and adjust seasoning if needed. You can also add additional herbs or spices according to your preference.Serve chilled or at room temperature. Enjoy your nutritious and delicious quinoa salad!',
        phoneNumber: '+91 6397067492',
        comments: [
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/verify.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          // Add more comments as needed
        ]),
    Coach(
        name: 'chicken',
        rating: '', // Replace with the coach's actual rating
        isValidated: false, // Replace with the validation status for this coach
        photoUrl: 'assets/food1.jpg',
        fee: "Non Veg",
        game: 'FootBall',
        Intro:
            'In a small bowl, whisk together the lemon juice, lemon zest, minced garlic, olive oil, chopped rosemary, thyme leaves, salt, and pepper to create the marinade.Place the chicken breasts in a shallow dish or a large resealable plastic bag. Pour the marinade over the chicken, making sure its evenly coated.Cover the dish or seal the bag and refrigerate for at least 30 minutes, or preferably marinate overnight for maximum flavor.Preheat your grill to medium-high heat.Remove the chicken from the marinade and discard any excess marinade.Grill the chicken breasts for about 6-8 minutes on each side, or until they are cooked through and have reached an internal temperature of 165°F (75°C). Cooking time may vary depending on the thickness of the chicken breasts.Once done, transfer the grilled chicken to a serving platter and garnish with lemon slices and chopped parsley.Serve the grilled lemon herb chicken hot with your favorite side dishes, such as grilled vegetables, quinoa salad, or steamed brown rice.Enjoy your delicious and healthy grilled lemon herb chicken!',
        phoneNumber: '+91 6397067492',
        comments: [
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/verify.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          // Add more comments as needed
        ]),
    Coach(
        name: 'coach3',
        rating: '', // Replace with the coach's actual rating
        isValidated: true, // Replace with the validation status for this coach
        photoUrl: 'assets/food3.jpg',
        fee: "",
        game: 'Kabaddi',
        Intro:
            'Hello, I\'m ____, a seasoned and dedicated coach with a passion for empowering individuals to unlock their full potential. With [X] years of experience in [specific field or industry], I have honed the skills necessary to guide you on a transformative journey toward personal and professional growth. My coaching philosophy revolves around [brief description of coaching approach, such as fostering self-discovery, building resilience, or cultivating leadership skills]. As your coach, I am committed to creating a supportive and collaborative environment where we can explore your goals, overcome challenges, and celebrate your successes together. Let\'s embark on a journey of self-discovery and achievement – I\'m here to inspire and guide you every step of the way.',
        phoneNumber: '+91 6397067492',
        comments: [
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/verify.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          // Add more comments as needed
        ]),
    Coach(
        name: 'coach5',
        rating: '', // Replace with the coach's actual rating
        isValidated: true, // Replace with the validation status for this coach
        photoUrl: 'assets/food4.jpg',
        fee: "",
        game: 'Cricket',
        Intro:
            'Hello, I\'m ____, a seasoned and dedicated coach with a passion for empowering individuals to unlock their full potential. With [X] years of experience in [specific field or industry], I have honed the skills necessary to guide you on a transformative journey toward personal and professional growth. My coaching philosophy revolves around [brief description of coaching approach, such as fostering self-discovery, building resilience, or cultivating leadership skills]. As your coach, I am committed to creating a supportive and collaborative environment where we can explore your goals, overcome challenges, and celebrate your successes together. Let\'s embark on a journey of self-discovery and achievement – I\'m here to inspire and guide you every step of the way.',
        phoneNumber: '+91 6397067492',
        comments: [
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/verify.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          // Add more comments as needed
        ]),
    Coach(
        name: 'coach4',
        rating: '', // Replace with the coach's actual rating
        isValidated: true, // Replace with the validation status for this coach
        photoUrl: 'assets/food1.jpg',
        fee: "",
        game: 'Basket Ball',
        Intro:
            'Hello, I\'m ____, a seasoned and dedicated coach with a passion for empowering individuals to unlock their full potential. With [X] years of experience in [specific field or industry], I have honed the skills necessary to guide you on a transformative journey toward personal and professional growth. My coaching philosophy revolves around [brief description of coaching approach, such as fostering self-discovery, building resilience, or cultivating leadership skills]. As your coach, I am committed to creating a supportive and collaborative environment where we can explore your goals, overcome challenges, and celebrate your successes together. Let\'s embark on a journey of self-discovery and achievement – I\'m here to inspire and guide you every step of the way.',
        phoneNumber: '+91 6397067492',
        comments: [
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/coach.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          Comment(
            userName: 'Alice',
            userPhotoUrl: 'assets/verify.png', // Replace with Alice's photo URL
            // Replace with Alice's rating for Jane Smith
            comment:
                'Jane Smith is an excellent coach! I have experienced positive changes in my personal and professional life under her guidance.',
          ),
          // Add more comments as needed
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                const Text(
                  " Trending Recipe",
                  // style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3, wordSpacing: 5),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height:
                        1.5, // Corresponds to line-height: 24px for font-size: 16px
                    letterSpacing: 0.0,
                    // textAlign: TextAlign.left, // Uncomment this line if you need to set the text alignment
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isPressed = !isPressed;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => foodList()));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
            Container(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: coaches.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      },
                      child: Container(
                        width: 140.97,
                        height: 175,

                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 241,
                              243), // Your desired background color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //elevation: isPressed ? 10 : 2,

                        child: Column(
                          children: [
                            SizedBox(height: 3),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 70,
                                width: 70,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage(coaches[index].photoUrl),
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 130.0, // Adjust as needed
                            //   left: 189.0, // Adjust as needed
                            // child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                ),
                                const SizedBox(width: 2),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8), // Add padding if needed
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 246, 247,
                                          248), // Your desired background color
                                      borderRadius: BorderRadius.circular(
                                          20), // Adjust as needed
                                    ),
                                    child: Text(
                                      coaches[index].rating,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // ),
                            Text(coaches[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Align(
                              alignment: Alignment.center,
                              child: Text(coaches[index].fee),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isPressed = !isPressed;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              recipeDetailsScreen(
                                                  coach: coaches[index])));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  // fixedSize: Size(80,80),
                                ),
                                child: const Text("open",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 248, 245, 245))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
