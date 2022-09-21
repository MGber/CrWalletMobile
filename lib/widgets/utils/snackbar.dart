import 'package:flutter/material.dart';

class SnackBarUtil {
  static void showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
        duration: const Duration(milliseconds: 500),
        content: Text(
          message,
          style: TextStyle(color: color),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
