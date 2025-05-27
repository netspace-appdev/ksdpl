

// mixins/image_picker_mixin.dart
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



///new code

mixin ImagePickerMixin {
  Map<String, RxList<File>> get imageMap;

  Future<void> pickImages(String key, ImageSource source) async {
    final picker = ImagePicker();

    if (!imageMap.containsKey(key)) {
      imageMap[key] = <File>[].obs;
    }

    if (source == ImageSource.camera) {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageMap[key]!.add(File(pickedFile.path));
      }
    } else {
      final pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        imageMap[key]!.addAll(pickedFiles.map((e) => File(e.path)));
      }
    }
  }

  void removeImage(String key, File imageFile) {
    imageMap[key]?.remove(imageFile);
  }

  void clearImages(String key) {
    imageMap[key]?.clear();
  }

  RxList<File> getImages(String key) {
    if (!imageMap.containsKey(key)) {
      imageMap[key] = <File>[].obs;
    }
    return imageMap[key]!;
  }
}
