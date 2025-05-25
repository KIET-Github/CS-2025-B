import 'package:diet/Homepage/meal.dart';
import 'package:diet/workout.dart';
import 'package:flutter/material.dart';

class lists {
  final String listsName;
  final IconData icon;
  final void Function(BuildContext) function;

  lists({
    required this.listsName,
    required this.icon,
    required this.function,
  });
}

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  bool isPressed = false;
  final List<lists> games = [
    lists(
      listsName: "Workout",
      icon: Icons.fitness_center,
      function: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => workoutScreens()),
        );
      },
    ),
    lists(
      listsName: "Meal",
      icon: Icons.restaurant,
      function: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealScreens()),
        );
      },
    ),
    lists(
      listsName: "Recipe",
      icon: Icons.restaurant_menu,
      function: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => workoutScreens()),
        );
      },
    ),
    lists(
      listsName: "Kabaddi",
      icon: Icons.sports_kabaddi_sharp,
      function: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => workoutScreens()),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: 100.0,
        width: 600.0,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: List.generate(
            games.length,
            (index) => Row(
              children: [
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPressed = !isPressed;
                    });
                    games[index].function(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 25,
                    shadowColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: isPressed
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                        : BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                  ),
                  child: Row(
                    children: [
                      Icon(games[index].icon),
                      const SizedBox(width: 8),
                      Text(
                        games[index].listsName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
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
