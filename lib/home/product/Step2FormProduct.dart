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
import '../../custom_widgets/CustomLabeledTextField2.dart';
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
        return Form(
          key: addProductController.stepFormKeys[1],
          child: Column(
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

              ),

              CustomLabeledTextField(
                label: AppText.ageLimitNonEarningCoApplicant,

                controller: addProductController.prodAgeLimitNonEarningCoApplicantController,
                inputType: TextInputType.number,
                hintText: AppText.enterAgeLimitNonEarningCoApplicant,

              ),

              CustomLabeledTextField(
                label: AppText.minAgeEarningApplicants,

                controller: addProductController.prodMinAgeEarningApplicantsController,
                inputType: TextInputType.number,
                hintText: AppText.enterMinAgeEarningApplicants,

              ),

              CustomLabeledTextField(
                label: AppText.minAgeNonEarningApplicants,

                controller: addProductController.prodMinAgeNonEarningApplicantsController,
                inputType: TextInputType.number,
                hintText: AppText.enterMinAgeNonEarningApplicants,

              ),

              CustomLabeledTextField(
                label: AppText.minIncomeCriteria,
                controller: addProductController.prodMinIncomeCriteriaController,
                inputType: TextInputType.number,
                hintText: AppText.enterMinIncomeCriteria,

              ),

              CustomLabeledTextField(
                label: AppText.minLoanAmount,
                controller: addProductController.prodMinLoanAmountController,
                inputType: TextInputType.number,
                hintText: AppText.enterMinLoanAmount,

              ),

              CustomLabeledTextField(
                label: AppText.maxLoanAmount,
                controller: addProductController.prodMaxLoanAmountController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxLoanAmount,

              ),

              CustomLabeledTextField2(
                label: AppText.eligibleProfitPercent, ///previous it was named Profit Percentage
                controller: addProductController.prodProfitPercentageController,
                inputType: TextInputType.number,
                hintText: AppText.enterEligibleProfitPercent,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodProfitPercentageController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Eligible Profit Percent should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },

              ),

              CustomLabeledTextField(
                label: AppText.minTenor,
                controller: addProductController.prodMinTenorController,
                inputType: TextInputType.number,
                hintText: AppText.enterMinTenor,

              ),

              CustomLabeledTextField(
                label: AppText.maxTenor,
                controller: addProductController.prodMaxTenorController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxTenor,

              ),

              CustomLabeledTextField2(
                label: AppText.minRoi,
                controller: addProductController.prodMinRoiController,
                inputType: TextInputType.number,
                hintText: AppText.enterMinRoi,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodMinRoiController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Minimum (ROI) should not be more than 100 %",
                  );
                 // camNoteController.calculateLoanDetails();
                },
              ),

              CustomLabeledTextField2(
                label: AppText.maxRoi,
                controller: addProductController.prodMaxRoiController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxRoi,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodMaxRoiController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Maximum ROI should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },
              ),

              CustomLabeledTextField(
                label: AppText.ageAtMaturity, ///previously it was named Max Tenor Eligibility Criteria
                controller: addProductController.prodMaxTenorEligibilityCriteriaController,
                inputType: TextInputType.number,
                hintText: AppText.enterAgeAtMaturity,
              ),

              CustomLabeledTextField(
                label: AppText.geoLimit,
                controller: addProductController.prodGeoLimitController,
                inputType: TextInputType.number,
                hintText: AppText.enterGeoLimit,

              ),
            ],
          ),
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
