import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';

class SignuplineText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const SignuplineText({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<SignuplineText> createState() => _SignuplineTextState();
}

class _SignuplineTextState extends State<SignuplineText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                fontFamily: AppFonts.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primarycolor,
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.centerRight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: _isHovering ? 39 : 0,
                height: 2,
                color: AppColors.primarycolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
