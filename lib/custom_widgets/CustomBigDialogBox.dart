import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBigDialogBox extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onSubmit;
  final Color titleBackgroundColor;
  final Color submitButtonColor;
  final String submitButtonText;

  const CustomBigDialogBox({
    Key? key,
    required this.title,
    required this.content,
    required this.onSubmit,
    this.titleBackgroundColor = Colors.blue,
    this.submitButtonColor = Colors.orange,
    this.submitButtonText = "Submit",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child:LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
             // width: double.infinity,
             // padding: EdgeInsets.zero,
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
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () => Get.back(),
                              child: Icon(Icons.close, color: Colors.grey),
                            ),
                          ],
                        ),

                        // Dynamic Content
                        content,

                        SizedBox(height: 30),
                        SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: submitButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: onSubmit,
                            child: Text(submitButtonText, style: TextStyle(color: Colors.white)),
                          ),
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
      )

    );
  }
}

