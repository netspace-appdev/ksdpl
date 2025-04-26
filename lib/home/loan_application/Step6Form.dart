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

class Step6Form extends StatelessWidget {
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
          Text( AppText.financialDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomLabeledTextField(
                label: AppText.grossMonthlySalary,
                isRequired: false,
                controller: loanApplicationController.fdGrossMonthlySalaryController,
                inputType: TextInputType.name,
                hintText: AppText.enterGrossMonthlySalary,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.netMonthlySalary,
                isRequired: false,
                controller: loanApplicationController.fdnNtMonthlySalaryController,
                inputType: TextInputType.name,
                hintText: AppText.enterNetMonthlySalary,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.annualBonus,
                isRequired: false,
                controller: loanApplicationController.fdAnnualBonusController,
                inputType: TextInputType.name,
                hintText: AppText.enterAnnualBonus,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.avgMonOvertime,
                isRequired: false,
                controller: loanApplicationController.fdAvgMonOvertimeController,
                inputType: TextInputType.name,
                hintText: AppText.enterAvgMonOvertime,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.avgMonCommission,
                isRequired: false,
                controller: loanApplicationController.fdAvgMonCommissionController,
                inputType: TextInputType.name,
                hintText: AppText.enterAvgMonCommission,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.socBuildName,
                isRequired: false,
                controller: loanApplicationController.propBuildingNameController,
                inputType: TextInputType.name,
                hintText: AppText.enterBuildingNo,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.monthlyPfDeduction,
                isRequired: false,
                controller: loanApplicationController.fdAMonthlyPfDeductionController,
                inputType: TextInputType.name,
                hintText: AppText.enterMonthlyPfDeduction,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.otherMonthlyIncome,
                isRequired: false,
                controller: loanApplicationController.fdOtherMonthlyIncomeController,
                inputType: TextInputType.name,
                hintText: AppText.enterOtherMonthlyIncome,
                validator: ValidationHelper.validateName,
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
