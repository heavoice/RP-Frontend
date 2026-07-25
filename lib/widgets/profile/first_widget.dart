import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FirstWidget extends StatefulWidget {
  const FirstWidget({super.key});

  @override
  State<FirstWidget> createState() => _FirstWidgetState();
}

class _FirstWidgetState extends State<FirstWidget> {
  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
          margin: const EdgeInsets.only(top: 42),
          constraints: BoxConstraints(
            maxWidth: screenWidth < 480 ? 300 : 400,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Aksi ketika ikon diklik
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            LucideIcons.arrowLeft,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Profil',
                              style:
                                  textStyle(18, FontWeight.w600, Colors.black)),
                          const SizedBox(height: 2),
                          Text(
                            'Kelola Profil Anda',
                            style: textStyle(
                              12,
                              FontWeight.w300,
                              AppColors.secondwidgetborder,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Colors.black12,
                        )),
                    child: const Icon(
                      LucideIcons.bell,
                      color: Colors.black,
                      size: 18,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
