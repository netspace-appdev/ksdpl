import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_widgets/CustomBigYesNDilogBox.dart';
import '../custom_widgets/CustomImageWidget.dart';
import 'helper.dart';


class DialogHelper {
  static void showPickUpConditionDialog({
    required BuildContext context,
    required String leadId,
    required String imageURL,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigYesNoDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Scan the QR Code",
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageWidget(
                  imageUrl: imageURL,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(height: 12),
                 RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                    children: [
                      TextSpan(
                        text: "Please Scan the QR Code to continue",
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          firstButtonText: "Yes",
          onFirstButtonPressed: () {
            // TODO: handle Yes action
            Get.back();
          },
          secondButtonText: "No",
          onSecondButtonPressed: () {
            Get.back();
          },
          firstButtonColor: AppColor.primaryColor,
          secondButtonColor: AppColor.redColor,
        );
      },
    );
  }
}
