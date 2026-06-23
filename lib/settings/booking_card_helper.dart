import 'package:flutter/material.dart';
import 'package:frontend/settings/constant.dart';

TextStyle textStyle(
  double size,
  FontWeight weight,
  Color color,
) {
  return TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: size,
    fontWeight: weight,
    color: color,
  );
}

String formatPrice(int price) {
  if (price >= 1000000000) {
    return '${(price / 1000000000).toStringAsFixed(1)} M';
  } else if (price >= 1000000) {
    return '${(price / 1000000).toStringAsFixed(0)} JT';
  }

  return price.toString();
}
