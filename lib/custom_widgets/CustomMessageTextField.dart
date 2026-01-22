import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/helper.dart';

class CustomMessageTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendTap;
  final VoidCallback onImageTap;
  final String hintText;
  final bool hasAttachment; // ✅ NEW


  const CustomMessageTextField({
    super.key,
    required this.controller,
    required this.onSendTap,
    required this.onImageTap,
    required this.hasAttachment,

    this.hintText = AppText.issueDetailDes,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final bool isSendEnabled =
            value.text.trim().isNotEmpty || hasAttachment;


        return TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: 5,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.primaryColor,
                width: 1.5,
              ),
            ),

            suffixIconConstraints: const BoxConstraints(
              minWidth: 96,
              maxWidth: 96,
            ),

            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// 📷 IMAGE PICKER
                  InkWell(
                    onTap: onImageTap,
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.image_outlined,
                        color: AppColor.primaryColor,
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  /// 🚀 SEND BUTTON (AUTO DISABLE)
                  InkWell(
                    onTap: isSendEnabled ? onSendTap : null,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: isSendEnabled
                            ? AppColor.primaryColor
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
