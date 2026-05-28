import 'package:flutter/material.dart';
import 'package:frontend/services/favorite_service.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/booking_service.dart';

class HouseCard extends ConsumerStatefulWidget {
  final Map<String, dynamic> house;
  final VoidCallback? onRemove;

  const HouseCard({
    super.key,
    required this.house,
    this.onRemove,
  });

  @override
  ConsumerState<HouseCard> createState() => _HouseCardState();
}

class _HouseCardState extends ConsumerState<HouseCard> {
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
                /// IMAGE + OVERLAY
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

                        /// FAVORITE ICON
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Material(
                            elevation: 4,
                            color: Colors.white,
                            shape: const CircleBorder(),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(999),
                              onTap: () async {
                                try {
                                  await FavoriteService.addFavorite(
                                    widget.house['id'],
                                  );

                                  setState(() {
                                    isFavorite = true;
                                  });

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Berhasil ditambahkan ke favorit',
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  debugPrint("FAVORITE ERROR: $e");

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Gagal: $e'),
                                    ),
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  size: 16,
                                  color: AppColors.secondcolor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// CONTENT
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

                      /// DETAILS
                      Row(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LucideIcons.bedDouble,
                                size: 14,
                                color: AppColors.secondwidgetborder,
                              ),
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
                              const Icon(
                                LucideIcons.bath,
                                size: 14,
                                color: AppColors.secondwidgetborder,
                              ),
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
                              const Icon(
                                LucideIcons.ruler,
                                size: 14,
                                color: AppColors.secondwidgetborder,
                              ),
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

                      /// BUTTON DETAIL
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: AppColors.secondcolor,
                          ),
                          child: const Center(
                            child: Text(
                              'Buka Selengkapnya',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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

                      /// BUTTON BOOKING
                      InkWell(
                        onTap: () async {
                          String notes = "";

                          final result = await showDialog<String>(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setModalState) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.background,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    title: const Text(
                                      'Tambah Catatan',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: AppFonts.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    content: TextField(
                                      cursorColor: AppColors.secondwidgetborder,
                                      maxLines: 3,
                                      onChanged: (value) {
                                        notes = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                            'Contoh: tolong proses cepat...',
                                        hintStyle: const TextStyle(
                                          fontFamily: AppFonts.primary,
                                          fontSize: 12,
                                          color: AppColors.secondwidgetborder,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.secondwidgetborder,
                                          ),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: AppFonts.primary,
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Batal',
                                          style: TextStyle(
                                            fontFamily: AppFonts.primary,
                                            fontSize: 12,
                                            color: AppColors.secondcolor,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primarycolor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(999),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                            notes,
                                          );
                                        },
                                        child: const Text(
                                          'Booking',
                                          style: TextStyle(
                                            fontFamily: AppFonts.primary,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );

                          /// USER CANCEL
                          if (result == null) return;

                          try {
                            final auth = ref.read(authProvider);
                            final token = auth.token ?? "";

                            await BookingService.createBooking(
                              token: token,
                              houseId: widget.house['id'],
                              notes: result,
                            );

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Booking berhasil dibuat",
                                ),
                              ),
                            );
                          } catch (e) {
                            if (!mounted) return;

                            final error = e.toString();

                            if (error.contains("House already booked")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Rumah sudah dibooking",
                                  ),
                                ),
                              );

                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Gagal booking: $e",
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: AppColors.primarycolor,
                          ),
                          child: const Center(
                            child: Text(
                              'Book Rumah Ini',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppFonts.primary,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
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
