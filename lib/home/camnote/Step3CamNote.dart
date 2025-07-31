import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/validation_helper.dart';
import 'package:ksdpl/custom_widgets/custom_photo_picker_widget.dart';
import 'package:lottie/lottie.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/camnote/camnote_controller.dart';
import '../../controllers/check_valid_email_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/new_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/product_detail_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import 'package:ksdpl/models/GetBranchDistrictByZipBankModel.dart' as branchByZip;
import 'package:ksdpl/models/camnote/GetBankerDetailsByBranchIdModel.dart' as banker;

import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomIconDilogBox.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLoadingOverlay.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../models/camnote/GetProductDetailsByFilterModel.dart' as proFilter;
import '../../models/camnote/fetchBankDetailSegKSDPLProdModel.dart' as otherBank;
import '../../models/camnote/GetProductDetailBySegmentAndProductModel.dart' as otherBankBranch;
class Step3CamNote extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  final CamNoteController camNoteController =Get.find();
  final AddProductController addProductController =Get.find();
  final ViewProductController viewProductController = Get.put(ViewProductController());
  NewDDController newDDController=Get.put(NewDDController());
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Container(

      child: Obx((){
        if( camNoteController.isBankerLoading.value)
          return Center(
            child: CustomSkelton.productShimmerList(context),
          );
        return Form(
          key: camNoteController.stepFormKeys[2],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      camNoteController.forBankDetailSubmit();
                    },
                    child: Text(
                      "Get Bank Details",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.secondaryColor),
                    ),
                  ),





                  InkWell(
                    onTap: (){
                      camNoteController.fetchBankDetailBySegmentIdAndKSDPLProductIdApi(
                        segmentVerticalId:camNoteController.camSelectedProdSegment.value.toString(),
                        KSDPLProductId: camNoteController.camSelectedProdType.value.toString()
                      );
                      camNoteController.selectedOtherBankBranch.value  = 0;
                      camNoteController.selectedOtherBank.value  = 0;
                      showGetBankDialog(
                        context: context,
                        segmentVerticalId: camNoteController.camSelectedProdSegment.value.toString(),
                        kSDPLProductId: camNoteController.camSelectedProdType.value.toString()
                      );
                    },
                    child: const Padding(

                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        "Get Other Banks",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.secondaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              bankerSection(context)
            ],
          ),
        );
      }),
    );
  }
  Widget _noDataCard(BuildContext context) {
    return Center(
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(10),
          //   border: Border.all(color: AppColor.grey4, width: 1),

        ),
        child:  Center(

          child: Column(
            children: [
              Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Lottie.asset(
                      AppImage.moneyStack,
                      repeat: false
                  )),
             /* Text(
                  "No Data Found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey1,
                  )),*/

              Text(
                  "Please Get Bank Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.blackColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget bankerSection(BuildContext context){
    return Obx((){
      if (camNoteController.isBankerLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (camNoteController.getProductDetailsByFilterModel.value == null ||
          camNoteController.getProductDetailsByFilterModel.value!.data == null || camNoteController.getProductDetailsByFilterModel.value!.data!.isEmpty) {
        return  Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration:  BoxDecoration(
            border: Border.all(color: AppColor.grey200),
            color: AppColor.appWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),

          ),
          child:  Column(

            children: [
              /// Header with profile and menu icon
              _noDataCard(context)

            ],
          ),
        );
      }

      return  Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Bank (${camNoteController.getProductDetailsByFilterModel.value!.data!.length.toString()})",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.blackColor),
              ),

            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            itemCount:camNoteController.getProductDetailsByFilterModel.value!.data!.length,//viewProductController.getAllProductListModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // final product = viewProductController.getAllProductListModel.value!.data![index];
              final banker =  camNoteController.getProductDetailsByFilterModel.value!.data![index];

              print("autoindividual in .getProductDetailsByFilterModel=======>${camNoteController.getProductDetailsByFilterModel.value!.data![index].autoindividual}");

              return Obx((){


                 final isSubmitted = camNoteController.isBankerSubmitted(banker.bankId.toString());
              final isSelected = camNoteController.isBankerSelected(banker.bankId.toString());
                return buildCard(
                  Helper.capitalizeEachWord(banker.bankName.toString()), // title
                  [
                    _buildDetailRow(AppText.bankerName, banker.bankersName.toString()),
                    _buildDetailRow(AppText.bankerMobile, banker.bankersMobileNumber.toString()),
                    _buildDetailRow(AppText.bankerWhatsapp, banker.bankersWhatsAppNumber.toString()),
                    _buildDetailRow(AppText.bankerEmail, banker.bankersEmailID.toString()),
                    _buildDetailRow(AppText.selectCustomerCategory, banker.customerCategory.toString()),
                    _buildDetailRow(AppText.ksdplProduct, banker.ksdplProduct.toString()),
                    _buildDetailRow(AppText.incomeType, banker.incomeTypes.toString()),

                    const SizedBox(height: 10),

                    Column(
                      children: [
                        camNoteController.camNoteLeadBankIds.contains(banker.bankId.toString())?
                        _buildTextButton(
                          label:"Add",
                          code:"add_disable" ,
                          context:context,
                          containerColor: camNoteController.bankerThemes[2]["containerColor"],
                          icon: Icons.add_task,
                          bankId:banker.bankId.toString(),
                          textColor: camNoteController.bankerThemes[2]["textColor"],
                          iconColor:camNoteController.bankerThemes[2]["iconColor"],
                          boxId: banker.id.toString(),
                          autoindividual: banker.autoindividual.toString()
                        ):
                        _buildTextButton(
                          label:"Add",
                          code:"add" ,
                          context:context,
                          containerColor: camNoteController.bankerThemes[0]["containerColor"],
                          icon: Icons.add_box_outlined,
                          bankId:banker.bankId.toString(),
                          textColor: camNoteController.bankerThemes[0]["textColor"],
                          iconColor:camNoteController.bankerThemes[0]["iconColor"],
                          boxId: banker.id.toString(),
                            autoindividual: banker.autoindividual.toString()
                        ),
                        SizedBox(height: 10,),

                        if (isSubmitted)
                          _buildTextButton(
                            label: isSelected ? "Selected" :  "Select",
                            code: "select",
                            context:context,
                            containerColor: isSelected ? camNoteController.bankerThemes[1]["containerColor"] :   camNoteController.bankerThemes[0]["containerColor"],
                            icon: isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            bankId:banker.bankId.toString(),
                            textColor:isSelected ? camNoteController.bankerThemes[1]["textColor"]:camNoteController.bankerThemes[0]["textColor"],
                            iconColor:isSelected ? camNoteController.bankerThemes[1]["iconColor"]:camNoteController.bankerThemes[0]["iconColor"],
                            boxId: banker.id.toString(),
                              autoindividual: banker.autoindividual.toString()
                          ),

                      ],
                    ),

                    SizedBox(height: 10,),

                    if (camNoteController.camNoteLeadBankIds.contains(banker.bankId.toString()))
                      Column(
                      children: [
                        StatusChip(label: "Cam Note Alert : Sent", color: Colors.orange)
                      ],
                    ),

                  ],
                    isSelected
                );
              });

            },
          ),


        ],
      );
    });
  }


  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6), // Increased spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColor.primaryLight,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            (label == "Assigned" || label == "Uploaded on")
                ? Helper.formatDate(value)
                : (value == "null" ? "" : value),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          const Divider(height: 16, thickness: 0.5), // Optional: subtle divider between fields
        ],
      ),
    );
  }


  Widget buildCard(String title, List<Widget> children, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        border: Border.all(color:  isSelected ? camNoteController.bankerContainerThemes[1]["containerColor"] :   camNoteController.bankerContainerThemes[0]["containerColor"],
        //AppColor.greenColor,
        //AppColor.grey4,
            width: 2),


      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
               //color: AppColor.primaryColor, // Blue background
                color:  isSelected ? camNoteController.bankerContainerThemes[1]["containerColor"] :   camNoteController.bankerContainerThemes[0]["containerColor"],
              //color: AppColor.greenColor, // Blue background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

            ),
            child: Text(
              title,
              style:  TextStyle(
                fontSize: 16,
                color: isSelected ? camNoteController.bankerContainerThemes[1]["textColor"] :   camNoteController.bankerContainerThemes[0]["textColor"],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildTextButton({
    required String label,
    required String code ,
    required BuildContext context,
    required Color containerColor,
    required IconData icon,
    required String bankId,
    required Color textColor,
    required Color iconColor,
    required String boxId,
    required String autoindividual,
}) {
    return GestureDetector(
      onTap: () {
        print("autoindividual.toString()--->first==>${autoindividual.toString()}");
        if(code=="select"){
          print("boxId--->${boxId}");
          print("bankId--->${bankId}");
          print("autoindividual.toString()--->in select =====${autoindividual.toString()}");
          camNoteController.toggleBankerSelection(bankId);
          if(camNoteController.selectedBankers.isNotEmpty){
            showDialog(
              context: context,
              builder: (context) {
                return CustomIconDialogBox(
                  title: "Are you sure?",
                  icon: Icons.info_outline,
                  iconColor: AppColor.secondaryColor,
                  description: AppText.sendCamMsg,
                  onYes: () {
                    camNoteController.saveForm();
                  },
                  onNo: () {

                  },
                );
              },
            );
          }

        }else if(code=="add"){
          print("autoindividual.toString()--->in add =====${autoindividual.toString()}");
          camNoteController.clearBankDetails();

          if(camNoteController.camZipController.text.isEmpty){

            SnackbarHelper.showSnackbar(title: "Incomplete Detail", message: AppText.enterZipcode);

          }else{

            newDDController.getBranchListOfDistrictByZipAndBankApi(bankId: bankId, zipcode:  camNoteController.camZipController.text);
            showCustomBottomSheet(context, bankId, boxId);
          }
        }else if(code=="add_disable"){
          ToastMessage.msg(AppText.camNoteSentMessage);
        }


      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: MediaQuery.of(context).size.width*0.80,

            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: code=="add_disable"?Colors.grey: AppColor.grey700),
              color: containerColor

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 20),
                SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void showCustomBottomSheet(BuildContext context, String bankId, String boxId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 24,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8, // optional: control sheet height
              child: Column(
                children: [
                  // Scrollable Form Fields
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 10),
                            CustomTextLabel(
                              label: AppText.branch,
                              isRequired: true,
                            ),
                            const SizedBox(height: 10),

                            Obx(() {
                              if (newDDController.isBranchLoading.value) {
                                return Center(child: CustomSkelton.leadShimmerList(context));
                              }

                              return CustomDropdown<branchByZip.Data>(
                                items: newDDController.branchByZipList ?? [],
                                getId: (item) => item.id.toString(),
                                getName: (item) => item.branchName.toString(),
                                selectedValue: newDDController.branchByZipList.firstWhereOrNull(
                                        (item) => item.id == camNoteController.selectedBankBranch.value),
                                onChanged: (value) {
                                  camNoteController.selectedBankBranch.value = value?.id;

                                  if(camNoteController.selectedBankBranch.value!=null){

                                    newDDController.getBankerDetailsByBranchIdApi(
                                        branchId: camNoteController.selectedBankBranch.value.toString());
                                  }

                                },
                                onClear: () {
                                  camNoteController.selectedBankBranch.value = 0;
                                  camNoteController.selectedBankerBranch.value = 0;
                                  newDDController.bankerByBranchList.clear();
                                  camNoteController.clearBankDetails();
                                },
                              );
                            }),

                            const SizedBox(height: 20),

                            CustomTextLabel(
                              label: AppText.employee,
                            ),

                            const SizedBox(height: 10),

                            Obx(() {
                              if (newDDController.isBankerLoading.value) {
                                return Center(child: CustomSkelton.leadShimmerList(context));
                              }

                              return CustomDropdown<banker.Data>(
                                items: newDDController.bankerByBranchList ?? [],
                                getId: (item) => item.id.toString(),
                                getName: (item) => item.bankersName.toString(),
                                selectedValue: newDDController.bankerByBranchList.firstWhereOrNull(
                                        (item) => item.id == camNoteController.selectedBankerBranch.value),
                                onChanged: (value) {
                                  camNoteController.selectedBankerBranch.value = value?.id;
                                  
                                  print("selectedBankerBranch===>${camNoteController.selectedBankerBranch.value}");
                                  
                                  if(camNoteController.selectedBankerBranch.value!=null){
                                    camNoteController.getBankerDetailsByIdApi(bankerId: camNoteController.selectedBankerBranch.value.toString());
                                  }

                                },
                                onClear: () {
                                  camNoteController.selectedBankerBranch.value = 0;
                                  camNoteController.clearBankerDetails();
                                },
                              );
                            }),

                            const SizedBox(height: 20),

                           Obx((){
                             if( camNoteController.isBankerSuperiorLoading.value)
                               return Center(
                                 child: CustomSkelton.productShimmerList(context),
                               );
                              return  Column(
                               children: [
                                 CustomLabeledTextField(
                                   label: AppText.bankerMobile,
                                   controller: camNoteController.camBankerMobileNoController,
                                   inputType: TextInputType.number,
                                   hintText: AppText.enterBankerMobile,
                                   isRequired: true,
                                   validator: ValidationHelper.validatePhoneNumber,
                                   maxLength: 10,
                                 ),
                                 CustomLabeledTextField(
                                   label: AppText.bankerName,
                                   controller: camNoteController.camBankerNameController,
                                   inputType: TextInputType.name,
                                   hintText: AppText.enterBankerName,
                                   validator: ValidationHelper.validateName,
                                   isRequired: true,
                                 ),
                                 CustomLabeledTextField(
                                   label: AppText.bankerWhatsapp,
                                   controller: camNoteController.camBankerWhatsappController,
                                   inputType: TextInputType.number,
                                   hintText: AppText.enterBankerWhatsapp,
                                   isRequired: true,
                                   validator: ValidationHelper.validateWhatsapp,
                                   maxLength: 10,

                                 ),
                                 CustomLabeledTextField(
                                   label: AppText.bankerEmail,
                                   controller: camNoteController.camBankerEmailController,
                                   inputType: TextInputType.emailAddress,
                                   hintText: AppText.enterBankerEmail,
                                   isRequired: true,
                                     validator: ValidationHelper.validateEmailOfficial
                                 ),
                                 CustomLabeledTextField(
                                   label: AppText.superiorMobile,
                                   controller: camNoteController.camBankerSuperiorMobController,
                                   inputType: TextInputType.number,
                                   hintText: AppText.enterSuperiorMobile,
                                   maxLength: 10,
                                 ),
                                 CustomLabeledTextField(
                                   label: AppText.superiorName,
                                   controller: camNoteController.camBankerSuperiorNameController,
                                   inputType: TextInputType.name,
                                   hintText: AppText.enterSuperiorName,

                                 ),
                                 CustomLabeledTextField(
                                   label: AppText.superiorWhatsapp,
                                   controller: camNoteController.camBankerSuperiorWhatsappController,
                                   inputType: TextInputType.number,
                                   hintText: AppText.enterSuperiorWhatsapp,
                                   maxLength: 10,
                                 ),
                                 CustomLabeledTextField(
                                   label: AppText.superiorEmail,
                                   controller: camNoteController.camBankerSuperiorEmailController,
                                   inputType: TextInputType.emailAddress,
                                   hintText: AppText.enterSuperiorEmail,

                                 ),
                               ],
                             );
                           }),

                            const SizedBox(height: 30), // Give some space above the fixed button
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Sticky Submit Button
                  Obx(() {
                    if (camNoteController.isLoading.value) {
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


                            if(camNoteController.selectedBankBranch.value==null){
                              SnackbarHelper.showSnackbar(title: "Incomplete Data", message: "Please select a branch");
                            }else{
                              if (_formKey.currentState!.validate()) {


                                if(camNoteController.camBankerMobileNoController.value==camNoteController.camBankerSuperiorMobController.value){
                                  SnackbarHelper.showSnackbar(title: "Incomplete Data", message: "Please use different mobile number for superior");
                                }{

                                  var branchId=camNoteController.selectedBankBranch.value.toString();


                                   camNoteController.getBankerDetaillApi(
                                     bankId: bankId,
                                     branchId:camNoteController.selectedBankBranch.value.toString(),
                                     bankersName: camNoteController.camBankerNameController.text.trim().toString(),
                                     bankersMobileNumber: camNoteController.camBankerMobileNoController.text.trim().toString(),
                                     bankersWhatsAppNumber: camNoteController.camBankerWhatsappController.text.trim().toString(),
                                     bankersEmailId:camNoteController.camBankerEmailController.text.trim().toString(),
                                     superiorName:camNoteController.camBankerSuperiorNameController.text.trim().toString(),
                                     superiorMobile:camNoteController.camBankerSuperiorMobController.text.trim().toString(),
                                     superiorWhatsApp:camNoteController.camBankerSuperiorWhatsappController.text.trim().toString(),
                                     superiorEmail:camNoteController.camBankerSuperiorEmailController.text.trim().toString(),
                                     whichScreen: "fresh_camnote"

                                   ).then((_){
                                     camNoteController.markBankerAsSubmitted(bankId);
                                     // camNoteController.bankerBranchMap[bankId] = branchId;
                                     camNoteController.bankerBranchMap[boxId] = branchId;

                                     print("camNoteController.bankerBranchMap on tap==>${camNoteController.bankerBranchMap}");

                                   });
                                  print("validate ho gaya===>");
                                }
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
          );
        }


    );
  }



  void showGetBankDialog({
    required BuildContext context,
    required segmentVerticalId,
    required kSDPLProductId,


  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Get Bank",
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7, // Prevents overflow
            ),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    CustomTextLabel(
                      label: AppText.bank,
                      isRequired: true,
                    ),

                    const SizedBox(height: 10),

                    Obx(() {
                      if (camNoteController.isOtherBankLoading.value) {
                        return Center(child: CustomSkelton.leadShimmerList(context));
                      }

                      return CustomDropdown<otherBank.Data>(
                        items: camNoteController.getOtherBankList ?? [],
                        getId: (item) => item.bankId.toString(),
                        getName: (item) => item.bankName.toString(),
                        selectedValue: camNoteController.getOtherBankList.firstWhereOrNull(
                                (item) => item.bankId == camNoteController.selectedOtherBank.value),
                        onChanged: (value) {
                          camNoteController.selectedOtherBank.value = value?.bankId??0;

                          if(camNoteController.selectedOtherBank.value!=0){

                            camNoteController.getProductDetailBySegmentAndProductApiApi(
                              bankId: camNoteController.selectedOtherBank.value.toString(),
                              segmentVerticalId:segmentVerticalId,
                              kSDPLProductId: kSDPLProductId
                            );
                          }

                        },
                        onClear: () {
                          camNoteController.selectedOtherBank.value  = 0;

                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    CustomTextLabel(
                      label: AppText.products,
                      isRequired: true,
                    ),

                    const SizedBox(height: 10),

                    Obx(() {
                      if (camNoteController.isOtherBankBrLoading.value) {
                        return Center(child: CustomSkelton.leadShimmerList(context));
                      }

                      return CustomDropdown<otherBankBranch.Data>(
                        items: camNoteController.getOtherBankBranchList ?? [],
                        getId: (item) => item.bankId.toString(),
                        getName: (item) => item.product.toString(),
                        selectedValue: camNoteController.getOtherBankBranchList.firstWhereOrNull(
                                (item) => item.bankId == camNoteController.selectedOtherBankBranch.value),
                        onChanged: (value) {
                          camNoteController.selectedOtherBankBranch.value = value?.bankId??0;



                        },
                        onClear: () {
                          camNoteController.selectedOtherBankBranch.value  = 0;

                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          onSubmit: () {

            if(camNoteController.selectedOtherBank.value==0){
              ToastMessage.msg(AppText.pleaseSelectBank);
            }else if( camNoteController.selectedOtherBankBranch.value  == 0){
              ToastMessage.msg(AppText.pleaseSelectproduct);
            }else{

              camNoteController.getProductListByIdApi(id: camNoteController.selectedOtherBankBranch.value.toString());
              Get.back();
            }

          },
        );
      },
    );
  }


}

class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.greenColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: Text(label, style: TextStyle(color: AppColor.appWhite, fontSize: 12))),
    );
  }
}