// widgets/photo_picker_widget.dart
import 'dart:io';
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
                controller.pickImage(imageKey, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(imageKey, ImageSource.gallery);
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
      final File? imageFile = controller.getImage(imageKey).value;
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
              if (imageFile != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    imageFile,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ],
      );
    });
  }
}


