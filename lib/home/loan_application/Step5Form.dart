import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import '../../common/helper.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../controllers/loan_appl_controller/step5Controller.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';

class Step5Form extends StatelessWidget {
  final loanApplicationController = Get.find<LoanApplicationController>();

  LeadDDController leadDDController = Get.put(LeadDDController());
  Step5Controller step5Controller = Get.put(Step5Controller());
  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(loanApplicationController.creditCardsList.length, (index) {
              final cc = loanApplicationController.creditCardsList[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text( AppText.creditCard +" (${index + 1})", style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      CustomLabeledTextField(
                        label: AppText.companyBank,
                        isRequired: false,
                        controller: cc.ccCompBankController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterCompanyBank,
                        validator:  ValidationHelper.validateName,
                      ),
                      CustomLabeledTextField(
                        label: AppText.cardNumber,
                        isRequired: false,
                        controller: cc.ccCardNumberController,
                        inputType: TextInputType.name,
                        hintText: AppText.enterCardNumber,
                        validator:  ValidationHelper.validateName,
                      ),

                      CustomLabeledPickerTextField(
                        label: AppText.havingSince,
                        isRequired: false,
                        controller: cc.ccHavingSinceController,
                        inputType: TextInputType.name,
                        hintText: AppText.mmddyyyy,
                        validator: ValidationHelper.validateDob,
                        isDateField: true,
                      ),

                      CustomLabeledTextField(
                        label: AppText.avgMonSpencing,
                        isRequired: false,
                        controller: cc.ccAvgMonSpendingController,
                        inputType: TextInputType.number,
                        hintText: AppText.enterAvgMonSpencing,
                        validator: ValidationHelper.validatePhoneNumber,
                      ),

                    ],
                  ),



                  SizedBox(height: 20),



                  index== loanApplicationController.creditCardsList.length-1?
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
                          loanApplicationController.addCreditCard();
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
                          backgroundColor:loanApplicationController.creditCardsList.length <= 1?AppColor.lightRed: AppColor.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: loanApplicationController.creditCardsList.length <= 1?(){}: (){
                          loanApplicationController.removeCreditCard(index);
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

/*  Widget _buildRadioOptionDep(String dep, FamilyMemberController fam) {
    return Row(
      children: [
        Radio<String>(
          value: dep,
          groupValue: fam.selectedGenderDependent.value,
          onChanged: (value) {
            fam.selectedGenderDependent.value=value;
          },
        ),
        Text(dep),
      ],
    );
  }*/
}
