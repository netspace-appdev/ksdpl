import 'package:get/get.dart';
import '../leads/loan_appl_controller.dart';
import 'family_member_model_controller.dart';

class Step4Controller extends GetxController{
  LoanApplicationController loanApplicationController=Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loanApplicationController.familyMemberApplList.add(FamilyMemberController());

  }

}