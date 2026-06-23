import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isCopyable;
  final VoidCallback? onCopy;

  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isCopyable = false,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primarycolor.withValues(alpha: 0.12),
            ),
            child: Icon(
              icon,
              size: 12,
              color: AppColors.primarycolor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: AppFonts.primary,
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: AppFonts.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (isCopyable)
                      GestureDetector(
                        onTap: onCopy,
                        child: const Icon(
                          LucideIcons.copy,
                          size: 12,
                          color: AppColors.secondwidgetborder,
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
