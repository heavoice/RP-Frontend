import 'package:flutter/material.dart';
import 'package:frontend/widgets/house_card.dart';

class QuickSearchHouseSlider extends StatelessWidget {
  final List<dynamic> houses;
  final VoidCallback? onRefresh;

  const QuickSearchHouseSlider({
    super.key,
    required this.houses,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        clipBehavior: Clip.none,
        physics: const ClampingScrollPhysics(),
        padEnds: false,
        itemCount: houses.length,
        itemBuilder: (context, index) {
          final house = houses[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: HouseCard(
              house: house,
              onRemove: onRefresh,
            ),
          );
        },
      ),
    );
  }
}
