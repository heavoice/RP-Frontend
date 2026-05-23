import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/page/login_screen.dart';
import 'package:frontend/providers/auth_provider.dart';

class ProtectedRoute extends ConsumerWidget {
  final Widget child;

  const ProtectedRoute({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    if (!auth.isLoggedIn) {
      return const LoginScreen();
    }

    return child;
  }
}
