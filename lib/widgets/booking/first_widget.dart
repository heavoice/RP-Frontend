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
  String selectedType = '';

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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            LucideIcons.arrowLeft,
                            color: AppColors.secondwidgetborder,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Booking',
                              style: textStyle(12, FontWeight.w300,
                                  AppColors.secondwidgetborder)),
                          const SizedBox(height: 2),
                          Text(
                            'Lihat list bookinganmu',
                            style: textStyle(
                              18,
                              FontWeight.w600,
                              Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
