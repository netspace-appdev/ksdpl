import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
      
      
        body: Form(
          key:  cibilGenerateController.formKey ,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Gradient Background
                    Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColor.primaryLight, AppColor.primaryDark],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child:Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          header(context),
                        ],
                      ),
                    ),
                    // White Container
                    Align(
                      alignment: Alignment.topCenter,  // Centers it
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Container(
                          margin:  EdgeInsets.only(
                              top:90 // MediaQuery.of(context).size.height * 0.22
                          ), // <-- Moves it 30px from top
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          decoration: const BoxDecoration(
                            color: AppColor.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45),
                            ),

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Prevents extra spacing
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
                            validator:ValidationHelper.validatecibilamount ,
                            //isInputEnabled: cibilGenerateController.enableAllCibilFields.value,
                          ),

                          CustomLabeledPickerTextField(
                            label: AppText.receivedDate,
                            controller: cibilGenerateController.camReceivableDateController,
                            inputType: TextInputType.name,
                            hintText: AppText.mmddyyyy,
                            isDateField: true,
                            isRequired: true,
                            isFutureDisabled: true,
                            validator:ValidationHelper.validateReceivedDate ,

                          ),

                          CustomLabeledTextField(
                            label: AppText.transactionDetails,
                            controller: cibilGenerateController.camTransactionDetailsController,
                            inputType: TextInputType.name,
                            isRequired: true,
                            hintText: AppText.enterTransactionDetails,
                            validator:ValidationHelper.validateUTR ,

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

                                  cibilGenerateController.addCustomerCibilRequestApi();
                                  // All validations passed
                                  print("Form is valid");
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
                          ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8), // for ripple effect
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12), // optional internal padding
              alignment: Alignment.center,
              child: Image.asset(
                AppImage.arrowLeft,
                height: 24,
              ),
            ),
          ),

          const Text(
            AppText.genCibil,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700
            ),
          ),

          InkWell(
            onTap: (){

            },
            child: Container(

              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(child: Icon(Icons.filter_alt_outlined, color: Colors.transparent,),),
            ),
          )

        ],
      ),
    );
  }
}
