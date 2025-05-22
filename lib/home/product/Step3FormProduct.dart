import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomChipTextfield.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import '../../custom_widgets/CustomTextLabel.dart';



class Step3FormProduct extends StatelessWidget {
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
          key: addProductController.stepFormKeys[2],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 20,
              ),
              CustomTextLabel(
                label: AppText.negativeProfiles,



              ),

              const SizedBox(height: 10),
              CustomChipTextField(
                textController: addProductController.chipTextController,
                initialTags: addProductController.selectedNegProfile.toList(),
                hintText:  AppText.negativeProfilesHint,
                onChanged: (tags) {
                  print("Updated tags: $tags");
                  addProductController.selectedNegProfile.assignAll(tags);
                },
              ),


              const SizedBox(
                height: 20,
              ),
              CustomTextLabel(
                label: AppText.negativeAreas,



              ),

              const SizedBox(height: 10),
              CustomChipTextField(
                textController: addProductController.chipText2Controller,
                initialTags: addProductController.selectedNegArea.toList(),
                hintText:  AppText.negativeProfilesHint,
                onChanged: (tags) {
                  print("Updated tags: $tags");
                  addProductController.selectedNegArea.assignAll(tags);
                },
              ),
              const SizedBox(height: 20),

              CustomLabeledTextField(
                label: AppText.minPropertyValue,
                controller: addProductController.prodMinPropertyValueController,
                inputType: TextInputType.number,
                hintText: AppText.enterMinPropertyValue,
                validator:  ValidationHelper.validateName,

              ),

              CustomLabeledTextField(
                label: AppText.maxIir,
                controller: addProductController.prodMaxIirController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxIir,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.maxFoir,
                controller: addProductController.prodMaxFoirController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxFoir,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.maxLtv,
                controller: addProductController.prodMaxLtvController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxLtv,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.processingFee,
                controller: addProductController.prodProcessingFeeController,
                inputType: TextInputType.number,
                hintText: AppText.enterProcessingFee,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.legalFee,
                controller: addProductController.prodLegalFeeController,
                inputType: TextInputType.number,
                hintText: AppText.enterLegalFee,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.technicalFee,
                controller: addProductController.prodTechnicalFeeController,
                inputType: TextInputType.number,
                hintText: AppText.enterTechnicalFee,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.adminFee,
                controller: addProductController.prodAdminFeeController,
                inputType: TextInputType.number,
                hintText: AppText.enterAdminFee,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.foreclosureCharges,
                controller: addProductController.prodForeclosureChargesController,
                inputType: TextInputType.number,
                hintText: AppText.enterForeclosureCharges,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.otherCharges,
                controller: addProductController.prodOtherChargesController,
                inputType: TextInputType.number,
                hintText: AppText.enterOtherCharges,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.stampDuty,
                controller: addProductController.prodStampDutyController,
                inputType: TextInputType.number,
                hintText: AppText.enterStampDuty,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.tsrYears,
                controller: addProductController.prodTsrYearsController,
                inputType: TextInputType.number,
                hintText: AppText.enterTsrYears,
                validator:  ValidationHelper.validateName,
              ),


              CustomLabeledTextField(
                label: AppText.tsrCharges,
                controller: addProductController.prodTsrChargesController,
                inputType: TextInputType.number,
                hintText: AppText.enterTsrCharges,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.valuationCharges,
                controller: addProductController.prodValuationChargesController,
                inputType: TextInputType.number,
                hintText: AppText.enterValuationCharges,
                validator:  ValidationHelper.validateName,
              ),



              CustomLabeledPickerTextField(
                label: AppText.productValidateFrom,
                isRequired: false,
                controller: addProductController.prodProductValidateFromController,
                inputType: TextInputType.name,
                hintText: AppText.yyyyMmDd,
                validator: ValidationHelper.validateDob,
                isDateField: true,
              ),

              CustomLabeledPickerTextField(
                label: AppText.productValidateTo,
                isRequired: false,
                controller: addProductController.prodProductValidateToController,
                inputType: TextInputType.name,
                hintText: AppText.yyyyMmDd,
                validator: ValidationHelper.validateDob,
                isDateField: true,
              ),

              CustomLabeledTextField(
                label: AppText.maxTat,
                controller: addProductController.prodMaxTatController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxTat,
                validator:  ValidationHelper.validateName,
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
