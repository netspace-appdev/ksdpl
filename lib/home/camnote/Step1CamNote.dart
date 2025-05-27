import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import '../../custom_widgets/CustomMultiSelectDropdown.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart' as state;
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;

class Step1CamNote extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  final CamNoteController camNoteController =Get.find();
  Addleadcontroller addleadcontroller = Get.find();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Obx((){
        if( camNoteController.isLoadingMainScreen.value)
          return Center(
            child: CustomSkelton.productShimmerList(context),
          );
        return Form(
          key: camNoteController.stepFormKeys[0],
          child: Obx((){
            if (addleadcontroller.isLoading.value) {
              return  Center(child: CustomSkelton.productShimmerList(context));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Prevents extra spacing
              children: [
                const SizedBox(
                  height: 10,
                ),

                CustomLabeledTextField(
                  label: AppText.fullName,
                  isRequired: true,
                  controller: addleadcontroller.fullNameController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterFullName,
                  validator:  ValidationHelper.validateName,
                ),

                CustomLabeledPickerTextField(
                  label: AppText.dateOfBirth,
                  isRequired: true,
                  controller: addleadcontroller.dobController,
                  inputType: TextInputType.name,
                  hintText: AppText.mmddyyyy,
                  validator: ValidationHelper.validateDob,
                  isDateField: true,
                ),

                CustomLabeledTextField(
                  label: AppText.phoneNumberNoStar,
                  isRequired: true,
                  controller: addleadcontroller.phoneController,
                  inputType: TextInputType.phone,
                  hintText: AppText.enterPhNumber,
                  validator: ValidationHelper.validatePhoneNumber,
                  maxLength: 10,
                ),
                const SizedBox(height: 10),
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

                const SizedBox(height: 20),


                CustomLabeledTextField(
                  label: AppText.lar,
                  isRequired: true,
                  controller: addleadcontroller.loanAmtReqController,
                  inputType: TextInputType.phone,
                  hintText: AppText.enterLar,
                  validator: ValidationHelper.validateLoanAmt,
                ),

                CustomLabeledTextField(
                  label: AppText.eml,
                  isRequired: false,
                  controller: addleadcontroller.emailController,
                  inputType: TextInputType.emailAddress,
                  hintText: AppText.enterEA,
                  validator: ValidationHelper.validateEmail,
                ),

                CustomLabeledTextField(
                  label: AppText.aadhar,
                  isRequired: false,
                  controller: addleadcontroller.aadharController ,
                  inputType: TextInputType.phone,
                  hintText: AppText.enterAadhar,
                  maxLength: 12,

                ),

                CustomLabeledTextField(
                  label: AppText.panNumber,
                  isRequired: false,
                  controller: addleadcontroller.panController ,
                  inputType: TextInputType.name,
                  hintText: AppText.enterPan,
                  validator: ValidationHelper.validatePanCard,
                  maxLength: 10,

                ),

                CustomLabeledTextField(
                  label: AppText.streetAdd,
                  isRequired: false,
                  controller: addleadcontroller.streetAddController ,
                  inputType: TextInputType.name,
                  hintText: AppText.enterStreetAdd,

                ),

                const Text(
                  AppText.state,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
                ),

                SizedBox(height: 10),


                Obx((){
                  if (leadDDController.isStateLoading.value) {
                    return  Center(child:CustomSkelton.leadShimmerList(context));
                  }

                  return CustomDropdown<state.Data>(
                    items: leadDDController.getAllStateModel.value?.data ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.stateName.toString(),
                    selectedValue: leadDDController.getAllStateModel.value?.data?.firstWhereOrNull(
                          (item) => item.id.toString() == leadDDController.selectedState.value,
                    ),
                    onChanged: (value) {
                      leadDDController.selectedState.value =  value?.id?.toString();
                      leadDDController.getDistrictByStateIdApi(stateId: leadDDController.selectedState.value);
                    },
                  );
                }),

                const SizedBox(height: 20),

                const Text(
                  AppText.district,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
                ),

                const SizedBox(height: 10),


                Obx((){
                  if (leadDDController.isDistrictLoading.value) {
                    return  Center(child:CustomSkelton.leadShimmerList(context));
                  }


                  return CustomDropdown<dist.Data>(
                    items: leadDDController.getDistrictByStateModel.value?.data ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.districtName.toString(),
                    selectedValue: leadDDController.getDistrictByStateModel.value?.data?.firstWhereOrNull(
                          (item) => item.id.toString() == leadDDController.selectedDistrict.value,
                    ),
                    onChanged: (value) {
                      leadDDController.selectedDistrict.value =  value?.id?.toString();
                      leadDDController.getCityByDistrictIdApi(districtId: leadDDController.selectedDistrict.value);
                    },
                  );
                }),

                const SizedBox(height: 20),


                const Text(
                  AppText.city,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
                ),

                const SizedBox(height: 10),


                Obx((){
                  if (leadDDController.isCityLoading.value) {
                    return  Center(child:CustomSkelton.leadShimmerList(context));
                  }


                  return CustomDropdown<city.Data>(
                    items: leadDDController.getCityByDistrictIdModel.value?.data ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.cityName.toString(),
                    selectedValue: leadDDController.getCityByDistrictIdModel.value?.data?.firstWhereOrNull(
                          (item) => item.id.toString() == leadDDController.selectedCity.value,
                    ),
                    onChanged: (value) {
                      leadDDController.selectedCity.value =  value?.id?.toString();
                    },
                  );
                }),

                const SizedBox(height: 20),

                CustomLabeledTextField(
                  label: AppText.zipCode,
                  isRequired: false,
                  controller: addleadcontroller.zipController ,
                  inputType: TextInputType.number,
                  hintText: AppText.enterZipCode,
                  maxLength: 6,
                ),

                CustomLabeledTextField(
                  label: AppText.nationality,
                  isRequired: false,
                  controller: addleadcontroller.nationalityController ,
                  inputType: TextInputType.name,
                  hintText: AppText.nationality,
                  validator: ValidationHelper.validateNationality,
                ),


                const Text(
                  AppText.currEmpSt,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
                ),

                const SizedBox(height: 10),


                Obx((){
                  if (leadDDController.isLoading.value) {
                    return  Center(child:CustomSkelton.productShimmerList(context));
                  }


                  return CustomDropdown<String>(
                    items: leadDDController.currEmpStList,
                    getId: (item) => item,  // Adjust based on your model structure
                    getName: (item) => item,
                    selectedValue: leadDDController.currEmpStatus.value,
                    onChanged: (value) {
                      leadDDController.currEmpStatus.value =  value;
                    },
                  );
                }),

                const SizedBox(height: 20),

                CustomLabeledTextField(
                  label: AppText.employerName,
                  isRequired: false,
                  controller: addleadcontroller.employerNameController ,
                  inputType: TextInputType.name,
                  hintText: AppText.enterEmployerName,
                  validator: ValidationHelper.validateEmpName,
                ),

                CustomLabeledTextField(
                  label: AppText.monIncome,
                  isRequired: false,
                  controller: addleadcontroller.monthlyIncomeController ,
                  inputType: TextInputType.number,
                  hintText: AppText.enterMonIncome,

                ),

                CustomLabeledTextField(
                  label: AppText.addIncome,
                  isRequired: false,
                  controller: addleadcontroller.addSourceIncomeController ,
                  inputType: TextInputType.name,
                  hintText: AppText.enterAddIncome,
                  validator: ValidationHelper.validateAddSrcInc,
                ),

                const Text(
                  AppText.preferredBank,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
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
                          (item) => item.id.toString() == leadDDController.selectedBank.value,
                    ),
                    onChanged: (value) {

                      leadDDController.selectedBank.value =  value?.id?.toString();
                      leadDDController.getProductListByBankIdApi(bankId: leadDDController.selectedBank.value);
                    },
                  );
                }),

                const SizedBox(height: 20),

                const Text(
                  AppText.existingRelationship,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
                ),

                const SizedBox(height: 10),


                Obx(()=>Column(
                  children: addleadcontroller.optionsRelBank.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;

                    return CheckboxListTile(
                      activeColor: AppColor.secondaryColor,

                      title: Text(option),
                      value: addleadcontroller.selectedIndexRelBank.value == index,
                      onChanged: (value) => addleadcontroller.selectCheckboxRelBank(index),
                    );
                  }).toList(),
                )),

                const SizedBox(height: 20),

                CustomLabeledTextField(
                  label: AppText.brLoc,
                  isRequired: false,
                  controller: addleadcontroller.branchLocController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterBrLoc,
                  validator: ValidationHelper.validateBrLoc,
                ),



                const SizedBox(height: 20),

                if(addleadcontroller.fromWhere.value!="interested")
                  Column(
                    children: [
                      CustomLabeledTextField(
                        label: AppText.existingLoans,
                        isRequired: false,
                        controller: addleadcontroller.existingLoansController ,
                        inputType: TextInputType.name,
                        hintText: AppText.enterExistingLoans,
                        validator: ValidationHelper.validateExLoan,
                      ),

                      const SizedBox(height: 20),

                      CustomLabeledTextField(
                        label: AppText.noOfExistingLoans,
                        isRequired: false,
                        controller: addleadcontroller.noOfExistingLoansController ,
                        inputType: TextInputType.number,
                        hintText: AppText.enterNoOfExistingLoans,
                        validator: ValidationHelper.validateNoExLoan,
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                const Text(
                  AppText.productTypeInt,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
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
                          (item) => item.id.toString() == leadDDController.selectedProdType.value,
                    ),
                    onChanged: (value) {
                      leadDDController.selectedProdType.value =  value?.id?.toString();
                    },
                  );
                }),


                const SizedBox(height: 20),

                Obx(() => Column(

                  children: [
                    CheckboxListTile(
                      activeColor: AppColor.secondaryColor,
                      title: Text(AppText.connector),
                      value: addleadcontroller.isConnectorChecked.value,
                      onChanged: addleadcontroller.toggleConnectorCheckbox,
                      controlAffinity: ListTileControlAffinity.leading, // Puts checkbox on the left
                    ),
                    if(addleadcontroller.isConnectorChecked.value)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          CustomLabeledTextField(
                            label: AppText.conName,
                            isRequired: false,
                            controller: addleadcontroller.connNameController ,
                            inputType: TextInputType.name,
                            hintText: AppText.enterConName,
                            validator: ValidationHelper.validateConnName,
                          ),

                          CustomLabeledTextField(
                            label: AppText.conMob,
                            isRequired: false,
                            controller: addleadcontroller.connMobController ,
                            inputType: TextInputType.number,
                            hintText: AppText.enterConMob,
                            validator: ValidationHelper.validatePhoneNumber,
                            maxLength: 10,
                          ),

                          CustomLabeledTextField(
                            label: AppText.conShare,
                            isRequired: false,
                            controller: addleadcontroller.connShareController ,
                            inputType: TextInputType.number,
                            hintText: AppText.enterConShare,

                          )

                        ],
                      )
                  ],
                )),


              ],
            );
          }),
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
