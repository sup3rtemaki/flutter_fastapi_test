import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService{
  static success(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: ThemeColors.success,
      textColor: Colors.white,
    );
  }

  static error(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: ThemeColors.danger,
      textColor: Colors.white,
    );
  }
}