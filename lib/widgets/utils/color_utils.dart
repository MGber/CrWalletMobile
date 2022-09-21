import 'dart:ui';

import 'package:flutter/material.dart';

class ColorUtils {
  static Color getPercentageColor(String stringValue) {
    if (double.parse(stringValue) < 0) return Colors.red;
    return Colors.green;
  }
}
