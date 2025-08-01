import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../common/helper.dart';
import 'DocumentCamImage.dart';
import 'SnackBarHelper.dart';

class CustomDocumentPhotoPickerWidget extends StatelessWidget {
  final RxList<DocumentCamImage> imageList;
  final String label;
  final bool isCloseVisible;
  final bool isUploadActive;
  final String toastMessage;

  const CustomDocumentPhotoPickerWidget({
    super.key,
    required this.imageList,
    required this.label,
    required this.isCloseVisible,
    required this.isUploadActive,
    required this.toastMessage,
  });

  void _pickImage(BuildContext context) async {
    if (!isUploadActive) {
      SnackbarHelper.showSnackbar(title: "Upload Disabled", message: toastMessage);
      return;
    }

    final image = await HelperClass.pickImage(); // You implement this
    if (image != null) {
      imageList.add(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                onTap: () => _showSourceSelector(context),
                    //_pickImage(context),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: isUploadActive ? Colors.blue : Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: isUploadActive ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageList.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, index) {
                      final image = imageList[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              image.file!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                          if (isCloseVisible)
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => imageList.removeAt(index),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  void _showSourceSelector(BuildContext context) {
    if (!isUploadActive) {
      SnackbarHelper.showSnackbar(title: "Upload Disabled", message: toastMessage);
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                final image = await HelperClass.pickImageFromCamera();
                if (image != null) {
                  imageList.add(image);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final image = await HelperClass.pickImageFromGallery();
                if (image != null) {
                  imageList.add(image);
                }
              },
            ),
          ],
        );
      },
    );
  }



}
