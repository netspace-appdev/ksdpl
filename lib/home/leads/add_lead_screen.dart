import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';

import '../../controllers/leads/leadlist_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';

class AddLeadScreen extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  LeadListController leadListController = Get.put(LeadListController());
  final TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());
  String _selectedGender = "Male";
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        backgroundColor: AppColor.backgroundColor,

        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Gradient Background
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child:Column(
                      children: [

                        SizedBox(
                          height: 20,
                        ),

                        header(context),

                        /* SizedBox(
                          height: 20,
                        ),

                        searchArea()*/

                      ],
                    ),
                  ),

                  // White Container
                  Align(
                    alignment: Alignment.topCenter,  // Centers it
                    child: Container(
                      margin:  EdgeInsets.only(
                          top:90 // MediaQuery.of(context).size.height * 0.22
                      ), // <-- Moves it 30px from top
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                        children: [
                          SizedBox(
                            height: 10,
                          ),

                          CustomLabeledTextField(
                            label: AppText.fullName,
                            isRequired: true,
                            controller: addleadcontroller.fullNameController,
                            inputType: TextInputType.name,
                            hintText: AppText.enterFullName,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledPickerTextField(
                            label: AppText.dateOfBirth,
                            isRequired: true,
                            controller: addleadcontroller.fullNameController,
                            inputType: TextInputType.name,
                            hintText: AppText.mmddyyyy,
                            validator: validateEmployeeId,
                            isDateField: true,
                          ),

                          CustomLabeledTextField(
                            label: AppText.phoneNumberNoStar,
                            isRequired: true,
                            controller: addleadcontroller.phoneController,
                            inputType: TextInputType.phone,
                            hintText: AppText.enterPhNumber,
                            validator: validateEmployeeId,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Gender",
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

                          SizedBox(height: 10),
                          /// Label Row (with * if required)
                          Row(
                            children: [
                              _buildRadioOption("Male"),
                              _buildRadioOption("Female"),
                              _buildRadioOption("Other"),
                            ],
                          ),

                          SizedBox(height: 20),


                          CustomLabeledTextField(
                            label: AppText.lar,
                            isRequired: true,
                            controller: addleadcontroller.loanAmtReqController,
                            inputType: TextInputType.phone,
                            hintText: AppText.enterLar,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.eml,
                            isRequired: false,
                            controller: addleadcontroller.emailController,
                            inputType: TextInputType.emailAddress,
                            hintText: AppText.enterEA,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.aadhar,
                            isRequired: false,
                            controller: addleadcontroller.aadharController ,
                            inputType: TextInputType.phone,
                            hintText: AppText.enterAadhar,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.panNumber,
                            isRequired: false,
                            controller: addleadcontroller.panController ,
                            inputType: TextInputType.phone,
                            hintText: AppText.enterPan,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.streetAdd,
                            isRequired: false,
                            controller: addleadcontroller.streetAddController ,
                            inputType: TextInputType.name,
                            hintText: AppText.enterStreetAdd,
                            validator: validateEmployeeId,
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
                            if (leadDDController.isLoading.value) {
                              return  Center(child:CustomSkelton.productShimmerList(context));
                            }
                            if (leadDDController.getAllStateModel.value!.data!.isEmpty) {
                              return const Text(AppText.noOptions);
                            }
                            if (leadDDController.getAllStateModel.value!.data!.isEmpty) {
                              return const Text(AppText.noOptions);
                            }
                            return CustomDropdown<Data>(
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

                          SizedBox(height: 20),

                          const Text(
                            AppText.district,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.grey2,
                            ),
                          ),

                          SizedBox(height: 10),


                          Obx((){
                            if (leadDDController.isLoading.value) {
                              return  Center(child:CustomSkelton.productShimmerList(context));
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
                               print("selectedDistrict===>${leadDDController.selectedDistrict.value }");
                              },
                            );
                          }),

                          SizedBox(height: 20),

                          CustomLabeledTextField(
                            label: AppText.zipCode,
                            isRequired: false,
                            controller: addleadcontroller.zipController ,
                            inputType: TextInputType.number,
                            hintText: AppText.enterZipCode,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.nationality,
                            isRequired: false,
                            controller: addleadcontroller.nationalityController ,
                            inputType: TextInputType.name,
                            hintText: AppText.nationality,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.employerName,
                            isRequired: false,
                            controller: addleadcontroller.employerNameController ,
                            inputType: TextInputType.name,
                            hintText: AppText.enterEmployerName,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.monIncome,
                            isRequired: false,
                            controller: addleadcontroller.monthlyIncomeController ,
                            inputType: TextInputType.name,
                            hintText: AppText.enterMonIncome,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.addIncome,
                            isRequired: false,
                            controller: addleadcontroller.monthlyIncomeController ,
                            inputType: TextInputType.number,
                            hintText: AppText.enterAddIncome,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.brLoc,
                            isRequired: false,
                            controller: addleadcontroller.branchLocController ,
                            inputType: TextInputType.number,
                            hintText: AppText.enterBrLoc,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.conName,
                            isRequired: false,
                            controller: addleadcontroller.connNameController ,
                            inputType: TextInputType.number,
                            hintText: AppText.enterConName,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.conMob,
                            isRequired: false,
                            controller: addleadcontroller.connMobController ,
                            inputType: TextInputType.number,
                            hintText: AppText.enterConMob,
                            validator: validateEmployeeId,
                          ),

                          CustomLabeledTextField(
                            label: AppText.conShare,
                            isRequired: false,
                            controller: addleadcontroller.connShareController ,
                            inputType: TextInputType.number,
                            hintText: AppText.enterConShare,
                            validator: validateEmployeeId,
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          InkWell(
              onTap: (){
                Get.back();
              },
              child: Image.asset(AppImage.arrowLeft,height: 24,)),
          Text(
            AppText.addLead,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700


            ),
          ),

          InkWell(
            onTap: (){

            },
            child: Container(

              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),

            ),
          )



        ],
      ),
    );
  }

  Widget searchArea(){
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            controller: _searchController,
            onChanged: (val){},
            hintText: "Search Leads...",
          ),
        ),
        Container(

          width: 50,
          height:50,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: const BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(child: Image.asset(AppImage.filterIcon, height: 22,)),
        )
      ],
    );
  }




  String? validateEmployeeId(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.passwordRequired;
    }
    return null;
  }

  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: _selectedGender,
          onChanged: (value) {

          },
        ),
        Text(gender),
      ],
    );
  }

}


