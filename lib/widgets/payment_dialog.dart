import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/detail_row.dart';
import 'package:frontend/services/payment_service.dart';
import 'package:frontend/settings/constant.dart';
import 'package:frontend/settings/payment_method_helper.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void showPaymentDialog(
    BuildContext context, Map<String, dynamic> payment, String token) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.background,
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 32,
          ),
          decoration: const BoxDecoration(
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Pembayaran",
                style: TextStyle(
                  fontFamily: AppFonts.primary,
                  fontWeight: FontWeight.w400,
                  color: AppColors.background,
                  fontSize: 9,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(payment['amount']),
                style: const TextStyle(
                  fontFamily: AppFonts.primary,
                  fontWeight: FontWeight.w800,
                  color: AppColors.background,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.withValues(alpha: 0.12),
                      ),
                      child: const Icon(
                        LucideIcons.clock4,
                        size: 12,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Status Transaksi",
                          style: TextStyle(
                            fontFamily: AppFonts.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 9,
                          ),
                        ),
                        Text(
                          payment['status'],
                          style: const TextStyle(
                            fontFamily: AppFonts.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    DetailRow(
                      icon: LucideIcons.hash,
                      label: "ID Transaksi",
                      value: payment['transactionId'],
                      isCopyable: true,
                      onCopy: () {
                        Clipboard.setData(
                          ClipboardData(text: payment['transactionId']),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("ID berhasil disalin"),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    DetailRow(
                      icon: LucideIcons.creditCard,
                      label: "Metode Pembayaran",
                      value: formatPaymentMethod(payment['method']),
                    ),
                    const Divider(height: 1),
                    DetailRow(
                      icon: LucideIcons.calendar,
                      label: "Tanggal Booking",
                      value: payment['createdAt'] != null
                          ? DateFormat(
                              'dd MMM yyyy',
                              'id_ID',
                            ).format(
                              DateTime.parse(payment['createdAt']).toLocal())
                          : "-",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
        actions: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: AppColors.primarycolor,
            ),
            child: InkWell(
              onTap: () async {
                try {
                  final paymentId = payment['id'];

                  if (paymentId == null) {
                    throw Exception("Payment ID not found");
                  }

                  final result = await PaymentService.payPayment(
                    token: token,
                    paymentId: paymentId,
                  );

                  if (!context.mounted) return;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result['message'] ?? "Payment success",
                      ),
                    ),
                  );
                } catch (e) {
                  debugPrint("PAY ERROR: $e");

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Gagal bayar: $e"),
                    ),
                  );
                }
              },
              child: const Text("Bayar",
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
              child: const Text("Tutup",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppFonts.primary,
                      color: AppColors.background,
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
            ),
          ),
        ],
      );
    },
  );
}
