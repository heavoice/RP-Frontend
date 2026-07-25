import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:frontend/env.dart';
import 'package:frontend/services/token_helper.dart';
import 'package:frontend/storage/token_storage.dart';

import 'package:http/http.dart' as http;

class HouseService {
  static Future<List<dynamic>> getHouses() async {
    try {
      final token = await TokenStorage.get();

      final url = Uri.parse(
        '${Env.gateway}/houses',
      );

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      /// HANDLE 401
      TokenHelper.handleUnauthorized(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(
          response.body,
        );

        return data;
      }
      throw Exception(
        'Gagal ambil houses',
      );
    } catch (e) {
      rethrow;
    }
  }
}
