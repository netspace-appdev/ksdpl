import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../addDocumentControler/addDocumentModel/addDocumentModel.dart';
import '../ProfileController.dart';

class EducationFormController extends GetxController{
  ProfileController profileApplicationController=Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileApplicationController.addDocumentList.add(AdddocumentModel());

  }

}