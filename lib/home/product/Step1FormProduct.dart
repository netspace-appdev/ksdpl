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
import '../../custom_widgets/CustomMultiSelectDropdown.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
class Step1FormProduct extends StatelessWidget {
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
          key: addProductController.stepFormKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 20,
              ),

              CustomTextLabel(
                label: AppText.ksdplProduct,
                isRequired: true,


              ),

              const SizedBox(height: 10),


              Obx((){
                if (leadDDController.isProductLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }


                return CustomDropdown<product.Data>(
                  items: leadDDController.getAllKsdplProductModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.productName.toString(),
                  selectedValue: leadDDController.getAllKsdplProductModel.value?.data?.firstWhereOrNull(
                        (item) => item.id == addProductController.selectedKsdplProduct.value,
                  ),
                  onChanged: (value) {
                    addProductController.selectedKsdplProduct.value =  value?.id;
                  },
                  onClear: (){
                    addProductController.selectedKsdplProduct.value =  null;
                  },
                );
              }),


              const SizedBox(height: 20),

              CustomTextLabel(
                label: AppText.bankNostar,


              ),

              const SizedBox(height: 10),


              Obx((){
                if (leadDDController.isBankLoading.value) {
                  return  Center(child:CustomSkelton.leadShimmerList(context));
                }


                return CustomDropdown<bank.Data>(
                  items: leadDDController.getAllBankModel.value?.data ?? [],
                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                  getName: (item) => item.bankName.toString(),
                  selectedValue: leadDDController.getAllBankModel.value?.data?.firstWhereOrNull(
                        (item) => item.id == addProductController.selectedBank.value,
                  ),
                  onChanged: (value) {

                    addProductController.selectedBank.value =  value?.id;


                    if( addProductController.selectedBank.value!=null){
                      leadDDController.getAllBranchByBankIdApi(bankId: addProductController.selectedBank.value.toString());

                    }


                  },
                  onClear: (){
                    addProductController.selectedBank.value =  0;
                    addProductController.selectedBankBranch.value = 0;
                    addProductController.selectedProdTypeOrTypeLoan.value=0;
                    leadDDController.getAllBranchBIModel.value?.data?.clear(); // reset dependent dropdown

                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),

              CustomLabeledTextField(
                label: AppText.bankerName,
                controller: addProductController.prodBankersNameController,
                inputType: TextInputType.name,
                hintText: AppText.enterBankerName,

              ),

              CustomLabeledTextField(
                label: AppText.bankerMobile,

                controller: addProductController.prodBankersMobController,
                inputType: TextInputType.number,
                hintText: AppText.enterBankerMobile,

              ),

              CustomLabeledTextField(
                label: AppText.bankerWhatsapp,

                controller: addProductController.prodBankersWhatsappController,
                inputType: TextInputType.number,
                hintText: AppText.enterBankerWhatsapp,

              ),

              CustomLabeledTextField(
                label: AppText.bankerEmail,

                controller: addProductController.prodBankersEmailController,
                inputType: TextInputType.emailAddress,
                hintText: AppText.enterBankerEmail,

              ),


              CustomLabeledTextField(
                label: AppText.minCibil,

                controller: addProductController.prodMinCibilController,
                inputType: TextInputType.number,
                hintText: AppText.enterBankerWhatsapp,

              ),


              CustomTextLabel(
                label: AppText.productSegment,
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
                        (item) => item.id == addProductController.selectedProductCategory.value,
                  ),
                  onChanged: (value) {
                    addProductController.selectedProductCategory.value =  value?.id;
                  },
                  onClear: (){
                    addProductController.selectedProductCategory.value = 0;
                    addProductController.productCategoryList.clear(); // reset dependent dropdown

                  },
                );
              }),

              const SizedBox(height: 20),


              CustomLabeledTextField(
                label: AppText.productName,
                isRequired: true,

                controller: addProductController.prodProductNameController,
                inputType: TextInputType.name,
                hintText: AppText.enterProductName,

              ),

              CustomTextLabel(
                label: AppText.selectCustomerCategory,


              ),

              const SizedBox(height: 10),


              MultiSelectDropdown<String>(
                items: addProductController.customerCategoryList,
                getId: (e) => e,
                getName: (e) => e,
                selectedValues: addProductController.selectedCustomerCategories.toList(), // or preselected values
                onChanged: (selectedList) {

                  addProductController.selectedCustomerCategories.assignAll(selectedList);
                },
              ),


              const SizedBox(height: 20),

              CustomTextLabel(
                label: AppText.selectCollateralSecurityCategory,


              ),

              const SizedBox(height: 10),


              MultiSelectDropdown<String>(
                items: addProductController.collSecCatList,
                getId: (e) => e,
                getName: (e) => e,
                selectedValues: addProductController.selectedCollSecCat.toList(), // or preselected values
                onChanged: (selectedList) {

                  addProductController.selectedCollSecCat.assignAll(selectedList);
                },
              ),


              const SizedBox(height: 20),

              CustomLabeledTextField(
                label: AppText.collateralSecurityExcluded,

                controller: addProductController.prodCollateralSecurityExcludedController,
                inputType: TextInputType.name,
                hintText: AppText.enterCollateralSecurityExcluded,

              ),


              const SizedBox(
                height: 20,
              ),

              CustomTextLabel(
                label: AppText.selectIncomeType,


              ),

              const SizedBox(height: 10),


              MultiSelectDropdown<String>(
                items: addProductController.incomeTypeList,
                getId: (e) => e,
                getName: (e) => e,
                selectedValues: addProductController.selectedIncomeType.toList(),
                onChanged: (selectedList) {

                  addProductController.selectedIncomeType.assignAll(selectedList);
                },
              ),


              const SizedBox(height: 20),

              CustomLabeledTextField(
                label: AppText.profileExcluded,

                controller: addProductController.prodProfileExcludedController,
                inputType: TextInputType.name,
                hintText: AppText.enterProfileExcluded,

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
