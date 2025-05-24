import 'package:diet/Homepage/Fitness_progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:diet/models/fitness_response.dart';

class FitnessResult extends StatefulWidget {
  final FitnessResponse response;

  FitnessResult({required this.response});

  @override
  State<FitnessResult> createState() => _FitnessResultState();
}

class _FitnessResultState extends State<FitnessResult> {
  late List<List<bool>> _checkedExercises;

  @override
  void initState() {
    super.initState();

    _checkedExercises = widget.response.exercisePlan
        .map<List<bool>>(
          (day) => List<bool>.filled(day['exercises'].length, false),
        )
        .toList();
  }

  void _onExerciseChecked(int dayIndex, int exerciseIndex, bool? checked) {
    setState(() {
      _checkedExercises[dayIndex][exerciseIndex] = checked ?? false;

      if (_checkedExercises[dayIndex].every((c) => c)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Congratulations! You completed all exercises for ${widget.response.exercisePlan[dayIndex]['day']}'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void _navigateToProgressScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FitnessProgressScreen(
          response: widget.response,
          checkedExercises: _checkedExercises,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final response = widget.response;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Fitness Plan Result'),
        backgroundColor: Colors.green.shade400,
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            tooltip: 'View Progress',
            onPressed: _navigateToProgressScreen,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('Your Health Stats'),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow(Icons.local_fire_department, 'Target Calories',
                        '${response.predictions['target_calories']}'),
                    _infoRow(Icons.fitness_center, 'Protein Ratio',
                        '${response.predictions['protein_ratio']}%'),
                    _infoRow(Icons.donut_small, 'Carb Ratio',
                        '${response.predictions['carb_ratio']}%'),
                    _infoRow(Icons.oil_barrel, 'Fat Ratio',
                        '${response.predictions['fat_ratio']}%'),
                    _infoRow(Icons.directions_run, 'Exercise Intensity',
                        '${response.predictions['exercise_intensity']}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _sectionHeader('Weekly Exercise Plan'),
            ...response.exercisePlan.asMap().entries.map<Widget>((entry) {
              int dayIndex = entry.key;
              var day = entry.value;

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(day['day'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Focus: ${day['focus']}',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      ...day['exercises']
                          .asMap()
                          .entries
                          .map<Widget>((exEntry) {
                        int exerciseIndex = exEntry.key;
                        var exercise = exEntry.value;

                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(exercise['name'],
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text(
                              'Sets: ${exercise['sets']}, Reps: ${exercise['reps']}, Rest: ${exercise['rest']}s'),
                          value: _checkedExercises[dayIndex][exerciseIndex],
                          onChanged: (checked) => _onExerciseChecked(
                              dayIndex, exerciseIndex, checked),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.green,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            _sectionHeader('Personalized Meal Plan'),
            ...response.mealPlan.map<Widget>((meal) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(meal['meal_name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      ...meal['foods'].entries.map<Widget>((food) {
                        return Text('${food.key}: ${food.value}g');
                      }).toList(),
                      const SizedBox(height: 6),
                      Text('Total Calories: ${meal['total_calories']}',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(value),
        ],
      ),
    );
  }
}
