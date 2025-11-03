
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBigLoaderThreeButtonDialogBox extends StatelessWidget {
  final String title;
  final Widget content;

  // ✅ Button 1
  final String? firstButtonText;
  final Widget? firstButtonChild;
  final VoidCallback onFirstButtonPressed;
  final Color firstButtonColor;

  // ✅ Button 2
  final String? secondButtonText;
  final Widget? secondButtonChild;
  final VoidCallback onSecondButtonPressed;
  final Color secondButtonColor;

  // ✅ Button 3 (Cancel)
  final String thirdButtonText;
  final VoidCallback onThirdButtonPressed;
  final Color thirdButtonColor;

  // Title bar color
  final Color titleBackgroundColor;

  const CustomBigLoaderThreeButtonDialogBox({
    Key? key,
    required this.title,
    required this.content,

    // First button
    this.firstButtonText,
    this.firstButtonChild,
    required this.onFirstButtonPressed,
    this.firstButtonColor = Colors.green,

    // Second button
    this.secondButtonText,
    this.secondButtonChild,
    required this.onSecondButtonPressed,
    this.secondButtonColor = Colors.blue,

    // Third button (Cancel)
    this.thirdButtonText = "Cancel",
    required this.onThirdButtonPressed,
    this.thirdButtonColor = Colors.red,

    // Title
    this.titleBackgroundColor = Colors.blueAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Title bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: titleBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header row
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

                  // Content
                  content,
                  const SizedBox(height: 30),

                  // First two buttons (side by side)
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
                          child: secondButtonChild ??
                              Text(
                                secondButtonText ?? "",
                                style: const TextStyle(color: Colors.white),
                              ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Third button (Cancel - full width)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: thirdButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onThirdButtonPressed,
                      child: Text(
                        thirdButtonText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
