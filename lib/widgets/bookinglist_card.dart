import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/payment_method_item.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/payment_service.dart';
import 'package:frontend/settings/booking_card_helper.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/widgets/payment_dialog.dart';
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
                      const SizedBox(height: 4),
                      if (widget.status != "CONFIRMED")
                        InkWell(
                          onTap: _handlePayment,
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

  Future<void> _handlePayment() async {
    final auth = ref.read(authProvider);
    final token = auth.token;

    if (token == null) throw Exception("No token");

    final bookingId = widget.booking?['id'];

    if (bookingId == null) {
      throw Exception("Booking ID not found");
    }

    try {
      final existingPayment = await PaymentService.getPaymentByBooking(
        token: token,
        bookingId: bookingId,
      );

      if (existingPayment != null) {
        // ignore: use_build_context_synchronously
        showPaymentDialog(context, existingPayment, token);
        return;
      }

      String? tempSelectedMethod = selectedMethod;

      final method = await showDialog<String>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                backgroundColor: AppColors.background,
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primarycolor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Icon(
                        LucideIcons.shieldCheck,
                        size: 24,
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Pilih Metode Pembayaran",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          fontFamily: AppFonts.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PaymentMethodItem(
                      title: "Bank Transfer",
                      description: "BSI · BRI · BCA",
                      value: "BANK_TRANSFER",
                      icon: LucideIcons.landmark,
                      selectedValue: tempSelectedMethod,
                      onSelected: (value) {
                        setDialogState(() {
                          tempSelectedMethod = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    PaymentMethodItem(
                      title: "E-Wallet",
                      description: "DANA · OVO · GoPay",
                      value: "E_WALLET",
                      icon: LucideIcons.smartphone,
                      selectedValue: tempSelectedMethod,
                      onSelected: (value) {
                        setDialogState(() {
                          tempSelectedMethod = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    PaymentMethodItem(
                      title: "Credit Card",
                      description: "Visa · MasterCard",
                      value: "CREDIT_CARD",
                      icon: LucideIcons.creditCard,
                      selectedValue: tempSelectedMethod,
                      onSelected: (value) {
                        setDialogState(() {
                          tempSelectedMethod = value;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: AppColors.primarycolor,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(
                              context,
                              tempSelectedMethod,
                            );
                          },
                          child: const Text("Pilih",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: AppFonts.primary,
                                  color: AppColors.background,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: AppColors.secondcolor,
                        ),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Text("Batal",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: AppFonts.primary,
                                  color: AppColors.background,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          );
        },
      );

      if (method == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pilih metode pembayaran terlebih dahulu"),
          ),
        );
        return;
      }

      final payment = await PaymentService.createPayment(
        token: token,
        bookingId: bookingId,
        method: method,
      );

      if (!mounted) return;

      showPaymentDialog(context, payment!, token);
    } catch (e) {
      debugPrint("PAYMENT ERROR: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal payment: $e")),
      );
    }
  }
}
