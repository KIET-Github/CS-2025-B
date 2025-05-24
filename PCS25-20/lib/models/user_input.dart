class UserInput {
  final int age;
  final double weight;
  final double height;
  final String gender;
  final String activityLevel;
  final String goal;

  UserInput({
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.activityLevel,
    required this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'activity_level': activityLevel,
      'goal': goal,
    };
  }
}
