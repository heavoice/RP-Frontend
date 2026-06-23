import 'package:flutter/material.dart';
import 'package:frontend/widgets/selected_house_card.dart';

class SelectedHouseSlider extends StatelessWidget {
  final List<dynamic> favorites;
  final VoidCallback? onRefresh;

  const SelectedHouseSlider({
    super.key,
    required this.favorites,
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
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final house = favorites[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SelectedHouseCard(
              favoriteHouse: house,
              onRemove: onRefresh,
            ),
          );
        },
      ),
    );
  }
}
