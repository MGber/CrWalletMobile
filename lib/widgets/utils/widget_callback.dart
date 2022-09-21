import 'package:flutter/material.dart';

class WidgetCallback {
  static void callBackMethod(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }
}
