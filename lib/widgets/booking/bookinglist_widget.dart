import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/services/booking_service.dart';
import 'package:frontend/widgets/bookinglist_card.dart';

class BookingListWidget extends ConsumerStatefulWidget {
  const BookingListWidget({super.key});

  @override
  ConsumerState<BookingListWidget> createState() => _BookingListWidgetState();
}

class _BookingListWidgetState extends ConsumerState<BookingListWidget> {
  late Future<List<dynamic>> housesFuture;

  @override
  void initState() {
    super.initState();
    housesFuture = loadHouses();
  }

  Future<List<dynamic>> loadHouses() async {
    try {
      /// 🔥 FIX: ambil token dari authProvider
      final auth = ref.read(authProvider);
      final token = auth.token ?? "";

      final bookings = await BookingService.getMyBookings(token);

      return bookings;
    } catch (e) {
      if (e.toString().contains("Unauthorized")) {
        await ref.read(authProvider.notifier).logout();
        rethrow;
      }

      rethrow;
    }
  }

  TextStyle textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontFamily: AppFonts.primary,
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Daftar Bookingan',
          style: textStyle(16, FontWeight.w600, Colors.black),
        ),
        Text(
          'Semua',
          style: textStyle(12, FontWeight.w400, AppColors.primarycolor),
        ),
      ],
    );
  }

  Widget _buildWrapper({
    required double screenWidth,
    required Widget child,
  }) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth < 480 ? 300 : 400,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<dynamic>>(
      future: housesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildWrapper(
            screenWidth: screenWidth,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.secondcolor,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return _buildWrapper(
            screenWidth: screenWidth,
            child: const Center(
              child: Text('Gagal mengambil data booking'),
            ),
          );
        }

        final bookings = snapshot.data ?? [];

        if (bookings.isEmpty) {
          return _buildWrapper(
            screenWidth: screenWidth,
            child: const Center(
              child: Text('Tidak ada booking tersedia'),
            ),
          );
        }

        return SingleChildScrollView(
          child: _buildWrapper(
            screenWidth: screenWidth,
            child: Column(
              children: bookings.map((booking) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: BookingListCard(
                    house: booking['house'],
                    status: booking['status'],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
