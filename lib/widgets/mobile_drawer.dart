import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/navigator_provider.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/settings/route_mapper.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MobileDrawer extends ConsumerWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final activeMenu = ref.watch(navigationProvider);

    /// 🔥 AUTO SYNC ROUTE -> STATE (FIX REFRESH ISSUE)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context)?.settings.name ?? '/home';
      final menu = routeToMenu(route);

      if (ref.read(navigationProvider) != menu) {
        ref.read(navigationProvider.notifier).state = menu;
      }
    });

    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          elevation: 12,
          borderRadius: BorderRadius.circular(999),
          color: Colors.white,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: screenWidth < 480 ? 300 : 400,
            ),
            height: screenWidth > 640 ? 70 : 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _navItem(context, ref,
                    title: 'Home',
                    activeMenu: activeMenu,
                    icon: LucideIcons.house,
                    route: '/home'),
                const SizedBox(width: 16),
                _navItem(context, ref,
                    title: 'Search',
                    activeMenu: activeMenu,
                    icon: LucideIcons.search,
                    route: '/search'),
                const SizedBox(width: 16),
                _navItem(context, ref,
                    title: 'Booking',
                    activeMenu: activeMenu,
                    icon: LucideIcons.bookPlus,
                    route: '/booking'),
                const SizedBox(width: 16),
                _navItem(context, ref,
                    title: 'User',
                    activeMenu: activeMenu,
                    icon: LucideIcons.user,
                    route: '/profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String activeMenu,
    required IconData icon,
    required String route,
  }) {
    final isActive = activeMenu == title;

    return InkWell(
      onTap: () {
        if (isActive) return;

        ref.read(navigationProvider.notifier).state = title;

        Navigator.pushReplacementNamed(context, route);
      },
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 14 : 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarycolor : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.secondwidgetborder,
            ),
            if (isActive)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: AppFonts.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
