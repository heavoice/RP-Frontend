import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/mobile_drawer.dart';
import 'package:frontend/widgets/profile/first_widget.dart';
import 'package:frontend/widgets/profile/fourth_widget.dart';
import 'package:frontend/widgets/profile/second_widget.dart';
import 'package:frontend/widgets/profile/third_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FirstWidget(),
            SizedBox(height: 40),
            SecondWidget(),
            SizedBox(height: 20),
            ThirdWidget(),
            SizedBox(height: 20),
            FourthWidget(),
            SizedBox(height: 100)
          ],
        ),
      ),

      floatingActionButton: MobileDrawer(),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // 🔥 cukup ini
    );
  }
}
