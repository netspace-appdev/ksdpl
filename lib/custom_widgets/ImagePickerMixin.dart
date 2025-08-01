

// mixins/image_picker_mixin.dart
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import 'CamImage.dart';


///experiment
mixin ImagePickerMixin {
  Map<String, RxList<CamImage>> get imageMap;

  Future<void> pickImages(String key, ImageSource source) async {
    final picker = ImagePicker();
    imageMap[key] ??= <CamImage>[].obs;

    if (source == ImageSource.camera) {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageMap[key]!.add(CamImage.file(File(pickedFile.path)));
      }
    } else {
      final pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        imageMap[key]!.addAll(
          pickedFiles.map((e) => CamImage.file(File(e.path))),
        );
      }
    }
  }

  void addNetworkImages(String key, List<String> urls) {
    imageMap[key] ??= <CamImage>[].obs;
    imageMap[key]!.addAll(urls.map((url) => CamImage.network(url)));
  }

  void removeImage(String key, CamImage image) {
    imageMap[key]?.remove(image);
  }

  void clearImages(String key) {
    imageMap[key]?.clear();
  }

  RxList<CamImage> getImages(String key) {
    imageMap[key] ??= <CamImage>[].obs;
    return imageMap[key]!;
  }
}


