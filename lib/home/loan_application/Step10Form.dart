import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import 'package:ksdpl/models/dashboard/GetAllChannelModel.dart' as channel;

import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import '../../custom_widgets/CustomTextLabel.dart';
import '../../custom_widgets/SnackBarHelper.dart';

class Step10Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();
  LeadDDController leadDDController = Get.put(LeadDDController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text( AppText.bankerDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                 padding: const EdgeInsets.only(top: 18.0),
                 child: SizedBox(
                   width: double.infinity,
                   height: 50,
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppColor.secondaryColor,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                     onPressed:(){
                       print('loanApplicationController.selectedBank.value${loanApplicationController.selectedBank.value}');
                       if(loanApplicationController.selectedBank.value==0||loanApplicationController.selectedBank.value==null){
                         SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select Bank Name");
                         return;
                       } if(loanApplicationController.selectedProdTypeOrTypeLoan.value==0||loanApplicationController.selectedProdTypeOrTypeLoan.value==null){
                         SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select Loan Type");
                         return;
                       } if(loanApplicationController.bankerNameController.text.trim().toString().isEmpty){
                         SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker Name");
                         return;
                       } if(loanApplicationController.bankerMobileController.text.trim().toString().isEmpty){
                         SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker Mobile ");
                         return;
                       } if(loanApplicationController.bankerWhatsappController.text.trim().toString().isEmpty){
                         SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker WhatsUp ");
                         return;
                       } if(loanApplicationController.bankerEmailController.text.trim().toString().isEmpty){
                         SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Email ");
                         return;
                       }else
                       loanApplicationController.onSaveLoanAppl();
                     },
                     child: const Text(
                       AppText.submit,
                       style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                       ),
                     ),
                   ),
                 ),
               ),
            ],
          ),



          ///
        ],
      ),
    );
  }
  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: loanApplicationController.selectedGender.value,
          onChanged: (value) {
            loanApplicationController.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}
