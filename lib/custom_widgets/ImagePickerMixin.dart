

// mixins/image_picker_mixin.dart
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

mixin ImagePickerMixin {
  Map<String, Rx<File?>> get imageMap;
  Future<void> pickImage(String key, ImageSource source);
  void clearImage(String key);

  Rx<File?> getImage(String key) {
    if (!imageMap.containsKey(key)) {
      imageMap[key] = Rx<File?>(null); // Initialize if not already
    }
    return imageMap[key]!;
  }
}
