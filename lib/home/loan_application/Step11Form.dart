import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../common/helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../custom_widgets/SnackBarHelper.dart';

class Step11Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();
  LeadDDController leadDDController = Get.put(LeadDDController());
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text( AppText.bankerDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height/3,

                  //  width: 150,
                    child: Lottie.asset(AppImage.applicationcompleted, repeat: false)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: loanApplicationController.isLoading.value
                        ? null
                        : () {

                      if (loanApplicationController.selectedBank.value == 0 || loanApplicationController.selectedBank.value == null) {
                        SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select Bank Name");
                        return;
                      }
                      if (loanApplicationController.selectedBankBranch.value == 0 || loanApplicationController.selectedBankBranch.value == null) {
                        SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select branch");
                        return;
                      }

                      if (loanApplicationController.selectedProdTypeOrTypeLoan.value == 0 || loanApplicationController.selectedProdTypeOrTypeLoan.value == null) {
                        SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select Loan Type");
                        return;
                      }

                      if (loanApplicationController.bankerNameController.text.trim().isEmpty) {
                        SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker Name");
                        return;
                      }

                      if (loanApplicationController.bankerMobileController.text.trim().isEmpty) {
                        SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker Mobile ");
                        return;
                      }

                      if (loanApplicationController.bankerWhatsappController.text.trim().isEmpty) {
                        SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker WhatsUp ");
                        return;
                      }

                      if (!emailRegex.hasMatch(loanApplicationController.bankerEmailController.text.trim()) ||
                          loanApplicationController.bankerEmailController.text.trim().isEmpty) {
                        SnackbarHelper.showSnackbar(title: "Invalid Email", message: "Please enter a Official email address.");
                        return;
                      }

                      loanApplicationController.onSaveLoanAppl(status: "1");
                    },
                    child: loanApplicationController.isLoading.value
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : const Text(
                      AppText.submit,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )),
                ),
              ),

            ],
          ),



          ///
        ],
      ),
    );
  }
}
