import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/payment_method_item.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/payment_service.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPaymentHandler {
  static Future<void> handlePayment({
    required BuildContext context,
    required WidgetRef ref,
    required Map<String, dynamic>? booking,
  }) async {
    final auth = ref.read(authProvider);
    final token = auth.token;

    if (token == null) {
      throw Exception("No token");
    }

    final bookingId = booking?['id'];

    if (bookingId == null) {
      throw Exception("Booking ID tidak ditemukan");
    }

    try {
      /// ===============================
      /// Cek payment yang sudah ada
      /// ===============================
      final existingPayment = await PaymentService.getPaymentByBooking(
        token: token,
        bookingId: bookingId,
      );

      if (existingPayment != null && existingPayment['status'] == 'PENDING') {
        final redirectUrl =
            existingPayment['redirect_url'] ?? existingPayment['redirectUrl'];

        if (redirectUrl != null && redirectUrl.toString().isNotEmpty) {
          final launched = await launchUrl(
            Uri.parse(redirectUrl),
            mode: LaunchMode.externalApplication,
          );

          if (!launched) {
            throw Exception("Gagal membuka halaman pembayaran");
          }

          return;
        }
      }

      /// ===============================
      /// Belum ada payment
      /// ===============================

      String? tempSelectedMethod;

      await showDialog(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (dialogContext, setDialogState) {
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
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Pilih Metode Pembayaran",
                        style: TextStyle(
                          fontFamily: AppFonts.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
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
                      description: "GoPay · ShopeePay",
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
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primarycolor,
                      ),
                      onPressed: () async {
                        if (tempSelectedMethod == null) {
                          ScaffoldMessenger.of(dialogContext).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Pilih metode pembayaran",
                              ),
                            ),
                          );
                          return;
                        }

                        try {
                          final result = await PaymentService.createPayment(
                            token: token,
                            bookingId: bookingId,
                            method: tempSelectedMethod!,
                          );

                          Navigator.pop(dialogContext);

                          final redirectUrl = result['redirect_url'];

                          if (redirectUrl == null ||
                              redirectUrl.toString().isEmpty) {
                            throw Exception(
                              "Redirect URL tidak tersedia",
                            );
                          }

                          final launched = await launchUrl(
                            Uri.parse(redirectUrl),
                            mode: LaunchMode.externalApplication,
                          );

                          if (!launched) {
                            throw Exception(
                              "Gagal membuka halaman pembayaran",
                            );
                          }
                        } catch (e) {
                          if (!dialogContext.mounted) return;

                          ScaffoldMessenger.of(dialogContext).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      child: const Text("Pilih"),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.secondcolor,
                      ),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      child: const Text("Batal"),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
