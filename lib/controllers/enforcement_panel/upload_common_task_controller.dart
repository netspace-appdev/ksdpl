import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../custom_widgets/SnackBarHelper.dart';

class UploadCommonTaskController extends GetxController{
  Rx<File?> selectedFile = Rx<File?>(null);
  final selectedFileName = ''.obs;


  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null && result.files.single.path != null) {

      selectedFile.value= File(result.files.single.path!);
      selectedFileName.value = result.files.single.name;


    } else {

      ToastMessage.msg(AppText.noFileSelected);


    }
  }
  void clearFile() {
    selectedFile.value= null;
  }
// Function to read the Excel file
/*  void _readExcelFile() {
    // Read file bytes
    var bytes = selectedFile.value!.readAsBytesSync();
    // Decode the Excel file
    var excel = Excel.decodeBytes(bytes);

    // Use the first sheet in the file (you can modify this as needed)
    if (excel.tables.isNotEmpty) {
      String firstSheet = excel.tables.keys.first;
      rows = excel.tables[firstSheet]?.rows ?? [];
    }

    setState(() {});
  }*/
}