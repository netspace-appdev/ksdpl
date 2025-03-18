/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/registration_dd_controller.dart';
import 'package:ksdpl/custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomTextField.dart';
import '../../common/helper.dart';
import '../common/skelton.dart';
import '../controllers/check_valid_email_controller.dart';
import '../controllers/checkphone_controller.dart';
import '../controllers/password_controller.dart';
import '../controllers/regstration_controller.dart';
import '../custom_widgets/CustomElevatedButton.dart';
import '../custom_widgets/CustomTexFieldFreezed.dart';
import '../custom_widgets/CustomTextFieldListener.dart';
import '../custom_widgets/CustomTextFieldPassword.dart';
import '../custom_widgets/SnackBarHelper.dart';




class RegistrationScreen extends StatelessWidget {


  final RegistrationDDController regDDController = Get.put(RegistrationDDController(),);
  final RegistrationController controller = Get.put(RegistrationController());
  final PasswordController pwdController = Get.put(PasswordController());
  final CheckValidEmailController checkValidEmailController = Get.put(CheckValidEmailController());

  final CheckPhoneController checkPhoneController = Get.put(CheckPhoneController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

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

                      Image.asset(
                        AppImage.splash,

                      ),

                      const SizedBox(height: 20),

                      Text(AppText.lenderPanel, style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColor.primaryColor,
                      ),),

                      const SizedBox(height: 20),

                      Text(AppText.registration, style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColor.lightGrey,
                      ),),

                      const SizedBox(height: 20),

                      Obx((){
                        if (regDDController.isLoading.value) {
                          return  Center(child:CustomSkelton.productShimmerList(context));
                        }
                        if (regDDController.banks.isEmpty) {
                          return const Text(AppText.noOptions);
                        }
                          return CustomDropdown(
                            items:regDDController.banks,
                            hintText: AppText.bank,
                            selectedValue: regDDController.selectedBank.value,
                            onChanged: (value) {

                              regDDController.selectedBank.value=value!;

                              regDDController.getAllBranchByBankIdApi(value);
                            },
                          );


                      }),

                      */
