import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/common/validation_helper.dart';
import 'package:lottie/lottie.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/addDocumentControler/documentSubmit_step_controller.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../custom_widgets/CustomBigYesNoLoaderDialogBox.dart';
import '../../custom_widgets/CustomDocumentPhotoPickerWidget.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../custom_widgets/SnackBarHelper.dart';

class Step10Form extends StatelessWidget {

  final loanApplicationController = Get.find<LoanApplicationController>();
  SubmitDocumentController incomeStepController = Get.put(SubmitDocumentController());


  @override
  Widget build(BuildContext context) {
    final data = loanApplicationController.loanApplicationDocumentByLoanIdModel.value?.data ?? [];

    return  SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            ExpansionTile(
              initiallyExpanded: true,
              childrenPadding: EdgeInsets.symmetric(horizontal: 20),
              title:const Text( AppText.UploadDoc, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
              leading: Icon(Icons.list_alt, size: 20,),
              children: [

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
                              isRequired: true,
                              controller: ai.aiSourceController,
                              inputType: TextInputType.name,
                              hintText: AppText.documentsName,
                              validator: ValidationHelper.validateDocName,
                              isInputEnabled: !ai.isDocNameDisabled.value,
                            ),

                            if(!ai.isDocSubmitted.value)
                              Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               if(ai.isThisGenerated.value)
                                 Column(
                                   children: [
                                     const CustomTextLabel(
                                       label:  AppText.documentStatusByCustomer,
                                       isRequired: true,
                                     ),

                                     const SizedBox(height: 10),

                                     Obx((){
                                       if (loanApplicationController.isLoading.value) {
                                         return  Center(child:CustomSkelton.productShimmerList(context));
                                       }


                                       return CustomDropdown<String>(
                                         items: loanApplicationController.docCustomerStList,
                                         getId: (item) => item,  // Adjust based on your model structure
                                         getName: (item) => item,

                                         selectedValue: ai.selectedDocStatusCus.value,
                                         onChanged: (value) {
                                           ai.selectedDocStatusCus.value =  value.toString();
                                         },
                                       );
                                     }),
                                     SizedBox(height: 20,),
                                   ],
                                 ),

                               CustomDocumentPhotoPickerWidget(
                                 imageList: ai.selectedImages,
                                 label: AppText.UploadDoc,
                                 isCloseVisible: loanApplicationController.photosPropEnabled.value,
                                 isUploadActive: loanApplicationController.photosPropEnabled.value,
                                 toastMessage: AppText.cannotupload,
                               )
                             ],
                           )

                          ],
                        ),
                        if(!ai.isDocSubmitted.value)
                          Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            if(ai.isThisGenerated.value==false)
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
                                        // child: CircularProgressIndicator(
                                        //   color: AppColor.primaryColor,
                                        // ),
                                      ),
                                    );
                                  }
                                  return Align(
                                    alignment: Alignment.centerRight,
                                    child: loanApplicationController.loanApplicationDocumentByLoanIdModel.value?.data==null?
                                    SizedBox():
                                    IconButton(
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
                                        // child: CircularProgressIndicator(
                                        //   color: AppColor.primaryColor,
                                        // ),
                                      ),
                                    );
                                  }
                                  return Align(
                                    alignment: Alignment.centerRight,
                                    child: loanApplicationController.loanApplicationDocumentByLoanIdModel.value?.data==null?
                                    SizedBox():IconButton(
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
                                }),
                              ],),


                            ElevatedButton(
                              onPressed: () {
                                /*if(loanApplicationController.selectedBank.value==0||loanApplicationController.selectedBank.value==null){
                                  SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select Bank Name");
                                  return;
                                } if(loanApplicationController.selectedProdTypeOrTypeLoan.value==0||loanApplicationController.selectedProdTypeOrTypeLoan.value==null){
                                  SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select Loan Type");
                                  return;
                                } if(loanApplicationController.bankerNameController.text.trim().toString().isEmpty){
                                  SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker Name");
                                  return;
                                } if(loanApplicationController.bankerMobileController.text.trim().toString().isEmpty){
                                  SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker Mobile ");
                                  return;
                                } if(loanApplicationController.bankerWhatsappController.text.trim().toString().isEmpty){
                                  SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Banker WhatsUp ");
                                  return;
                                } if(loanApplicationController.bankerEmailController.text.trim().toString().isEmpty){
                                  SnackbarHelper.showSnackbar(title: "Incomplete Step 8", message: "Please Enter Email ");
                                  return;
                                }else
                                if(loanApplicationController.addDocumentList.isNotEmpty) {
                                  final doc = loanApplicationController
                                      .addDocumentList[index];
                                  loanApplicationController.submitDoc(doc: doc);
                                }*/
                                if(loanApplicationController.addDocumentList.isNotEmpty) {
                                  final doc = loanApplicationController
                                      .addDocumentList[index];
                                  loanApplicationController.submitDoc(doc: doc);
                                }
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.secondaryColor,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Obx(() {
                                return loanApplicationController.isLoading.value
                                    ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                                    : const Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              }),
                            ),
                        //    ),
                            // Submit button per document

                          ],
                        )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppColor.grey700),
                                    color: Colors.green

                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Icon(Icons.check_box , color: AppColor.appWhite, size: 20),
                                    SizedBox(width: 6),
                                    Text(
                                      "Submitted",
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.appWhite),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ],
                    );
                  }),
                )),


              ],
            ),
            SizedBox(height: 10,),
            Obx(() {
              final data = loanApplicationController.loanApplicationDocumentByLoanIdModel.value?.data ?? [];

              if (loanApplicationController.isloadData.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (data.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(height: 200, width: 150, child: Lottie.asset(AppImage.nodataCofee)),
                    const Center(child: Text("No documents uploaded yet.")),
                    const SizedBox(height: 10),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Icon(Icons.list_alt, size: 20),
                        SizedBox(width: 20),
                        Text(
                          AppText.UploadedDoc,
                          style: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      final imageName = item.imageName ?? '';
                      final imagePathRaw = item.imagePath ?? '';
                      final List<String> images = imagePathRaw.split(',').where((e) => e.trim().isNotEmpty).toList();
                      print("imagePathRaw--->${imagePathRaw}");

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColor.appWhite,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: AppColor.primaryColor,
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      imageName,
                                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.grey3),
                                    ),
                                    InkWell(
                                      onTap: () {

                                        showDocDeleteDialog(context: context, docId: item.id.toString(),imageName: imageName);
                                      },
                                      child: SvgPicture.asset(
                                        AppImage.deleteIcon,
                                        width: 16,
                                        height: 16,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: images.length,
                                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                                  itemBuilder: (context, imgIndex) {

                                    final imageUrl = '${BaseUrl.imageBaseUrl}${images[imgIndex]}';

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          imageUrl,
                                         // width: MediaQuery.of(context).size.width * 0.25,
                                          //height: MediaQuery.of(context).size.height * 0.12,
                                          fit: BoxFit.fill,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: SizedBox(
                                           //     width: MediaQuery.of(context).size.width * 0.25,
                                              //  height: MediaQuery.of(context).size.height * 0.12,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2.5,
                                                    value: loadingProgress.expectedTotalBytes != null
                                                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (_, __, ___) => Image.asset(
                                            AppImage.noImage,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height
            ),
          ],
        ),
      ),
    );
  }

  void showDocDeleteDialog({
    required BuildContext context,
    required String docId,
    required String imageName,
  })
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => CustomBigYesNoLoaderDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Remove Document",
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                    children: [
                      TextSpan(
                        text: "Are you sure you want to delete ${imageName}",
                        style: const TextStyle(
                          color: AppColor.grey700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 👇 Loader logic right here
          firstButtonChild: loanApplicationController.isLoadingRemoveDoc.value
              ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Text(
            "Yes, Delete it",
            style: TextStyle(color: Colors.white),
          ),

          secondButtonText: "Cancel",
          firstButtonColor: AppColor.primaryColor,
          secondButtonColor: AppColor.redColor,

          onFirstButtonPressed: () {
            if (!loanApplicationController.isLoadingRemoveDoc.value ) {
               loanApplicationController.submitRemoveDocumentApi(DocumentId: docId.toString(),).then((_){
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
