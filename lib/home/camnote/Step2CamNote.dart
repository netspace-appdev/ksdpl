import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/custom_widgets/custom_photo_picker_widget.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/camnote/camnote_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
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


                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                title:const Text( AppText.sectionA, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                leading: Icon(Icons.list_alt, size: 20,),
                children: [

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
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
                       label: AppText.cibil,
                       controller: camNoteController.camCibilController,
                       inputType: TextInputType.number,
                       hintText: AppText.enterCibilScore,
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


                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                title:const Text(AppText.sectionB, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                leading: Icon(Icons.list_alt, size: 20,),
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomTextLabel(
                        label: AppText.loanSegment,
                        isRequired: true,

                      ),

                      const SizedBox(height: 10),


                      Obx((){
                        if (addProductController.isLoadingProductCategory.value) {
                          return  Center(child:CustomSkelton.leadShimmerList(context));
                        }
                        print("prod cat list in obx=-=====>${ addProductController.productCategoryList.toString()}");


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

                      const SizedBox(height: 20),


                      CustomTextLabel(
                        label: AppText.loanProduct,
                        isRequired: true,

                      ),

                      const SizedBox(height: 10),


                      Obx((){
                        if (viewProductController.isMainListMoreLoading.value) {
                          return  Center(child:CustomSkelton.leadShimmerList(context));
                        }
                        print("prod cat list in obx=-=====>${ viewProductController.loanProductList.toString()}");


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

                      CustomLabeledTextField(
                        label: AppText.offeredSecurityType,
                        controller: camNoteController.camOfferedSecurityTypeController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterSecurityType,
                      ),

                      CustomLabeledTextField(
                        label: AppText.geoLocationProperty,
                        controller: camNoteController.camGeoLocationPropertyController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterGeoLocationProperty,
                      ),

                      CustomLabeledTextField(
                        label: AppText.geoLocationOffice,
                        controller: camNoteController.camGeoLocationOfficeController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterGeoLocationOffice,
                      ),

                      CustomPhotoPickerWidget(
                        controller: camNoteController,
                        imageKey: 'property_photo',
                        label: 'Upload Property Photo',
                      ),

                      SizedBox(height: 20),

                      CustomPhotoPickerWidget(
                        controller: camNoteController,
                        imageKey: 'residence_photo',
                        label: 'Upload Residence Photo',
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
  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: camNoteController.selectedGender.value,
          onChanged: (value) {
            camNoteController.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}
