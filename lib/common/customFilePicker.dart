import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/FilePickerController.dart';
import 'helper.dart';

class CustomFilePickerWidget extends StatelessWidget {
  final FilePickerController controller;
  final String label;
  final String fileKey;
  final bool isCloseVisible;
  final bool isUploadActive;
  final String? toastMessage;
  final String? Function(String?)? validator; // ✅ Add validator

  const CustomFilePickerWidget({
    super.key,
    required this.controller,
    required this.fileKey,
    required this.label,
    this.isCloseVisible = true,
    this.isUploadActive = true,
    this.toastMessage,
    this.validator,
  });

  void _pickFile(BuildContext context, FormFieldState<String> state) {
    if (!isUploadActive) {
      if (toastMessage != null && toastMessage!.isNotEmpty) {
        Get.snackbar(
          'Upload Disabled',
          toastMessage!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return;
    }

    controller.pickFiles(fileKey);
    state.didChange("file_picked"); // Notify the form field
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (state) {
        return Obx(() {
          final files = controller.getFiles(fileKey);
          final fileName = files.isNotEmpty ? files.first.name : 'No file chosen';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                    fontSize: 14,
                  ),
                  children: const [
                    TextSpan(
                      text: '',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickFile(context, state),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.grey2),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.grey3,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.blue.shade900),
                          ),
                        ),
                        child: const Text(
                          "Choose Files",
                          style: TextStyle(
                            color: AppColor.grey2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          fileName,
                          style: const TextStyle(color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        });
      },
    );
  }
}
