import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../controllers/loan_appl_controller/step2_controller.dart';
import '../../controllers/loan_appl_controller/step7_controller.dart';
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
class Step7Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();

  LeadDDController leadDDController = Get.put(LeadDDController());

  Step7Controller step7Controller = Get.put(Step7Controller());
  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(loanApplicationController.referencesList.length, (index) {
              final ref = loanApplicationController.referencesList[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),

                  ///co AP Permanent Address

                  ExpansionTile(
                    childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                    title: Text( AppText.references +" (${index + 1})", style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                    leading: Icon(Icons.list_alt, size: 20,),
                    initiallyExpanded: true,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CustomLabeledTextField(
                            label: AppText.name,
                            isRequired: false,
                            controller: ref.refNameController,
                            inputType: TextInputType.name,
                            hintText: AppText.enterReferenceName,
                            validator:  ValidationHelper.validateName,
                          ),
                          CustomLabeledTextField(
                            label: AppText.address,
                            isRequired: false,
                            controller: ref.refAddController,
                            inputType: TextInputType.name,
                            hintText: AppText.enterReferenceAdd,
                            validator:  ValidationHelper.validateName,
                          ),
                          CustomLabeledTextField(
                            label: AppText.mobNo,
                            isRequired: false,
                            maxLength: 10,
                            controller: ref.refMobController,
                            inputType: TextInputType.number,
                            hintText: AppText.enterReferenceMob,
                            validator:  ValidationHelper.validatePhoneNumber,
                          ),
                          CustomLabeledTextField(
                            label: AppText.phoneNo,
                            isRequired: false,
                            controller: ref.refPhoneController,
                            inputType: TextInputType.number,
                            hintText: AppText.enterReferencePhone,
                            maxLength: 10,
                            validator:  ValidationHelper.validateName,
                          ),

                          CustomLabeledTextField(
                            label: AppText.relWithAppl,
                            isRequired: false,
                            controller: ref.refRelWithApplController,
                            inputType: TextInputType.name,
                            hintText: AppText.enterRelWithAppl,
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
                                    (item) => item.id.toString() == ref.selectedStatePerm.value,
                              ),
                              onChanged: (value) {
                                ref.selectedStatePerm.value =  value?.id?.toString();
                                ref.getDistrictByStateIdPermApi(stateId: ref.selectedStatePerm.value);
                              },
                              onClear: (){
                                ref.selectedDistrictPerm.value = null;
                                ref.districtListPerm.value.clear(); // reset dependent dropdown

                                ref.selectedCityPerm.value = null;
                                ref. cityListPerm.value.clear(); // reset dependent dropdown
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
                            if (ref.isDistrictLoadingPerm.value) {
                              return  Center(child:CustomSkelton.leadShimmerList(context));
                            }


                            return CustomDropdown<dist.Data>(
                              items: ref.districtListPerm.value ?? [],
                              getId: (item) => item.id.toString(),  // Adjust based on your model structure
                              getName: (item) => item.districtName.toString(),
                              selectedValue: ref.districtListPerm.value.firstWhereOrNull(
                                    (item) => item.id.toString() == ref.selectedDistrictPerm.value,
                              ),
                              onChanged: (value) {
                                ref.selectedDistrictPerm.value =  value?.id?.toString();
                                ref.getCityByDistrictIdPermApi(districtId: ref.selectedDistrictPerm.value);
                              },
                              onClear: (){
                                ref.selectedDistrictPerm.value = null;
                                ref.districtListPerm.value.clear(); // reset dependent dropdown

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
                            if (ref.isCityLoadingPerm.value) {
                              return  Center(child:CustomSkelton.leadShimmerList(context));
                            }


                            return CustomDropdown<city.Data>(
                              items: ref.cityListPerm.value  ?? [],
                              getId: (item) => item.id.toString(),  // Adjust based on your model structure
                              getName: (item) => item.cityName.toString(),
                              selectedValue: ref. cityListPerm.value.firstWhereOrNull(
                                    (item) => item.id.toString() == ref.selectedCityPerm.value,
                              ),
                              onChanged: (value) {
                                ref.selectedCityPerm.value =  value?.id?.toString();
                              },
                            );
                          }),

                          const SizedBox(height: 20),


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
                              items:  ref.countryList,
                              getId: (item) => item,  // Adjust based on your model structure
                              getName: (item) => item,
                              selectedValue: ref.selectedCountry.value,
                              onChanged: (value) {
                                ref.selectedCountry.value =  value;
                              },
                            );
                          }),

                          const SizedBox(height: 20),

                          CustomLabeledTextField(
                            label: AppText.pinCode,
                            isRequired: false,
                            controller: ref.refPincodeController,
                            inputType: TextInputType.number,
                            hintText: AppText.enterPinCode,
                            maxLength: 6,
                            validator: ValidationHelper.validateName,
                          ),

                        ],
                      ),
                    ],
                  ),



                  SizedBox(height: 20),



                  index== loanApplicationController.referencesList.length-1?
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
                          loanApplicationController.addReference();
                        },
                        child: const Text(
                          "Add New Reference",
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
                          backgroundColor:loanApplicationController.referencesList.length <= 1?AppColor.lightRed: AppColor.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: loanApplicationController.referencesList.length <= 1?(){}: (){
                          loanApplicationController.removeReference(index);
                        },
                        child: const Text(
                          "Remove This Reference",
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
          )),


        ],
      ),
    );
  }
  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: loanApplicationController.selectedGenderCoAP.value,
          onChanged: (value) {
            loanApplicationController.selectedGenderCoAP.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}
