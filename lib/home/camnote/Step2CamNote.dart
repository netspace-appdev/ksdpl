import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
import 'package:ksdpl/custom_widgets/custom_photo_picker_widget.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/camnote/camnote_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDialogBox.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomIconDilogBox.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLoadingOverlay.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart' as customTF;
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import '../../models/product/GetAllProductListModel.dart' as prod;

class Step2CamNote extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  final CamNoteController camNoteController =Get.find();
  final AddProductController addProductController =Get.find();
  final ViewProductController viewProductController = Get.put(ViewProductController());
  @override
  Widget build(BuildContext context) {

    return Container(

      child: Obx((){
        if( camNoteController.isLoadingMainScreen.value)
           return Center(
            child: CustomSkelton.productShimmerList(context),
          );
        return Form(
          key: camNoteController.stepFormKeys[1],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 20,
              ),

              ExpansionTile(
                initiallyExpanded: true,


                childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                title:const Text( AppText.sectionA, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                leading: const Icon(Icons.list_alt, size: 20,),
                children: [

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                      Column(
                       children: [
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Expanded( // This allows the label text to wrap
                               child: Row(
                                 children: [
                                   const Text.rich(
                                     TextSpan(
                                       text: AppText.cibil,
                                       style: TextStyle(
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold,
                                         color: AppColor.grey2,
                                       ),
                                     ),
                                   ),
                                   SizedBox(width: 10,),
                                   Visibility(
                                     visible: camNoteController.isGenerateCibilVisible.value,
                                     child: InkWell(
                                       onTap: (){
                                         camNoteController.selectedIndexGenCibil.value=-1;
                                         camNoteController.camCibilMobController.text=camNoteController.camPhoneController.text;
                                         camNoteController.selectedGenderGenCibil.value=camNoteController.selectedGender.value;
                                         showDialogSendEmailCibil(context:context);
                                       },
                                       child: const Text(
                                        AppText.sendEmailToCustomer,
                                         style: TextStyle(
                                           fontSize: 16,
                                           fontWeight: FontWeight.bold,
                                           color: AppColor.redColor,
                                         ),
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           ],
                         ),


                         SizedBox(height: 10),
                       ],
                     ),



                     customTF.CustomTextFieldPrefix(
                       controller: camNoteController.camCibilController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterCibilScore,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),
                     SizedBox(height: 15,),

                     CustomLabeledTextField(
                       label: AppText.totalLoanAvaileCibil,
                       controller: camNoteController.camTotalLoanAvailedController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalLoanAvaileCibil,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalLiveLoan,
                       controller: camNoteController.camTotalLiveLoanController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalLiveLoan,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalEmi,
                       controller: camNoteController.camTotalEmiController,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalEmi,
                     ),

                     CustomLabeledTextField(
                       label: AppText.emiStoppedBefore,
                       controller: camNoteController.camEmiStoppedBeforeController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterEmiStoppedBefore,
                     ),

                     CustomLabeledTextField(
                       label: AppText.emiWillContinue,
                       controller: camNoteController.camEmiWillContinueController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterEmiWillContinue,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalOverdueCases,
                       controller: camNoteController.camTotalOverdueCasesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterOverdueCases,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalOverdueAmountCibil,
                       controller: camNoteController.camTotalOverdueAmountController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterOverdueAmountCibil,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalEnquiries,
                       controller: camNoteController.camTotalEnquiriesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalEnquiries,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),
                   ],
                 )


                ],
              ),

              ExpansionTile(
                initiallyExpanded: true,


                childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                title:const Text(AppText.sectionB, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                leading: const Icon(Icons.list_alt, size: 20,),
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const CustomTextLabel(
                        label: AppText.incomeType,
                        isRequired: false,
                      ),

                      const SizedBox(height: 10),


                      Obx((){
                        if (camNoteController.isLoading.value) {
                          return  Center(child:CustomSkelton.productShimmerList(context));
                        }


                        return CustomDropdown<String>(
                          items: addProductController.incomeTypeList,
                          getId: (item) => item,  // Adjust based on your model structure
                          getName: (item) => item,
                          selectedValue: camNoteController.selectedCamIncomeTypeList.value,
                          onChanged: (value) {
                            camNoteController.selectedCamIncomeTypeList.value =  value;
                          },
                        );
                      }),

                      const SizedBox(height: 20),

                      CustomLabeledTextField(
                        label: AppText.earningCustomerAge,
                        controller: camNoteController.camEarningCustomerAgeController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterEarningCustomerAge,
                        isInputEnabled: false,
                      ),


                      CustomLabeledTextField(
                        label: AppText.nonEarningCustomerAge,
                        controller: camNoteController.camNonEarningCustomerAgeController,
                        inputType: TextInputType.number,
                        hintText: AppText.nonEarningCustomerAge,
                      ),

                      CustomLabeledTextField(
                        label: AppText.totalFamilyIncome,
                        controller: camNoteController.camTotalFamilyIncomeController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterTotalFamilyIncome,
                      ),

                      CustomLabeledTextField(
                        label: AppText.incomeCanBeConsidered,
                        controller: camNoteController.camIncomeCanBeConsideredController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterConsideredIncome,
                      ),

                      CustomLabeledTextField(
                        label: AppText.loanAmountRequested,
                        controller: camNoteController.camLoanAmtReqController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterConsideredIncome,
                        isInputEnabled: false,
                      ),

                      CustomLabeledTextField(
                        label: AppText.loanTenorRequested,
                        controller: camNoteController.camLoanTenorRequestedController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLoanTenorRequested,
                      ),

                      CustomLabeledTextField(
                        label: AppText.rateOfInterest,
                        controller: camNoteController.camRateOfInterestController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterRateOfInterest,
                      ),

                      CustomLabeledTextField(
                        label: AppText.proposedEmi,
                        controller: camNoteController.camProposedEmiController,
                        inputType: TextInputType.number,
                        hintText: AppText.autoCalculatedProposedEmi,
                       isInputEnabled: false,
                      ),

                      CustomLabeledTextField(
                        label: AppText.propertyValue,
                        controller: camNoteController.camPropertyValueController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterPropertyValue,
                      ),

                      CustomLabeledTextField(
                        label: AppText.foir,
                        controller: camNoteController.camFoirController,
                        inputType: TextInputType.number,
                        hintText: AppText.autoCalculatedFoir,
                        isInputEnabled: false,
                      ),

                      CustomLabeledTextField(
                        label: AppText.ltv,
                        controller: camNoteController.camLtvController,
                        inputType: TextInputType.number,
                        hintText: AppText.autoCalculatedLtv,
                        isInputEnabled: false,
                      ),

                      CustomLabeledTextField(
                        label: AppText.offeredSecurityType,
                        controller: camNoteController.camOfferedSecurityTypeController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterSecurityType,
                      ),
                    ],
                  )


                ],
              ),

            ],
          ),
        );
      }),
    );
  }


