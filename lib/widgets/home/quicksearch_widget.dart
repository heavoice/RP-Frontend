import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/search_provider.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/qsearchhouse_slider.dart';

class QuickSearchWidget extends ConsumerWidget {
  const QuickSearchWidget({super.key});

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
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final houses = ref.watch(searchProvider);

    final screenWidth = MediaQuery.of(context).size.width;

    /// BELUM SEARCH
    if (houses == null) {
      return const SizedBox.shrink();
    }

    /// EMPTY
    if (houses.isEmpty) {
      return _buildWrapper(
        screenWidth: screenWidth,
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Rumah tidak ditemukan',
                    style: textStyle(
                      14,
                      FontWeight.w500,
                      Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
      );
    }

    /// SORT ASCENDING
    houses.sort(
      (a, b) => (a['id'] ?? 0).compareTo(b['id'] ?? 0),
    );

    /// SUCCESS
    return SingleChildScrollView(
      child: _buildWrapper(
        screenWidth: screenWidth,
        child: QuickSearchHouseSlider(
          houses: houses,
        ),
      ),
    );
  }
}
