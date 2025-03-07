import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/registration_dd_controller.dart';
import 'package:ksdpl/custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomTextField.dart';
import '../../common/helper.dart';
import '../common/skelton.dart';
import '../common/storage_service.dart';
import '../controllers/ImagePickerController.dart';
import '../controllers/check_valid_email_controller.dart';
import '../controllers/checkphone_controller.dart';
import '../controllers/password_controller.dart';
import '../controllers/profile/EditProfileController.dart';
import '../controllers/regstration_controller.dart';
import '../custom_widgets/CustomElevatedButton.dart';
import '../custom_widgets/CustomTexFieldFreezed.dart';
import '../custom_widgets/CustomTextArea.dart';
import '../custom_widgets/CustomTextFieldListener.dart';
import '../custom_widgets/CustomTextFieldPassword.dart';
import '../custom_widgets/SnackBarHelper.dart';




class LeadDetailsScreen extends StatelessWidget {


  final RegistrationDDController regDDController = Get.put(RegistrationDDController(),);
  final RegistrationController controller = Get.put(RegistrationController());
  final EditProfileController editProfileController =Get.put(EditProfileController());
  final ImagePickerController  imagePickerController = Get.put(ImagePickerController());
  //No use start
  final PasswordController pwdController = Get.put(PasswordController());
  final CheckValidEmailController checkValidEmailController = Get.put(CheckValidEmailController());

  final CheckPhoneController checkPhoneController = Get.put(CheckPhoneController());
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
          title: Text("Lead Details", style: Theme.of(context).textTheme.titleMedium!.copyWith(
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

                      Obx((){
                        if (editProfileController.isLoading.value) {
                          return  Center(child:CustomSkelton.productShimmerList(context));
                        }
                        return Column(
                          children: [
                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.companyName,
                                controller: editProfileController.companyNameController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.founderName,
                                controller: editProfileController.founderNameController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.ceoName,
                                controller: editProfileController.ceoNameController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.tagline,
                                controller: editProfileController.taglineController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.foundingDate,
                                controller: editProfileController.foundingDateController,
                                validator: validateEmployeeId
                            ),


                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.headquartLocation,
                                controller: editProfileController.headquartLocationController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.emailNoStar,
                                controller: editProfileController.emailController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.phone,
                                label: AppText.phoneNumberNoStar,
                                controller: editProfileController.phNoController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.phone,
                                label: AppText.whatsappNoNoStar,
                                controller: editProfileController.whatsappNoController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.phone,
                                label: AppText.fax,
                                controller: editProfileController.faxController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.website,
                                controller: editProfileController.websiteController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.linkedIn,
                                controller: editProfileController.linkedInController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.facebook,
                                controller: editProfileController.facebookController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),


                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.twitter,
                                controller: editProfileController.twitterController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.companyAddress,
                                controller: editProfileController.companyAddressController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.gstNumber,
                                controller: editProfileController.gstNumberController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.panNumber,
                                controller: editProfileController.panNumberController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.cinNumber,
                                controller: editProfileController.cinNumberController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                                inputType: TextInputType.text,
                                label: AppText.mapIntegration,
                                controller: editProfileController.mapIntegrationEmbedCodeController,
                                validator: validateEmployeeId
                            ),

                            const SizedBox(height: 20),

                            CustomTextArea(
                              label: AppText.privacyPolicy,
                              controller: editProfileController.privacyPolicyController,
                              maxLines: 4, // Increase lines if needed
                              validator: (value) => value!.isEmpty ? "Please enter some text" : null,

                            ),

                            const SizedBox(height: 20),

                            CustomTextArea(
                              label: AppText.termsConditions,
                              controller: editProfileController.tncController,
                              maxLines: 4, // Increase lines if needed
                              validator: (value) => value!.isEmpty ? "Please enter some text" : null,

                            ),

                          ],
                        );
                      }),
                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(AppText.companyLogo, style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.black54,
                        ),),
                      ),
                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => imagePickerController.selectedImage.value != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              Image.file(
                                imagePickerController.selectedImage.value!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 2,
                                  right: 2,
                                  child: InkWell(
                                    onTap: (){
                                      imagePickerController.selectedImage.value = null;
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 0.5,
                                              spreadRadius: 0.5
                                          )
                                        ]
                                      ),
                                      child: Icon(Icons.close, size: 15,),
                                    ),
                                  )
                              )
                            ],
                          ),
                        )
                            :
                        InkWell(
                          onTap: (){
                            imagePickerController.showImageSourceDialog();
                          },
                          child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [Colors.cyanAccent.shade700,Colors.blue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(2, 4),
                                  )
                                ],
                              ),
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo, size: 30, color: Colors.white),
                                  SizedBox(height: 5),
                                  Text(
                                    "Upload",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )

                          ),
                        )
                        ),
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
                            onPressed: (){},
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

/*  void onPressed(){
    if (_formKey.currentState!.validate()) {
      var id=StorageService.get(StorageService.BANKER_ID);
      editProfileController.addCompanyProfileApi(
        id : id.toString(),
        companyName : editProfileController.companyNameController.text.trim().toString(),
        founderName : editProfileController.founderNameController.text.trim().toString(),
        ceoName :editProfileController.ceoNameController.text.trim().toString(),
        tagline : editProfileController.taglineController.text.trim().toString(),
        foundingDate :editProfileController.foundingDateController.text.trim().toString(),
        headquartersLocation : editProfileController.headquartLocationController.text.trim().toString(),
        email : editProfileController.emailController.text.trim().toString(),
        phoneNo : editProfileController.phNoController.text.trim().toString(),
        whatsAppNo : editProfileController.whatsappNoController.text.trim().toString(),,
        fax : editProfileController.faxController.text.trim().toString(),,
        websiteURL: editProfileController.websiteController.text.trim().toString(),,
        linkedIn : editProfileController.linkedInController.text.trim().toString(),,
        facebook : editProfileController.facebookController.text.trim().toString(),,
        twitter : editProfileController.twitterController.text.trim().toString(),,
        companyAddress : editProfileController.companyAddressController.text.trim().toString(),,
        mapIntegration : editProfileController.mapIntegrationEmbedCodeController.text.trim().toString(),,
        privacyPolicy : editProfileController.privacyPolicyController.text.trim().toString(),,
        termsAndConditions : editProfileController.tncController.text.trim().toString(),,
        gstNumber : editProfileController.gstNumberController.text.trim().toString(),,
        panNumber : editProfileController.panNumberController.text.trim().toString(),,
        cinNumber : editProfileController.cinNumberController.text.trim().toString(),,
        createdDate : editProfileController.createdByController.text.trim().toString(),
        createdBy : editProfileController.creade.text.trim().toString(),,,
        updateDate : updateDate,
        updatedBy : updatedBy,
      );
    }
  }*/

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
