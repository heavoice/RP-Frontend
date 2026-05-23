import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get gateway {
    const definedUrl = String.fromEnvironment(
      'GATEWAY_URL',
    );
    if (definedUrl.isNotEmpty) {
      return definedUrl;
    }
    final envUrl = dotenv.env['GATEWAY_URL'];
    if (envUrl != null && envUrl.isNotEmpty) {
      return envUrl;
    }
    throw Exception(
      'GATEWAY_URL not found',
    );
  }

  static Future<void> load() async {
    if (kIsWeb) return;
    await dotenv.load(
      fileName: const String.fromEnvironment(
        'ENV',
        defaultValue: '.env.development',
      ),
    );
  }
}
