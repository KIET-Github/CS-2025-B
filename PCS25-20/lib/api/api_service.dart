import 'dart:convert';
import 'package:diet/models/fitness_response.dart';
import 'package:diet/models/user_input.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.231.177:8000/api/fitness-plan';
// Use 10.0.2.2 for emulator

  Future<FitnessResponse> fetchFitnessPlan(UserInput userInput) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userInput.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return FitnessResponse.fromJson(data);
      } else {
        throw Exception('Failed to fetch fitness plan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching fitness plan: $e');
    }
  }
}
