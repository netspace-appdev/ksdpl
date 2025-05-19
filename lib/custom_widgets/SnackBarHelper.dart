import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/common/helper.dart';

class SnackbarHelper {
  static void showSnackbar({
    required String title,
    required String message,
    Color backgroundColor = AppColor.appWhite,
    Color textColor = AppColor.primaryColor,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: position,
      duration: duration,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      boxShadows: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    );
  }
}
