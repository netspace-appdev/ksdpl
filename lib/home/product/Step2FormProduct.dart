import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import '../../custom_widgets/CustomTextLabel.dart';

class Step2FormProduct extends StatelessWidget {
  final addProductController = Get.find<AddProductController>();
  LeadDDController leadDDController = Get.put(LeadDDController());

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Obx((){
        if( addProductController.isLoadingMainScreen.value)
          return Center(
            child: CustomSkelton.productShimmerList(context),
          );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 20,
            ),

            CustomLabeledTextField(
              label: AppText.ageLimitEarningApplicants,
              controller: addProductController.prodAgeLimitEarningApplicantsController,
              inputType: TextInputType.number,
              hintText: AppText.enterAgeLimitEarningApplicants,
              validator:  ValidationHelper.validateName,
            ),

            CustomLabeledTextField(
              label: AppText.ageLimitNonEarningCoApplicant,

              controller: addProductController.prodAgeLimitNonEarningCoApplicantController,
              inputType: TextInputType.number,
              hintText: AppText.enterAgeLimitNonEarningCoApplicant,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.minAgeEarningApplicants,

              controller: addProductController.prodMinAgeEarningApplicantsController,
              inputType: TextInputType.number,
              hintText: AppText.enterMinAgeEarningApplicants,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.minAgeNonEarningApplicants,

              controller: addProductController.prodMinAgeNonEarningApplicantsController,
              inputType: TextInputType.number,
              hintText: AppText.enterMinAgeNonEarningApplicants,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.minIncomeCriteria,

              controller: addProductController.prodMinIncomeCriteriaController,
              inputType: TextInputType.number,
              hintText: AppText.enterMinIncomeCriteria,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.minLoanAmount,
              controller: addProductController.prodMinLoanAmountController,
              inputType: TextInputType.number,
              hintText: AppText.enterMinLoanAmount,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.maxLoanAmount,
              controller: addProductController.prodMaxLoanAmountController,
              inputType: TextInputType.number,
              hintText: AppText.enterMaxLoanAmount,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.profitPercentage,
              controller: addProductController.prodProfitPercentageController,
              inputType: TextInputType.number,
              hintText: AppText.enterProfitPercentage,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.minTenor,
              controller: addProductController.prodMinTenorController,
              inputType: TextInputType.number,
              hintText: AppText.enterMinTenor,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.minTenor,
              controller: addProductController.prodMinTenorController,
              inputType: TextInputType.number,
              hintText: AppText.enterMinTenor,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.maxTenor,
              controller: addProductController.prodMaxTenorController,
              inputType: TextInputType.number,
              hintText: AppText.enterMaxTenor,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.minRoi,
              controller: addProductController.prodMinRoiController,
              inputType: TextInputType.number,
              hintText: AppText.enterMinRoi,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.maxRoi,
              controller: addProductController.prodMaxRoiController,
              inputType: TextInputType.number,
              hintText: AppText.enterMaxRoi,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.maxTenorEligibilityCriteria,
              controller: addProductController.prodMaxTenorEligibilityCriteriaController,
              inputType: TextInputType.number,
              hintText: AppText.enterMaxTenorEligibilityCriteria,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.geoLimit,
              controller: addProductController.prodGeoLimitController,
              inputType: TextInputType.number,
              hintText: AppText.enterGeoLimit,
              validator:  ValidationHelper.validatePhoneNumber,
            ),
          ],
        );
      }),
    );
  }
  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: addProductController.selectedGender.value,
          onChanged: (value) {
            addProductController.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}
