import 'package:get/get.dart';
import 'package:ksdpl/controllers/loan_appl_controller/credit_cards_model_controller.dart';
import '../leads/loan_appl_controller.dart';
import 'family_member_model_controller.dart';

class Step5Controller extends GetxController{
  LoanApplicationController loanApplicationController=Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loanApplicationController.creditCardsList.add(CreditCardsController());

  }

}