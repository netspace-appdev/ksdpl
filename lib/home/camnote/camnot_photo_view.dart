import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widgets/ImagePickerMixin.dart';
import 'package:ksdpl/common/helper.dart'; // for AppColor

class ApiPhotoViewer extends StatelessWidget {
  final ImagePickerMixin controller;
  final String imageKey;
  final List<String> imageUrls; // from API response
  final String label;
  final bool isCloseVisible;

  const ApiPhotoViewer({
    super.key,
    required this.controller,
    required this.imageKey,
    required this.imageUrls,
    required this.label,
    this.isCloseVisible = false, // default false (API images usually not removable)
  });

  @override
  Widget build(BuildContext context) {
    // add network images into controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (imageUrls.isNotEmpty) {
        controller.clearImages(imageKey); // avoid duplication
        controller.addNetworkImages(imageKey, imageUrls);
      }
    });

    return Obx(() {
      final images = controller.getImages(imageKey);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16)),

          const SizedBox(height: 10),

          images.isEmpty
              ? Container(
            width: double.infinity,
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("No images found",
                style: TextStyle(color: AppColor.grey2, fontSize: 12)),
          )
              : SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) {
                final img = images[index];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: img.isLocal
                          ? Image.file(img.file!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.error,
                              color: Colors.red))
                          : Image.network(
                        img.url!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            width: 120,
                            height: 120,
                            alignment: Alignment.center,
                            color: Colors.grey[200],
                            child: const CircularProgressIndicator(
                                strokeWidth: 2),
                          );
                        },
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image,
                            color: Colors.red),
                      ),
                    ),
                    if (isCloseVisible)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(imageKey, img),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(Icons.close,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
