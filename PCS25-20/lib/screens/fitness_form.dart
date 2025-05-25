import 'package:diet/api/api_service.dart';
import 'package:diet/models/user_input.dart';
import 'package:flutter/material.dart';

import 'fitness_result.dart';

class FitnessForm extends StatefulWidget {
  @override
  _FitnessFormState createState() => _FitnessFormState();
}

class _FitnessFormState extends State<FitnessForm> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String gender = 'female';
  String activityLevel = 'low';
  String goal = 'weight_loss';

  final List<String> genders = ['male', 'female'];
  final List<String> activityLevels = ['low', 'moderate', 'high'];
  final List<String> goals = ['weight_loss', 'muscle_gain', 'maintenance'];

  void submitForm() async {
    try {
      final userInput = UserInput(
        age: int.parse(ageController.text),
        weight: double.parse(weightController.text),
        height: double.parse(heightController.text),
        gender: gender,
        activityLevel: activityLevel,
        goal: goal,
      );

      final apiService = ApiService(); // Create an instance of ApiService
      final response = await apiService.fetchFitnessPlan(userInput);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FitnessResult(response: response),
        ),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch fitness plan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Plan Input'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: heightController,
                decoration: InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField(
                value: gender,
                items: genders.map((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    gender = newValue as String;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              DropdownButtonFormField(
                value: activityLevel,
                items: activityLevels.map((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    activityLevel = newValue as String;
                  });
                },
                decoration: InputDecoration(labelText: 'Activity Level'),
              ),
              DropdownButtonFormField(
                value: goal,
                items: goals.map((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    goal = newValue as String;
                  });
                },
                decoration: InputDecoration(labelText: 'Goal'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 83, 194, 83), // Set background color
                  foregroundColor: Colors.white, // Set text color
                ),
                onPressed: submitForm,
                child: Text('Get Plan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
