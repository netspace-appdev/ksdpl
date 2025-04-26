import 'package:get/get.dart';
import 'package:ksdpl/controllers/loan_appl_controller/reference_model_controller.dart';
import 'co_applicant_detail_mode_controllerl.dart';
import '../leads/loan_appl_controller.dart';

class Step7Controller extends GetxController{
  LoanApplicationController loanApplicationController=Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loanApplicationController.referencesList.add(ReferenceController());

  }

}