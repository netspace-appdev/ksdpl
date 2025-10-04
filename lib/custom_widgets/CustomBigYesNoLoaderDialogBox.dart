import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class CustomBigYesNoLoaderDialogBox extends StatelessWidget {
  final String title;
  final Widget content;

  // ✅ These are updated:
  final String? firstButtonText;
  final Widget? firstButtonChild; // 👈 New optional widget for loading state
  final String secondButtonText;

  final VoidCallback onFirstButtonPressed;
  final VoidCallback onSecondButtonPressed;

  final Color titleBackgroundColor;
  final Color firstButtonColor;
  final Color secondButtonColor;

  const CustomBigYesNoLoaderDialogBox({
    Key? key,
    required this.title,
    required this.content,
    this.firstButtonText, // 👈 now optional
    this.firstButtonChild, // 👈 new param
    required this.secondButtonText,
    required this.onFirstButtonPressed,
    required this.onSecondButtonPressed,
    this.titleBackgroundColor = Colors.blue,
    this.firstButtonColor = Colors.green,
    this.secondButtonColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              content,
              const SizedBox(height: 30),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: firstButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onFirstButtonPressed,
                      // 👇 if child is provided, show it; else show text
                      child: firstButtonChild ??
                          Text(
                            firstButtonText ?? "",
                            style: const TextStyle(color: Colors.white),
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onSecondButtonPressed,
                      child: Text(
                        secondButtonText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

