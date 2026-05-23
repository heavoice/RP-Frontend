import 'package:frontend/exceptions/unauthorized_exception.dart';

class TokenHelper {
  static void handleUnauthorized(
    int statusCode,
  ) {
    if (statusCode == 401) {
      throw UnauthorizedException(
        'Unauthorized',
      );
    }
  }
}
