import 'package:flutter/material.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final _durationController = TextEditingController();
  final _weightController = TextEditingController();
  String _selectedExercise = 'Running (8 km/h)';
  double? _caloriesBurned;

  final Map<String, double> metValues = {
    'Running (8 km/h)': 8.3,
    'Walking (5 km/h)': 3.5,
    'Cycling (slow)': 4.0,
    'Yoga': 2.5,
  };

  void _calculateCalories() {
    final weight = double.tryParse(_weightController.text);
    final duration = double.tryParse(_durationController.text);

    if (weight == null || duration == null || weight <= 0 || duration <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter valid values")),
      );
      return;
    }

    final met = metValues[_selectedExercise]!;
    final calories = met * weight * (duration / 60);
    setState(() {
      _caloriesBurned = calories;
    });
  }

  @override
  void dispose() {
    _durationController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Burn Calculator'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedExercise,
                  decoration: InputDecoration(
                    labelText: 'Exercise Type',
                    border: OutlineInputBorder(),
                  ),
                  items: metValues.keys.map((exercise) {
                    return DropdownMenuItem(
                      value: exercise,
                      child: Text(exercise),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedExercise = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Duration (minutes)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Your Weight (kg)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateCalories,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Calculate Calories Burned"),
                ),
                if (_caloriesBurned != null) ...[
                  SizedBox(height: 20),
                  Text(
                    "Calories Burned: ${_caloriesBurned!.toStringAsFixed(2)} kcal",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
