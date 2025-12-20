import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:ksdpl/controllers/new_dd_controller.dart';
import 'package:lottie/lottie.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/camnote/camnote_controller.dart';
import '../../controllers/lead_dd_controller.dart';

import '../../controllers/leads/leadlist_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomIconDilogBox.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLabeledTextField2.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart' as customTF;
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/camnote/GetAllPrimeSecurityMasterModel.dart' as primeSecurity;

class Step2CamNote extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  final CamNoteController camNoteController =Get.find();
  final AddProductController addProductController =Get.find();
  final ViewProductController viewProductController = Get.put(ViewProductController());
  final NewDDController newDDController = Get.find();
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

              ///Section A
              ExpansionTile(
                initiallyExpanded: true,


                childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                title:const Text( AppText.section1, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                leading: const Icon(Icons.list_alt, size: 20,),
                children: [

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Text(AppText.downloadCibil, style: TextStyle(color: AppColor.secondaryColor, fontSize: 16, fontWeight: FontWeight.w500),),
                         _buildIconButtonDownload(
                           icon: AppImage.downloadImg,
                           disableIcon: AppImage.downloadImg_disable,
                           context: context,
                           url: camNoteController.cibilJsonPdfUrl.value
                         ),
                       ],
                     ),
                     const SizedBox(
                       height: 20,
                     ),

                     const Text(AppText.CIBIL_REPORT_OVERVIEW, style: TextStyle(color: AppColor.secondaryColor, fontSize: 16, fontWeight: FontWeight.w500),),
                     SizedBox(height: 20,),
                        Column(
                       children: [
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Expanded(
                               child: Wrap(
                                 spacing: 10, // gap between items
                                 runSpacing: 5, // gap between lines if wrapped
                                 crossAxisAlignment: WrapCrossAlignment.center,
                                 children: [
                                   const Text(
                                     AppText.cibil,
                                     style: TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.bold,
                                       color: AppColor.grey2,
                                     ),
                                   ),
                                   if(camNoteController.enableAllCibilFields.value)
                                   if (camNoteController.isGenerateCibilVisible.value)
                                     InkWell(
                                       onTap: () {
                                         camNoteController.selectedIndexGenCibil.value = -1;
                                         camNoteController.camCibilMobController.text =
                                             camNoteController.camPhoneController.text;
                                         camNoteController.selectedGenderGenCibil.value =
                                             camNoteController.selectedGender.value;
                                         showDialogSendEmailCibil(context: context);
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


                     //New
                     CustomLabeledTextField(
                       label: AppText.totalLiveLoanAvailedOnCibil,
                       controller: camNoteController.camTotalLiveLoanAvailedOnCibilController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalLiveLoanAvailedOnCibil,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),


                     CustomLabeledTextField(
                       label: AppText.closedCases,
                       controller: camNoteController.camClosedCasesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterClosedCases,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.closedAmount,
                       controller: camNoteController.camClosedAmountController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterClosedAmount,
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
                       label: AppText.currentBalance,
                       controller: camNoteController.camCurrentBalanceController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterCurrentBalance,
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
                       label: AppText.writtenOffCases,
                       controller: camNoteController.camWrittenOffCasesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterWrittenOffCases,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),
                     CustomLabeledTextField(
                       label: AppText.writtenOffAmount,
                       controller: camNoteController.camWrittenOffAmountController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterWrittenOffAmount,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),
                     CustomLabeledTextField(
                       label: AppText.settlementCases,
                       controller: camNoteController.camSettlementCasesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterSettlementCases,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.settlementAmount,
                       controller: camNoteController.camSettlementAmountController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterSettlementAmount,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.suitFiledWillfulDefaultCases,
                       controller: camNoteController.camSuitFiledWillfulDefaultCasesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterSuitFiledWillfulDefaultCases,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                     CustomLabeledTextField(
                       label: AppText.suitFiledWillfulDefaultAmount,
                       controller: camNoteController.camSuitFiledWillfulDefaultAmountController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterSuitFiledWillfulDefaultAmount,
                       isInputEnabled: camNoteController.enableAllCibilFields.value,
                     ),

                    /* CustomLabeledTextField(
                       label: AppText.totalEnquiries,
                       controller: camNoteController.camTotalEnquiriesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalEnquiries,
                       isInputEnabled:camNoteController.enableAllCibilFields.value,
                     ),*/
                   ],
                 )


                ],
              ),


              ///Section B
              ExpansionTile(
                initiallyExpanded: true,


                childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                title:const Text( AppText.section2, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                leading: const Icon(Icons.list_alt, size: 20,),
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppText.LOAN_REPAYMENT_HISTORY, style: TextStyle(color: AppColor.secondaryColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      SizedBox(height: 20,),

                      CustomLabeledTextField(
                        label: AppText.standardCases,
                        controller: camNoteController.camStandardCountController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterStandardCases,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),
                      CustomLabeledTextField(
                        label: AppText.doubtfulCases,
                        controller: camNoteController.camDoubtfulCountController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterDoubtfulCases,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),
                      CustomLabeledTextField(
                        label: AppText.numberOfDaysPastDueCount,
                        controller: camNoteController.camNumberOfDaysPastDueCountController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterNumberOfDaysPastDueCount,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),

                      CustomLabeledTextField(
                        label: AppText.specialMentionAccountCount,
                        controller: camNoteController.camSpecialMentionAccountCountController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterSpecialMentionAccountCount,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),
                      CustomLabeledTextField(
                        label: AppText.lossCases,
                        controller: camNoteController.camLossCountController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLossCases,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),
                      CustomLabeledTextField(
                        label: AppText.npt,
                        controller: camNoteController.camNptController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterNpt,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),

                      CustomLabeledTextField(
                        label: AppText.substandardCases,
                        controller: camNoteController.camSubstandardCountController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterSubstandardCases,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),

                      CustomLabeledTextField(
                        label: AppText.totalCases,
                        controller: camNoteController.camTotalCountsController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterTotalCases,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),
                      ///ends
                      /*CustomLabeledTextField(
                        label: AppText.totalSanctionedAmount,
                        controller: camNoteController.camTotalSanctionedAmountController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterTotalSanctionedAmount,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),

                      CustomLabeledTextField(
                        label: AppText.emisOfExistingLiabilities,
                        controller: camNoteController.camEmisOfExistingLiabilitiesController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterEmisOfExistingLiabilities,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),*/


                    ],
                  )


                ],
              ),

              /// Section C
              /*ExpansionTile(
                initiallyExpanded: true,


                childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                title:const Text(AppText.sectionC, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
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

                      CustomLabeledTextField2(
                        label: AppText.incomeCanBeConsidered,
                        controller: camNoteController.camIncomeCanBeConsideredController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterConsideredIncome,
                        isInputEnabled: true,
                        isRequired: false,
                        onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },
                      ),

                      CustomLabeledTextField2(
                        label: AppText.loanAmountRequested,
                        controller: camNoteController.camLoanAmtReqController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterConsideredIncome,
                        isInputEnabled: false,
                        isRequired: false,
                        onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },
                      ),

                      CustomLabeledTextField2(
                        label: AppText.loanTenorRequested,
                        controller: camNoteController.camLoanTenorRequestedController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLoanTenorRequested,
                        isRequired: false,
                        isInputEnabled: true,
                        onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },
                      ),

                      CustomLabeledTextField2(
                        label: AppText.rateOfInterest,
                        controller: camNoteController.camRateOfInterestController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterRateOfInterest,
                        isRequired: false,
                        isInputEnabled: true,
                        onChanged: (value){
                          ValidationHelper.validatePercentageInput(
                            controller:  camNoteController.camRateOfInterestController,
                            value: value,
                            maxValue: 100,
                            errorMessage: "The rate of interest (ROI) should not be more than 100 %",
                          );
                          camNoteController.calculateLoanDetails();
                        },
                      ),

                      CustomLabeledTextField(
                        label: AppText.proposedEmi,
                        controller: camNoteController.camProposedEmiController,
                        inputType: TextInputType.number,
                        hintText: AppText.autoCalculatedProposedEmi,
                       isInputEnabled: false,
                      ),

                      CustomLabeledTextField2(
                        label: AppText.propertyValue,
                        controller: camNoteController.camPropertyValueController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterPropertyValue,
                        isInputEnabled: true,
                        isRequired: false,
                        onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },
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

                     */


              /* CustomLabeledTextField(
                        label: AppText.offeredSecurityType,
                        controller: camNoteController.camOfferedSecurityTypeController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterSecurityType,
                      ),*/

              /*
                      const SizedBox(
                        height: 20,
                      ),

                      CustomTextLabel(
                        label: AppText.offeredSecurityType,
                        isRequired: camNoteController.isOfferedSecurityMandatory.value?true:false,
                      ),

                      const SizedBox(height: 10),

                      Obx((){
                        if (newDDController.isPrimeSecurityLoading.value) {
                          return  Center(child:CustomSkelton.leadShimmerList(context));
                        }


                        return CustomDropdown<primeSecurity.Data>(
                          items: newDDController.primeSecurityList.value ?? [],
                          getId: (item) => item.id.toString(),  // Adjust based on your model structure
                          getName: (item) => item.description.toString(),
                         */


              /* selectedValue: newDDController.primeSecurityList.value.firstWhereOrNull(
                                (item) => item.description == camNoteController.camOfferedSecurityTypeController.text,
                          ),*/

              /*
                          selectedValue: newDDController.primeSecurityList.value.firstWhereOrNull(
                                (item) =>
                            item.description?.trim().toLowerCase() ==
                                camNoteController.camOfferedSecurityTypeController.text.trim().toLowerCase(),
                          ),
                          onChanged: (value) {
                            camNoteController.camOfferedSecurityTypeController.text =  value?.description??"";
                            print("camNoteController.camOfferedSecurityTypeController.text===>${ camNoteController.camOfferedSecurityTypeController.text}");

                          },
                          onClear: (){
                            camNoteController.camOfferedSecurityTypeController.clear();
                          },
                        );
                      }),

                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  )


                ],
              ),*/

              /// section 3 - retail account list

              ExpansionTile(
                initiallyExpanded: true,


                childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                title:const Text(AppText.section3, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                leading: const Icon(Icons.list_alt, size: 20,),
                children: [
                  const Text(AppText.obligation, style: TextStyle(color: AppColor.secondaryColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  const Text(AppText.loanAccountSummary, style: TextStyle(color: AppColor.primaryColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      accountSection(context),
                      CustomLabeledTextField(
                        label: AppText.currentlyCasesBeingServed,
                        controller: camNoteController.camCurrentlyCasesBeingServedController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterCurrentlyCasesBeingServed,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),

                      CustomLabeledTextField(
                        label: AppText.casesToBeForeclosedOnOrBeforeDisb,
                        controller: camNoteController.camCasesToBeForeclosedOnOrBeforeDisbController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterCasesToBeForeclosedOnOrBeforeDisb,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),

                      CustomLabeledTextField(
                        label: AppText.casesToBeContenued,
                        controller: camNoteController.camCasesToBeContenuedController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterCasesToBeContenued,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),

                      CustomLabeledTextField(
                        label: AppText.totalEnquiriesWithin12months,
                        controller: camNoteController.camTotalEnquiriesWithin12monthsCibilController,
                        inputType: TextInputType.number,
                        hintText: AppText.entertotalEnquiriesWithin12months,
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
                        isRequired: false,
                        isInputEnabled:camNoteController.enableAllCibilFields.value,
                      /*  onChanged: (value) {
                          camNoteController.calculateEmilWillContinue();
                        },*/
                      ),

                      CustomLabeledTextField(
                        label: AppText.emiWillContinue,
                        controller: camNoteController.camEmiWillContinueController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterEmiWillContinue,
                        isInputEnabled:camNoteController.enableAllCibilFields.value,
                        isRequired: false,

                      /*  onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },*/

                      ),

                      CustomLabeledTextField2(
                        label: AppText.EMIsCcasesNotReflecting,
                        controller: camNoteController.camEMIsCcasesNotReflectingCibilController,
                        isInputEnabled: true,
                        inputType: TextInputType.number,
                        hintText: AppText.enterEMIsCcasesNotReflecting,
                        isRequired: false,

                        onChanged: (value) {
                          camNoteController.calculateEMIWIllContAfterNotReflecting();
                        },
                      ),
                    ],
                  )


                ],
              ),


              /// Section D
              ExpansionTile(
                initiallyExpanded: true,


                childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                title:const Text(AppText.section4, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                leading: const Icon(Icons.list_alt, size: 20,),
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppText.LOAN_SYNOPSIS, style: TextStyle(color: AppColor.secondaryColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      SizedBox(height: 20,),

                      CustomTextLabel(
                        label: AppText.offeredSecurityType,
                        isRequired: camNoteController.isOfferedSecurityMandatory.value?true:false,
                      ),

                      const SizedBox(height: 10),

                      Obx((){
                        if (newDDController.isPrimeSecurityLoading.value) {
                          return  Center(child:CustomSkelton.leadShimmerList(context));
                        }


                        return CustomDropdown<primeSecurity.Data>(
                          items: newDDController.primeSecurityList.value ?? [],
                          getId: (item) => item.id.toString(),  // Adjust based on your model structure
                          getName: (item) => item.description.toString(),
                          /* selectedValue: newDDController.primeSecurityList.value.firstWhereOrNull(
                                (item) => item.description == camNoteController.camOfferedSecurityTypeController.text,
                          ),*/
                          selectedValue: newDDController.primeSecurityList.value.firstWhereOrNull(
                                (item) =>
                            item.description?.trim().toLowerCase() ==
                                camNoteController.camOfferedSecurityTypeController.text.trim().toLowerCase(),
                          ),
                          onChanged: (value) {
                            camNoteController.camOfferedSecurityTypeController.text =  value?.description??"";
                            print("camNoteController.camOfferedSecurityTypeController.text===>${ camNoteController.camOfferedSecurityTypeController.text}");

                          },
                          onClear: (){
                            camNoteController.camOfferedSecurityTypeController.clear();
                          },
                        );
                      }),

                      const SizedBox(
                        height: 20,
                      ),
                      CustomLabeledTextField2(
                        label: AppText.propertyValue,
                        controller: camNoteController.camPropertyValueController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterPropertyValue,
                        isInputEnabled: true,
                        isRequired: false,
                        onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },
                      ),
                      CustomLabeledTextField2(
                        label: AppText.loanTenorRequested,
                        controller: camNoteController.camLoanTenorRequestedController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLoanTenorRequested,
                        isRequired: false,
                        isInputEnabled: true,
                        onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },
                      ),

                      CustomLabeledTextField(
                        label: AppText.ltv,
                        controller: camNoteController.camLtvController,
                        inputType: TextInputType.number,
                        hintText: AppText.autoCalculatedLtv,
                        isInputEnabled: false,
                      ),

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
                        label: AppText.totalFamilyIncome,
                        controller: camNoteController.camTotalFamilyIncomeController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterTotalFamilyIncome,
                      ),

                      CustomLabeledTextField2(
                        label: AppText.incomeCanBeConsidered,
                        controller: camNoteController.camIncomeCanBeConsideredController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterConsideredIncome,
                        isInputEnabled: true,
                        isRequired: false,
                        onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },
                      ),

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


                      CustomLabeledTextField2(
                        label: AppText.loanAmountRequested,
                        controller: camNoteController.camLoanAmtReqController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterConsideredIncome,
                        isInputEnabled: false,
                        isRequired: false,
                        onChanged: (value) {
                          camNoteController.calculateLoanDetails();
                        },
                      ),

                      CustomLabeledTextField2(
                        label: AppText.rateOfInterest,
                        controller: camNoteController.camRateOfInterestController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterRateOfInterest,
                        isRequired: false,
                        isInputEnabled: true,
                        onChanged: (value){
                          ValidationHelper.validatePercentageInput(
                            controller:  camNoteController.camRateOfInterestController,
                            value: value,
                            maxValue: 100,
                            errorMessage: "The rate of interest (ROI) should not be more than 100 %",
                          );
                          camNoteController.calculateLoanDetails();
                        },
                      ),

                      CustomLabeledTextField(
                        label: AppText.proposedEmi,
                        controller: camNoteController.camProposedEmiController,
                        inputType: TextInputType.number,
                        hintText: AppText.autoCalculatedProposedEmi,
                        isInputEnabled: false,
                      ),

                      CustomLabeledTextField(
                        label: AppText.iir,
                        controller: camNoteController.camIirController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterIir,
                        isInputEnabled: camNoteController.enableAllCibilFields.value,
                      ),

                      CustomLabeledTextField(
                        label: AppText.foir,
                        controller: camNoteController.camFoirController,
                        inputType: TextInputType.number,
                        hintText: AppText.autoCalculatedFoir,
                        isInputEnabled: false,
                      ),



                      const SizedBox(
                        height: 20,
                      ),

                    ],
                  )


                ],
              ),
              const SizedBox(
                height: 90,
              ),

            ],
          ),
        );
      }),
    );
  }





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

  Widget _noDataCard(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(10),
          //   border: Border.all(color: AppColor.grey4, width: 1),

        ),
        child:  Center(

          child: Column(
            children: [
              Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Lottie.asset(
                      AppImage.empty,
                      repeat: false
                  )),
              Text(
                  "No data Found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey1,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountSection(BuildContext context){

      if ( camNoteController.retailAccountList.isEmpty) {
        return  Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration:  BoxDecoration(
            border: Border.all(color: AppColor.grey200),
            color: AppColor.appWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),

          ),
          child:  Column(

            children: [
              /// Header with profile and menu icon
              _noDataCard(context)

            ],
          ),
        );
      }

      return  SizedBox(
        height: 450,
        child: ListView.builder(
          itemCount:camNoteController.retailAccountList.length??0,//
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,   // 👈 Add this
          //physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {


            final item = camNoteController.retailAccountList[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width * 0.60, // 👈 card width

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               /*   buildCardOuter("#${index+1}", [
                    DetailRow2(label: AppText.institution, value: item.institution??""),
                    DetailRow2(label: AppText.prodType, value:  item.accountType??""),
                    DetailRow2(label: AppText.status, value:  item.open=="Yes"?"Live":"Closed"),
                    SizedBox(height: 10,),
                    item.open=="Yes"?
                    Row(
                      children: [
                        Obx(() => Checkbox(
                          value: item.isSelected.value,
                          onChanged: (val) {
                            item.isSelected.value = val ?? false;
                            camNoteController.updateSelectedRanks();
                          },
                        )),
                        const Text(AppText.markForForeclosure, style: TextStyle(color: AppColor.secondaryColor,),),
                      ],
                    ):Container(),
                    SizedBox(height: 10,),
                    _buildTextButton("View", context, Colors.pink, Icons.insert_drive_file, "0",item),
                  ],
                      Icons.info_outline

                  ),*/

                  Container(
                    height: 430,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.grey4, width: 1),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon( Icons.info_outline, color: Colors.white),
                              const SizedBox(width: 5),
                              Text(
                                "#${index+1}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Scrollable content
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: ListView(
                              children: [
                                DetailRow2(label: AppText.institution, value: item.institution??""),
                                DetailRow2(label: AppText.prodType, value:  item.accountType??""),
                                DetailRow2(label: AppText.status, value:  item.open=="Yes"?"Live":"Closed"),

                              ],
                            ),
                          ),
                        ),

                        // Fixed Footer
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  item.open=="Yes"?
                                  Row(
                                    children: [
                                      Obx(() => Checkbox(
                                        value: item.isSelected.value,
                                        onChanged: (val) {
                                          item.isSelected.value = val ?? false;
                                          camNoteController.updateSelectedRanks();
                                        },
                                      )),
                                      const Text(AppText.markForForeclosure, style: TextStyle(color: AppColor.secondaryColor,),),
                                    ],
                                  ):Container(),

                                  SizedBox(height: 10,),

                                ],
                              ),
                              _buildTextButton("View", context, Colors.pink, Icons.insert_drive_file, "0",item),
                            ],
                          ),

                        ),
                      ],
                    ),
                  )

                ],
              ),
            );

          },
        ),
      );

  }

  Widget _buildDetailRow(String label, String value) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 85,

            child: Text(
              "$label",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.primaryLight,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label=="Assigned" ||  label=="Uploaded on"?": ${ Helper.formatDate(value)}":  ":  ${value=="null"?"":value}",

              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, List<Widget> children, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: AppColor.grey4, width: 1),


      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColor.primaryColor, // Blue background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white,),
                SizedBox(width: 5,),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardOuter(String title, List<Widget> children, IconData icon) {
    return Container(
      height: 430,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: AppColor.grey4, width: 1),


      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColor.primaryColor, // Blue background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white,),
                SizedBox(width: 5,),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextButton(String label, BuildContext context, Color color, IconData icon, String id, CibilAccount item) {
    return GestureDetector(
      onTap: () {
        showFilterDialog(context: context, item: item);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //width: MediaQuery.of(context).size.width*0.20,

            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.grey700)

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.blackColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void showFilterDialog({
    required BuildContext context,
    required CibilAccount item,
  })
  {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "",
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(Get.context!).size.height * 0.7, // Prevents overflow
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCard("Account Details", [
                        DetailRow(label: AppText.institution, value: item.institution??""),
                        DetailRow(label: AppText.loanAccountNumber, value: item.accountNumber??""),
                        DetailRow(label: AppText.prodType, value:  item.accountType??""),
                        DetailRow(label: AppText.ownershipType, value:  item.ownershipType??""),
                        DetailRow(label: AppText.status, value:  item.open=="Yes"?"Live":"Closed"),
                        DetailRow(label: AppText.sanctionAmount, value:  item.sanctionAmount??""),
                        DetailRow(label: AppText.principalOutstanding, value:  item.balance??""),
                        DetailRow(label: AppText.installmentAmount, value:  item.installmentAmount??""),
                        DetailRow(label: AppText.DPD, value:  ""),
                        DetailRow(label: AppText.postDueAmount, value: item.pastDueAmount??""),

                      ],
                          Icons.info_outline

                      ),


                      SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
          ),
          submitButtonText: "Ok, Got it",
          onSubmit: () {
            Navigator.pop(context);
            // Handle submission logic
          },
        );
      },
    );
  }

  Widget _buildIconButtonDownload({
    required String icon,
    required String disableIcon,
    required BuildContext context,
    String ? url,
  })
  {
    return IconButton(
      onPressed:url==null || url==""?null: () {
        print("button tapped===>${url}");
        LeadListController leadListController=Get.find();
        leadListController.launchInBrowser(url??"");
      },

      icon: Container(
        width: 50,

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration:  BoxDecoration(
          border: Border.all(color: AppColor.secondaryColor),
          color: AppColor.appWhite,
          borderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),

        ),
        child: Center(
          // child: Icon(icon, color: color),
          child: url==null || url=="" ?Image.asset(disableIcon, height: 12,) :Image.asset(icon, height: 12,),
        ),
      ),
    );
  }
}
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor
            ),
          ),
          const SizedBox(height: 4),
          value=="null" || value==AppText.customdash?
          Row(


            children: [
              Icon(Icons.horizontal_rule, size: 15,),
            ],):
          Text(
            value,
            style:  TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: value=="Live"? Colors.green:value=="Closed"?Colors.red: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}


class DetailRow2 extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow2({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor
            ),
          ),
          const SizedBox(height: 4),
          value=="null" || value==AppText.customdash?
          Row(


            children: [
              Icon(Icons.horizontal_rule, size: 15,),
            ],):
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style:  TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: value=="Live"? Colors.green:value=="Closed"?Colors.red: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}