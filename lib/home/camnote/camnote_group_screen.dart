
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import '../../common/helper.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/product/add_product_controller.dart';

import '../product/Step2FormProduct.dart';
import '../product/Step3FormProduct.dart';

import 'Step1CamNote.dart';
import 'Step2CamNote.dart';
import 'Step3CamNote.dart';



class CamNoteGroupScreen extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());

  final AddProductController addProductController =Get.put(AddProductController());
  final CamNoteController camNoteController =Get.find();
  final List<Widget> stepForms = [
    Step1CamNote(),
    Step2CamNote(),
    Step3CamNote(),


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
                              controller: camNoteController.scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: camNoteController.titles.length,
                              itemBuilder: (context, index) {
                                return Obx(() {
                                  Color circleColor;

                                  if (camNoteController.currentStep.value == index) {
                                    circleColor = AppColor.primaryColor;
                                  } else if (camNoteController.stepCompleted[index]) {
                                    circleColor = Colors.green;
                                  } else {
                                    circleColor = Colors.grey;
                                  }

                                  return GestureDetector(
                                    onTap: () => camNoteController.jumpToStep(index),
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
                                                color: camNoteController.stepCompleted[index - 1]
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
                                                if (camNoteController.stepCompleted[index])
                                                  Positioned(
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Container(
                                                      decoration:BoxDecoration(
                                                          color:camNoteController.currentStep.value == index
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
                                                  camNoteController.titles[index],
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

                                  onPressed: camNoteController.currentStep.value > 0
                                      ? camNoteController.previousStep
                                      : null,
                                  child:  Text('Prev', style: TextStyle(color:camNoteController.currentStep.value > 0? AppColor.appWhite: AppColor.black87) ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(130, 40),

                                    backgroundColor: AppColor.primaryColor,
                                  ),
                                ),

                                ElevatedButton(
                                  onPressed: camNoteController.currentStep.value < 3
                                      ? ()=>camNoteController.nextStep(camNoteController.currentStep.value)
                                      : null,
                                  child:  Text(camNoteController.currentStep.value==2?"Save":'Next',style: TextStyle(color: AppColor.appWhite),),
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
                              child: stepForms[camNoteController.currentStep.value],
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
/*        bottomNavigationBar: Obx(() => Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: camNoteController.currentStep.value > 0
                    ? camNoteController.previousStep
                    : null,
                child: const Text('Prev'),
              ),
              ElevatedButton(
                onPressed: (){},
                child: const Text('Save', style: TextStyle(color: AppColor.appWhite),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: camNoteController.currentStep.value < 6
                    ? camNoteController.nextStep
                    : null,
                child: const Text('Next',style: TextStyle(color: AppColor.appWhite),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                ),
              ),
            ],
          ),
        )),*/


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
            AppText.leadform_camnote,
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



