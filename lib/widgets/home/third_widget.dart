import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/services/favorite_service.dart';
import 'package:frontend/storage/token_storage.dart';
import 'package:frontend/widgets/selectedhouse_slider.dart';

class ThirdWidget extends StatefulWidget {
  const ThirdWidget({super.key});

  @override
  State<ThirdWidget> createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends State<ThirdWidget> {
  Future<List<dynamic>>? favoritesFuture;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final userId = await TokenStorage.getUserId();

    setState(() {
      favoritesFuture = FavoriteService.getFavorites(userId);
    });
  }

  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth < 480 ? 300 : 400,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Favorite Kamu",
                  style: textStyle(
                    18,
                    FontWeight.w600,
                    Colors.black,
                  ),
                ),
                Text(
                  "Lihat semua",
                  style: textStyle(
                    12,
                    FontWeight.w300,
                    AppColors.primarycolor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// CONTENT
            favoritesFuture == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondcolor,
                    ),
                  )
                : FutureBuilder<List<dynamic>>(
                    future: favoritesFuture!,
                    builder: (context, snapshot) {
                      /// LOADING
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.secondcolor,
                          ),
                        );
                      }

                      /// ERROR
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Gagal load favorites",
                            style: textStyle(
                              12,
                              FontWeight.w300,
                              Colors.red,
                            ),
                          ),
                        );
                      }

                      /// DATA
                      final favorites = snapshot.data ?? [];

                      /// EMPTY
                      if (favorites.isEmpty) {
                        return Center(
                          child: Text(
                            "Belum ada favorite",
                            style: textStyle(
                              12,
                              FontWeight.w300,
                              Colors.black,
                            ),
                          ),
                        );
                      }

                      /// SUCCESS
                      return SelectedHouseSlider(
                        favorites: favorites,
                        onRefresh: loadFavorites,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
