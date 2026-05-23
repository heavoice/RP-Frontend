import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:frontend/env.dart';
import 'package:frontend/storage/token_storage.dart';
import 'package:http/http.dart' as http;

class LoginService {
  /// LOGIN
  static Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('========== LOGIN ==========');

      final url = Uri.parse(
        '${Env.gateway}/auth/login',
      );

      debugPrint('URL: $url');

      debugPrint('EMAIL: $email');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      debugPrint(
        'LOGIN STATUS: ${response.statusCode}',
      );

      debugPrint(
        'LOGIN BODY: ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(
          response.body,
        );

        debugPrint(
          'LOGIN SUCCESS',
        );

        debugPrint(
          'TOKEN: ${data['token']}',
        );

        debugPrint(
          'USER ID: ${data['userId']}',
        );

        return data;
      }

      throw Exception(
        'Login gagal: ${response.body}',
      );
    } catch (e) {
      debugPrint(
        'LOGIN ERROR: $e',
      );

      rethrow;
    }
  }

  /// GET USER
  static Future<dynamic> getUser(
    int id,
  ) async {
    try {
      debugPrint('========== GET USER ==========');

      final token = await TokenStorage.get();

      debugPrint(
        'TOKEN: $token',
      );

      if (token == null) {
        throw Exception(
          'Token tidak ada',
        );
      }

      final url = Uri.parse(
        '${Env.gateway}/users/$id',
      );

      debugPrint(
        'URL: $url',
      );

      debugPrint(
        'USER ID: $id',
      );

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint(
        'GET USER STATUS: ${response.statusCode}',
      );

      debugPrint(
        'GET USER BODY: ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(
          response.body,
        );

        debugPrint(
          'GET USER SUCCESS',
        );

        return data;
      }

      throw Exception(
        'Gagal ambil user: ${response.body}',
      );
    } catch (e) {
      debugPrint(
        'GET USER ERROR: $e',
      );

      rethrow;
    }
  }
}
