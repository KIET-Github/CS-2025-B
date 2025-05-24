class FitnessResponse {
  final Map<String, dynamic> predictions;
  final List<dynamic> exercisePlan;
  final List<dynamic> mealPlan;

  FitnessResponse({
    required this.predictions,
    required this.exercisePlan,
    required this.mealPlan,
  });

  factory FitnessResponse.fromJson(Map<String, dynamic> json) {
    return FitnessResponse(
      predictions: json['predictions'],
      exercisePlan: json['exercise_plan'],
      mealPlan: json['meal_plan'],
    );
  }
}
