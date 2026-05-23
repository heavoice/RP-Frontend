import 'package:flutter_riverpod/legacy.dart';
import 'package:frontend/services/login_service.dart';
import 'package:frontend/settings/auth_state.dart';
import 'package:frontend/storage/token_storage.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  /// LOAD SESSION SAAT APP START
  Future<void> loadSession() async {
    final token = await TokenStorage.get();
    final userId = await TokenStorage.getUserId();

    state = AuthState(
      token: token,
      userId: userId == 0 ? null : userId,
      initialized: true,
    );
  }

  /// LOGIN
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final data = await LoginService.login(
      email: email,
      password: password,
    );

    final token = data['token'];
    final userId = data['userId'];

    await TokenStorage.save(token);

    await TokenStorage.saveUserId(userId);

    state = AuthState(
      token: token,
      userId: userId,
      initialized: true,
    );
  }

  /// LOGOUT
  Future<void> logout() async {
    await TokenStorage.clear();

    state = const AuthState(
      initialized: true,
    );
  }
}
