import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FirstWidget extends ConsumerStatefulWidget {
  const FirstWidget({super.key});

  @override
  ConsumerState<FirstWidget> createState() => _FirstWidgetState();
}

class _FirstWidgetState extends ConsumerState<FirstWidget> {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final userAsync = ref.watch(userProvider);
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
              userAsync.when(
                loading: () => Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 45,
                        height: 45,
                        color: AppColors.secondwidgetborder,
                        alignment: Alignment.center,
                        child: const Text(
                          "?",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Loading...",
                      style: textStyle(
                        12,
                        FontWeight.w300,
                        AppColors.secondwidgetborder,
                      ),
                    ),
                  ],
                ),
                error: (_, __) => Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 45,
                        height: 45,
                        color: AppColors.secondwidgetborder,
                        alignment: Alignment.center,
                        child: const Text(
                          "?",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "User",
                      style: textStyle(
                        18,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                  ],
                ),
                data: (user) {
                  final userName = user?['name'] ?? "User";

                  return Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 45,
                          height: 45,
                          color: AppColors.secondwidgetborder,
                          alignment: Alignment.center,
                          child: Text(
                            userName[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: AppFonts.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat Datang,",
                            style: textStyle(
                              12,
                              FontWeight.w300,
                              AppColors.secondwidgetborder,
                            ),
                          ),
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
                  );
                },
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
