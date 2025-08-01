import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/helper.dart';
import '../../common/validation_helper.dart';
import '../../controllers/addDocumentControler/documentSubmit_step_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../custom_widgets/CamImage.dart';
import '../../custom_widgets/CustomDocumentPhotoPickerWidget.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../custom_widgets/custom_photo_picker_widget.dart';

class SubmitDocument extends StatelessWidget {
  // const SubmitDocument({super.key});

  final loanApplicationController = Get.find<LoanApplicationController>();
  SubmitDocumentController incomeStepController = Get.put(SubmitDocumentController());



  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /*CustomLabeledTextField(
              label: AppText.documentsName,
              isRequired: false,
              controller: loanApplicationController.submintdocumentName,
              inputType: TextInputType.name,
              hintText: AppText.documentsName,
            ),

            CustomPhotoPickerWidget(
              controller: loanApplicationController,
              imageKey: 'ImagePath',
              label: AppText.UploadDoc,
              isCloseVisible:loanApplicationController.photosPropEnabled.value,
              isUploadActive: loanApplicationController.photosPropEnabled.value,
              toastMessage: "you can not upload photos now",
            ),*/

             SizedBox(height: 10,),

            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(loanApplicationController.addDocumentList.length, (index) {
                final ai = loanApplicationController.addDocumentList[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 20,),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        CustomLabeledTextField(
                          label: AppText.documentsName,
                          isRequired: false,
                          controller: ai.aiSourceController,
                          inputType: TextInputType.name,
                          hintText: AppText.documentsName,
                        ),

                        CustomDocumentPhotoPickerWidget(
                          imageList: ai.selectedImages,
                          label: AppText.UploadDoc,
                          isCloseVisible: loanApplicationController.photosPropEnabled.value,
                          isUploadActive: loanApplicationController.photosPropEnabled.value,
                          toastMessage: "you can not upload photos now",
                        )

                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        index== loanApplicationController.addDocumentList.length-1?
                        Obx((){
                          if(loanApplicationController.isLoading.value){
                            return const Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            );
                          }
                          return Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: (){
                                  loanApplicationController.addAdditionalSrcDocument();
                                },
                                icon: Container(

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      color: AppColor.primaryColor,

                                    ),
                                    padding: EdgeInsets.all(10),

                                    child: Icon(Icons.add, color: AppColor.appWhite,)
                                )
                            ),
                          );
                        }):
                        Container(),

                        SizedBox(height: 20),

                        Obx((){
                          if(loanApplicationController.isLoading.value){
                            return const Align(
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
                          return Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: loanApplicationController.addDocumentList.length <= 1?(){}: (){
                                  loanApplicationController.removeAdditionalSrcDocument(index);
                                },
                                icon: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      color: loanApplicationController.addDocumentList.length <= 1?AppColor.lightRed: AppColor.redColor,
                                    ),
                                    padding: EdgeInsets.all(10),

                                    child: Icon(Icons.remove, color: AppColor.appWhite,)
                                )
                            ),
                          );
                        })
                      ],
                    )
                  ],
                );
              }),
            )),
             SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.only(top: 18.0),
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
                    print('loanApplicationController.selectedBank.value: '
                        '${loanApplicationController.selectedBank.value}');

                    // Validate name
                   /* if (loanApplicationController.submintdocumentName.value.text.trim().isEmpty) {
                      SnackbarHelper.showSnackbar(
                        title: "Submit Document Page",
                        message: "Upload Document Name",
                      );
                      return;
                    }

                    // Validate each document's image
                    for (var doc in loanApplicationController.addDocumentList) {
                      if (doc.selectedImages.isEmpty) {
                        SnackbarHelper.showSnackbar(
                          title: "Submit Document Page",
                          message: "Please upload at least one image for each document.",
                        );
                        return;
                      }
                    }*/

                    // ✅ Print all selected image paths (for debug)
                    for (int i = 0; i < loanApplicationController.addDocumentList.length; i++) {
                      final doc = loanApplicationController.addDocumentList[i];
                      for (var img in doc.selectedImages) {
                        print('📸 Document $i Image Path: ${img.file?.path}');
                      }
                    }

                    // Submit
                    loanApplicationController.submitDoc();
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height
            ),
          ],
        ),
      ),
    );
  }
}
