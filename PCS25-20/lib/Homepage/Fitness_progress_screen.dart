import 'package:flutter/material.dart';
import 'package:diet/models/fitness_response.dart';

class FitnessProgressScreen extends StatelessWidget {
  final FitnessResponse response;
  final List<List<bool>> checkedExercises;

  FitnessProgressScreen({
    required this.response,
    required this.checkedExercises,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Progress'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: response.exercisePlan.length,
        itemBuilder: (context, dayIndex) {
          var day = response.exercisePlan[dayIndex];
          var checked = checkedExercises[dayIndex];

          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day['day'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  ...day['exercises'].asMap().entries.map((entry) {
                    int exerciseIndex = entry.key;
                    var exercise = entry.value;

                    return Row(
                      children: [
                        Icon(
                          checked[exerciseIndex]
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: checked[exerciseIndex]
                              ? Colors.green
                              : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(exercise['name'])),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
