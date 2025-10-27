import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../controllers/loan_appl_controller/step2_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import 'package:ksdpl/models/dashboard/GetAllChannelModel.dart' as channel;

import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;

import '../../controllers/loan_appl_controller/co_applicant_detail_mode_controllerl.dart';
class Step2Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();

  LeadDDController leadDDController = Get.put(LeadDDController());
  //Step2Controller step2Controller = Get.put(Step2Controller());
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Obx(() {
              if( loanApplicationController.isLoadingMainScreen.value)
                return Center(
                  child: CustomSkelton.productShimmerList(context),
                );

              print("length coApplicantList--->${loanApplicationController.coApplicantList.length}");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(loanApplicationController.coApplicantList.length, (index) {
                  final coAp = loanApplicationController.coApplicantList[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text( AppText.coApplicantDetails +" (${index + 1})", style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      SizedBox(height: 20,),
                      ExpansionTile(
                        initiallyExpanded: true,


                        childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                        title: Text( AppText.coApplicantDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                        leading: Icon(Icons.list_alt, size: 20,),
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),

                              CustomLabeledTextField(
                                label: AppText.fullName,
                                isRequired: false,
                                controller: coAp.coApFullNameController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterFullName,
                                validator:  ValidationHelper.validateName,
                              ),

                              CustomLabeledTextField(
                                label: AppText.fathersName,
                                isRequired: false,
                                controller: coAp.coApFatherNameController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterFathersName,

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
                                  /*Text(
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
                                  _buildRadioOption("Male",coAp ),
                                  _buildRadioOption("Female",coAp),
                                  _buildRadioOption("Other",coAp),
                                ],
                              )
                              ),

                              const SizedBox(height: 20),

                              CustomLabeledPickerTextField(
                                label: AppText.dateOfBirth,
                                isRequired: false,
                                controller: coAp.coApDobController,
                                inputType: TextInputType.name,
                                hintText: AppText.mmddyyyy,
                                validator: ValidationHelper.validateDob,
                                isDateField: true,
                              ),

                              CustomLabeledTextField(
                                label: AppText.qualification,
                                isRequired: false,
                                controller: coAp.coApQualiController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterQualification,

                              ),

                              CustomLabeledTextField(
                                label: AppText.maritalStatus,
                                isRequired: false,
                                controller: coAp.coApMaritalController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterMaritalStatus,
                               //
                              ),

                             /* CustomLabeledTextField(
                                label: AppText.employmentStatus,
                                isRequired: false,
                                controller: coAp.coApEmplStatusController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterEmploymentStatus,
                              //
                              ),*/
                              const Text(
                                AppText.employmentStatus,
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

                                  selectedValue: coAp.coApEmplStatusController.text,
                                  onChanged: (value) {
                                    coAp.coApEmplStatusController.text =  value.toString();
                                  },
                                );
                              }),
                              SizedBox(height: 20,),

                              CustomLabeledTextField(
                                label: AppText.nationality,
                                isRequired: false,
                                controller: coAp.coApNationalityController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterNationality,
                              //
                              ),


                              CustomLabeledTextField(
                                label: AppText.occupation,
                                isRequired: false,
                                controller: coAp.coApOccupationController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterOccupation,
                              //
                              ),

                              CustomLabeledTextField(
                                label: AppText.occupationSector,
                                isRequired: false,
                                controller: coAp.coApOccSectorController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterOccupationSector,
                              //
                              ),


                              CustomLabeledTextField(
                                label: AppText.eml,
                                isRequired: false,
                                controller: coAp.coApEmailController,
                                inputType: TextInputType.emailAddress,
                                hintText: AppText.enterEA,
                                validator: ValidationHelper.validateEmail,
                              ),

                              CustomLabeledTextField(
                                label: AppText.mobileNumber,
                                isRequired: false,
                                controller: coAp.coApMobController,
                                inputType: TextInputType.phone,
                                maxLength: 10,
                                hintText: AppText.enterPhNumber,
                                validator: ValidationHelper.validatePhoneNumber,

                              ),


                            ],
                          ),


                        ],
                      ),

                      ///co AP Current AKA Present Address

                      ExpansionTile(
                        childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                        title: Text( AppText.presentAdd, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
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
                                controller: coAp.coApCurrHouseFlatController,
                                inputType: TextInputType.number,
                                hintText: AppText.enterHouseFlatNo,
                                validator:  ValidationHelper.validateName,
                              ),
                              CustomLabeledTextField(
                                label: AppText.buildingNo,
                                isRequired: false,
                                controller: coAp.coApCurrBuildingNoController,
                                inputType: TextInputType.number,
                                hintText: AppText.enterBuildingNo,
                                validator:  ValidationHelper.validateName,
                              ),
                              CustomLabeledTextField(
                                label: AppText.societyName,
                                isRequired: false,
                                controller: coAp.coApCurrSocietyNameController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterSocietyName,
                                validator:  ValidationHelper.validateName,
                              ),

                              CustomLabeledTextField(
                                label: AppText.locality,
                                isRequired: false,
                                controller: coAp.coApCurrLocalityController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterLocality,
                                validator: ValidationHelper.validateName,
                              ),

                              CustomLabeledTextField(
                                label: AppText.streetName,
                                isRequired: false,
                                controller: coAp.coApCurrStreetNameController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterStreetName,
                                validator: ValidationHelper.validateName,
                              ),

                              CustomLabeledTextField(
                                label: AppText.pinCode,
                                isRequired: false,
                                controller: coAp.coApCurrPinCodeController,
                                inputType: TextInputType.number,
                                hintText: AppText.enterPinCode,
                                maxLength: 6,
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
                                        (item) => item.stateName.toString() == coAp.selectedStateCurr.value,
                                  ),
                                  onChanged: (value) {
                                    coAp.selectedStateCurr.value =  value?.stateName?.toString();
                                    coAp.getDistrictByStateIdCurrApi(stateId: value?.id.toString());
                                  },
                                  onClear: (){
                                    coAp.selectedDistrictCurr.value = null;
                                    coAp.districtListCurr.value.clear(); // reset dependent dropdown

                                    coAp.selectedCityCurr.value = null;
                                    coAp. cityListCurr.value.clear(); // reset dependent dropdown
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
                                if (coAp.isDistrictLoadingCurr.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
                                }


                                return CustomDropdown<dist.Data>(
                                  items: coAp.districtListCurr.value ?? [],
                                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                  getName: (item) => item.districtName.toString(),
                                  selectedValue: coAp.districtListCurr.value.firstWhereOrNull(
                                        (item) => item.districtName.toString() == coAp.selectedDistrictCurr.value,
                                  ),
                                  onChanged: (value) {
                                    coAp.selectedDistrictCurr.value =  value?.districtName?.toString();
                                    coAp.getCityByDistrictIdCurrApi(districtId:  value?.id.toString());
                                  },
                                  onClear: (){
                                    coAp.selectedDistrictCurr.value = null;
                                    coAp.districtListCurr.value.clear(); // reset dependent dropdown

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
                                if (coAp.isCityLoadingCurr.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
                                }


                                return CustomDropdown<city.Data>(
                                  items: coAp.cityListCurr.value  ?? [],
                                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                  getName: (item) => item.cityName.toString(),
                                  selectedValue: coAp. cityListCurr.value.firstWhereOrNull(
                                        (item) => item.cityName.toString() == coAp.selectedCityCurr.value,
                                  ),
                                  onChanged: (value) {
                                    coAp.selectedCityCurr.value =  value?.cityName?.toString();
                                  },
                                );
                              }),

                              const SizedBox(height: 20),

                              CustomLabeledTextField(
                                label: AppText.taluka,
                                isRequired: false,
                                controller: coAp.coApCurrTalukaController,
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
                                  selectedValue: coAp.selectedCountrCurr.value,
                                  onChanged: (value) {
                                    coAp.selectedCountrCurr.value =  value;
                                  },
                                );
                              }),

                              const SizedBox(height: 20),

                              Obx(() => Row(
                                children: [
                                  Checkbox(
                                    activeColor: AppColor.secondaryColor,
                                    value: coAp.isSameAddressApl.value,
                                    onChanged: (val) {
                                      coAp.isSameAddressApl.value = val ?? false;

                                      if (val == true) {
                                        coAp.copyPresentToPermanentAddress();
                                      }
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Use Present Address as Permanent Address",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),

                      ///co AP Permanent Address

                      ExpansionTile(
                        childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                        title: Text( AppText.permanentAdd, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
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
                                controller: coAp.coApPermHouseFlatController,
                                inputType: TextInputType.number,
                                hintText: AppText.enterHouseFlatNo,
                                validator:  ValidationHelper.validateName,
                              ),
                              CustomLabeledTextField(
                                label: AppText.buildingNo,
                                isRequired: false,
                                controller: coAp.coApPermBuildingNoController,
                                inputType: TextInputType.number,
                                hintText: AppText.enterBuildingNo,
                                validator:  ValidationHelper.validateName,
                              ),
                              CustomLabeledTextField(
                                label: AppText.societyName,
                                isRequired: false,
                                controller: coAp.coApPermSocietyNameController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterSocietyName,
                                validator:  ValidationHelper.validateName,
                              ),

                              CustomLabeledTextField(
                                label: AppText.locality,
                                isRequired: false,
                                controller: coAp.coApPermLocalityController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterLocality,
                                validator: ValidationHelper.validateName,
                              ),

                              CustomLabeledTextField(
                                label: AppText.streetName,
                                isRequired: false,
                                controller: coAp.coApPermStreetNameController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterStreetName,
                                validator: ValidationHelper.validateName,
                              ),

                              CustomLabeledTextField(
                                label: AppText.pinCode,
                                isRequired: false,
                                maxLength: 6,
                                controller: coAp.coApPermPinCodeController,
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
                                        (item) => item.stateName.toString() == coAp.selectedStatePerm.value,
                                  ),
                                  onChanged: (value) {
                                    coAp.selectedStatePerm.value =  value?.stateName?.toString();
                                    coAp.getDistrictByStateIdPermApi(stateId:  value?.id?.toString());
                                  },
                                  onClear: (){
                                    coAp.selectedDistrictPerm.value = null;
                                    coAp.districtListPerm.value.clear(); // reset dependent dropdown

                                    coAp.selectedCityPerm.value = null;
                                    coAp. cityListPerm.value.clear(); // reset dependent dropdown
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
                                if (coAp.isDistrictLoadingPerm.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
                                }


                                return CustomDropdown<dist.Data>(
                                  items: coAp.districtListPerm.value ?? [],
                                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                  getName: (item) => item.districtName.toString(),
                                  selectedValue: coAp.districtListPerm.value.firstWhereOrNull(
                                        (item) => item.districtName.toString() == coAp.selectedDistrictPerm.value,
                                  ),
                                  onChanged: (value) {
                                    coAp.selectedDistrictPerm.value =  value?.districtName?.toString();
                                    coAp.getCityByDistrictIdPermApi(districtId:  value?.id?.toString());
                                  },
                                  onClear: (){
                                    coAp.selectedDistrictPerm.value = null;
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
                                if (coAp.isCityLoadingPerm.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
                                }


                                return CustomDropdown<city.Data>(
                                  items: coAp.cityListPerm.value  ?? [],
                                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                  getName: (item) => item.cityName.toString(),
                                  selectedValue: coAp. cityListPerm.value.firstWhereOrNull(
                                        (item) => item.cityName.toString() == coAp.selectedCityPerm.value,
                                  ),
                                  onChanged: (value) {
                                    coAp.selectedCityPerm.value =  value?.cityName?.toString();
                                  },
                                );
                              }),

                              const SizedBox(height: 20),

                              CustomLabeledTextField(
                                label: AppText.taluka,
                                isRequired: false,
                                controller: coAp.coApPermTalukaController,
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
                                  selectedValue: coAp.selectedCountryPerm.value,
                                  onChanged: (value) {
                                    coAp.selectedCountryPerm.value =  value;
                                  },
                                );
                              }),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),

                      ///co Ap Employer details
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
                                controller: coAp.coApOrgNameController,
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
                                  items: coAp.ownershipList,
                                  getId: (item) => item,  // Adjust based on your model structure
                                  getName: (item) => item,
                                  selectedValue: coAp.selectedOwnershipList.value,
                                  onChanged: (value) {
                                    coAp.selectedOwnershipList.value =  value;
                                  },
                                );
                              }),

                              const SizedBox(height: 20),

                              CustomLabeledTextField(
                                label: AppText.natureOfBusiness,
                                isRequired: false,
                                controller: coAp.coApNatureOfBizController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterNatureOfBusiness,
                                validator:  ValidationHelper.validateName,
                              ),

                              CustomLabeledTextField(
                                label: AppText.staffStrength,
                                isRequired: false,
                                controller: coAp.coApStaffStrengthController,
                                inputType: TextInputType.number,
                                hintText: AppText.enterStaffStrength,
                                validator:  ValidationHelper.validateName,
                              ),

                              CustomLabeledPickerTextField(
                                label: AppText.salaryDate,
                                isRequired: false,
                                controller: coAp.coApSalaryDateController,
                                inputType: TextInputType.name,
                                hintText: AppText.mmddyyyy,
                                validator: ValidationHelper.validateDob,
                                isDateField: true,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 20),



                      index== loanApplicationController.coApplicantList.length-1?
                      Obx((){
                        if(loanApplicationController.isLoading.value){
                          return const Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: (){
    if (_formKey.currentState!.validate()) {
      loanApplicationController.addCoApplicant();
    }
                            },
                            child: const Text(
                              "Add New Co-Applicant",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }):
                      Container(),

                      SizedBox(height: 20),

                      Obx((){
                        if(loanApplicationController.isLoading.value){
                          return const Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:loanApplicationController.coApplicantList.length <= 1?AppColor.lightRed: AppColor.redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: loanApplicationController.coApplicantList.length <= 1?(){}: (){
                              loanApplicationController.removeCoApplicant(index);
                            },
                            child: const Text(
                              "Remove This Co-Applicant",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  );
                }),
              );
            }),


          ],
        ),
      ),
    );
  }
  Widget _buildRadioOption(String gender, CoApplicantDetailController coAp) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: coAp.selectedGenderCoAP.value,
          onChanged: (value) {
            coAp.selectedGenderCoAP.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}
