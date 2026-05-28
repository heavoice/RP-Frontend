import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/booking/bookinglist_widget.dart';
import 'package:frontend/widgets/mobile_drawer.dart';
import 'package:frontend/widgets/booking/first_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FirstWidget(),
            SizedBox(height: 40),
            BookingListWidget(),
          ],
        ),
      ),

      floatingActionButton: MobileDrawer(),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // 🔥 cukup ini
    );
  }
}
