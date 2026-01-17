import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/customFilePicker.dart';

import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/FilePickerController.dart';
import '../../controllers/ticketControllers/raiseTicketController.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomTextArea.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../custom_widgets/custom_photo_picker_widget.dart';

class RaiseTicketScreen extends StatelessWidget {
  //const RaiseTicketScreen({super.key});

  RaiseTicketController raiseTicketController = Get.put(RaiseTicketController());
  final _formKeyQr = GlobalKey<FormState>();
 // CamNoteController camNoteController=Get.put(CamNoteController());
  final filePickerController = Get.put(FilePickerController());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,


        body: Form(
          key:  raiseTicketController.formKey ,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Gradient Background
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
                            height: 20,
                          ),
                          header(context),
                        ],
                      ),
                    ),
                    // White Container
                    Align(
                      alignment: Alignment.topCenter,  // Centers it
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          margin:  EdgeInsets.only(
                              top:90 // MediaQuery.of(context).size.height * 0.22
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                            children: [
                              CustomLabeledTextField(
                                label: AppText.subject,
                                isRequired: true,
                                controller: raiseTicketController.subjectController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterFullName,
                                validator:  ValidationHelper.validateSubject,
                              ),

                              const CustomTextLabel(
                                label: AppText.panel,
                                isRequired: true,
                              ),
                              SizedBox(height: 5,),

                              Obx((){
                                if (raiseTicketController.isPackageMasterLoading.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
                                }


                                return CustomDropdown<DropdownItem>(
                                  items: raiseTicketController.queryTypeList,
                                  getId: (item) => item.id.toString(),
                                  getName: (item) => item.name,
                                  selectedValue: raiseTicketController.queryTypeList.firstWhereOrNull(
                                        (item) => item.id == raiseTicketController.selectedType.value,
                                  ),
                                  onChanged: (value) {
                                    raiseTicketController.selectedType.value = value?.id.toString()??'';
                                  },
                                  onClear: () {
                                    raiseTicketController.selectedType.value = "";
                                  },
                                );
                              }),

                              SizedBox(height: 16,),
                              const CustomTextLabel(
                                label: AppText.priority,
                                isRequired: true,

                              ),
                              SizedBox(height: 5,),

                              Obx((){
                                if (raiseTicketController.isPackageMasterLoading.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
                                }
                                return CustomDropdown<DropdownItem>(
                                  items: raiseTicketController.priorityList,
                                  getId: (item) => item.id.toString(),
                                  getName: (item) => item.name,
                                  selectedValue: raiseTicketController.priorityList.firstWhereOrNull(
                                        (item) => item.id == raiseTicketController.selectedPriority.value,
                                  ),
                                  onChanged: (value) {
                                    raiseTicketController.selectedPriority.value = value?.id.toString()??'';
                                  },
                                  onClear: () {
                                    raiseTicketController.selectedPriority.value = "";
                                  },
                                );

                              }),

                              const SizedBox(height: 15),
                              CustomFilePickerWidget(
                                controller: filePickerController,
                                fileKey: AppText.file,
                                label: AppText.image,
                                isCloseVisible: true,
                                isUploadActive: true,
                                toastMessage: "",
                                validator: (val) {
                                  if (filePickerController
                                      .getFiles(AppText.file)
                                      .isEmpty) {
                                    return AppText.uploaddoc;
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 10),

                              CustomTextLabel(
                                label: AppText.issueDetail,
                                isRequired: true,
                              ),

                              const SizedBox(height: 10),
                              CustomTextArea(
                                label: AppText.issueDetailDes,
                                controller: raiseTicketController.issueDetailController,
                                maxLines: 5, // Increase lines if needed
                                validator: (value) => value!.isEmpty ? AppText.issueDetail : null,
                              ),
                              const SizedBox(height: 15),

                              Obx(() {
                                if (raiseTicketController.isLoading.value) {
                                  return const SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(color: AppColor.primaryColor),
                                    ),
                                  );
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
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

                                        if (raiseTicketController.formKey.currentState!.validate()) {
                                          if(raiseTicketController.selectedType.isEmpty){
                                            SnackbarHelper.showSnackbar(title: "Error", message: "Select The Type");
                                          }
                                          else if(raiseTicketController.selectedPriority.isEmpty){
                                            SnackbarHelper.showSnackbar(title: "Error", message: "Select The Priority");
                                          }
                                          else{

                                           raiseTicketController.addTicketApiResponse(
                                           panelId:raiseTicketController.selectedType.value,
                                           subject:raiseTicketController.subjectController.text.trim(),
                                           category:"1",
                                           priority:raiseTicketController.selectedPriority.value,
                                           issueDetails:raiseTicketController.issueDetailController.text.trim(),
                                           createdBy:"",
                                           );


                                            //https://devapi.kanchaneshver.com/api/Ticket/AddTicket
                                            //https://devapi.kanchaneshver.com/api/Ticket/GetAllTicket

                                      }
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
                              }),


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
            AppText.ticketRaise,
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
