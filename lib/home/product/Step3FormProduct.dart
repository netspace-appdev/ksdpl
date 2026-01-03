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
import '../../custom_widgets/CustomLabeledTextField2.dart';
import '../../custom_widgets/CustomMultiSelectDropdown.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/product/GetAllNegativeProfileModel.dart' as negProfile;


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
                label: AppText.negativeProfilesExcluded,



              ),

              const SizedBox(height: 10),



              Obx(() {
                final values = addProductController.selectedNegProfile.toList(); // List<negProfile.Data>
                final negProfileList = addProductController.negProfileApiList.toList();

                final isAllSelected = Set.from(values.map((e) => e.id)).containsAll(negProfileList.map((e) => e.id));
                final controlOption = negProfile.Data(id: -1, negativeProfile: isAllSelected ? "Deselect All" : "Select All");

                final allItems = [controlOption, ...negProfileList];

                return MultiSelectDropdown<negProfile.Data>(
                  key: ValueKey(values.map((e) => e.id).join(',')), // Stable key
                  items: allItems,
                  getId: (e) => e.id.toString(),
                  getName: (e) => e.negativeProfile ?? 'Unknown',
                  selectedValues: values.where((e) => e.id != -1).toList(), // exclude control option from selection
                  onChanged: (selectedList) {
                    if (selectedList.any((e) => e.id == -1 && e.negativeProfile == "Select All")) {
                      addProductController.selectedNegProfile.assignAll(negProfileList);
                    } else if (selectedList.any((e) => e.id == -1 && e.negativeProfile == "Deselect All")) {
                      addProductController.selectedNegProfile.clear();
                    } else {
                      addProductController.selectedNegProfile.assignAll(
                        selectedList.where((e) => e.id != -1),
                      );
                    }
                  },
                );
              }),


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

              CustomLabeledTextField2(
                label: AppText.maxIir,
                controller: addProductController.prodMaxIirController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxIir,
                validator:  ValidationHelper.validateName,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodMaxIirController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Maximum IIR should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },

              ),

              CustomLabeledTextField2(
                label: AppText.maxFoir,
                controller: addProductController.prodMaxFoirController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxFoir,
                validator:  ValidationHelper.validateName,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodMaxFoirController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Maximum LTV should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },
              ),

              CustomLabeledTextField2(
                label: AppText.maxLtv,
                controller: addProductController.prodMaxLtvController,
                inputType: TextInputType.number,
                hintText: AppText.enterMaxLtv,
                validator:  ValidationHelper.validateName,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodMaxLtvController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Maximum LTV should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },
              ),

              CustomLabeledTextField2(
                label: AppText.processingFee,
                controller: addProductController.prodProcessingFeeController,
                inputType: TextInputType.number,
                hintText: AppText.enterProcessingFee,
                validator:  ValidationHelper.validatePercentage,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodProcessingFeeController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Processing Fee should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },
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

              CustomLabeledTextField2(
                label: AppText.adminFee,
                controller: addProductController.prodAdminFeeController,
                inputType: TextInputType.number,
                hintText: AppText.enterAdminFee,
                validator:  ValidationHelper.validateName,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodAdminFeeController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Admin Fee should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },
              ),

              CustomLabeledTextField2(
                label: AppText.foreclosureCharges,
                controller: addProductController.prodForeclosureChargesController,
                inputType: TextInputType.number,
                hintText: AppText.enterForeclosureCharges,
                validator:  ValidationHelper.validateName,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodForeclosureChargesController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Foreclosure Charges should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },
              ),

              /*CustomLabeledTextField(
                label: AppText.processingCharges,
                controller: addProductController.prodProcessingChargesController,
                inputType: TextInputType.number,
                hintText: AppText.enterProcessingCharges,
                validator:  ValidationHelper.validateName,
              ),*/


              CustomLabeledTextField(
                label: AppText.otherCharges,
                controller: addProductController.prodOtherChargesController,
                inputType: TextInputType.number,
                hintText: AppText.enterOtherCharges,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField2(
                label: AppText.stampDuty,
                controller: addProductController.prodStampDutyController,
                inputType: TextInputType.number,
                hintText: AppText.enterStampDuty,
                validator:  ValidationHelper.validateName,
                isRequired: false,
                onChanged: (value){
                  ValidationHelper.validatePercentageInput(
                    controller:  addProductController.prodForeclosureChargesController,
                    value: value,
                    maxValue: 100,
                    errorMessage: "The Stamp Duty should not be more than 100 %",
                  );
                  // camNoteController.calculateLoanDetails();
                },
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
