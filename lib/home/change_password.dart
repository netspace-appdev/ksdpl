import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/profile/change_password_controller.dart';
import 'package:ksdpl/controllers/registration_dd_controller.dart';
import 'package:ksdpl/custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomTextField.dart';
import '../../common/helper.dart';
import '../common/skelton.dart';
import '../common/storage_service.dart';
import '../controllers/check_valid_email_controller.dart';
import '../controllers/checkphone_controller.dart';
import '../controllers/password_controller.dart';
import '../controllers/profile/EditProfileController.dart';
import '../controllers/regstration_controller.dart';
import '../custom_widgets/CustomElevatedButton.dart';
import '../custom_widgets/CustomTexFieldFreezed.dart';
import '../custom_widgets/CustomTextFieldListener.dart';
import '../custom_widgets/CustomTextFieldPassword.dart';
import '../custom_widgets/SnackBarHelper.dart';




class ChangePasswordScreen extends StatelessWidget {



  final ChangePasswordController changePasswordController =Get.put(ChangePasswordController());

  //No use start
  final PasswordController oldPwdController = Get.put(PasswordController(), tag: "oldPwd");
  final PasswordController newPwdController = Get.put(PasswordController(), tag: "newPwd");
  final PasswordController confirmPwdController = Get.put(PasswordController(),tag: "confirmPwd");

  // no use end

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(


          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,  color:AppColor.secondaryColor),
            ),
          ),
          title: Text(AppText.changePassword, style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColor.appWhite,
          ),),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  colors: <Color>[AppColor.primaryColor, AppColor.primaryColor]),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      Obx(() => CustomTextFieldPassword (
                        inputType: TextInputType.text,
                        label: AppText.oldPassword,
                        controller: changePasswordController.oldPassController,
                        isPassword: true,
                        obscureText: changePasswordController.oldObscurePassword.value,
                        onSuffixIconPressed: () {
                          changePasswordController.oldObscurePassword.value = !changePasswordController.oldObscurePassword.value;
                        },
                        validator: oldValidatePassword,
                        passwordStrength: oldPwdController.passwordStrength,
                        passwordStrengthColor: oldPwdController.passwordStrengthColor,
                        onChanged: (value) {
                          oldPwdController.checkPasswordStrength(value); // CALL FUNCTION HERE
                        },

                      )),
                      const SizedBox(height: 10),

                      Obx(() => CustomTextFieldPassword (
                        inputType: TextInputType.text,
                        label: AppText.newPassword,
                        controller: changePasswordController.newPassController,
                        isPassword: true,
                        obscureText: changePasswordController.newObscurePassword.value,
                        onSuffixIconPressed: () {
                          changePasswordController.newObscurePassword.value = !changePasswordController.newObscurePassword.value;
                        },
                        validator: newValidatePassword,
                        passwordStrength: newPwdController.passwordStrength,
                        passwordStrengthColor: newPwdController.passwordStrengthColor,
                        onChanged: (value) {
                          newPwdController.checkPasswordStrength(value); // CALL FUNCTION HERE
                        },

                      )),
                      const SizedBox(height: 10),

                      Obx(() => CustomTextFieldPassword (
                        inputType: TextInputType.text,
                        label: AppText.confirmPassword,
                        controller: changePasswordController.confirmPassController,
                        isPassword: true,
                        obscureText: changePasswordController.confirmObscurePassword.value,
                        onSuffixIconPressed: () {
                          changePasswordController.confirmObscurePassword.value = !changePasswordController.confirmObscurePassword.value;
                        },
                        validator: confirmValidatePassword,
                        passwordStrength: confirmPwdController.passwordStrength,
                        passwordStrengthColor: confirmPwdController.passwordStrengthColor,
                        onChanged: (value) {
                          confirmPwdController.checkPasswordStrength(value); // CALL FUNCTION HERE
                        },

                      )),

                      const SizedBox(height: 20),

                      Obx((){
                        if(changePasswordController.isLoading.value){
                          return const CircularProgressIndicator();
                        }else{
                          return CustomElevatedButton(
                            text: AppText.submit,
                            color: AppColor.primaryColor,
                            height: 50,
                            onPressed: onPressed,
                            textStyle: const TextStyle(color: AppColor.appWhite,fontSize:AppFSize.mediumFont, fontWeight: FontWeight.w600),
                            width: double.infinity,
                          );
                        }
                      }),

                      const SizedBox(height: 24.0),




                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressed(){
    if (_formKey.currentState!.validate()) {
      if (changePasswordController.newPassController.text!=changePasswordController.confirmPassController.text) {
        SnackbarHelper.showSnackbar(
            title: AppText.companyHeader,
            message: AppText.passwordMustBeSame
        );
      } else {
        changePasswordController.changePasswordApi(
         newPassword: changePasswordController.newPassController.text.toString(),
        );
      }
    }
  }



  String? oldValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.oldPasswordRequired;
    }
    return null;
  }
  String? newValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.newPasswordRequired;
    }
    return null;
  }
  String? confirmValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.confirmPasswordRequired;
    }
    return null;
  }



}
