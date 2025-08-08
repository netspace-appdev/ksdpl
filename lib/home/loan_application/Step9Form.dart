import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/helper.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';


class Step9Form extends StatelessWidget {
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
          Text( AppText.ChargesDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),

              CustomLabeledTextField(
                label: AppText.ProcessingFees,
                isRequired: false,
                controller: loanApplicationController.chargesDetailProcessingFees,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.AdminFeeCharges,
                isRequired: false,
                controller: loanApplicationController.chargesDetailAdminFeeChargess,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validatePhoneNumber,
              ),

              CustomLabeledTextField(
                label: AppText.ForeclosureCharges,
                isRequired: false,
                controller: loanApplicationController.chargesDetailForeclosureCharges,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validatePhoneNumber,
              ),
              CustomLabeledTextField(
                label: AppText.StampDuty,
                isRequired: false,
                controller: loanApplicationController.chargesDetailStampDuty,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validateEmail,
              ),
              CustomLabeledTextField(
                label: AppText.LegalVettingCharges,
                isRequired: false,
                controller: loanApplicationController.chargesDetailLegalVettingCharges,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validateEmail,
              ),

              CustomLabeledTextField(
                label: AppText.TechnicalInspectionCharges,
                isRequired: false,
                controller: loanApplicationController.chargesDetailTechnicalInspectionCharges,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validateEmail,
              ),

              CustomLabeledTextField(
                label: AppText.otherCharges,
                isRequired: false,
                controller: loanApplicationController.chargesDetailOtherCharges,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validateEmail,
              ),

              CustomLabeledTextField(
                label: AppText.TSRLegalCharges,
                isRequired: false,
                controller: loanApplicationController.chargesDetailTSRLegalCharges,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validateEmail,
              ),
              CustomLabeledTextField(
                label: AppText.valuationCharges,
                isRequired: false,
                controller: loanApplicationController.chargesDetailValuationCharges,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validateEmail,
              ),

              CustomLabeledTextField(
                label: AppText.processingCharges,
                isRequired: false,
                controller: loanApplicationController.chargesDetailProcessingCharges,
                inputType: TextInputType.number,
                hintText: AppText.ChargesDetailshint,
                validator:  ValidationHelper.validateEmail,
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
