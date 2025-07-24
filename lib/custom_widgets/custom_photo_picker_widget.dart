///working code
/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'ImagePickerMixin.dart';

class CustomPhotoPickerWidget extends StatelessWidget {
  final ImagePickerMixin controller;
  final String label;
  final String imageKey;

  const CustomPhotoPickerWidget({
    super.key,
    required this.controller,
    required this.imageKey,
    required this.label,
  });

  void _showSourceSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                controller.pickImages(imageKey, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                controller.pickImages(imageKey, ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Obx(() {

      final images = controller.getImages(imageKey);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                onTap: () => _showSourceSelector(context),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: const Icon(Icons.add_a_photo, size: 30, color: Colors.blueGrey),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              images[index],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => images.removeAt(index),
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
}*/

///experiment
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ksdpl/common/helper.dart';

import 'ImagePickerMixin.dart';

class CustomPhotoPickerWidget extends StatelessWidget {
  final ImagePickerMixin controller;
  final String label;
  final String imageKey;
  final bool isCloseVisible; // <-- New flag
  final bool isUploadActive;
  final String? toastMessage;
  const CustomPhotoPickerWidget({
    super.key,
    required this.controller,
    required this.imageKey,
    required this.label,
    this.isCloseVisible = true, // default to true
    this.isUploadActive = true,
    this.toastMessage,
  });

  void _showSourceSelector(BuildContext context) {
    if (!isUploadActive) {
      if (toastMessage != null && toastMessage!.isNotEmpty) {
        Get.snackbar(
          'Upload Disabled',
          toastMessage!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
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
              onTap: () {
                Navigator.pop(context);
                controller.pickImages(imageKey, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                controller.pickImages(imageKey, ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final images = controller.getImages(imageKey);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                onTap: () => _showSourceSelector(context),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: isUploadActive==false?Colors.grey: AppColor.primaryColor),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child:  Icon(Icons.add_a_photo, size: 30, color: isUploadActive==false?Colors.grey: AppColor.primaryColor),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                   /* itemBuilder: (_, index) {
                      final image = images[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: image.isLocal
                                ? Image.file(
                              image.file!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              image.url!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          *//*Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => controller.removeImage(imageKey, image),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(Icons.close, color: Colors.white, size: 16),
                              ),
                            ),
                          ),*//*
                          Positioned(
                            top: 4,
                            right: 4,
                            child: isCloseVisible
                                ? GestureDetector(
                              onTap: () => controller.removeImage(imageKey, image),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(Icons.close, color: Colors.white, size: 16),
                              ),
                            )
                                : const SizedBox.shrink(), // don't show anything if false
                          ),
                        ],
                      );
                    },*/
                      itemBuilder: (_, index) {
                        final image = images[index];
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: image.isLocal
                                  ? Image.file(
                                image.file!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
                              )
                                  : Image.network(
                                image.url!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  );
                                },
                                errorBuilder: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
                              ),
                            ),
                            if (isCloseVisible)
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => controller.removeImage(imageKey, image),
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
                      }

                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}



