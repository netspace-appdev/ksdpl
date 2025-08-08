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

class Step8Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();
  LeadDDController leadDDController = Get.put(LeadDDController());

  @override
  Widget build(BuildContext context) {
    return Container(
      /*height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,*/

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( AppText.bankerDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomLabeledTextField(
                label: AppText.bankerName,
                isRequired: true,
                controller: loanApplicationController.bankerNameController,
                inputType: TextInputType.name,
                hintText: AppText.enterBankerName,
              //  validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.bankerMobile,
                isRequired: true,
                controller: loanApplicationController.bankerMobileController,
                inputType: TextInputType.number,
                hintText: AppText.enterBankerMobile,
            //   validator:  ValidationHelper.validatePhoneNumber,
              ),
              CustomLabeledTextField(
                label: AppText.bankerWhatsapp,
                isRequired: true,
                controller: loanApplicationController.bankerWhatsappController,
                inputType: TextInputType.number,
                hintText: AppText.enterBankerWhatsapp,
             //   validator:  ValidationHelper.validatePhoneNumber,
              ),
              CustomLabeledTextField(
                label: AppText.bankerEmail,
                isRequired: true,
                controller: loanApplicationController.bankerEmailController,
                inputType: TextInputType.name,
                hintText: AppText.enterBankerEmail,
            //    validator:  ValidationHelper.validateEmail,
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
