import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';

class PasswordUnderlineText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const PasswordUnderlineText({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<PasswordUnderlineText> createState() => _PasswordUnderlineTextState();
}

class _PasswordUnderlineTextState extends State<PasswordUnderlineText> {
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
            const SizedBox(height: 2),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.centerRight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: _isHovering ? 98 : 0,
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
