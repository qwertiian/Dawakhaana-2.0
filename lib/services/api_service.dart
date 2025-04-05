import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/env.dart';
import '../models/article.dart';
import '../models/condition.dart';
import '../models/symptom.dart';

class ApiService {
<<<<<<< HEAD
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: Env.apiTimeout,
    receiveTimeout: Env.apiTimeout,
  ));
=======
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: Env.apiTimeout,
      receiveTimeout: Env.apiTimeout,
      sendTimeout: Env.apiTimeout,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
>>>>>>> a6bc40793cdae86e1990de3f4ac9570fd1d98741
  final _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Get all symptoms
  Future<List<Symptom>> getSymptoms() async {
    try {
      final response = await _dio.get('/symptoms');
      final List<dynamic> data = response.data;
      return data.map((json) => Symptom.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Failed to fetch symptoms');
    }
  }

  // Get all conditions
  Future<List<Condition>> getConditions() async {
    try {
      final response = await _dio.get('/conditions');
      final List<dynamic> data = response.data;
      return data.map((json) => Condition.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Failed to fetch conditions');
    }
  }

  // Get conditions for a specific symptom
  Future<List<Condition>> getConditionsForSymptom(String symptomId) async {
    try {
      final response = await _dio.get('/conditions?symptom_id=$symptomId');
      final List<dynamic> data = response.data;
      return data.map((json) => Condition.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Failed to fetch conditions for symptom');
    }
  }

  // Get all articles
  Future<List<Article>> getArticles() async {
    try {
      final response = await _dio.get('/articles');
      final List<dynamic> data = response.data;
      return data.map((json) => Article.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Failed to fetch articles');
    }
  }

  // Profile methods
  Future<Map<String, dynamic>> fetchProfile() async {
    final token = await _getToken();
    try {
      final response = await _dio.get(
        '/profile',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Failed to fetch profile');
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final token = await _getToken();
    await _dio.put(
      '/profile',
      data: data,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
  }

  /// Send OTP via Node.js backend
  Future<void> sendOtp(String phone, {String? name, required String mode}) async {
    try {
      print('📤 Sending OTP to: $phone');
      final response = await _dio.post(
        '/auth/send-otp',
        data: {
          'phone': phone,
          if (name != null) 'name': name,
          'mode': mode
        },
      );
      print('✅ OTP sent: ${response.data}');
    } on DioException catch (e) {
      print('❌ Error sending OTP');
      print('Status Code: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('Error Message: ${e.message}');
      throw Exception(e.response?.data['error'] ?? 'Failed to send OTP');
    }
  }

  /// Verify OTP via Node.js backend and store token securely
  Future<void> verifyOtp(String phone, String otp, {String? name}) async {
    try {
      final response = await _dio.post(
        '/auth/verify-otp',
        data: {
          'phone': phone,
          'otp': otp,
          if (name != null) 'name': name, // ✅ Only include name if provided
        },
      );

      final token = response.data['token'];
      if (token != null) {
        await _storage.write(key: 'auth_token', value: token);
      } else {
        throw Exception('Token missing in response');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'OTP verification failed');
    }
  }
}
