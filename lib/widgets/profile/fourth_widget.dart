import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FourthWidget extends ConsumerStatefulWidget {
  const FourthWidget({super.key});

  @override
  ConsumerState<FourthWidget> createState() => _FourthWidgetState();
}

class _FourthWidgetState extends ConsumerState<FourthWidget> {
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
          'Pengaturan',
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
                icon: LucideIcons.settings,
                title: "Pengaturan Akun",
                onTap: () {
                  // TODO: Edit Profile
                },
              ),
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              _menuItem(
                icon: LucideIcons.bell,
                title: "Notifikasi",
                onTap: () {
                  // TODO: Riwayat Booking
                },
              ),
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              _menuItem(
                icon: LucideIcons.shieldCheck,
                title: "Keamanan",
                onTap: () {
                  // TODO: Riwayat Transaksi
                },
              ),
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              _menuItem(
                icon: LucideIcons.circleQuestionMark,
                title: "Bantuan",
                onTap: () {
                  // TODO: Riwayat Transaksi
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
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
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.logOut,
                    size: 18,
                    color: AppColors.primarycolor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Keluar Akun",
                      style: textStyle(
                        12,
                        FontWeight.w500,
                        Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
              LucideIcons.chevronRight,
              color: AppColors.secondwidgetborder,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
