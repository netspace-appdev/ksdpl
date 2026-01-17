import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksdpl/common/DialogHelper.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/cibilgenerate_controller/CibilGenerateController.dart';

import '../../common/base_url.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../custom_widgets/CustomBigYesNDilogBox.dart';
import '../../custom_widgets/CustomBigYesNoLoaderDialogBox.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomImageWidget.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/camnote/GetAllPackageMasterModel.dart' as cibilPackagrList;

class Cibilgeneratepage extends StatelessWidget {

 // const Cibilgeneratepage({super.key});

  CibilGenerateController cibilGenerateController = Get.put(CibilGenerateController());
  final _formKeyQr = GlobalKey<FormState>();
  CamNoteController camNoteController=Get.put(CamNoteController());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
      
      
        body: Form(
          key:  cibilGenerateController.formKey ,
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
                            label: AppText.fullName,
                            isRequired: true,
                            controller: cibilGenerateController.camFullNameController,
                            inputType: TextInputType.name,
                            hintText: AppText.enterFullName,
                            validator:  ValidationHelper.validateName,
                          ),
                          CustomLabeledTextField(
                            label: AppText.mobilenumber,
                            isRequired: true,
                            controller: cibilGenerateController.camCibilMobController,
                            inputType: TextInputType.phone,
                            hintText: AppText.enterMBmber,
                            validator: ValidationHelper.validatePhoneNumber,
                            maxLength: 10,
                          ),

                              const CustomTextLabel(
                                label: AppText.packageName,
                                isRequired: true,

                              ),

                              const SizedBox(height: 10),

                              Obx((){
                                if (cibilGenerateController.isPackageMasterLoading.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
                                }


                                return CustomDropdown<cibilPackagrList.Data>(
                                  items: cibilGenerateController.packageMasterList  ?? [],
                                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                  getName: (item) => item.packageName.toString(),
                                  selectedValue: cibilGenerateController.packageMasterList.firstWhereOrNull(
                                        (item) => item.id == cibilGenerateController.selectedCibilPackage.value,
                                  ),
                                  onChanged: (value) {
                                /*    if(value?.qRImage!=null){
                                      DialogHelper.showPickUpConditionDialog(
                                          context: context,
                                          leadId: "0",
                                          imageURL:  BaseUrl.imageBaseUrl+value!.qRImage.toString()??""

                                      );
                                    }
                                    cibilGenerateController.selectedCibilPackage.value =  value?.id;
                                    cibilGenerateController.camAmountRecoveredController.text=value?.amount.toString()??"0";*/

                                    cibilGenerateController.selectedCibilPackage.value =  value?.id;
                                    cibilGenerateController.camAmountRecoveredController.text=value?.amount.toString()??"0";

                                    print("cibilGenerateController.selectedCibilPackage.value-====${cibilGenerateController.selectedCibilPackage.value}");
                                    if(cibilGenerateController.selectedCibilPackage.value!=null){

                                      if(value?.qRImage!=null){
                                        showPackageQRDialog(
                                            context: context,
                                            imageURL:  BaseUrl.imageBaseUrl+value!.qRImage.toString()??"",
                                            packageId: cibilGenerateController.selectedCibilPackage.value.toString()

                                        );
                                      }

                                    }
                                  },
                                  onClear: (){
                                    cibilGenerateController.selectedCibilPackage.value = 0;
                                    cibilGenerateController.camAmountRecoveredController.clear();
                                  },
                                );
                              }),


                              const SizedBox(height: 20),

                              CustomLabeledTextField(
                            label: AppText.amountToBeRecovered,
                            controller: cibilGenerateController.camAmountRecoveredController,
                            inputType: TextInputType.number,
                            hintText: AppText.enterAmountCibil,
                            isRequired: true,
                            validator:ValidationHelper.validatecibilamount ,
                            isInputEnabled: false,
                            //isInputEnabled: cibilGenerateController.enableAllCibilFields.value,
                          ),

