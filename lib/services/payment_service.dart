import 'dart:convert';
import 'package:frontend/env.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<Map<String, dynamic>> createPayment({
    required String token,
    required int bookingId,
    String? method,
  }) async {
    final uri = Uri.parse('${Env.gateway}/payments');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'bookingId': bookingId,
        'method': method,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    }

    throw Exception(data['error'] ?? 'Failed to create payment');
  }

  static Future<Map<String, dynamic>?> getPaymentByBooking({
    required String token,
    required int bookingId,
  }) async {
    final uri = Uri.parse('${Env.gateway}/payments/booking/$bookingId');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }

  static Future<Map<String, dynamic>> payPayment({
    required String token,
    required int paymentId,
  }) async {
    final uri = Uri.parse('${Env.gateway}/payments/$paymentId/pay');

    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = jsonDecode(response.body);

    /// ✅ SUCCESS
    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(data['error'] ?? 'Failed to pay payment');
  }
}
