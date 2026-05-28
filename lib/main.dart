import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/env.dart';
import 'package:frontend/page/booking_screen.dart';

import 'package:frontend/page/home_screen.dart';
import 'package:frontend/page/login_screen.dart';
import 'package:frontend/page/register_screen.dart';
import 'package:frontend/page/search_screen.dart';
import 'package:frontend/page/splash_screen.dart';

import 'package:frontend/providers/auth_provider.dart';

import 'package:frontend/settings/protected_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// LOAD ENV
  await Env.load();

  /// INIT PROVIDER CONTAINER
  final container = ProviderContainer();

  /// LOAD SESSION DARI STORAGE
  await container.read(authProvider.notifier).loadSession();

  runApp(
    /// SHARE CONTAINER KE SELURUH APP
    UncontrolledProviderScope(
      container: container,
      child: const RumahPrediksi(),
    ),
  );
}

class RumahPrediksi extends ConsumerWidget {
  const RumahPrediksi({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    /// WATCH AUTH STATE
    final auth = ref.watch(authProvider);

    /// SPLASH / LOADING SESSION
    if (!auth.initialized) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Rumah Prediksi',

      /// ROOT APP REACTIVE
      home: auth.isLoggedIn
          ? const ProtectedRoute(
              child: HomeScreen(),
            )
          : const LoginScreen(),

      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const ProtectedRoute(
              child: HomeScreen(),
            ),
        '/search': (_) => const ProtectedRoute(
              child: SearchScreen(),
            ),
        '/booking': (_) => const ProtectedRoute(
              child: BookingScreen(),
            )
      },
    );
  }
}
