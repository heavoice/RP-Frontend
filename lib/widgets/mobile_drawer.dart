import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/navigator_provider.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MobileDrawer extends ConsumerWidget {
  const MobileDrawer({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    final activeMenu = ref.watch(navigationProvider);

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
                _navItem(
                  context,
                  ref,
                  title: 'Home',
                  activeMenu: activeMenu,
                  icon: LucideIcons.house,
                  route: '/home',
                ),
                const SizedBox(width: 20),
                _navItem(
                  context,
                  ref,
                  title: 'Search',
                  activeMenu: activeMenu,
                  icon: LucideIcons.search,
                  route: '/search',
                ),
                const SizedBox(width: 20),
                _navItem(
                  context,
                  ref,
                  title: 'Favorite',
                  activeMenu: activeMenu,
                  icon: LucideIcons.heart,
                  route: '/favorite',
                ),
                const SizedBox(width: 20),
                _navItem(
                  context,
                  ref,
                  title: 'User',
                  activeMenu: activeMenu,
                  icon: LucideIcons.user,
                  route: '/profile',
                ),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isAbove640 = screenWidth > 640;
    final isActive = activeMenu == title;

    return InkWell(
      onTap: () {
        if (isActive) return;

        /// UPDATE GLOBAL STATE
        ref
            .read(
              navigationProvider.notifier,
            )
            .state = title;

        Navigator.pushReplacementNamed(
          context,
          route,
        );
      },
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 250,
        ),
        curve: Curves.easeInOut,
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
              size: isAbove640 ? 24 : 20,
              color: isActive ? Colors.white : AppColors.secondwidgetborder,
            ),
            AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 200,
              ),
              child: isActive
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Text(
                        title,
                        key: ValueKey(
                          title,
                        ),
                        style: const TextStyle(
                          fontFamily: AppFonts.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
