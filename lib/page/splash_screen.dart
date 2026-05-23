import 'package:flutter/material.dart';

import 'package:frontend/settings/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  TextStyle textStyle(
    double size,
    FontWeight weight,
  ) {
    return TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: size,
      fontWeight: weight,
      color: AppColors.primarycolor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/img/splash_screen3.0x.png',
              ),
              const SizedBox(height: 32),
              Text(
                'Temukan nilai rumah, apartemen, atau kos-kosan hanya dengan beberapa klik.',
                textAlign: TextAlign.center,
                style: textStyle(
                  12,
                  FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Made by Heavoice',
                style: textStyle(
                  12,
                  FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
