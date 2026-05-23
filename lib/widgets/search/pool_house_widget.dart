import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/exceptions/unauthorized_exception.dart';
import 'package:frontend/providers/auth_provider.dart';

import 'package:frontend/settings/constant.dart';
import 'package:frontend/services/house_service.dart';
import 'package:frontend/widgets/house_card.dart';

class PoolHouseWidget extends ConsumerStatefulWidget {
  const PoolHouseWidget({super.key});

  @override
  ConsumerState<PoolHouseWidget> createState() => _PoolHouseWidgetState();
}

class _PoolHouseWidgetState extends ConsumerState<PoolHouseWidget> {
  late Future<List<dynamic>> housesFuture;

  @override
  void initState() {
    super.initState();

    housesFuture = loadHouses();
  }

  /// LOAD HOUSES
  Future<List<dynamic>> loadHouses() async {
    try {
      final houses = await HouseService.getHouses();

      return houses;
    } on UnauthorizedException {
      /// AUTO LOGOUT REACTIVE
      await ref.read(authProvider.notifier).logout();

      rethrow;
    }
  }

  TextStyle textStyle(
    double size,
    FontWeight weight,
    Color color,
  ) {
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
          'Daftar Rumah',
          style: textStyle(
            16,
            FontWeight.w600,
            Colors.black,
          ),
        ),
        Text(
          'Urutkan',
          style: textStyle(
            12,
            FontWeight.w400,
            AppColors.primarycolor,
          ),
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
        /// LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildWrapper(
            screenWidth: screenWidth,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 80,
              ),
              child: const CircularProgressIndicator(
                color: AppColors.primarycolor,
              ),
            ),
          );
        }

        /// ERROR
        if (snapshot.hasError) {
          final error = snapshot.error;

          /// UNAUTHORIZED
          if (error is UnauthorizedException) {
            /// TIDAK PERLU NAVIGATOR MANUAL
            /// authProvider sudah logout otomatis

            return const SizedBox();
          }

          return _buildWrapper(
            screenWidth: screenWidth,
            child: Center(
              child: Text(
                'Gagal mengambil data rumah',
                style: textStyle(
                  14,
                  FontWeight.w500,
                  Colors.red,
                ),
              ),
            ),
          );
        }

        /// DATA
        List<dynamic> houses = snapshot.data ?? [];

        /// SORT ASCENDING
        houses.sort(
          (a, b) => (a['id'] ?? 0).compareTo(b['id'] ?? 0),
        );

        /// EMPTY
        if (houses.isEmpty) {
          return _buildWrapper(
            screenWidth: screenWidth,
            child: Center(
              child: Text(
                'Tidak ada rumah tersedia',
                style: textStyle(
                  14,
                  FontWeight.w500,
                  AppColors.primarycolor,
                ),
              ),
            ),
          );
        }

        /// SUCCESS
        return SingleChildScrollView(
          child: _buildWrapper(
            screenWidth: screenWidth,
            child: Column(
              children: houses.map((house) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: HouseCard(
                    house: house,
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
