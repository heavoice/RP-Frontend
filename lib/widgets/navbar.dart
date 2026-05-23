// navbar.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';

class Navbar extends StatefulWidget {
  final ScrollController scrollController;
  const Navbar({super.key, required this.scrollController});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _hasShadow = false;

  TextStyle textStyle(double size, FontWeight weight) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: AppColors.background,
      );

  Widget navItem(String label) {
    return Text(label, style: textStyle(14, FontWeight.w600));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController.addListener(_scrollListener);
    });
  }

  void _scrollListener() {
    final isScrolled = widget.scrollController.offset > 0;
    if (isScrolled != _hasShadow) {
      setState(() {
        _hasShadow = isScrolled;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: _hasShadow ? 192 : 128),
      width: double.infinity,
      height: _hasShadow ? 90 : 110,
      child: Transform.translate(
        offset: const Offset(0, 10),
        child: ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              color: _hasShadow ? Colors.black : Colors.transparent,
              border: _hasShadow
                  ? Border.all(color: AppColors.primarycolor, width: 1)
                  : null,
              borderRadius: _hasShadow ? BorderRadius.circular(20) : null,
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: _hasShadow ? 36 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/img/logo.png',
                    ),
                    Wrap(
                      spacing: 32,
                      children: [
                        navItem('About'),
                        navItem('Services'),
                        navItem('Blog'),
                        navItem('FAQ'),
                      ],
                    ),
                    Wrap(
                      spacing: 32,
                      children: [
                        navItem('Sign In'),
                        navItem('Log In'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
