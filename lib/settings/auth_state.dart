class AuthState {
  final String? token;
  final int? userId;
  final bool initialized;

  const AuthState({
    this.token,
    this.userId,
    this.initialized = false,
  });

  bool get isLoggedIn {
    return token != null && token!.isNotEmpty;
  }

  AuthState copyWith({
    String? token,
    int? userId,
    bool? initialized,
  }) {
    return AuthState(
      token: token,
      userId: userId,
      initialized: initialized ?? this.initialized,
    );
  }
}
