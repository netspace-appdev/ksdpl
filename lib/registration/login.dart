/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../custom_widgets/CustomTextField.dart';
import '../../common/helper.dart';
import '../controllers/login_controller.dart';
import '../controllers/registration_dd_controller.dart';
import '../custom_widgets/CustomDialog.dart';
import '../custom_widgets/CustomElevatedButton.dart';



class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(
                      AppImage.splash,

                    ),

                    const SizedBox(height: 20),

                    Text(AppText.signIn, style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColor.lightGrey,
                    ),),

                    const SizedBox(height: 20),

                    Text(AppText.enterAccDetails, style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColor.blackColor.withOpacity(0.85),
                      fontSize: 20
                    ),),

                    const SizedBox(height: 20),


                    CustomTextField(
                        inputType: TextInputType.phone,
                        label: AppText.mobileNumber,
                        controller: controller.mobileController,
                      validator: validatePhoneNumber
                    ),

                    const SizedBox(height: 16.0),

                    Obx(() => CustomTextField(
                      inputType: TextInputType.text,
                      label: AppText.password,
                      controller: controller.passwordController,
                      isPassword: true,
                      obscureText: controller.obscurePassword.value,
                      onSuffixIconPressed: () {
                        controller.obscurePassword.value = !controller.obscurePassword.value;
                      },
                      validator: validatePassword

                    )),

                    const SizedBox(height: 16.0),

                    InkWell(
                      onTap: (){
                       // Get.delete<RegistrationDDController>();
                       // Get.toNamed("/registration");


                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(AppText.forgotYourPassword, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColor.redColor.withOpacity(0.9),
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Obx((){
                      if(controller.isLoading.value){
                        return CircularProgressIndicator();
                      }else{
                        return CustomElevatedButton(
                          text: AppText.submit,
                          color: AppColor.primaryColor,
                          height: 50,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //Get.toNamed("/bottomNavbar");
                              controller.loginApi(controller.mobileController.text,
                                  controller.passwordController.text);
                            }

                          },
                          textStyle: TextStyle(color: AppColor.appWhite,fontSize:AppFSize.mediumFont, fontWeight: FontWeight.w600),
                          width: double.infinity,
                        );
                      }
                    }),

                    const SizedBox(height: 24.0),

                    InkWell(
                      onTap: (){
                       // Get.delete<RegistrationDDController>();
                       // Get.toNamed("/registration");


                      },
                      child: Text(AppText.createNewAccount, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColor.blackColor.withOpacity(0.9),
                          fontWeight: FontWeight.w700
                      ),),
                    )



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
}*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../common/helper.dart';
import '../controllers/login_controller.dart';
import '../custom_widgets/CustomTextFieldPrefix.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
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
                      // Login Title
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Welcome Text
                      const Text(
                        "Welcome back!\nPlease login to continue",
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


                      ),
                      const SizedBox(height: 15),

                      // Password Field
                     Obx(()=> CustomTextFieldPrefix(
                       inputType:  TextInputType.text,
                       controller: controller.passwordController,
                       hintText: "Password",
                       validator: validatePassword,
                       isPassword: true,
                       obscureText: controller.obscurePassword.value,
                       onSuffixIconPressed: () {
                         controller.obscurePassword.value = !controller.obscurePassword.value;
                       },
                       prefixImage: AppImage.passwordIcon,


                     )),
                      const SizedBox(height: 10),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.orange[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                                controller.loginApi(controller.mobileController.text,
                                    controller.passwordController.text);
                              }
                              //Get.offAllNamed("/bottomNavbar");

                            },
                            child: const Text(
                              "SIGN IN",
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

                      // Signup Link
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Signup here",
                                style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
}


