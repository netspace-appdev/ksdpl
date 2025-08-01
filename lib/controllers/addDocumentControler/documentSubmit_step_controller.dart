import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/controllers/leads/loan_appl_controller.dart';
import 'addDocumentModel/addDocumentModel.dart';

class SubmitDocumentController extends GetxController{
  LoanApplicationController loanApplicationController=Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loanApplicationController.addDocumentList.add(AdddocumentModel());

  }

}