import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/booking_service.dart';
import 'package:frontend/settings/booking_card_helper.dart';
import 'package:frontend/settings/booking_status_helper.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/booking_payment_handler.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BookingListCard extends ConsumerStatefulWidget {
  final Map<String, dynamic> house;
  final Map<String, dynamic>? booking;
  final VoidCallback? onRemove;
  final String? status;

  const BookingListCard({
    super.key,
    required this.house,
    this.booking,
    this.onRemove,
    this.status,
  });

  @override
  ConsumerState<BookingListCard> createState() => _BookingListCardState();
}

class _BookingListCardState extends ConsumerState<BookingListCard> {
  bool isHover = false;
  bool isFavorite = true;
  String? selectedMethod;
  Timer? _timer;

  String getCountdown(String? expiresAt) {
    if (expiresAt == null) return "-";

    final expireTime = DateTime.parse(expiresAt).toLocal();
    final remaining = expireTime.difference(DateTime.now());

    if (remaining.isNegative) {
      return "Expired";
    }

    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final house = widget.house;
    final booking = widget.booking;
    final status = BookingStatusHelper.getEffectiveStatus(
      booking?['status'],
      booking?['expiresAt'],
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(32),
            clipBehavior: Clip.antiAlias,
            color: AppColors.background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  color: AppColors.background,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  house['location'] ?? '-',
                                  style: textStyle(
                                    9,
                                    FontWeight.w400,
                                    AppColors.background,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: status == "CONFIRMED"
                                  ? Colors.green
                                  : status == "CANCELLED"
                                      ? Colors.red
                                      : status == "EXPIRED"
                                          ? AppColors.secondwidgetborder
                                          : Colors.orange,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.background,
                                fontFamily: AppFonts.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(
                            BookingStatusHelper.getIcon(
                              booking?['status'],
                              booking?['expiresAt'],
                            ),
                            size: 14,
                            color: BookingStatusHelper.getColor(
                              booking?['status'],
                              booking?['expiresAt'],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            BookingStatusHelper.getText(
                              booking?['status'],
                              getCountdown,
                              booking?['expiresAt'],
                            ),
                            style: textStyle(
                              11,
                              FontWeight.w400,
                              BookingStatusHelper.getColor(
                                booking?['status'],
                                booking?['expiresAt'],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
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
                      Row(
                        children: [
                          _detailItem(
                            LucideIcons.bedDouble,
                            '${house['bedrooms'] ?? 0}',
                          ),
                          const SizedBox(width: 16),
                          Container(
                            width: 1,
                            height: 13,
                            color: AppColors.secondwidgetborder,
                          ),
                          const SizedBox(width: 16),
                          _detailItem(
                            LucideIcons.bath,
                            '${house['bathrooms'] ?? 0}',
                          ),
                          const SizedBox(width: 16),
                          Container(
                            width: 1,
                            height: 13,
                            color: AppColors.secondwidgetborder,
                          ),
                          const SizedBox(width: 16),
                          _detailItem(
                            LucideIcons.ruler,
                            '${house['landSize'] ?? '-'} m²',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (status == "CONFIRMED") ...[
                        InkWell(
                          onTap: () {
                            // TODO: Lihat transaksi
                          },
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
                                'Lihat Transaksi',
                                style: TextStyle(
                                  fontFamily: AppFonts.primary,
                                  fontSize: 12,
                                  color: AppColors.background,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ] else if (status != "CANCELLED" &&
                          status != "EXPIRED") ...[
                        InkWell(
                          onTap: () async {
                            final auth = ref.read(authProvider);
                            final token = auth.token;

                            if (token == null) throw Exception("No token");

                            try {
                              await BookingService.cancelBooking(
                                token: token,
                                bookingId: booking!['id'],
                              );

                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Booking berhasil dibatalkan"),
                                ),
                              );

                              setState(() {
                                booking['status'] = "CANCELLED";
                              });
                            } catch (e) {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
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
                              color: AppColors.secondcolor,
                            ),
                            child: const Center(
                              child: Text(
                                'Batalkan',
                                style: TextStyle(
                                  fontFamily: AppFonts.primary,
                                  fontSize: 12,
                                  color: AppColors.background,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        InkWell(
                          onTap: () => BookingPaymentHandler.handlePayment(
                            context: context,
                            ref: ref,
                            booking: booking!,
                          ),
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
                                'Bayar',
                                style: TextStyle(
                                  fontFamily: AppFonts.primary,
                                  fontSize: 12,
                                  color: AppColors.background,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _detailItem(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.secondwidgetborder,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: textStyle(
            11,
            FontWeight.w400,
            AppColors.secondwidgetborder,
          ),
        ),
      ],
    );
  }
}
