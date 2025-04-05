/*@override
Widget build(BuildContext context) {
  return Dialog(
    insetPadding: EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top color bar
                  Container(
                    width: double.infinity,
                    height: 5,
                    decoration: BoxDecoration(
                      color: titleBackgroundColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                    ),
                  ),

                  // Actual Dialog Body
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
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
                        SizedBox(height: 15),

                        /// 👇 YOUR Custom Content Here
                        Flexible(child: content),

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
    ),
  );
}*/
