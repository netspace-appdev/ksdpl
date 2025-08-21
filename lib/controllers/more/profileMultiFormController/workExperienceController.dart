import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/controllers/more/ProfileController.dart';

import '../../addDocumentControler/addDocumentModel/addDocumentModel.dart';

class WorkExperienceController extends GetxController{
  // Dropdown selection
  final companyNameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final departmentController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final employmentTypeController = TextEditingController();
  final companyAddressController = TextEditingController();
  final reasonForLeavingController = TextEditingController();
  final lastDrawnSalaryController = TextEditingController();
  final responsibilitiesController = TextEditingController();

  // File upload
  var selectedFileName = ''.obs; // To store file name
  var selectedFilePath = ''.obs; // To store file path

  // Dispose controllers to avoid memory leaks
  void dispose() {
    companyNameController.dispose();
    jobTitleController.dispose();
    departmentController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    employmentTypeController.dispose();
    companyAddressController.dispose();
    reasonForLeavingController.dispose();
    lastDrawnSalaryController.dispose();
    responsibilitiesController.dispose();
  }
}
