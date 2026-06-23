import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PaymentMethodItem extends StatelessWidget {
  final String title;
  final String value;
  final String? selectedValue;
  final Function(String value) onSelected;
  final IconData icon;
  final String description;

  const PaymentMethodItem({
    super.key,
    required this.title,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedValue == value;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => onSelected(value),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected ? AppColors.secondcolor : Colors.black12,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.secondcolor : Colors.black12,
              ),
              child: Icon(
                icon, // 👈 pakai icon dari parameter
                size: 12,
                color:
                    isSelected ? AppColors.background : AppColors.secondcolor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppFonts.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: AppFonts.primary,
                      fontSize: 7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            isSelected
                ? const Icon(
                    LucideIcons.circleCheckBig,
                    size: 18,
                    color: AppColors.secondcolor,
                  )
                : Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black26,
                        width: 1.5,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
