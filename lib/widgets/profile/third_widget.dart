import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ThirdWidget extends ConsumerStatefulWidget {
  const ThirdWidget({super.key});

  @override
  ConsumerState<ThirdWidget> createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends ConsumerState<ThirdWidget> {
  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktivitas',
          style: textStyle(14, FontWeight.w400, AppColors.secondwidgetborder),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: screenWidth < 480 ? 300 : 400,
          ),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          child: Column(
            children: [
              _menuItem(
                icon: LucideIcons.userPen,
                title: "Edit Profile",
                onTap: () {
                  // TODO: Edit Profile
                },
              ),
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              _menuItem(
                icon: LucideIcons.album,
                title: "Riwayat Booking",
                onTap: () {
                  // TODO: Riwayat Booking
                },
              ),
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              _menuItem(
                icon: LucideIcons.receiptText,
                title: "Riwayat Transaksi",
                onTap: () {
                  // TODO: Riwayat Transaksi
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: AppColors.primarycolor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: textStyle(
                  12,
                  FontWeight.w500,
                  Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.secondwidgetborder,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
