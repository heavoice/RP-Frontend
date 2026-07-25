import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/settings/get_initial.dart';
import 'package:frontend/settings/joined_date.dart';

class SecondWidget extends ConsumerStatefulWidget {
  const SecondWidget({super.key});

  @override
  ConsumerState<SecondWidget> createState() => _SecondWidgetState();
}

class _SecondWidgetState extends ConsumerState<SecondWidget> {
  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final userAsync = ref.watch(userProvider);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth < 480 ? 300 : 400,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black12,
          ),
        ),
        child: Row(
          children: [
            userAsync.when(
              loading: () => Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "?",
                        style: TextStyle(
                          color: AppColors.primarycolor,
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
                      color: Colors.black12,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "?",
                        style: TextStyle(
                          color: AppColors.primarycolor,
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(
                          color: Colors.black12,
                          width: 1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        getInitials(userName),
                        style: const TextStyle(
                          color: AppColors.primarycolor,
                          fontFamily: AppFonts.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: textStyle(
                            14,
                            FontWeight.w600,
                            Colors.black,
                          ),
                        ),
                        Text(
                          user?['email'] ?? "No Email",
                          style: textStyle(
                            11,
                            FontWeight.w300,
                            AppColors.secondwidgetborder,
                          ),
                        ),
                        Row(
                          children: [
                            if (user?['id'] != null)
                              Text(
                                "User #${user!['id']}",
                                style: textStyle(
                                  11,
                                  FontWeight.w300,
                                  AppColors.secondwidgetborder,
                                ),
                              ),
                            if (user?['id'] != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  "•",
                                  style: textStyle(
                                    11,
                                    FontWeight.w300,
                                    AppColors.secondwidgetborder,
                                  ),
                                ),
                              ),
                            Text(
                              "Bergabung ${formatJoinedDate(user?['createdAt'])}",
                              style: textStyle(
                                11,
                                FontWeight.w300,
                                AppColors.secondwidgetborder,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