                          CustomLabeledPickerTextField(
                            label: AppText.receivedDate,
                            controller: cibilGenerateController.camReceivableDateController,
                            inputType: TextInputType.name,
                            hintText: AppText.mmddyyyy,
                            isDateField: true,
                            isRequired: true,
                            isFutureDisabled: true,
                            validator:ValidationHelper.validateReceivedDate ,

                          ),

                          CustomLabeledTextField(
                            label: AppText.transactionDetails,
                            controller: cibilGenerateController.camTransactionDetailsController,
                            inputType: TextInputType.name,
                            isRequired: true,
                            hintText: AppText.enterTransactionDetails,
                            validator:ValidationHelper.validateUTR ,

                          ),

                         /* SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              // onPressed: onPressed,
                              onPressed: () {
                                if (cibilGenerateController.formKey.currentState?.validate() ?? false) {

                                  cibilGenerateController.addCustomerCibilRequestApi();

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
                          ),*/

                              Obx((){
                                if(cibilGenerateController.isLoading.value){
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
                                      if (cibilGenerateController.formKey.currentState?.validate() ?? false) {

                                        cibilGenerateController.addCustomerCibilRequestApi();

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
                                );
                              }),
                              const SizedBox(height: 20),
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
            AppText.genCibil,
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

  void showPackageQRDialog({
    required BuildContext context,
    required String imageURL,
    required String packageId,

  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigYesNoDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Scan the QR Code",
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomImageWidget(
                    imageUrl: imageURL,
                    // imageUrl: "",
                    height: 300,
                    width: MediaQuery.of(context).size.width
                ),

                const SizedBox(height: 12),

                // C. Hindi
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                    children: [
                      TextSpan(
                          text: "Please Scan the QR Code to continue or \nSend QR on WhatsApp",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          firstButtonText: "WhatsApp",
          onFirstButtonPressed: (){
            Get.back();
            cibilGenerateController.qrCBCustomerNameController.clear();
            cibilGenerateController.qrCBWhatsappController.clear();
            showQRCustomerNUmberDialog(
              context: context,
              packageId: packageId,
            );

          },
          secondButtonText: "No, Thanks",
          onSecondButtonPressed: (){
            Get.back();
          },
          firstButtonColor: AppColor.primaryColor,
          secondButtonColor: AppColor.redColor,
        );
      },
    );
  }


  void showQRCustomerNUmberDialog({
    required BuildContext context,
    required String packageId,
  })
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => CustomBigYesNoLoaderDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Customer Details",
          content: SingleChildScrollView(
            child: Form(
              key: _formKeyQr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabeledTextField(
                    label: AppText.customerName,
                    isRequired: true,
                    controller: cibilGenerateController.qrCBCustomerNameController,
                    inputType: TextInputType.name,
                    hintText: AppText.enterCustomerName,
                    validator: ValidationHelper.validateName,
                  ),
                  const SizedBox(height: 15),
                  CustomLabeledTextField(
                    label: AppText.whatsappNoNoStar,
                    isRequired: true,
                    controller: cibilGenerateController.qrCBWhatsappController,
                    inputType: TextInputType.number,
                    hintText: AppText.enterWhatsappNo,
                    validator: ValidationHelper.validateWhatsapp,
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                      children: [
                        TextSpan(
                          text: "Send QR on above WhatsApp Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 👇 Loader logic right here
          firstButtonChild: camNoteController.isQRApiLoading.value
              ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Text(
            "Send",
            style: TextStyle(color: Colors.white),
          ),

          secondButtonText: "Cancel",
          firstButtonColor: AppColor.primaryColor,
          secondButtonColor: AppColor.redColor,

          onFirstButtonPressed: () {
            if (!camNoteController.isQRApiLoading.value &&
                _formKeyQr.currentState!.validate()) {
              camNoteController.sendPaymentQRCodeOnWhatsAppToCustomerApi(
                CustomerName: cibilGenerateController.qrCBCustomerNameController.text.trim(),
                CustomerWhatsAppNo: cibilGenerateController.qrCBWhatsappController.text.trim(),
                PackageId: packageId,
              ).then((_){
                Get.back();
              });
            }
          },
          onSecondButtonPressed: () {
            Get.back();
          },
        ));
      },
    );
  }

}
