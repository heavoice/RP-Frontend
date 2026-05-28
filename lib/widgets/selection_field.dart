import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';

class SelectionField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const SelectionField({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.secondwidgetborder),
              const SizedBox(width: 4),
              Text(
                label,
                style: textStyle(
                  11,
                  FontWeight.w500,
                  AppColors.secondwidgetborder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                value,
                style: textStyle(13, FontWeight.w600, Colors.black),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: AppColors.secondwidgetborder,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
