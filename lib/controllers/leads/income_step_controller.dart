import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:ksdpl/controllers/leads/add_income_model_controller.dart';

import 'loan_appl_controller.dart';

class IncomeStepController extends GetxController{
  Addleadcontroller addleadcontroller=Get.find();
  CamNoteController camNoteController=Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addleadcontroller.addIncomeList.add(AddIncomeModelController());
    camNoteController.addIncomeList.add(AddIncomeModelController());

  }

}