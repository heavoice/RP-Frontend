import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BookingListCard extends StatefulWidget {
  final Map<String, dynamic> house;
  final VoidCallback? onRemove;
  final String? status;

  const BookingListCard({
    super.key,
    required this.house,
    this.onRemove,
    this.status,
  });

  @override
  State<BookingListCard> createState() => _BookingListCardState();
}

class _BookingListCardState extends State<BookingListCard> {
  bool isHover = false;
  bool isFavorite = true;

  TextStyle textStyle(double size, FontWeight weight, Color color) => TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  String formatPrice(int price) {
    if (price >= 1000000000) {
      return '${(price / 1000000000).toStringAsFixed(1)} M';
    } else if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(0)} JT';
    }
    return price.toString();
  }

  @override
  Widget build(BuildContext context) {
    /// 🔥 SAFE ACCESS (booking -> house)
    final house = widget.house;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(32),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE + OVERLAY (TIDAK DIUBAH)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/img/first_section.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),

                        /// LOCATION TAG
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondcolor,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  LucideIcons.mapPin,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  house['location'] ?? '-',
                                  style: textStyle(
                                    9,
                                    FontWeight.w400,
                                    Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 🔥 STATUS BADGE (kanan atas)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: (widget.status ?? "").toUpperCase() ==
                                      "CONFIRMED"
                                  ? Colors.green
                                  : Colors.orange,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              (widget.status ?? "").toUpperCase(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: AppFonts.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// CONTENT (TIDAK DIUBAH STRUKTURNYA)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${house['title'] ?? '-'}',
                        overflow: TextOverflow.ellipsis,
                        style: textStyle(
                          18,
                          FontWeight.w600,
                          Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),

                      /// PRICE
                      Row(
                        children: [
                          const Icon(
                            LucideIcons.wallet,
                            size: 14,
                            color: AppColors.secondwidgetborder,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            formatPrice(house['price'] ?? 0),
                            style: textStyle(
                              11,
                              FontWeight.w400,
                              AppColors.secondwidgetborder,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// DETAILS (UNCHANGED)
                      Row(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(LucideIcons.bedDouble,
                                  size: 14,
                                  color: AppColors.secondwidgetborder),
                              const SizedBox(width: 4),
                              Text(
                                '${house['bedrooms'] ?? 0}',
                                style: textStyle(
                                  11,
                                  FontWeight.w400,
                                  AppColors.secondwidgetborder,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Container(
                            width: 1,
                            height: 13,
                            color: AppColors.secondwidgetborder,
                          ),
                          const SizedBox(width: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(LucideIcons.bath,
                                  size: 14,
                                  color: AppColors.secondwidgetborder),
                              const SizedBox(width: 4),
                              Text(
                                '${house['bathrooms'] ?? 0}',
                                style: textStyle(
                                  11,
                                  FontWeight.w400,
                                  AppColors.secondwidgetborder,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Container(
                            width: 1,
                            height: 13,
                            color: AppColors.secondwidgetborder,
                          ),
                          const SizedBox(width: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(LucideIcons.ruler,
                                  size: 14,
                                  color: AppColors.secondwidgetborder),
                              const SizedBox(width: 4),
                              Text(
                                '${house['landSize'] ?? '-'} m²',
                                style: textStyle(
                                  11,
                                  FontWeight.w400,
                                  AppColors.secondwidgetborder,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// BUTTONS (TETAP)
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: AppColors.secondcolor),
                          child: const Center(
                            child: Text(
                              'Lihat Transaksi',
                              style: TextStyle(
                                fontFamily: AppFonts.primary,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 4),

                      if (widget.status != "CONFIRMED")
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: AppColors.primarycolor),
                            child: const Center(
                              child: Text(
                                'Bayar',
                                style: TextStyle(
                                  fontFamily: AppFonts.primary,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
