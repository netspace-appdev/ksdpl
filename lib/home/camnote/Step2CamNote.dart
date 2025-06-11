import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/custom_widgets/custom_photo_picker_widget.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/camnote/camnote_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
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
                     CustomLabeledTextField(
                       label: AppText.cibil,
                       controller: camNoteController.camCibilController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterCibilScore,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalLoanAvaileCibil,
                       controller: camNoteController.camTotalLoanAvailedController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalLoanAvaileCibil,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalLiveLoan,
                       controller: camNoteController.camTotalLiveLoanController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalLiveLoan,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalEmi,
                       controller: camNoteController.camTotalEmiController,
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
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalOverdueCases,
                       controller: camNoteController.camTotalOverdueCasesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterOverdueCases,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalOverdueAmountCibil,
                       controller: camNoteController.camTotalOverdueAmountController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterOverdueAmountCibil,
                     ),

                     CustomLabeledTextField(
                       label: AppText.totalEnquiries,
                       controller: camNoteController.camTotalEnquiriesController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterTotalEnquiries,
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

                      CustomLabeledTextField(
                        label: AppText.geoLocationProperty,
                        controller: camNoteController.camGeoLocationPropertyLatController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLatitude,
                      ),
                      CustomLabeledTextField(
                        label: "",
                        controller: camNoteController.camGeoLocationPropertyLongController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLongitude,
                      ),

                      CustomLabeledTextField(
                        label: AppText.geoLocationResidence,
                        controller: camNoteController.camGeoLocationResidenceLatController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLatitude,
                      ),
                      CustomLabeledTextField(
                        label: "",
                        controller: camNoteController.camGeoLocationResidenceLongController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLongitude,
                      ),

                      CustomLabeledTextField(
                        label: AppText.geoLocationOffice,
                        controller: camNoteController.camGeoLocationOfficeLatController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLatitude,
                      ),

                      CustomLabeledTextField(
                        label: "",
                        controller: camNoteController.camGeoLocationOfficeLongController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterLongitude,
                      ),

 /*                     const CustomTextLabel(
                        label: AppText.loanSegment,
                        isRequired: true,

                      ),

                      const SizedBox(height: 10),


                      Obx((){
                        if (addProductController.isLoadingProductCategory.value) {
                          return  Center(child:CustomSkelton.leadShimmerList(context));
                        }



                        return CustomDropdown<productCat.Data>(
                          items: addProductController.productCategoryList  ?? [],
                          getId: (item) => item.id.toString(),  // Adjust based on your model structure
                          getName: (item) => item.productCategoryName.toString(),
                          selectedValue: addProductController.productCategoryList.firstWhereOrNull(
                                (item) => item.id == camNoteController.selectedProductCategory.value,
                          ),
                          onChanged: (value) {
                            camNoteController.selectedProductCategory.value =  value?.id;
                          },
                          onClear: (){
                            camNoteController.selectedProductCategory.value = 0;
                            addProductController.productCategoryList.clear(); // reset dependent dropdown

                          },
                        );
                      }),

                      const SizedBox(height: 20),*/


                      CustomPhotoPickerWidget(
                        controller: camNoteController,
                        imageKey: 'property_photo',
                        label: 'Upload Property Photos',
                      ),

                      const SizedBox(height: 20,),

                      CustomPhotoPickerWidget(
                        controller: camNoteController,
                        imageKey: 'residence_photo',
                        label: 'Upload Residence Photos',
                      ),

                      const SizedBox(height: 20,),

                      CustomPhotoPickerWidget(
                        controller: camNoteController,
                        imageKey: 'office_photo',
                        label: 'Upload Office Photos',
                      ),

        /*              const CustomTextLabel(
                        label: AppText.loanProduct,
                        isRequired: true,

                      ),

                      const SizedBox(height: 10),


                      Obx((){
                        if (viewProductController.isMainListMoreLoading.value) {
                          return  Center(child:CustomSkelton.leadShimmerList(context));
                        }



                        return CustomDropdown<prod.Data>(
                          items: viewProductController.loanProductList?? [],
                          getId: (item) => item.id.toString(),  // Adjust based on your model structure
                          getName: (item) => item.product.toString(),
                          selectedValue: viewProductController.loanProductList.firstWhereOrNull(
                                (item) => item.id == camNoteController.selectedLoanProduct.value,
                          ),
                          onChanged: (value) {
                            camNoteController.selectedLoanProduct.value =  value?.id;
                          },
                          onClear: (){
                            camNoteController.selectedLoanProduct.value = 0;
                            viewProductController.loanProductList.clear(); // reset dependent dropdown

                          },
                        );
                      }),

                      const SizedBox(height: 20),


*/

                      const SizedBox(height: 20,),
                    ],
                  )


                ],
              ),

              ExpansionTile(
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
                      ),


                      CustomLabeledTextField(
                        label: AppText.nonEarningCustomerAge,
                        controller: camNoteController.camEarningCustomerAgeController,
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
                        controller: camNoteController.camLoanAmountRequestedController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterConsideredIncome,
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
                      ),

                      CustomLabeledTextField(
                        label: AppText.ltv,
                        controller: camNoteController.camLtvController,
                        inputType: TextInputType.number,
                        hintText: AppText.autoCalculatedLtv,
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

}
