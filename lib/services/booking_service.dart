import 'dart:convert';
import 'package:frontend/env.dart';
import 'package:http/http.dart' as http;

class BookingService {
  static Future<List<dynamic>> getMyBookings(String token) async {
    final uri = Uri.parse('${Env.gateway}/users/bookings/me');

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

    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    }

    throw Exception('Failed to load bookings');
  }

  static Future<Map<String, dynamic>> createBooking({
    required String token,
    required int houseId,
    String? notes,
  }) async {
    final uri = Uri.parse('${Env.gateway}/users/bookings');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'houseId': houseId,
        'notes': notes,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    }

    /// backend error message
    throw Exception(data['error'] ?? 'Failed to create booking');
  }
}
