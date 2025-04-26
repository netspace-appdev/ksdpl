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

import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import '../../custom_widgets/CustomTextLabel.dart';

class Step3Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();
  LeadDDController leadDDController = Get.put(LeadDDController());

  @override
  Widget build(BuildContext context) {
    return Container(
      /*height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,*/

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( AppText.propertyDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomLabeledTextField(
                label: AppText.propertyId,
                isRequired: false,
                controller: loanApplicationController.propPropIdController,
                inputType: TextInputType.name,
                hintText: AppText.enterPropertyId,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.surveyNo,
                isRequired: false,
                controller: loanApplicationController.propSurveyNoController,
                inputType: TextInputType.name,
                hintText: AppText.enterSurveyNo,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.finalPlotNo,
                isRequired: false,
                controller: loanApplicationController.propFinalPlotNoNoController,
                inputType: TextInputType.name,
                hintText: AppText.enterFinalPlotNo,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.blockNo,
                isRequired: false,
                controller: loanApplicationController.propBlockNoNoNoController,
                inputType: TextInputType.name,
                hintText: AppText.enterBlockNo,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.houseFlatNo,
                isRequired: false,
                controller: loanApplicationController.propHouseFlatController,
                inputType: TextInputType.name,
                hintText: AppText.enterHouseFlatNo,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.socBuildName,
                isRequired: false,
                controller: loanApplicationController.propBuildingNameController,
                inputType: TextInputType.name,
                hintText: AppText.enterBuildingNo,
                validator:  ValidationHelper.validateName,
              ),
              CustomLabeledTextField(
                label: AppText.streetName,
                isRequired: false,
                controller: loanApplicationController.propStreetNameController,
                inputType: TextInputType.name,
                hintText: AppText.enterStreetName,
                validator:  ValidationHelper.validateName,
              ),

              CustomLabeledTextField(
                label: AppText.locality,
                isRequired: false,
                controller: loanApplicationController.propLocalityController,
                inputType: TextInputType.name,
                hintText: AppText.enterLocality,
                validator: ValidationHelper.validateName,
              ),


              CustomLabeledTextField(
                label: AppText.pinCode,
                isRequired: false,
                controller: loanApplicationController.propPinCodeController,
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
                        (item) => item.id.toString() == loanApplicationController.selectedStateProp.value,
                  ),
                  onChanged: (value) {
                    loanApplicationController.selectedStateProp.value =  value?.id?.toString();
                    leadDDController.getDistrictByStateIdCurrApi(stateId: loanApplicationController.selectedStateProp.value);
                  },
                  onClear: (){
                    loanApplicationController.selectedDistrictProp.value = null;
                    leadDDController.districtListCurr.value.clear(); // reset dependent dropdown

                    loanApplicationController.selectedCityProp.value = null;
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
                        (item) => item.id.toString() == loanApplicationController.selectedDistrictProp.value,
                  ),
                  onChanged: (value) {
                    loanApplicationController.selectedDistrictProp.value =  value?.id?.toString();
                    leadDDController.getCityByDistrictIdCurrApi(districtId: loanApplicationController.selectedDistrictProp.value);
                  },
                  onClear: (){
                    loanApplicationController.selectedCityProp.value = null;
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
                        (item) => item.id.toString() == loanApplicationController.selectedCityProp.value,
                  ),
                  onChanged: (value) {
                    loanApplicationController.selectedCityProp.value =  value?.id?.toString();
                  },
                );
              }),

              const SizedBox(height: 20),

              CustomLabeledTextField(
                label: AppText.taluka,
                isRequired: false,
                controller: loanApplicationController.talukaController,
                inputType: TextInputType.number,
                hintText: AppText.enterTaluka,
                validator: ValidationHelper.validateName,
              ),



            ],
          ),



          ///
        ],
      ),
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
