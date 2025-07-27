import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../common/helper.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/more/changePasswordController.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';

class Changepassword extends StatelessWidget {

  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

  InfoController infoController = Get.put(InfoController());
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key:_scaffoldKey,
        backgroundColor: AppColor.backgroundColor,
    //    drawer:   CustomDrawer(),
        body: Form(
        key:  changePasswordController.formKey ,
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
                                  //SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                                  Container(
                                      height: MediaQuery.of(context).size.width * 0.45,
                                      width: MediaQuery.of(context).size.width * 0.85,
                                      child: Image.asset(AppImage.changePassword),

                                  ),
                                  Obx(()=> CustomTextFieldPrefix(
                                    inputType:  TextInputType.text,
                                    controller: changePasswordController.oldPasswordController,
                                    hintText: "Old Password",
                                    validator: validatePassword,
                                    isPassword: true,
                                    obscureText: changePasswordController.obscurePassword.value,
                                    onSuffixIconPressed: () {
                                      changePasswordController.obscurePassword.value = !changePasswordController.obscurePassword.value;
                                    },
                                    prefixImage: AppImage.passwordIcon,
                                  )),

                                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                                  Obx(()=> CustomTextFieldPrefix(
                                    inputType:  TextInputType.text,
                                    controller: changePasswordController.newPasswordController,
                                    hintText: "New Password",
                                    validator: validatePassword,
                                    isPassword: true,
                                    obscureText: changePasswordController.obscureNewPassword.value,
                                    onSuffixIconPressed: () {
                                      changePasswordController.obscureNewPassword.value = !changePasswordController.obscureNewPassword.value;
                                    },
                                    prefixImage: AppImage.passwordIcon,
                                  )),

                                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                                  Obx(()=> CustomTextFieldPrefix(
                                    inputType:  TextInputType.text,
                                    controller: changePasswordController.confirmPasswordController,
                                    hintText: "Confirm Password",
                                    validator: validateConfirmPassword,
                                    isPassword: true,
                                    obscureText: changePasswordController.obscureConfirmPassword.value,
                                    onSuffixIconPressed: () {
                                      changePasswordController.obscureConfirmPassword.value = !changePasswordController.obscureConfirmPassword.value;
                                    },
                                    prefixImage: AppImage.passwordIcon,
                                  )),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Obx((){
                              if(addleadcontroller.isLoading.value){
                                return SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: AppColor.primaryColor,
                                  ),
                                );
                              }
                              return Align(
                                alignment: Alignment.bottomCenter,

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
                                if (changePasswordController.formKey.currentState?.validate() ?? false) {
                                  // Compare new and confirm password
                                  if (changePasswordController.newPasswordController.text !=
                                      changePasswordController.confirmPasswordController.text) {
                                    ToastMessage.msg(AppText.passwordMustBeSame);

                                    return;
                                  }

                                  changePasswordController.CheckOldPasswordRequestApi();
                                  // ✅ All validations passed
                                  print("Form is valid");
                                  // call your API or logic here
                                } else {
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
                              );
                            })
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.passwordRequired;
    } else if (value.length < 6) {
      return AppText.password6characters;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.confirmPasswordRequired;
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
              changePasswordController.clearFormFields();
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
            AppText.changePassword,
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
