import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/controllers/more/changeEmailController.dart';
import 'package:lottie/lottie.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../common/validation_helper.dart';
import '../../controllers/cibilgenerate_controller/CibilGenerateController.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/more/ChangeContactNumberController.dart';
import '../../controllers/more/changePasswordController.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';
import '../custom_drawer.dart';

class ChangeEmail extends StatelessWidget {

  ChangeEmailController changeEmailController = Get.put(ChangeEmailController());


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key:_scaffoldKey,
        backgroundColor: AppColor.backgroundColor,
        body: Form(
        key:  changeEmailController.formKey ,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child:Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        header(context),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,  // Centers it
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Container(
                        margin:  EdgeInsets.only(
                            top:90 // MediaQuery.of(context).size.height * 0.22
                        ), // <-- Moves it 30px from top
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height/1.2,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        decoration: const BoxDecoration(
                          color: AppColor.backgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                          ),
                        ),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                                children: [
                                  Center(
                                    child: Container(
                                        height: MediaQuery.of(context).size.width * 0.45,
                                        width: MediaQuery.of(context).size.width * 0.85,
                                        child: Lottie.asset(
                                            AppImage.login_successJson,
                                            repeat: false
                                        )),
                                  ),

                                 SizedBox(height: MediaQuery.of(context).size.height*0.04,),

                                  CustomLabeledTextField(
                                    inputType:  TextInputType.text,
                                    controller: changeEmailController.emailController,
                                    hintText: "Enter New Email",
                                    isRequired: true,
                                    validator: ValidationHelper.validateEmail,
                                    obscureText: false,
                                    label: AppText.eml,
                                  ),

                                  CustomLabeledTextField(
                                    isInputEnabled: false,
                                    inputType:  TextInputType.phone,
                                    controller: changeEmailController.mobileController,
                                    hintText: '',
                                    isRequired: true,
                                    isPassword: false,
                                    obscureText: false,
                                    maxLength: 10,
                                    label: AppText.login,
                                  ),

                                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: SizedBox(
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
                                    if (changeEmailController.formKey.currentState?.validate() ?? false) {
                                      print("Form is valid");
                                      changeEmailController.changeEmailRequestApi();
                                    } else {
                                      // Some validation failed
                                      print("Form is not valid");
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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

  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
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
            AppText.changeEmail,
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
              child: Center(child: Icon(Icons.filter_alt_outlined, color: Colors.transparent,),),
            ),
          )
        ],
      ),
    );
  }
}
