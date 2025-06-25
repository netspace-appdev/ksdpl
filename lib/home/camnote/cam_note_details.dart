
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:lottie/lottie.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/dashboard/DashboardController.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../controllers/new_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/product_detail_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLabeledTimePicker.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../models/camnote/GetCamNoteLeadIdModel.dart';
import '../../services/call_service.dart';
import '../custom_drawer.dart';
import 'package:ksdpl/models/leads/GetAllLeadStageModel.dart' as stage;
import 'package:ksdpl/models/GetBranchDistrictByZipBankModel.dart' as branchByZip;
import 'package:ksdpl/models/camnote/GetBankerDetailsByBranchIdModel.dart' as banker;


class CamNoteDetailsScreen extends StatelessWidget {

  final CamNoteController camNoteController =Get.find();
  NewDDController newDDController=Get.put(NewDDController());
  final _formKey = GlobalKey<FormState>();

  @override
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        drawer:   CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Gradient Background
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
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
                    child: Container(
                      margin:  EdgeInsets.only(
                          top:90 // MediaQuery.of(context).size.height * 0.22
                      ), // <-- Moves it 30px from top
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
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

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cam Notes",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),

                          const SizedBox(height: 20),
                          camNoteSection(context),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
            AppText.camNoteDetails,
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




  Widget _noDataCard(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
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
                      AppImage.nodataCofee,
                      repeat: false
                  )),
              Text(
                  "No Cam Note Found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey1,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget camNoteSection(BuildContext context){
    return Obx((){
      if (camNoteController.isLoadingMainScreen.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (camNoteController.getCamNoteLeadIdModel.value == null ||
          camNoteController.getCamNoteLeadIdModel.value!.data == null || camNoteController.getCamNoteLeadIdModel.value!.data!.isEmpty) {
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


          ListView.builder(
            itemCount:camNoteController.getCamNoteLeadIdModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // final product = viewProductController.getAllProductListModel.value!.data![index];
              final camNote =  camNoteController.getCamNoteLeadIdModel.value!.data![index];

              return buildCard(
                Helper.capitalizeEachWord(camNote.bankName.toString()), // title
                [
                  _buildDetailRow(AppText.bankName, camNote.bankName.toString()),
                  _buildDetailRow(AppText.branchName,  camNote.branchName.toString()),
                  _buildDetailRow(AppText.bankerName,  camNote.bankersName.toString()),
                  _buildDetailRow(AppText.cibil,camNote.cibil.toString()),
                  _buildDetailRow(AppText.softSanctionStatus,

                      camNote.softsanction==0?"Pending":
              camNote.softsanction==1?"Approved":
              camNote.softsanction==2?"Hold":
              camNote.softsanction==-1?"Rejected":
                      ""),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if(camNote.softsanction==0 || camNote.softsanction==2)
                        _buildTextButton("Update", context, Colors.purple, Icons.edit, camNote.id.toString(), "update", camNote.softsanction??-2, camNote.bankId, camNote.leadID),
                      _buildTextButton("Details", context, Colors.pink, Icons.insert_drive_file, camNote.id.toString(), "detail", camNote.softsanction??-2,camNote.bankId,  camNote.leadID ),
                    ],
                  ),
                ],
              );

            },
          ),

        ],
      );
    });
  }

  Widget _buildDetailRow(String label, String value) {
    //   String assigned = value.toString();
//    List<String> assignedParts = assigned.split('T');


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 85,

            child: Text(
              "$label",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.primaryLight,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label=="Assigned" ||  label=="Uploaded on"?": ${ Helper.formatDate(value)}":  ":  ${value=="null"?"":value}",

              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: AppColor.grey4, width: 1),


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
              color: AppColor.primaryColor, // Blue background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
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



  Widget _buildTextButton(String label, BuildContext context, Color color, IconData icon, String id, String code, num softSanction, bankId, leadID) {

    return InkWell(
      onTap: ()  {
        if (code == "detail") {
          AddProductController addProductController = Get.put(AddProductController());
          camNoteController.getCamNoteDetailByIdApi(id: id);

         Get.toNamed("/camNoteSingle");

        }else  if (code == "update") {
          camNoteController.clearBankDetails();
          Addleadcontroller addLeadController=Get.find();
          var pinCode=addLeadController.getLeadDetailModel.value?.data?.pincode??"";
          print("pincode====>${pinCode}");
          newDDController.getBranchListOfDistrictByZipAndBankApi(bankId: bankId.toString(), zipcode:  pinCode.toString());
          showCustomBottomSheet(context, bankId.toString(), id);
        }else{

        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width:
            softSanction==0 || softSanction==2?
            MediaQuery.of(context).size.width*0.40:
            MediaQuery.of(context).size.width*0.80,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.grey700)

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColor.grey700, size: 20),
                SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.blackColor),
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
                                      validator: ValidationHelper.validateWhatsapp
                                  ),
                                  CustomLabeledTextField(
                                      label: AppText.bankerEmail,
                                      controller: camNoteController.camBankerEmailController,
                                      inputType: TextInputType.emailAddress,
                                      hintText: AppText.enterBankerEmail,
                                      isRequired: true,
                                      validator: ValidationHelper.validateEmailNotNull
                                  ),
                                  CustomLabeledTextField(
                                    label: AppText.superiorMobile,
                                    controller: camNoteController.camBankerSuperiorMobController,
                                    inputType: TextInputType.number,
                                    hintText: AppText.enterSuperiorMobile,

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
                                    whichScreen: "update_camnote"

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

}


