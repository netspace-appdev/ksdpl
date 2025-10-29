import 'package:get/get.dart';
import 'co_applicant_detail_mode_controllerl.dart';
import '../leads/loan_appl_controller.dart';

class Step2Controller extends GetxController{
  LoanApplicationController loanApplicationController=Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("onInit---");
    loanApplicationController.coApplicantList.add(CoApplicantDetailController());


  }

}