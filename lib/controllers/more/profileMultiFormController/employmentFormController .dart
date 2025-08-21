import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/controllers/more/ProfileController.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/workExperienceController.dart';

import '../../addDocumentControler/addDocumentModel/addDocumentModel.dart';

class EmploymentFormController  extends GetxController{
  ProfileController profileApplicationController=Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
      profileApplicationController.employmentFormList.add(WorkExperienceController());

  }

}