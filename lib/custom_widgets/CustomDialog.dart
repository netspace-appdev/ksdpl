import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:lottie/lottie.dart';

class CustomDialog {
  static void show({
    required String message,
    required IconData customIcon,
    required Color iconColor,
  required String title,
  required String okButtonText,
    VoidCallback? onOkPressed,
}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Icon(customIcon, color: iconColor, size: 60),
              Container(
                height: 100,
                width: 100,
                  child: Lottie.asset(AppImage.ok)),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColor.black54),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.back(); // Closes the dialog
                  if (onOkPressed != null) {
                    onOkPressed();
                  }
                },
                child: Text(okButtonText, style: TextStyle(color: AppColor.appWhite),),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevents dismissing by tapping outside
    );
  }
}
