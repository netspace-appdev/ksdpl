import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:ksdpl/controllers/cibilgenerate_controller/CibilGenerateController.dart';

import '../../common/validation_helper.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';

class Cibilgeneratepage extends StatelessWidget {

 // const Cibilgeneratepage({super.key});

  CibilGenerateController cibilGenerateController = Get.put(CibilGenerateController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Generate Cibil',
          //  widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.appWhite,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
        ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),

        child: SingleChildScrollView(
          child: Form(
            key:  cibilGenerateController.formKey ,
            child: Column(
              children: [
                CustomLabeledTextField(
                  label: AppText.fullName,
                  isRequired: true,
                  controller: cibilGenerateController.camFullNameController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterFullName,
                  validator:  ValidationHelper.validateName,
                ),
                CustomLabeledTextField(
                  label: AppText.mobilenumber,
                  isRequired: true,
                  controller: cibilGenerateController.camCibilMobController,
                  inputType: TextInputType.phone,
                  hintText: AppText.enterMBmber,
                  validator: ValidationHelper.validatePhoneNumber,
                  maxLength: 10,
                ),

                CustomLabeledTextField(
                  label: AppText.totalAmountCibil,
                  controller: cibilGenerateController.camTotalOverdueAmountController,
                  inputType: TextInputType.number,
                  hintText: AppText.enterAmountCibil,
                  isRequired: true,
                  validator: ValidationHelper.validateAmt,

                  //isInputEnabled: cibilGenerateController.enableAllCibilFields.value,
                ),

                CustomLabeledPickerTextField(
                  label: AppText.receivedDate,
                  controller: cibilGenerateController.camReceivableDateController,
                  inputType: TextInputType.name,
                  hintText: AppText.mmddyyyy,
                  isDateField: true,
                  isRequired: true,
                  isFutureDisabled:true,
                  validator: ValidationHelper.validateReceivedDate,

                ),

                CustomLabeledTextField(
                  label: AppText.transactionDetails,
                  controller: cibilGenerateController.camTransactionDetailsController,
                  inputType: TextInputType.name,
                  isRequired: true,
                  hintText: AppText.enterTransactionDetails,
                  validator: ValidationHelper.validateUTR,

                ),


                SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
               // onPressed: onPressed,
                onPressed: () {
                  if (cibilGenerateController.formKey.currentState?.validate() ?? false) {
                    // All validations passed

                    cibilGenerateController.callApi();
                  } else {
                    // Some validation failed
                    print("Form is not valid");
                  }
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
            )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
