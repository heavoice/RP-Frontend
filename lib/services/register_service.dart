import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';

class RegisterService {
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? birthDate,
    String? gender,
  }) async {
    final url = Uri.parse('${Env.gateway}/users/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "birthDate": birthDate,
        "gender": gender,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Register failed: ${response.body}');
    }
  }
}
