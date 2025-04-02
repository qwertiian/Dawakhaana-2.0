import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/env.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: Env.apiTimeout,
    receiveTimeout: Env.apiTimeout,
  ));
  final _storage = const FlutterSecureStorage(); // Changed from FlutterStorage

  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

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
}