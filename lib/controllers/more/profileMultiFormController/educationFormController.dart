import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/controllers/more/ProfileController.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/ademicsController.dart';



class EducationFormController extends GetxController{
  ProfileController profileController=Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileController.acadmicsFormApplList.add(AcademicFormController());
  }

}
