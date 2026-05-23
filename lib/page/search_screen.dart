import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/mobile_drawer.dart';
import 'package:frontend/widgets/search/first_widget.dart';
import 'package:frontend/widgets/search/pool_house_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FirstWidget(),
            SizedBox(height: 40),
            PoolHouseWidget(),
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
