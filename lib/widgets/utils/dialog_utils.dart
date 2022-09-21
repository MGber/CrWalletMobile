import 'package:flutter/material.dart';

class DialogUtils {
  static Future<void> showCustomDialog(
      BuildContext context, Widget dialog) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(child: dialog);
          },
        );
      },
    );
  }
}
