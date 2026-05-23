import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/home/first_widget.dart';
import 'package:frontend/widgets/home/third_widget.dart';
import 'package:frontend/widgets/mobile_drawer.dart';
import 'package:frontend/widgets/home/second_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            SizedBox(height: 40),
            ThirdWidget(),
            SizedBox(height: 100),
          ],
        ),
      ),

      floatingActionButton: MobileDrawer(),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // 🔥 cukup ini
    );
  }
}