/*      Obx(() {
                        if (regDDController.isLoading.value) {
                          return Center(child: CustomSkelton.productShimmerList(context));
                        }

                        // If no data is available, show a disabled dropdown instead of plain text
                        return CustomDropdown(
                          items: regDDController.banks.isEmpty
                              ? [] // Pass empty list if no options
                              : regDDController.banks,
                          hintText: regDDController.banks.isEmpty
                              ? "No options available" // Change the hint text dynamically
                              : AppText.bank,
                          selectedValue: regDDController.banks.isEmpty
                              ? null // No selection if there are no options
                              : regDDController.selectedBank.value,
                          onChanged: regDDController.banks.isEmpty
                              ? (value) {} // Provide an empty function instead of null
                              : (value) {
                            regDDController.selectedBank.value = value!;
                            regDDController.getAllBranchByBankIdApi(value);
                          },
                        );
                      }),*//*


                      const SizedBox(height: 20),

                      Obx((){
                        if (regDDController.isLoading.value) {
                          return  Center(child:CustomSkelton.productShimmerList(context));
                        }

                          return CustomDropdown(
                            items:regDDController.branches,
                            hintText: AppText.branch,
                            selectedValue: regDDController.selectedBranch.value,
                            onChanged: (value) {

                              regDDController.selectedBranch.value=value!;

                            },
                          );


                      }),

                      const SizedBox(height: 20),

                      Obx((){
                        if (regDDController.isLoading.value) {
                          return  Center(child:CustomSkelton.productShimmerList(context));
                        }else{
                          return CustomDropdown(
                            items:regDDController.roleLevelList,
                            hintText: AppText.roleLevel,
                            selectedValue: regDDController.selectedRoleLevel.value,
                            onChanged: (value) {

                              regDDController.selectedRoleLevel.value=value!;
                              regDDController.getBankerRoleByLevelAndBankIdApi(
                                  regDDController.selectedRoleLevel.value.toString(),
                                  regDDController.selectedBank.value.toString());
                            },
                          );
                        }

                      }),

                      ///Role

                      const SizedBox(height: 20),

                      Obx((){
                        if (regDDController.isLoading.value) {
                          return  Center(child:CustomSkelton.productShimmerList(context));
                        }else{
                          return CustomDropdown(
                            items:regDDController.roleList,
                            hintText: AppText.role,
                            selectedValue: regDDController.selectedRole.value,
                            onChanged: (value) {

                              regDDController.selectedFuncSupervisor=Rxn<String>();
                              regDDController. funcSupervisorList.clear();

                              regDDController.selectedRole.value=value!;
                              var selectedRoleObj = regDDController.roleList.firstWhere(
                                    (element) => element["id"] == value,
                                orElse: () => {},
                              );

                              regDDController.functionalSupervisorApi(
                                  regDDController.selectedBank.value.toString(),
                                  regDDController.selectedBranch.value.toString(),
                                  selectedRoleObj["shortRole"].toString(),
                                  "0");

                              regDDController.adminSupervisorApi(
                                  regDDController.selectedBank.value.toString(),
                                  regDDController.selectedBranch.value.toString(),
                                  selectedRoleObj["shortRole"].toString(),
                                  );
                            },
                          );
                        }

                      }),

                      ///Func. Supervisor

                      const SizedBox(height: 20),

                      Obx((){
                        if (regDDController.isLoading.value) {
                          return  Center(child:CustomSkelton.productShimmerList(context));
                        }else{
                          return CustomDropdown(
                            items:regDDController.funcSupervisorList,
                            hintText: AppText.functionalSupervisorName,
                            selectedValue: regDDController.selectedFuncSupervisor.value,
                            onChanged: (value) {

                              regDDController.selectedFuncSupervisor.value=value!;
                              var selectedRoleObj = regDDController.funcSupervisorList.firstWhere(
                                    (element) => element["id"] == value,
                                orElse: () => {},
                              );

                              controller.functionalSupervisorMobileController.text=selectedRoleObj["contact"].toString();
                              controller.functionalSupervisorEmailController.text=selectedRoleObj["email"].toString();

                            },
                          );
                        }

                      }),

                      const SizedBox(height: 20),

                      CustomTextFieldFreezed(
                          inputType: TextInputType.text,
                          label: AppText.functionalSupervisorMobile,
                          controller: controller.functionalSupervisorMobileController,

                      ),

                      const SizedBox(height: 20),

                      CustomTextFieldFreezed(
                          inputType: TextInputType.text,
                          label: AppText.functionalSupervisorEmail,
                          controller: controller.functionalSupervisorEmailController,

                      ),

                      ///Admin. Supervisor

                      const SizedBox(height: 20),

                      Obx((){
                        if (regDDController.isLoading.value) {
                          return  Center(child:CustomSkelton.productShimmerList(context));
                        }else{
                          return CustomDropdown(
                            items:regDDController.adminSupervisorList,
                            hintText: "Administrative Supervisor Name*",
                            selectedValue: regDDController.selectedAdminSupervisor.value,
                            onChanged: (value) {

                              regDDController.selectedAdminSupervisor.value=value!;
                              var selectedRoleObj = regDDController.adminSupervisorList.firstWhere(
                                    (element) => element["id"] == value,
                                orElse: () => {},
                              );

                              controller.adminSupervisorMobileController.text=selectedRoleObj["contact"].toString();
                              controller.adminSupervisorEmailController.text=selectedRoleObj["email"].toString();

                            },
                          );
                        }

                      }),



                      const SizedBox(height: 20),

                      CustomTextFieldFreezed(
                          inputType: TextInputType.text,
                          label: AppText.administrativeSupervisorMobile,
                          controller: controller.adminSupervisorMobileController,

                      ),

                      const SizedBox(height: 20),

                      CustomTextFieldFreezed(
                          inputType: TextInputType.text,
                          label: AppText.administrativeSupervisorEmail,
                          controller: controller.adminSupervisorEmailController,

                      ),


                      const SizedBox(height: 20),

                      Helper.customDivider(
                          color: AppColor.lightGrey
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                          inputType: TextInputType.text,
                          label: AppText.employeeID,
                          controller: controller.employeeIdController,
                          validator: validateEmployeeId //change it
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                          inputType: TextInputType.text,
                          label: AppText.lenderName,
                          controller: controller.lenderNameController,
                          validator: validateLenderName //change it
                      ),

                      const SizedBox(height: 20),

                      CustomTextFieldListener(
                          inputType: TextInputType.phone,
                          label: AppText.contactNo,
                          controller: controller.contactNoController,
                          validator: validatePhoneNumber //change it
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                          inputType: TextInputType.phone,
                          label: AppText.whatsappNo,
                          controller: controller.whatsappNoController,
                          validator: validatePhoneNumber //change it
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                          inputType: TextInputType.emailAddress,
                          label: AppText.email,
                          controller: controller.emailController,
                          validator: validateEmail,
                          onChanged: (value) {
                          checkValidEmailController.checkValidEmail(value);// CALL FUNCTION HERE
                          },

                      ),

                      const SizedBox(height: 20),

                      Obx(() => CustomTextFieldPassword (
                        inputType: TextInputType.text,
                          label: AppText.passwordStar,
                          controller: controller.passwordController,
                          isPassword: true,
                          obscureText: controller.obscurePassword.value,
                          onSuffixIconPressed: () {
                            controller.obscurePassword.value = !controller.obscurePassword.value;
                          },
                          validator: validatePassword,
                        passwordStrength: pwdController.passwordStrength,
                        passwordStrengthColor: pwdController.passwordStrengthColor,
                        onChanged: (value) {
                          pwdController.checkPasswordStrength(value); // CALL FUNCTION HERE
                        },

                      )),


                      const SizedBox(height: 20),


                      Helper.customDivider(
                        color: AppColor.lightGrey
                      ),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Obx((){
                            return Checkbox(
                              value: controller.isTermsChecked.value, // Current state of the checkbox
                              onChanged: (bool? value) {

                                controller.isTermsChecked.value = value ?? false;

                              },
                            );
                          }),
                          Text(AppText.iAgreeTC),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx((){
                        if(controller.isLoading.value){
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppText.alreadyRegistered, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColor.lightGrey,
                          ),),
                          InkWell(
                            onTap: (){
                              Get.toNamed("/login");

                            },
                            child: Text(AppText.login, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w400
                            ),),
                          )
                        ],
                      )



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
      if ((regDDController.selectedBank.value ?? "").isEmpty) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message: AppText.pleaseSelectBank
        );
      } else if ((regDDController.selectedBranch.value ?? "").isEmpty) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message: AppText.pleaseSelectBranch
        );
      } else if ((regDDController.selectedRoleLevel.value ?? "").isEmpty) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message:  AppText.pleaseSelectRoleLevel
        );
      } else if ((regDDController.selectedRole.value ?? "").isEmpty) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message:  AppText.pleaseSelectRole
        );
      } else if ((regDDController.selectedFuncSupervisor.value ?? "").isEmpty) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message:  AppText.pleaseSelectFuncSupervisor
        );
      } else if ((regDDController.selectedAdminSupervisor.value ?? "").isEmpty) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message: AppText.pleaseSelectAdminSupervisor
        );
      }else if (!controller.isTermsChecked.value) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message: AppText.pleaseSelectTnC
        );
      } else if (!checkPhoneController.isPhoneNumberExists.value) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message:AppText.phoneInUse
        );
      }else if (!checkValidEmailController.isValidEmail.value) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message: AppText.validEmailWarning
        );
      }else if (pwdController.passwordStrength.value==AppText.weakPassword) {
        SnackbarHelper.showSnackbar(
            title: AppText.mrb,
            message: AppText.weakPassword
        );
      }else {

        var role=regDDController.selectedRole.value;
        var selectedRoleObj = regDDController.roleList.firstWhere(
              (element) => element["id"] == role,
          orElse: () => {},
        );

        var namePart=Helper.splitName(controller.lenderNameController.text.toString());


        var data=regDDController.selectedFuncSupervisor.value;
        var funcSupervisorObj = regDDController.funcSupervisorList.firstWhere(
              (element) => element["id"] == data,
          orElse: () => {},
        );
        var data1=regDDController.selectedAdminSupervisor.value;
        var adminSupervisorObj = regDDController.adminSupervisorList.firstWhere(
              (element) => element["id"] == data1,
          orElse: () => {},
        );



        controller.validateBankerRegistrationRoleApi(
          bankId: regDDController.selectedBank.value.toString(),
          branchId: regDDController.selectedBranch.value.toString(),
          shortName:  selectedRoleObj["shortRole"].toString(),
          emailId: controller.emailController.text.toString(),
          userName:  controller.emailController.text.toString(),
          firstName: namePart["firstName"].toString(),
          lastName: namePart["lastName"].toString(),
          password: controller.passwordController.text.toString(),
          phoneNumber: controller.contactNoController.text.toString(),
          role:  selectedRoleObj["name"].toString(),

          id:"0",
          bankerCode:controller.employeeIdController.text.toString(),
          bankerName:controller.lenderNameController.text.toString(),
          contactNo:controller.contactNoController.text.toString(),
          whatsappNo:controller.whatsappNoController.text.toString(),
          email:controller.emailController.text.toString(),
          supervisorName:funcSupervisorObj["name"].toString(),//don't know
          supervisorMobileNo:controller.functionalSupervisorMobileController.text.toString(),
          supervisorEmail:controller.functionalSupervisorEmailController.text.toString(),
          levelId:regDDController.selectedRoleLevel.value.toString(),
          admSupervisorName:adminSupervisorObj["name"].toString(), //don't know
          admSupervisorMobileNo:controller.adminSupervisorMobileController.text.toString(),
          admSupervisorEmail:controller.adminSupervisorEmailController.text.toString(),
          supervisorId:regDDController.selectedFuncSupervisor.value.toString(),
          admSupervisorId:regDDController.selectedAdminSupervisor.value.toString(),
          roleAsShortRole:selectedRoleObj["shortRole"].toString(),

        );
      }
    }
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
    }
    return null;
  }
 ///start
  String? validateEmployeeId(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.passwordRequired;
    }
    return null;
  }
  String? validateLenderName(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.passwordRequired;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    // Regular expression for a valid email format
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid email address";
    }

    return null; // Email is valid
  }

}
*/
