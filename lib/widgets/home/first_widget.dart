import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/exceptions/unauthorized_exception.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/login_service.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FirstWidget extends ConsumerStatefulWidget {
  const FirstWidget({super.key});

  @override
  ConsumerState<FirstWidget> createState() => _FirstWidgetState();
}

class _FirstWidgetState extends ConsumerState<FirstWidget> {
  String userName = '';
  bool isLoading = true;

  TextStyle textStyle(
    double size,
    FontWeight weight,
    Color color,
  ) {
    return TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  Future<void> fetchUser() async {
    try {
      /// AMBIL DARI PROVIDER
      final auth = ref.read(authProvider);

      final userId = auth.userId;

      debugPrint('USER ID: $userId');

      if (userId == null || userId == 0) {
        throw Exception('User ID tidak valid');
      }

      final user = await LoginService.getUser(userId);

      debugPrint('USER DATA: $user');

      if (!mounted) return;

      setState(() {
        userName = user?['name'] ?? 'User';

        isLoading = false;
      });
    } on UnauthorizedException {
      /// AUTO LOGOUT REACTIVE
      await ref.read(authProvider.notifier).logout();
    } catch (e) {
      debugPrint('GET USER ERROR: $e');

      if (!mounted) return;

      setState(() {
        userName = 'User';

        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 42),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth < 480 ? 300 : 400,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// USER INFO
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      color: AppColors.secondwidgetborder,
                      width: 45,
                      height: 45,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLoading ? "Loading..." : "Selamat Datang,",
                        style: textStyle(
                          12,
                          FontWeight.w300,
                          AppColors.secondwidgetborder,
                        ),
                      ),
                      if (!isLoading)
                        Text(
                          userName,
                          style: textStyle(
                            18,
                            FontWeight.w600,
                            Colors.black,
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              /// LOGOUT
              InkWell(
                onTap: () async {
                  /// LOGOUT GLOBAL REACTIVE
                  await ref.read(authProvider.notifier).logout();
                },
                borderRadius: BorderRadius.circular(999),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      LucideIcons.logOut,
                      color: AppColors.secondwidgetborder,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
