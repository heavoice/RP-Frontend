import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BookingStatusHelper {
  static String getEffectiveStatus(
    String? status,
    String? expiresAt,
  ) {
    final currentStatus = (status ?? "").toUpperCase();

    // status final tidak boleh diubah
    if (currentStatus == "CONFIRMED" ||
        currentStatus == "CANCELLED" ||
        currentStatus == "EXPIRED") {
      return currentStatus;
    }

    if (expiresAt != null) {
      final expireTime = DateTime.parse(expiresAt).toLocal();

      if (DateTime.now().isAfter(expireTime)) {
        return "EXPIRED";
      }
    }

    return currentStatus;
  }

  static Color getColor(
    String? status,
    String? expiresAt,
  ) {
    switch (getEffectiveStatus(status, expiresAt)) {
      case 'CONFIRMED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      case 'EXPIRED':
        return AppColors.secondwidgetborder;
      default:
        return Colors.orange;
    }
  }

  static IconData getIcon(
    String? status,
    String? expiresAt,
  ) {
    switch (getEffectiveStatus(status, expiresAt)) {
      case 'CONFIRMED':
        return LucideIcons.circleCheckBig;
      case 'CANCELLED':
        return LucideIcons.circleX;
      case 'EXPIRED':
        return LucideIcons.circleAlert;
      default:
        return LucideIcons.clock4;
    }
  }

  static String getText(
    String? status,
    String Function(String?) getCountdown,
    String? expiresAt,
  ) {
    switch (getEffectiveStatus(status, expiresAt)) {
      case 'CONFIRMED':
        return "Sudah dibayar";
      case 'CANCELLED':
        return "Booking dibatalkan";
      case 'EXPIRED':
        return "Booking telah kedaluwarsa";
      default:
        return "Harus dibayar sebelum: ${getCountdown(expiresAt)}";
    }
  }
}
