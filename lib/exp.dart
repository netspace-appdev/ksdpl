import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/helper.dart';

class MultiStepFormController extends GetxController {
  var currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 5) currentStep.value++;
  }

  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  void saveForm() {
    print("Form Saved!");
  }
}

class MultiStepForm extends StatelessWidget {
  final MultiStepFormController controller = Get.put(MultiStepFormController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryLight, // Gradient background color

      body: Column(
        children: [
          // **Gradient Background & Header**
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
            child: Column(
              children: [
                SizedBox(height: 20),
                header(context),
              ],
            ),
          ),

          // **White Container with Scrollable Form**
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 100), // Adjust position
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // **Form Fields (Example)**
                      for (int i = 0; i < 10; i++) // Replace with actual fields
                        TextFormField(
                          decoration: InputDecoration(labelText: "Field ${i + 1}"),
                        ),
                      SizedBox(height: 120), // Add space so form doesn't overlap with buttons
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // **Sticky Bottom Buttons**
      bottomNavigationBar: Obx(() => Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // **Previous Button (Hidden on Step 1)**
            if (controller.currentStep.value > 0)
              ElevatedButton(
                onPressed: controller.previousStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text("Previous", style: TextStyle(color: Colors.white)),
              )
            else
              SizedBox(), // Empty space to maintain layout

            // **Next & Save Button**
            ElevatedButton(
              onPressed: controller.currentStep.value == 5 ? controller.saveForm : controller.nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                controller.currentStep.value == 5 ? "Save & Continue" : "Next",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      )),
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
}
