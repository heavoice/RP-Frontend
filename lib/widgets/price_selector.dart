import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';

class PriceSelector extends StatelessWidget {
  final String selectedPrice;
  final Function(String) onChanged;

  const PriceSelector({
    super.key,
    required this.selectedPrice,
    required this.onChanged,
  });

  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.tune,
                size: 14, color: AppColors.secondwidgetborder),
            const SizedBox(width: 4),
            Text(
              'ANGGARAN',
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
            Expanded(child: _item('Rp < 1M')),
            const SizedBox(width: 8),
            Expanded(child: _item('Rp 1-3M')),
            const SizedBox(width: 8),
            Expanded(child: _item('Rp 3-5M')),
            const SizedBox(width: 8),
            Expanded(child: _item('Rp 5M+')),
          ],
        ),
      ],
    );
  }

  Widget _item(String label) {
    final isSelected = selectedPrice == label;

    return InkWell(
      onTap: () => onChanged(label),
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarycolor : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: textStyle(
            9,
            FontWeight.w500,
            isSelected ? Colors.white : AppColors.secondwidgetborder,
          ),
        ),
      ),
    );
  }
}
