import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:frontend/env.dart';
import 'package:frontend/services/token_helper.dart';
import 'package:frontend/storage/token_storage.dart';

import 'package:http/http.dart' as http;

class FavoriteService {
  /// ADD FAVORITE
  static Future<List<dynamic>> addFavorite(
    int houseId,
  ) async {
    try {
      final token = await TokenStorage.get();

      final userId = await TokenStorage.getUserId();

      debugPrint(
        'TOKEN: $token',
      );

      debugPrint(
        'USERID: $userId',
      );

      debugPrint(
        'HOUSEID: $houseId',
      );

      if (token == null) {
        throw Exception(
          'Token null',
        );
      }

      if (userId == 0) {
        throw Exception(
          'UserId tidak valid',
        );
      }

      final response = await http.post(
        Uri.parse(
          '${Env.gateway}/users/favorites',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'x-user-id': userId.toString(),
        },
        body: jsonEncode({
          'houseId': houseId,
        }),
      );

      debugPrint(
        'ADD FAVORITE STATUS: ${response.statusCode}',
      );

      debugPrint(
        'ADD FAVORITE BODY: ${response.body}',
      );

      /// HANDLE 401
      TokenHelper.handleUnauthorized(
        response.statusCode,
      );

      final body = response.body.isNotEmpty
          ? jsonDecode(
              response.body,
            )
          : null;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body ?? {};
      }

      throw Exception(
        body?['error'] ?? 'Failed to add favorite',
      );
    } catch (e) {
      debugPrint(
        'ADD FAVORITE ERROR: $e',
      );

      rethrow;
    }
  }

  /// GET FAVORITES
  static Future<List<dynamic>> getFavorites(
    int userId,
  ) async {
    try {
      final token = await TokenStorage.get();

      final response = await http.get(
        Uri.parse(
          '${Env.gateway}/users/$userId/favorites/',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint(
        'GET FAVORITES STATUS: ${response.statusCode}',
      );

      debugPrint(
        'GET FAVORITES BODY: ${response.body}',
      );

      /// HANDLE 401
      TokenHelper.handleUnauthorized(
        response.statusCode,
      );

      if (response.statusCode == 200) {
        return jsonDecode(
          response.body,
        );
      }

      throw Exception(
        'Failed to get favorites',
      );
    } catch (e) {
      debugPrint(
        'GET FAVORITES ERROR: $e',
      );

      rethrow;
    }
  }

  /// REMOVE FAVORITE
  static Future<Map<String, dynamic>> removeFavorite(
    int houseId,
  ) async {
    try {
      final token = await TokenStorage.get();

      final userId = await TokenStorage.getUserId();

      if (token == null) {
        throw Exception(
          'Token null',
        );
      }

      if (userId == 0) {
        throw Exception(
          'UserId tidak valid',
        );
      }

      final response = await http.delete(
        Uri.parse(
          '${Env.gateway}/users/favorites/$userId/$houseId',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint(
        'REMOVE FAVORITE STATUS: ${response.statusCode}',
      );

      debugPrint(
        'REMOVE FAVORITE BODY: ${response.body}',
      );

      /// HANDLE 401
      TokenHelper.handleUnauthorized(
        response.statusCode,
      );

      final body = response.body.isNotEmpty
          ? jsonDecode(
              response.body,
            )
          : null;

      if (response.statusCode == 200) {
        return body ?? {};
      }

      throw Exception(
        body?['error'] ?? 'Failed to remove favorite',
      );
    } catch (e) {
      debugPrint(
        'REMOVE FAVORITE ERROR: $e',
      );

      rethrow;
    }
  }
}
