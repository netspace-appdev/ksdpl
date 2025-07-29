import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerItem {
  final File file;
  final String name;

  FilePickerItem({required this.file, required this.name});
}

class FilePickerController extends GetxController {
  final RxMap<String, RxList<FilePickerItem>> fileMap = <String, RxList<FilePickerItem>>{}.obs;

  void pickFiles(String key) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      fileMap.putIfAbsent(key, () => <FilePickerItem>[].obs);
      for (var file in result.files) {
        fileMap[key]!.add(FilePickerItem(file: File(file.path!), name: file.name));
      }
    }
  }

  List<FilePickerItem> getFiles(String key) => fileMap[key]?.toList() ?? [];

  void removeFile(String key, FilePickerItem file) {
    fileMap[key]?.remove(file);
  }




}
