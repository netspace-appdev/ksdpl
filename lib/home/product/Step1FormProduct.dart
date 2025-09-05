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
              CustomLabeledTextField(
                label: AppText.fromAmtRange,
                isRequired: true,
                controller: addProductController.prodFromAmtController,
                inputType: TextInputType.number,
                hintText: AppText.enterFromAmtRange,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.toAmtRange,
                isRequired: true,

                controller: addProductController.prodToAmtController,
                inputType: TextInputType.number,
                hintText: AppText.enterToAmtRange,
                validator:  ValidationHelper.validateName,
              ),


              CustomTextLabel(
                label: AppText.bankNostar,
                isRequired: true,

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
                maxLength: 10,
                controller: addProductController.prodBankersMobController,
                inputType: TextInputType.number,
                hintText: AppText.enterBankerMobile,

              ),

              CustomLabeledTextField(
                label: AppText.bankerWhatsapp,
                maxLength: 10,
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
                label: AppText.superiorName,
                controller: addProductController.prodBankerSuperiorNameController,
                inputType: TextInputType.name,
                hintText: AppText.enterSuperiorName,

              ),

              CustomLabeledTextField(
                label: AppText.superiorMobile,
                controller: addProductController.prodBankerSuperiorMobController,
                inputType: TextInputType.number,
                hintText: AppText.enterSuperiorMobile,
                maxLength: 10,

              ),

              CustomLabeledTextField(
                label: AppText.superiorWhatsapp,
                controller: addProductController.prodBankerSuperiorWhatsappController,
                inputType: TextInputType.number,
                hintText: AppText.enterSuperiorWhatsapp,
                maxLength: 10,


              ),

              CustomLabeledTextField(
                label: AppText.superiorEmail,
                controller: addProductController.prodBankerSuperiorEmailController,
                inputType: TextInputType.emailAddress,
                hintText: AppText.enterSuperiorEmail,

              ),




              CustomLabeledTextField(
                label: AppText.minCibil,

                controller: addProductController.prodMinCibilController,
                inputType: TextInputType.number,
                hintText: AppText.enterMinCibil,

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



            Obx(() {
              final values = addProductController.selectedCustomerCategories.toList();
              final customerList = addProductController.customerCategoryList;

              final isAllSelected = Set.from(values).containsAll(customerList);

              final controlOption = isAllSelected ? "Deselect All" : "Select All";

              final allItems = [controlOption, ...customerList];

              return MultiSelectDropdown<String>(
                key: ValueKey(values.join(',')),
                items: allItems,
                getId: (e) => e,
                getName: (e) => e,
                selectedValues: values, // ← DO NOT include controlOption here!
                onChanged: (selectedList) {
                  if (selectedList.contains("Select All")) {
                    addProductController.selectedCustomerCategories
                        .assignAll(customerList);
                  } else if (selectedList.contains("Deselect All")) {
                    addProductController.selectedCustomerCategories.clear();
                  } else {
                    addProductController.selectedCustomerCategories
                        .assignAll(selectedList.where((e) => e != "Select All" && e != "Deselect All"));
                  }
                },
              );
            }),




            const SizedBox(height: 20),

              CustomTextLabel(
                label: AppText.selectCollateralSecurityCategory,


              ),

              const SizedBox(height: 10),


            /*  Obx(() {
                final values = addProductController.selectedCollSecCat.toList();
                return MultiSelectDropdown<String>(
                  key: ValueKey(values.join(',')), // 👈 Force widget to rebuild when selection changes
                  items: addProductController.collSecCatList.toList(),
                  getId: (e) => e,
                  getName: (e) => e,
                  selectedValues: values,
                  onChanged: (selectedList) {
                    addProductController.selectedCollSecCat.assignAll(selectedList);
                  },
                );
              }),
*/


            Obx(() {
              final values = addProductController.selectedCollSecCat.toList();
              final catList = addProductController.collSecCatList;

              final isAllSelected = Set.from(values).containsAll(catList);
              final controlOption = isAllSelected ? "Deselect All" : "Select All";
              final allItems = [controlOption, ...catList];

              return MultiSelectDropdown<String>(
                key: ValueKey(values.join(',')), // 👈 Force widget to rebuild when selection changes
                items: allItems,
                getId: (e) => e,
                getName: (e) => e,
                selectedValues: values, // Don’t include Select/Deselect All in selected list!
                onChanged: (selectedList) {
                  if (selectedList.contains("Select All")) {
                    addProductController.selectedCollSecCat.assignAll(catList);
                  } else if (selectedList.contains("Deselect All")) {
                    addProductController.selectedCollSecCat.clear();
                  } else {
                    addProductController.selectedCollSecCat.assignAll(
                      selectedList.where((e) => e != "Select All" && e != "Deselect All"),
                    );
                  }
                },
              );
            }),


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

              Obx(() {
                final values = addProductController.selectedIncomeType.toList();
                final incomeTypeList = addProductController.incomeTypeList;

                final isAllSelected = Set.from(values).containsAll(incomeTypeList);
                final controlOption = isAllSelected ? "Deselect All" : "Select All";
                final allItems = [controlOption, ...incomeTypeList];

                return MultiSelectDropdown<String>(
                  key: ValueKey(values.join(',')), // Force rebuild to reflect changes
                  items: allItems,
                  getId: (e) => e,
                  getName: (e) => e,
                  selectedValues: values, // Don't include "Select All"/"Deselect All" in selected values
                  onChanged: (selectedList) {
                    if (selectedList.contains("Select All")) {
                      addProductController.selectedIncomeType.assignAll(incomeTypeList);
                    } else if (selectedList.contains("Deselect All")) {
                      addProductController.selectedIncomeType.clear();
                    } else {
                      addProductController.selectedIncomeType.assignAll(
                        selectedList.where((e) => e != "Select All" && e != "Deselect All"),
                      );
                    }
                  },
                );
              }),


              const SizedBox(height: 20),




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
