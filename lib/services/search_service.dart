import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/env.dart';
import 'package:frontend/storage/token_storage.dart';
import 'package:http/http.dart' as http;

class SearchService {
  static Future<List<dynamic>> quickSearch({
    String? location,
    String? propertyType,
    int? priceMin,
    int? priceMax,
  }) async {
    final token = await TokenStorage.get();

    final query = {
      if (location != null) 'location': location,
      if (propertyType != null) 'propertyType': propertyType,
      if (priceMin != null) 'priceMin': priceMin.toString(),
      if (priceMax != null) 'priceMax': priceMax.toString(),
    };

    final uri = Uri.parse(
      '${Env.gateway}/search',
    ).replace(
      queryParameters: query,
    );

    debugPrint(uri.toString());
    debugPrint("TOKEN: $token");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Failed search houses: ${response.body}',
    );
  }
}
