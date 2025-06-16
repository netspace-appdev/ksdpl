

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../common/helper.dart';
import '../controllers/login_controller.dart';
import '../custom_widgets/CustomBigDialogBox.dart';
import '../custom_widgets/CustomTextFieldPrefix.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final LoginController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryLight, AppColor.primaryDark],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // White Container (Login Form)
          Align(
            alignment: Alignment.topCenter,  // Centers it
            child: Container(
              margin:  EdgeInsets.only(
                  top:  MediaQuery.of(context).size.height * 0.14
              ), // <-- Moves it 30px from top
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                    children: [
                      Center(
                        child: Image.asset(
                          AppImage.logo1, // Replace with your image path
                          height: 70,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Login Title
                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Welcome Text
                      const Text(
                        "Enter your account details below",
                        style: TextStyle(fontSize: 16, color: AppColor.blackColor),
                      ),
                      const SizedBox(height: 25),

                      // Mobile Number Field

                      CustomTextFieldPrefix(
                        inputType:  TextInputType.phone,
                        controller: controller.mobileController,
                        hintText: "Mobile Number",
                        validator: validatePhoneNumber,
                        isPassword: false,
                        obscureText: false,
                        prefixImage: AppImage.phoneIcon,
                        maxLength: 10,


                      ),

                      const SizedBox(height: 25),

                      // Sign In Button
                      Obx((){
                        if(controller.isLoading.value){
                          return Align(
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
                              backgroundColor: AppColor.secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {

                                Helper.checkInternet(() => controller.forgotPasswordApi(
                                    controller.mobileController.text.trim(),context));
                              }

                            },
                            child: const Text(
                              AppText.submit,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Input Fields

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.phoneNumberRequired;
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return AppText.enterValidPhone;
    }
    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.passwordRequired;
    } else if (value.length < 6) {
      return AppText.password6characters;
    }
    return null;
  }

  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(

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


          Expanded(
            child: Center(
              child: Text(
                AppText.allReminders,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColor.grey3,
                    fontWeight: FontWeight.w700


                ),
              ),
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