/*
  void showDialogGenCibil({
    required BuildContext context,
  }) {

    //working leads is now ongoing call
    List<String> options = [AppText.genAadhar,AppText.genPan];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx((){

          return camNoteController.isLoadingCibil.value?
          CustomLoadingOverlay():

          CustomBigDialogBox(
            titleBackgroundColor: AppColor.secondaryColor,

            title: "Genrate CIBIL",
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical:0 ),
                  child:  Obx(()=>Column(
                    children: options.asMap().entries.map((entry) {
                      int index = entry.key;
                      String option = entry.value;

                      return CheckboxListTile(
                        activeColor: AppColor.secondaryColor,

                        title: Text(option),
                        value: camNoteController.selectedIndexGenCibil.value == index,
                        onChanged: (value) => camNoteController.selectCheckboxCibil(index),
                      );
                    }).toList(),
                  )),
                ),
                SizedBox(height: 10,),


                Obx(()=>Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(camNoteController.selectedIndexGenCibil.value==0)...[
                      CustomLabeledTextField(
                        label: AppText.fullName,
                        controller: camNoteController.camFullNameController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterFullName,
                        isRequired: true,
                        validator: ValidationHelper.validateName,
                      ),
                      CustomLabeledTextField(
                        label: AppText.aadhar,
                        isRequired: true,

                        controller:camNoteController.camAadharController,
                        inputType: TextInputType.phone,
                        hintText: AppText.enterAadhar,
                        maxLength: 12,
                        isSecret: true,
                        secretDigit: 4,

                      ),

                      CustomLabeledTextField(
                        label: AppText.phoneNumberNoStar,
                        isRequired: true,

                        controller: camNoteController.camCibilMobController,
                        inputType: TextInputType.phone,
                        hintText: AppText.enterPhNumber,
                        validator: ValidationHelper.validatePhoneNumber,
                        maxLength: 10,

                      ),
                      const Row(
                        children: [
                          Text(
                            AppText.gender,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.grey2,
                            ),
                          ),
                          Text(
                            " *",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.redColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      /// Label Row (with * if required)
                      Obx(()=>  Row(
                        children: [
                          _buildRadioOption("Male"),
                          _buildRadioOption("Female"),
                          _buildRadioOption("Other"),
                        ],
                      )
                      ),
                    ],

                    if(camNoteController.selectedIndexGenCibil.value==1)...[
                      CustomLabeledTextField(
                        label: AppText.fullName,
                        controller: camNoteController.camFullNameController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterFullName,
                        isRequired: true,
                        validator: ValidationHelper.validateName,
                      ),
                      CustomLabeledTextField(
                        label: AppText.panNumber,
                        isRequired: true,

                        controller: camNoteController.camPanController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterPan,
                        validator: ValidationHelper.validatePanCard,
                        maxLength: 10,
                        isCapital: true,
                      ),

                      CustomLabeledTextField(
                        label: AppText.phoneNumberNoStar,
                        isRequired: true,

                        controller: camNoteController.camCibilMobController,
                        inputType: TextInputType.phone,
                        hintText: AppText.enterPhNumber,
                        validator: ValidationHelper.validatePhoneNumber,
                        maxLength: 10,

                      ),
                    ]
                  ],
                ))


              ],
            ),
            onSubmit: () {
              if(camNoteController.selectedGenderGenCibil.value==null && camNoteController.selectedIndexGenCibil.value==0){
                SnackbarHelper.showSnackbar(title: "Incomplete Data", message: "Please select gender");
              }else if(camNoteController.selectedIndexGenCibil.value==0){
                camNoteController.generateCibilScoreByAadharApi(
                    fullName: camNoteController.camFullNameController.text.trim().toString(),
                    idNumber: camNoteController.camAadharController.text.trim().toString(),
                    mobile: camNoteController.camCibilMobController.text.trim().toString(),
                    gender: camNoteController.selectedGenderGenCibil.value.toString(),
                ); //
                // Close dialog after submission
              }else if(camNoteController.selectedIndexGenCibil.value==1){
                camNoteController.generateCibilScoreByPANApi(
                  fullName: camNoteController.camFullNameController.text.trim().toString(),
                  pan: camNoteController.camPanController.text.trim().toString(),
                  mobile: camNoteController.camCibilMobController.text.trim().toString(),
                ); //generateCibilScoreByPANApi
              // Close dialog after submission
              }else{

              }

              // Handle submission logic
            },
          );
        });

      },
    );
  }
*/


  void showDialogSendEmailCibil({
    required BuildContext context,
  }) {


    showDialog(
      context: context,
      builder: (context) {
        return CustomIconDialogBox(
          title: "Are you sure?",
          icon: Icons.info_outline,
          iconColor: AppColor.secondaryColor,
          description: AppText.reqCibilMsg,
          onYes: () {
            camNoteController.requestForFinancialServicesApi(leadId: camNoteController.getLeadId.toString());
          },
          onNo: () {

          },
        );
      },
    );
  }



  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: camNoteController.selectedGenderGenCibil.value,
          onChanged: (value) {
            camNoteController.selectedGenderGenCibil.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}
