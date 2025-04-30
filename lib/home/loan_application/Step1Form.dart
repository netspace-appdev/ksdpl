import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import 'package:ksdpl/models/dashboard/GetAllChannelModel.dart' as channel;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import '../../custom_widgets/CustomTextLabel.dart';

class Step1Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();
  LeadDDController leadDDController = Get.put(LeadDDController());

  @override
  Widget build(BuildContext context) {

    return Container(
      /*height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,*/

      child: Obx((){
        if( loanApplicationController.isLoadingMainScreen.value)
          return Center(
            child: CustomSkelton.productShimmerList(context),
          );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              initiallyExpanded: true,


              childrenPadding: EdgeInsets.symmetric(horizontal: 20),
              title:const Text( AppText.personInformation, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
              leading: Icon(Icons.list_alt, size: 20,),
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    CustomLabeledTextField(
                      label: AppText.dsaCode,
                      controller: loanApplicationController.dsaCodeController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterDsaCode,
                      validator:  ValidationHelper.validateName,
                    ),
                    CustomLabeledTextField(
                      label: AppText.loanApplicationNo,

                      controller: loanApplicationController.lanController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterLoanApplicationNo,
                      validator:  ValidationHelper.validateName,
                    ),


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
                              (item) => item.id == loanApplicationController.selectedBank.value,
                        ),
                        onChanged: (value) {

                          loanApplicationController.selectedBank.value =  value?.id;
                          leadDDController.getAllBranchByBankIdApi(bankId: loanApplicationController.selectedBank.value);

                          leadDDController.getProductListByBankIdApi(bankId: leadDDController.selectedBank.value);
                        },
                        onClear: (){
                          loanApplicationController.selectedBankBranch.value = null;
                          leadDDController.getAllBranchBIModel.value?.data!.clear(); // reset dependent dropdown
                        },
                      );
                    }),

                    const SizedBox(
                      height: 20,
                    ),

                    CustomTextLabel(
                      label: AppText.brNostar,

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
                              (item) => item.id== loanApplicationController.selectedBankBranch.value,
                        ),
                        onChanged: (value) {
                          loanApplicationController.selectedBankBranch.value =  value?.id;
                        },
                      );
                    }),

                    const SizedBox(
                      height: 20,
                    ),

                    CustomTextLabel(
                      label: AppText.loanType,

                    ),

                    const SizedBox(height: 10),
                    ///exp
                    Obx((){
                      if (leadDDController.isProductLoading.value) {
                        return  Center(child:CustomSkelton.leadShimmerList(context));
                      }


                      return CustomDropdown<product.Data>(
                        items: leadDDController.getAllKsdplProductModel.value?.data ?? [],
                        getId: (item) => item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.productName.toString(),
                        selectedValue: leadDDController.getAllKsdplProductModel.value?.data?.firstWhereOrNull(
                              (item) => item.id.toString() == loanApplicationController.selectedProdTypeOrTypeLoan.value,
                        ),
                        onChanged: (value) {
                          loanApplicationController.selectedProdTypeOrTypeLoan.value =  value?.id?.toString();
                        },
                      );
                    }),

                    /* Obx((){
                    if (leadDDController.isProductLoading.value) {
                      return  Center(child:CustomSkelton.leadShimmerList(context));
                    }


                    return CustomDropdown<bankBrach.Data>(
                      items: leadDDController.getAllBranchBIModel.value?.data ?? [],
                      getId: (item) => item.id.toString(),  // Adjust based on your model structure
                      getName: (item) => item.branchName.toString(),
                      selectedValue: leadDDController.getAllBranchBIModel.value?.data?.firstWhereOrNull(
                            (item) => item.id.toString() == leadDDController.selectedBankBranch.value,
                      ),
                      onChanged: (value) {

                        leadDDController.selectedBankBranch.value =  value?.id?.toString();


                      },
                    );
                  }),
*/
                    const SizedBox(height: 20),

                    CustomLabeledTextField(
                      label: AppText.panCardNo,

                      controller: loanApplicationController.panController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterPanCardNo,
                      validator:  ValidationHelper.validatePanCard,
                    ),

                    CustomLabeledTextField(
                      label: AppText.aadharCardNo,

                      controller: loanApplicationController.aadharController,
                      inputType: TextInputType.number,
                      hintText: AppText.enterAadharCardNo,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.loanAmountApplied,

                      controller: loanApplicationController.laAppliedController,
                      inputType: TextInputType.number,
                      hintText: AppText.enterLoanAmountApplied,
                      validator:  ValidationHelper.validateName,
                    ),


                    CustomLabeledTextField(
                      label: AppText.dsaStaffName,

                      controller: loanApplicationController.dsaStaffNController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterDsaStaffName,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.uniqueLeadNumber,

                      controller: loanApplicationController.ulnController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterUniqueLeadNumber,
                      validator:  ValidationHelper.validateName,
                      isInputEnabled: false,

                    ),


                    CustomTextLabel(
                      label: AppText.channel,

                    ),

                    const SizedBox(height: 10),


                    Obx((){
                      if (leadDDController.isChannelLoading.value) {
                        return  Center(child:CustomSkelton.leadShimmerList(context));
                      }


                      return CustomDropdown<channel.Data>(
                        items: leadDDController.getAllChannelModel.value?.data ?? [],
                        getId: (item) => item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.channelName.toString(),
                        selectedValue: leadDDController.getAllChannelModel.value?.data?.firstWhereOrNull(
                              (item) => item.id.toString() == loanApplicationController.selectedChannel.value,
                        ),
                        onChanged: (value) {

                          loanApplicationController.selectedChannel.value =  value?.id?.toString();


                        },
                      );
                    }),

                    const SizedBox(height: 20),
                    CustomLabeledTextField(
                      label: AppText.channelCode,
                      isRequired: false,
                      controller: loanApplicationController.chCodeController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterChannelCode,
                      validator:  ValidationHelper.validateName,
                      isInputEnabled: false,

                    ),
                    CustomLabeledTextField(
                      label: AppText.processingFee,
                      isRequired: false,
                      controller: loanApplicationController.proFeeController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterProcessingFee,
                      validator:  ValidationHelper.validateName,


                    ),

                    CustomLabeledTextField(
                      label: AppText.chqDdSlipNo,
                      isRequired: false,
                      controller: loanApplicationController.chqDDSNController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterChqDdSlipNo,
                      validator:  ValidationHelper.validateName,


                    ),

                    CustomLabeledPickerTextField(
                      label: AppText.processingFeeDate,
                      isRequired: false,
                      controller: loanApplicationController.proFeeDateController,
                      inputType: TextInputType.name,
                      hintText: AppText.mmddyyyy,
                      validator: ValidationHelper.validateDob,
                      isDateField: true,
                    ),

                    CustomLabeledTextField(
                      label: AppText.loanPurpose,
                      isRequired: false,
                      controller: loanApplicationController.loPurposeController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterLoanPurpose,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.scheme,
                      isRequired: false,
                      controller: loanApplicationController.schemeController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterScheme,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.repaymentType,
                      isRequired: false,
                      controller: loanApplicationController.repayTpeController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterRepaymentType,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.loanTenure,
                      isRequired: false,
                      controller: loanApplicationController.loanTenureYController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterLoanTenure,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.monthlyInstallment,
                      isRequired: false,
                      controller: loanApplicationController.monthInstaController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterMonthlyInstallment,
                      validator:  ValidationHelper.validateName,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      AppText.previousLoanApplied,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.grey2,
                      ),
                    ),

                    Obx(()=>Column(
                      children: loanApplicationController.optionsPrevLoanAppl.asMap().entries.map((entry) {
                        int index = entry.key;
                        String option = entry.value;

                        return CheckboxListTile(
                          activeColor: AppColor.secondaryColor,

                          title: Text(option),
                          value: loanApplicationController.selectedPrevLoanAppl.value == index,
                          onChanged: (value) => loanApplicationController.selectedPrevLoanAppl(index),
                        );
                      }).toList(),
                    )),

                    const SizedBox(height: 20),




                    Helper.customDivider(color: AppColor.grey200),
                    SizedBox(height: 20,),

                    CustomLabeledTextField(
                      label: AppText.applFNmae,
                      isRequired: false,
                      controller: loanApplicationController.applFullNameController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterFullName,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.fathersName,
                      isRequired: false,
                      controller: loanApplicationController.fatherNameController,
                      inputType: TextInputType.phone,
                      hintText: AppText.enterFathersName,
                      validator: ValidationHelper.validateName,
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
                        /*  Text(
                        " *",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.redColor,
                        ),
                      ),*/
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

                    CustomLabeledPickerTextField(
                      label: AppText.dateOfBirth2,
                      isRequired: false,
                      controller: loanApplicationController.dobController,
                      inputType: TextInputType.name,
                      hintText: AppText.mmddyyyy,
                      validator: ValidationHelper.validateDob,
                      isDateField: true,
                    ),

                    CustomLabeledTextField(
                      label: AppText.qualification,
                      isRequired: false,
                      controller: loanApplicationController.qualiController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterQualification,
                      validator: ValidationHelper.validatePhoneNumber,
                    ),

                    CustomLabeledTextField(
                      label: AppText.maritalStatus,
                      isRequired: false,
                      controller: loanApplicationController.maritalController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterMaritalStatus,
                      validator: ValidationHelper.validatePhoneNumber,
                    ),

                    CustomLabeledTextField(
                      label: AppText.nationality,
                      isRequired: false,
                      controller: loanApplicationController.nationalityController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterNationality,
                      validator: ValidationHelper.validatePhoneNumber,
                    ),


                    CustomLabeledTextField(
                      label: AppText.occupation,
                      isRequired: false,
                      controller: loanApplicationController.occupationController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterOccupation,
                      validator: ValidationHelper.validatePhoneNumber,
                    ),

                    CustomLabeledTextField(
                      label: AppText.occupationSector,
                      isRequired: false,
                      controller: loanApplicationController.occSectorController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterOccupationSector,
                      validator: ValidationHelper.validatePhoneNumber,
                    ),


                    CustomLabeledTextField(
                      label: AppText.eml,
                      isRequired: false,
                      controller: loanApplicationController.applEmailController,
                      inputType: TextInputType.emailAddress,
                      hintText: AppText.enterEA,
                      validator: ValidationHelper.validateEmail,
                    ),

                    CustomLabeledTextField(
                      label: AppText.mobileNumber,
                      isRequired: false,
                      controller: loanApplicationController.applMobController,
                      inputType: TextInputType.phone,
                      hintText: AppText.enterPhNumber,
                      validator: ValidationHelper.validatePhoneNumber,

                    ),

                    CustomLabeledTextField(
                      label: AppText.employmentStatus,
                      isRequired: false,
                      controller: loanApplicationController.emplStatusController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterEmploymentStatus,
                      validator: ValidationHelper.validatePhoneNumber,
                    ),
                  ],
                ),


              ],
            ),

            ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 20),
              title:const Text( AppText.applicantEmployerDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
              leading: Icon(Icons.list_alt, size: 20,),
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomLabeledTextField(
                      label: AppText.organizationName,
                      isRequired: false,
                      controller: loanApplicationController.orgNameController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterOrganizationName,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomTextLabel(
                      label: AppText.ownershipType,
                      isRequired: false,
                    ),

                    const SizedBox(height: 10),

                    Obx((){
                      if (leadDDController.isLoading.value) {
                        return  Center(child:CustomSkelton.productShimmerList(context));
                      }


                      return CustomDropdown<String>(
                        items: loanApplicationController.ownershipList,
                        getId: (item) => item,  // Adjust based on your model structure
                        getName: (item) => item,
                        selectedValue: loanApplicationController.selectedOwnershipList.value,
                        onChanged: (value) {
                          loanApplicationController.selectedOwnershipList.value =  value;
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    CustomLabeledTextField(
                      label: AppText.natureOfBusiness,
                      isRequired: false,
                      controller: loanApplicationController.natureOfBizController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterNatureOfBusiness,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.staffStrength,
                      isRequired: false,
                      controller: loanApplicationController.staffStrengthController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterStaffStrength,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledPickerTextField(
                      label: AppText.salaryDate,
                      isRequired: false,
                      controller: loanApplicationController.salaryDateController,
                      inputType: TextInputType.name,
                      hintText: AppText.mmddyyyy,
                      validator: ValidationHelper.validateDob,
                      isDateField: true,
                    ),
                  ],
                ),
              ],
            ),


            ///Current AKA Present Address

            ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 20),
              title:const Text( AppText.presentAdd, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
              leading: Icon(Icons.list_alt, size: 20,),
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomLabeledTextField(
                      label: AppText.houseFlatNo,
                      isRequired: false,
                      controller: loanApplicationController.houseFlatController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterHouseFlatNo,
                      validator:  ValidationHelper.validateName,
                    ),
                    CustomLabeledTextField(
                      label: AppText.buildingNo,
                      isRequired: false,
                      controller: loanApplicationController.buildingNoController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterBuildingNo,
                      validator:  ValidationHelper.validateName,
                    ),
                    CustomLabeledTextField(
                      label: AppText.societyName,
                      isRequired: false,
                      controller: loanApplicationController.societyNameController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterSocietyName,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.locality,
                      isRequired: false,
                      controller: loanApplicationController.localityController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterLocality,
                      validator: ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.streetName,
                      isRequired: false,
                      controller: loanApplicationController.streetNameController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterStreetName,
                      validator: ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.pinCode,
                      isRequired: false,
                      controller: loanApplicationController.pinCodeController,
                      inputType: TextInputType.number,
                      hintText: AppText.enterPinCode,
                      validator: ValidationHelper.validateName,
                    ),

                    CustomTextLabel(
                      label: AppText.state,
                      isRequired: false,
                    ),

                    SizedBox(height: 10),


                    Obx((){
                      if (leadDDController.isStateLoading.value) {
                        return  Center(child:CustomSkelton.leadShimmerList(context));
                      }

                      return CustomDropdown<Data>(
                        items: leadDDController.getAllStateModel.value?.data ?? [],
                        getId: (item) => item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.stateName.toString(),
                        selectedValue: leadDDController.getAllStateModel.value?.data?.firstWhereOrNull(
                              (item) => item.id.toString() == leadDDController.selectedStateCurr.value,
                        ),
                        onChanged: (value) {
                          leadDDController.selectedStateCurr.value =  value?.id?.toString();
                          leadDDController.getDistrictByStateIdCurrApi(stateId: leadDDController.selectedStateCurr.value);
                        },
                        onClear: (){
                          leadDDController.selectedDistrictCurr.value = null;
                          leadDDController.districtListCurr.value.clear(); // reset dependent dropdown

                          leadDDController.selectedCityCurr.value = null;
                          leadDDController. cityListCurr.value.clear(); // reset dependent dropdown
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    CustomTextLabel(
                      label: AppText.district,
                      isRequired: false,
                    ),

                    const SizedBox(height: 10),


                    Obx((){
                      if (leadDDController.isDistrictLoadingCurr.value) {
                        return  Center(child:CustomSkelton.leadShimmerList(context));
                      }


                      return CustomDropdown<dist.Data>(
                        items: leadDDController.districtListCurr.value ?? [],
                        getId: (item) => item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.districtName.toString(),
                        selectedValue: leadDDController.districtListCurr.value.firstWhereOrNull(
                              (item) => item.id.toString() == leadDDController.selectedDistrictCurr.value,
                        ),
                        onChanged: (value) {
                          leadDDController.selectedDistrictCurr.value =  value?.id?.toString();
                          leadDDController.getCityByDistrictIdCurrApi(districtId: leadDDController.selectedDistrictCurr.value);
                        },
                        onClear: (){
                          leadDDController.selectedDistrictCurr.value = null;
                          leadDDController.districtListCurr.value.clear(); // reset dependent dropdown

                        },
                      );
                    }),

                    const SizedBox(height: 20),


                    CustomTextLabel(
                      label: AppText.city,
                      isRequired: false,
                    ),

                    const SizedBox(height: 10),


                    Obx((){
                      if (leadDDController.isCityLoadingCurr.value) {
                        return  Center(child:CustomSkelton.leadShimmerList(context));
                      }


                      return CustomDropdown<city.Data>(
                        items: leadDDController. cityListCurr.value  ?? [],
                        getId: (item) => item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.cityName.toString(),
                        selectedValue: leadDDController. cityListCurr.value.firstWhereOrNull(
                              (item) => item.id.toString() == leadDDController.selectedCityCurr.value,
                        ),
                        onChanged: (value) {
                          leadDDController.selectedCityCurr.value =  value?.id?.toString();
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    CustomLabeledTextField(
                      label: AppText.taluka,
                      isRequired: false,
                      controller: loanApplicationController.talukaController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterTaluka,
                      validator: ValidationHelper.validateName,
                    ),

                    CustomTextLabel(
                      label: AppText.country,
                      isRequired: false,
                    ),

                    const SizedBox(height: 10),

                    Obx((){
                      if (leadDDController.isLoading.value) {
                        return  Center(child:CustomSkelton.productShimmerList(context));
                      }


                      return CustomDropdown<String>(
                        items: loanApplicationController.countryList,
                        getId: (item) => item,  // Adjust based on your model structure
                        getName: (item) => item,
                        selectedValue: loanApplicationController.selectedCountry.value,
                        onChanged: (value) {
                          loanApplicationController.selectedCountry.value =  value;
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                  ],
                ),
              ],
            ),


            ///Permanent Address
            ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 20),
              title:const Text( AppText.permanentAdd, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
              leading: Icon(Icons.list_alt, size: 20,),
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomLabeledTextField(
                      label: AppText.houseFlatNo,
                      isRequired: false,
                      controller: loanApplicationController.houseFlatPermController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterHouseFlatNo,
                      validator:  ValidationHelper.validateName,
                    ),
                    CustomLabeledTextField(
                      label: AppText.buildingNo,
                      isRequired: false,
                      controller: loanApplicationController.buildingNoPermController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterBuildingNo,
                      validator:  ValidationHelper.validateName,
                    ),
                    CustomLabeledTextField(
                      label: AppText.societyName,
                      isRequired: false,
                      controller: loanApplicationController.societyNamePermController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterSocietyName,
                      validator:  ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.locality,
                      isRequired: false,
                      controller: loanApplicationController.localityPermController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterLocality,
                      validator: ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.streetName,
                      isRequired: false,
                      controller: loanApplicationController.streetNamePermController,
                      inputType: TextInputType.name,
                      hintText: AppText.enterStreetName,
                      validator: ValidationHelper.validateName,
                    ),

                    CustomLabeledTextField(
                      label: AppText.pinCode,
                      isRequired: false,
                      controller: loanApplicationController.pinCodePermController,
                      inputType: TextInputType.number,
                      hintText: AppText.enterPinCode,
                      validator: ValidationHelper.validateName,
                    ),

                    CustomTextLabel(
                      label: AppText.state,
                      isRequired: false,
                    ),

                    SizedBox(height: 10),


                    Obx((){
                      if (leadDDController.isStateLoadingPerm.value) {
                        return  Center(child:CustomSkelton.leadShimmerList(context));
                      }

                      return CustomDropdown<Data>(
                        items: leadDDController.getAllStateModel.value?.data ?? [],
                        getId: (item) => item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.stateName.toString(),
                        selectedValue: leadDDController.getAllStateModel.value?.data?.firstWhereOrNull(
                              (item) => item.id.toString() == leadDDController.selectedStatePerm.value,
                        ),
                        onChanged: (value) {
                          leadDDController.selectedStatePerm.value =  value?.id?.toString();
                          leadDDController.getDistrictByStateIdPermApi(stateId: leadDDController.selectedStatePerm.value);
                        },
                        onClear: (){
                          leadDDController.selectedDistrictPerm.value = null;
                          leadDDController. districtListPerm.value.clear(); // reset dependent dropdown


                          leadDDController.selectedCityPerm.value = null;
                          leadDDController. cityListPerm.value.clear(); // reset dependent dropdown
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    CustomTextLabel(
                      label: AppText.district,
                      isRequired: false,
                    ),

                    const SizedBox(height: 10),


                    Obx((){
                      if (leadDDController.isDistrictLoadingPerm.value) {
                        return  Center(child:CustomSkelton.leadShimmerList(context));
                      }


                      return CustomDropdown<dist.Data>(
                        items: leadDDController. districtListPerm.value ?? [],
                        getId: (item) => item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.districtName.toString(),
                        selectedValue: leadDDController. districtListPerm.value.firstWhereOrNull(
                              (item) => item.id.toString() == leadDDController.selectedDistrictPerm.value,
                        ),
                        onChanged: (value) {
                          leadDDController.selectedDistrictPerm.value =  value?.id?.toString();
                          leadDDController.getCityByDistrictIdPermApi(districtId: leadDDController.selectedDistrictPerm.value);
                        },
                        onClear: (){
                          leadDDController.selectedCityPerm.value = null;
                          leadDDController.districtListPerm.value.clear(); // reset dependent dropdown

                        },
                      );
                    }),

                    const SizedBox(height: 20),


                    CustomTextLabel(
                      label: AppText.city,
                      isRequired: false,
                    ),

                    const SizedBox(height: 10),


                    Obx((){
                      if (leadDDController.isCityLoadingPerm.value) {
                        return  Center(child:CustomSkelton.leadShimmerList(context));
                      }


                      return CustomDropdown<city.Data>(
                        items:  leadDDController. cityListPerm.value  ?? [],
                        getId: (item) => item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.cityName.toString(),
                        selectedValue: leadDDController. cityListPerm.value .firstWhereOrNull(
                              (item) => item.id.toString() == leadDDController.selectedCityPerm.value,
                        ),
                        onChanged: (value) {
                          leadDDController.selectedCityPerm.value =  value?.id?.toString();
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    CustomLabeledTextField(
                      label: AppText.taluka,
                      isRequired: false,
                      controller: loanApplicationController.talukaPermController,
                      inputType: TextInputType.number,
                      hintText: AppText.enterTaluka,
                      validator: ValidationHelper.validateName,
                    ),

                    CustomTextLabel(
                      label: AppText.country,
                      isRequired: false,
                    ),

                    const SizedBox(height: 10),

                    Obx((){
                      if (leadDDController.isLoading.value) {
                        return  Center(child:CustomSkelton.productShimmerList(context));
                      }


                      return CustomDropdown<String>(
                        items: loanApplicationController.countryList,
                        getId: (item) => item,  // Adjust based on your model structure
                        getName: (item) => item,
                        selectedValue: loanApplicationController.selectedCountryPerm.value,
                        onChanged: (value) {
                          loanApplicationController.selectedCountryPerm.value =  value;
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                  ],
                ),
              ],
            )

            ///
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
          groupValue: loanApplicationController.selectedGender.value,
          onChanged: (value) {
            loanApplicationController.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}
