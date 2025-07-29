import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/customFilePicker.dart';
import '../../common/helper.dart';
import '../../common/validation_helper.dart';
import '../../controllers/FilePickerController.dart';
import '../../controllers/addEmployeeExpenseDetailsController/addEmployeeExpenseDetailsController.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';

class EditEmployeeExpenseDetail extends StatelessWidget {
  // const EditEmployeeExpenseDetail({super.key});

  AddEmployeeExpenseDetailsController addExpenseController = Get.put(AddEmployeeExpenseDetailsController());
  final FilePickerController filePickerController = Get.find();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Form(
          key:  addExpenseController.formKey ,
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
                    // White Container
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
                                    Container(
                                      height: MediaQuery.of(context).size.width * 0.35,
                                      //       width: MediaQuery.of(context).size.width * 0.45,
                                      child: Center(child: Image.asset(AppImage.choosefile)),
                                    ),

                                    CustomLabeledPickerTextField(
                                      label: AppText.expenseDate,
                                      controller: addExpenseController.camExpenseDateController,
                                      inputType: TextInputType.name,
                                      hintText: AppText.mmddyyyy,
                                      isDateField: true,
                                      isRequired: false,
                                      isFutureDisabled: true,
                                      validator:ValidationHelper.validateExpenseDate ,
                                    ),

                                    CustomFilePickerWidget(
                                      controller: filePickerController,
                                      fileKey: "docs",
                                      label:AppText.UploadDoc,
                                      isCloseVisible: true,
                                      isUploadActive: true,
                                      toastMessage: "",
                                      validator: (val) {
                                        if (filePickerController
                                            .getFiles("docs")
                                            .isEmpty) {
                                          return AppText.uploaddoc;
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height:10,),

                                    CustomLabeledTextField(
                                      label: AppText.pofileDescriptions,
                                      isRequired: false,
                                      controller: addExpenseController.camDescriptionController,
                                      inputType: TextInputType.name,
                                      hintText: AppText.pofileDescriptions,
                                      validator: ValidationHelper.validateDescription,
                                    ),
                                    const Text(
                                       AppText.UploadDoc,
                                    style:  TextStyle(color: AppColor.grey2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                    SizedBox(height: 5),
                                     InkWell(
                                      onTap: (){
                                         addExpenseController.launchURL();
                                      },
                                      child: Container(
                                        padding:  EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue), // Border color
                                          borderRadius: BorderRadius.circular(6), // Corner radius
                                          color: Colors.white, // Optional background
                                        ),
                                        child:  Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.download, size: 20, color: Colors.blue),
                                            const SizedBox(width: 6),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.4,
                                              child: Text(
                                                addExpenseController.getExpenseDetailById.value?.data?.documents.toString()??'',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              Obx((){
                                if(addExpenseController.isLoading.value){
                                  return Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  );
                                }
                                return   Align(
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
                                        if (addExpenseController.formKey.currentState?.validate() ?? false) {
                                          //   print("Form is valid");
                                          addExpenseController.updateExpenseDetailsRequestApi();
                                        } else {
                                          // Some validation failed
                                          print("Form is not valid");
                                        }
                                      }, child: const Text(
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
            AppText.editExpenses,
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
