import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcademicFormController extends GetxController {
  // Dropdown selection
  var selectedEducationType = Rxn<String>();

  // Text controllers
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController institutionNameController = TextEditingController();
  final TextEditingController universityNameController = TextEditingController();
  final TextEditingController yearOfPassingController = TextEditingController();
  final TextEditingController gradeOrPercentageController = TextEditingController();

  // File upload
  var selectedFileName = ''.obs; // To store file name
  var selectedFilePath = ''.obs; // To store file path

  // Dispose controllers to avoid memory leaks
  @override
  void onClose() {
    qualificationController.dispose();
    specializationController.dispose();
    institutionNameController.dispose();
    universityNameController.dispose();
    yearOfPassingController.dispose();
    gradeOrPercentageController.dispose();
    super.onClose();
  }
}
