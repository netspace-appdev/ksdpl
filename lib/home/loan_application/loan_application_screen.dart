
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/home/loan_application/Step9Form.dart';
import 'package:ksdpl/home/loan_application/submitDocument.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetProductListByBank.dart' as productBank;
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'Step10Form.dart';
import 'Step1Form.dart';
import 'Step2Form.dart';
import 'Step3Form.dart';
import 'Step4Form.dart';
import 'Step5Form.dart';
import 'Step6Form.dart';
import 'Step7Form.dart';
import 'Step8Form.dart';


class LoanApplicationScreen extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  final TextEditingController _searchController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  final List<GlobalKey<FormState>> _formKeys =
  List.generate(10, (_) => GlobalKey<FormState>());


  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());/// Remove it
  final LoanApplicationController loanApplicationController =Get.put(LoanApplicationController());
  final List<Widget> stepForms = [
    Step1Form(),
    Step2Form(),
    Step3Form(),
    Step4Form(),
    Step5Form(),
    Step6Form(),
    Step7Form(),
    Step8Form(),
    Step9Form(),
    SubmitDocument(),
    Step10Form(),
  ];
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
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        header(context),
                      ],
                    ),
                  ),

                  // White Container
                  Align(
                    alignment: Alignment.topCenter,  // Centers it
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 90 // MediaQuery.of(context).size.height * 0.22
                      ), // <-- Moves it 30px from top
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              controller: loanApplicationController.scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: loanApplicationController.titles.length,
                              itemBuilder: (context, index) {
                                return Obx(() {
                                  Color circleColor;

                                  if (loanApplicationController.currentStep.value == index) {
                                    circleColor = AppColor.primaryColor;
                                  } else if (loanApplicationController.stepCompleted[index]) {
                                    circleColor = Colors.green;
                                  } else {
                                    circleColor = Colors.grey;
                                  }

                                  return GestureDetector(
                                    onTap: () => loanApplicationController.jumpToStep(index),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        if (index != 0)
                                          Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(bottom: 25), // adjust vertically
                                            child: SizedBox(
                                              width: 30,
                                              child: Divider(
                                                thickness: 2,
                                                color: loanApplicationController.stepCompleted[index - 1]
                                                    ? Colors.green
                                                    : Colors.grey[300],
                                                height: 2,
                                              ),
                                            ),
                                          ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: circleColor,
                                                  child: Text(
                                                    '${index + 1}',
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                                if (loanApplicationController.stepCompleted[index])
                                                   Positioned(
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Container(
                                                      decoration:BoxDecoration(
                                                        color:loanApplicationController.currentStep.value == index
                                                            ? Colors.green // current step completed
                                                            : Colors.blue,
                                                        shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.white)
                                                      ),
                                                      padding: EdgeInsets.all(2.0),
                                                      child: Icon(Icons.check, size: 12, color: Colors.white),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 100,
                                                child: Text(
                                                  _breakTwoWords(loanApplicationController.titles[index]),
                                                  style: const TextStyle(fontSize: 12, ),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Scrollable form
                          SingleChildScrollView(
                            child: Obx(() => Padding(
                              padding: const EdgeInsets.only(bottom: 80),
                              child: stepForms[loanApplicationController.currentStep.value],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: loanApplicationController.currentStep.value > 0
                    ? loanApplicationController.previousStep
                    : null,
                child: const Text('Prev'),
              ),
               ElevatedButton(
                onPressed: (){
                  loanApplicationController.onSaveLoanAppl();
                },
                child: const Text('Save', style: TextStyle(color: AppColor.appWhite),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: loanApplicationController.currentStep.value < 9
                    ? loanApplicationController.nextStep
                    : null,
                /*onPressed: () {
                  final index = loanApplicationController.currentStep.value;
                  final isValid = _formKeys[index].currentState?.validate() ?? false;
                  if (isValid) {
                    loanApplicationController.stepCompleted[index] = true;
                    if (index < 9) {
                      loanApplicationController.currentStep.value++;
                    } else {
                      // Submit logic
                      loanApplicationController.onSaveLoanAppl();
                    }
                  } else {
                    ToastMessage.msg("Please complete required fields");
                  }
                },*/

                child: const Text('Next',style: TextStyle(color: AppColor.appWhite),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                ),
              ),
            ],
          ),
        )),


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
          const Text(
            AppText.loanAppl,
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
              decoration:  const BoxDecoration(
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

  void onPressed(){


    if (_formKey.currentState!.validate()) {

      if (addleadcontroller.selectedGender.value==null) {
        ToastMessage.msg("Please select gender");
      }else {
        ToastMessage.msg("Form Submitted");
      }
    }
  }

  Widget percentBar(){
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: new LinearPercentIndicator(
        //width: MediaQuery.of(context).size.width - 50,
        animation: true,
        lineHeight: 15.0,
        animationDuration: 2500,
        percent: 0.8,
        //center: Text("80.0%"),
        // linearStrokeCap: LinearStrokeCap.roundAll,
        barRadius: Radius.circular(15),
        progressColor:AppColor.greenColor,
      ),
    );
  }
  String _breakTwoWords(String title) {
    final words = title.trim().split(' ');
    if (words.length == 2) {
      return '${words[0]}\n${words[1]}';
    }
    return title;
  }

}



