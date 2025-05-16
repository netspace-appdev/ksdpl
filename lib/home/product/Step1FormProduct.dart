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
import '../../custom_widgets/CustomTextLabel.dart';

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    leadDDController.getProductListByBankIdApi(bankId: addProductController.selectedBank.value.toString());
                  }


                },
                onClear: (){
                  addProductController.selectedBank.value =  0;
                  addProductController.selectedBankBranch.value = 0;
                  addProductController.selectedProdTypeOrTypeLoan.value=0;
                  leadDDController.getAllBranchBIModel.value?.data?.clear(); // reset dependent dropdown
                  leadDDController.getAllKsdplProductModel.value?.data?.clear();
                  leadDDController.getAllKsdplProductApi();

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
              validator:  ValidationHelper.validateName,
            ),

            CustomLabeledTextField(
              label: AppText.bankerMobile,

              controller: addProductController.prodBankersMobController,
              inputType: TextInputType.number,
              hintText: AppText.enterBankerMobile,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.bankerWhatsapp,

              controller: addProductController.prodBankersWhatsappController,
              inputType: TextInputType.number,
              hintText: AppText.enterBankerWhatsapp,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            CustomLabeledTextField(
              label: AppText.minCibil,

              controller: addProductController.prodMinCibilController,
              inputType: TextInputType.number,
              hintText: AppText.enterBankerWhatsapp,
              validator:  ValidationHelper.validatePhoneNumber,
            ),

            const SizedBox(
              height: 20,
            ),

            CustomTextLabel(
              label: AppText.selectCollateralSecurityCategory,


            ),

            const SizedBox(height: 10),


            Obx((){
              if (leadDDController.isBranchLoading.value) {
                return  Center(child:CustomSkelton.leadShimmerList(context));
              }


              return CustomDropdown<bankBrach.Data>(
                items: leadDDController.getAllBranchBIModel.value?.data ?? [],
                getId: (item) => item.id.toString(),  // Adjust based on your model structure
                getName: (item) => item.branchName.toString(),
                selectedValue: leadDDController.getAllBranchBIModel.value?.data?.firstWhereOrNull(
                      (item) => item.id== addProductController.selectedBankBranch.value,
                ),
                onChanged: (value) {
                  addProductController.selectedBankBranch.value =  value?.id;
                },
                onClear: (){
                  addProductController.selectedBankBranch.value = 0;
                  leadDDController.getAllBranchBIModel.value?.data?.clear(); // reset dependent dropdown
                },
              );
            }),


            const SizedBox(height: 20),

            CustomLabeledTextField(
              label: AppText.collateralSecurityExcluded,

              controller: addProductController.prodCollateralSecurityExcludedController,
              inputType: TextInputType.name,
              hintText: AppText.enterCollateralSecurityExcluded,
              validator:  ValidationHelper.validateName,
            ),


            const SizedBox(
              height: 20,
            ),

            CustomTextLabel(
              label: AppText.selectIncomeType,


            ),

            const SizedBox(height: 10),


            Obx((){
              if (leadDDController.isBranchLoading.value) {
                return  Center(child:CustomSkelton.leadShimmerList(context));
              }


              return CustomDropdown<bankBrach.Data>(
                items: leadDDController.getAllBranchBIModel.value?.data ?? [],
                getId: (item) => item.id.toString(),  // Adjust based on your model structure
                getName: (item) => item.branchName.toString(),
                selectedValue: leadDDController.getAllBranchBIModel.value?.data?.firstWhereOrNull(
                      (item) => item.id== addProductController.selectedBankBranch.value,
                ),
                onChanged: (value) {
                  addProductController.selectedBankBranch.value =  value?.id;
                },
                onClear: (){
                  addProductController.selectedBankBranch.value = 0;
                  leadDDController.getAllBranchBIModel.value?.data?.clear(); // reset dependent dropdown
                },
              );
            }),


            const SizedBox(height: 20),

            CustomLabeledTextField(
              label: AppText.profileExcluded,

              controller: addProductController.prodProfileExcludedController,
              inputType: TextInputType.name,
              hintText: AppText.enterProfileExcluded,
              validator:  ValidationHelper.validateName,
            ),


          ],
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
