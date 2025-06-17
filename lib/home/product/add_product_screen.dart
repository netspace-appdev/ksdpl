
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../common/helper.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import 'Step1FormProduct.dart';
import 'Step2FormProduct.dart';
import 'Step3FormProduct.dart';
import 'Step4FormProduct.dart';


class AddProductScreen extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());

  final _formKey = GlobalKey<FormState>();
  final AddProductController addProductController =Get.find();
  final List<Widget> stepForms = [
    Step1FormProduct(),
    Step2FormProduct(),
    Step3FormProduct(),
    Step4FormProduct(),
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

                          Container(

                            height: 70,
                            child: ListView.builder(
                              controller: addProductController.scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: addProductController.titles.length,
                              itemBuilder: (context, index) {
                                return Obx(() {
                                  Color circleColor;

                                  if (addProductController.currentStep.value == index) {
                                    circleColor = AppColor.primaryColor;
                                  } else if (addProductController.stepCompleted[index]) {
                                    circleColor = Colors.green;
                                  } else {
                                    circleColor = Colors.grey;
                                  }

                                  return GestureDetector(
                                    onTap: () => addProductController.jumpToStep(index),
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
                                                color: addProductController.stepCompleted[index - 1]
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
                                                if (addProductController.stepCompleted[index])
                                                  Positioned(
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Container(
                                                      decoration:BoxDecoration(
                                                          color:addProductController.currentStep.value == index
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
                                                  addProductController.titles[index],
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


                          Obx(() => Container(

                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(

                                  onPressed: addProductController.currentStep.value > 0
                                      ? addProductController.previousStep
                                      : null,
                                  child:  Text('Prev', style: TextStyle(color:addProductController.currentStep.value > 0? AppColor.appWhite: AppColor.black87) ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(130, 40),

                                    backgroundColor: AppColor.primaryColor,
                                  ),
                                ),
                                /* ElevatedButton(
                                  onPressed: addProductController.validateAndSubmit,
                                  child: const Text('Save', style: TextStyle(color: AppColor.appWhite),),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                ),*/
                                ElevatedButton(
                                  onPressed: addProductController.currentStep.value < 4
                                      ? ()=>addProductController.nextStep(addProductController.currentStep.value)
                                      : null,
                                  child:  Text(addProductController.currentStep.value==3?"Save":'Save & Next',style: TextStyle(color: AppColor.appWhite),),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(130, 40),
                                    backgroundColor: AppColor.greenColor,
                                  ),
                                ),
                              ],
                            ),
                          )),

                          // Scrollable form
                          SingleChildScrollView(
                            child: Obx(() => Padding(
                              padding: const EdgeInsets.only(bottom: 80),
                              child: stepForms[addProductController.currentStep.value],
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
            borderRadius: BorderRadius.circular(8), // for ripple effect
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12), // optional internal padding
              alignment: Alignment.center,
              child: Image.asset(
                AppImage.arrowLeft,
                height: 24,
              ),
            ),
          ),

          const Text(
            AppText.addProduct,
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







}



