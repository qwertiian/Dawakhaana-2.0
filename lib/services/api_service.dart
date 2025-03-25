import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/article.dart';
import '/models/condition.dart';
import '/models/symptom.dart';
import '/utils/constants.dart';

class ApiService {
  final String baseUrl = AppConstants.baseUrl;
  final http.Client client = http.Client();

  Future<List<Symptom>> getSymptoms() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl${AppConstants.symptomsEndpoint}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Symptom.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load symptoms');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Condition>> getConditions() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl${AppConstants.conditionsEndpoint}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Condition.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load conditions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> getArticles() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl${AppConstants.articlesEndpoint}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Condition>> getConditionsForSymptom(String symptomId) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl${AppConstants.conditionsEndpoint}?symptom=$symptomId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Condition.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load conditions for symptom');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Symptom>> getSymptomsForCondition(String conditionId) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl${AppConstants.symptomsEndpoint}?condition=$conditionId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Symptom.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load symptoms for condition');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}