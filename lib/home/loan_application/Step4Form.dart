import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import '../../common/helper.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../controllers/loan_appl_controller/step4_controller.dart';

import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';

class Step4Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();

  LeadDDController leadDDController = Get.put(LeadDDController());
  Step4Controller step4Controller = Get.put(Step4Controller());
  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(loanApplicationController.familyMemberApplList.length, (index) {
              final fam = loanApplicationController.familyMemberApplList[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text( AppText.familyMember +" (${index + 1})", style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      CustomLabeledTextField(
                        label: AppText.fullName,
                        isRequired: false,
                        controller: fam.famNameController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterFullName,
                        validator:  ValidationHelper.validateName,
                      ),

                      CustomLabeledPickerTextField(
                        label: AppText.dateOfBirth,
                        isRequired: false,
                        controller: fam.famDobController,
                        inputType: TextInputType.name,
                        hintText: AppText.mmddyyyy,
                        validator: ValidationHelper.validateDob,
                        isDateField: true,
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
                         /* Text(
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
                          _buildRadioOption("Male",fam),
                          _buildRadioOption("Female",fam),
                          _buildRadioOption("Other", fam),
                        ],
                      )
                      ),

                      const SizedBox(height: 20),



                      CustomLabeledTextField(
                        label: AppText.relWithAppl,
                        isRequired: false,
                        controller: fam.famRelWithApplController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterRelWithAppl,
                        validator: ValidationHelper.validatePhoneNumber,
                      ),

                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Text(
                            AppText.dependent,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.grey2,
                            ),
                          ),
                         /* Text(
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
                      Obx(()=>  Row(
                        children: [
                          _buildRadioOptionDep("Yes", fam),
                          _buildRadioOptionDep("No", fam),
                        ],
                      )
                      ),

                      const SizedBox(height: 20),


                      CustomLabeledTextField(
                        label: AppText.monthlyIncome,
                        isRequired: false,
                        controller: fam.famMonthlyIncomeController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterMonthlyIncome,
                        validator: ValidationHelper.validatePhoneNumber,
                      ),

                      CustomLabeledTextField(
                        label: AppText.enterEmployedWith,
                        isRequired: false,
                        controller: fam.famEmployedWithController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterEmployedWith,
                        validator: ValidationHelper.validatePhoneNumber,
                      ),


                    ],
                  ),



                  SizedBox(height: 20),



                  index== loanApplicationController.familyMemberApplList.length-1?
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
                          loanApplicationController.addFamilyMember();
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
                          backgroundColor:loanApplicationController.familyMemberApplList.length <= 1?AppColor.lightRed: AppColor.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: loanApplicationController.familyMemberApplList.length <= 1?(){}: (){
                          loanApplicationController.removeFamilyMember(index);
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
          )),


        ],
      ),
    );
  }
  Widget _buildRadioOption(String gender, FamilyMemberController fam) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: fam.selectedGenderFam.value,
          onChanged: (value) {
            fam.selectedGenderFam.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }

  Widget _buildRadioOptionDep(String dep, FamilyMemberController fam) {
    return Row(
      children: [
        Radio<String>(
          value: dep,
          groupValue: fam.selectedFamDependent.value,
          onChanged: (value) {
            fam.selectedFamDependent.value=value;
          },
        ),
        Text(dep),
      ],
    );
  }
}
