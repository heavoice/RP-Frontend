import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/login_service.dart';

final userProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final auth = ref.watch(authProvider);

  if (auth.userId == null || auth.userId == 0) {
    return null;
  }

  return await LoginService.getUser(auth.userId!);
});
