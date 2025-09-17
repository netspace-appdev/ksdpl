import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBigYesNoDialogBox extends StatelessWidget {
  final String title;
  final Widget content;

  // Two buttons instead of one
  final String firstButtonText;
  final String secondButtonText;
  final VoidCallback onFirstButtonPressed;
  final VoidCallback onSecondButtonPressed;

  final Color titleBackgroundColor;
  final Color firstButtonColor;
  final Color secondButtonColor;

  const CustomBigYesNoDialogBox({
    Key? key,
    required this.title,
    required this.content,
    required this.firstButtonText,
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
      insetPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Bar
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: titleBackgroundColor,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.back(),
                                child: Icon(Icons.close, color: Colors.grey),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // Dynamic Content
                          content,

                          const SizedBox(height: 30),

                          // Two Buttons
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
                                  child: Text(
                                    firstButtonText,
                                    style: TextStyle(color: Colors.white),
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
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
