import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/validation_helper.dart';
import 'package:ksdpl/custom_widgets/custom_photo_picker_widget.dart';
import 'package:lottie/lottie.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/camnote/camnote_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/new_dd_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../controllers/product/view_product_controller.dart';
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import 'package:ksdpl/models/GetBranchDistrictByZipBankModel.dart' as branchByZip;
import 'package:ksdpl/models/camnote/GetBankerDetailsByBranchIdModel.dart' as banker;

import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../custom_widgets/SnackBarHelper.dart';

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
              productSection(context)
            ],
          ),
        );
      }),
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
                      AppImage.moneyStack,
                      repeat: false
                  )),
              Text(
                  "No Products Found",
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

  Widget productSection(BuildContext context){
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

          ListView.builder(
            itemCount:camNoteController.getProductDetailsByFilterModel.value!.data!.length,//viewProductController.getAllProductListModel.value!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // final product = viewProductController.getAllProductListModel.value!.data![index];
              final banker =  camNoteController.getProductDetailsByFilterModel.value!.data![index];


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
                      _buildTextButton("Add","add" ,context, camNoteController.bankerThemes[0]["containerColor"], Icons.edit, banker.bankId.toString(), camNoteController.bankerThemes[0]["textColor"], camNoteController.bankerThemes[0]["iconColor"]),
                      SizedBox(height: 10,),
                      _buildTextButton("Select", "select",context,camNoteController.bankerThemes[1]["containerColor"], Icons.check_circle, banker.bankId.toString(), camNoteController.bankerThemes[1]["textColor"], camNoteController.bankerThemes[1]["iconColor"]),

                    ],
                  ),
                ],
              );

            },
          ),

         /* if (viewProductController.hasMore.value && viewProductController.filteredProducts.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  viewProductController.getAllProductListApi(
                      isLoadMore: true
                  );
                },
                child:
                viewProductController.isMainListMoreLoading.value //isDashboardLeadListMoreLoading
                    ? Container(
                    width: 15,
                    height: 15,
                    child: Center(child: CircularProgressIndicator(color: AppColor.primaryColor, strokeWidth: 2,)))
                    : Text("Load More"),
              ),
            ),*/
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


  Widget buildCard(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        border: Border.all(color:
        //AppColor.greenColor,
        AppColor.grey4,
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
                color: Colors.grey,
              //color: AppColor.greenColor, // Blue background
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



  Widget _buildTextButton(String label,String code ,BuildContext context, Color containerColor, IconData icon, String bankId,  Color textColor, Color iconColor) {
    return GestureDetector(
      onTap: () {

       // Addleadcontroller adLeaController = Get.find();

        camNoteController.clearBankDetails();

        if(camNoteController.camZipController.text.isEmpty){
          SnackbarHelper.showSnackbar(title: "Incomplete Detail", message: AppText.enterZipcode);
        }else{
          newDDController.getBranchListOfDistrictByZipAndBankApi(bankId: bankId, zipcode:  camNoteController.camZipController.text);

          showCustomBottomSheet(context, bankId);
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
                border: Border.all(color: AppColor.grey700),
              color: containerColor

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_rounded, color: iconColor, size: 20),
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


  void showCustomBottomSheet(BuildContext context, String bankId) {
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

                                  print("🔍 Debugging getBankerDetaillApi call:");
                                  print("bankId: $bankId");
                                  print("branchId: ${camNoteController.selectedBankBranch.value.toString()}");
                                  print("bankersName: ${camNoteController.camBankerNameController.text.trim()}");
                                  print("bankersMobileNumber: ${camNoteController.camBankerMobileNoController.text.trim()}");
                                  print("bankersWhatsAppNumber: ${camNoteController.camBankerWhatsappController.text.trim()}");
                                  print("bankersEmailId: ${camNoteController.camBankerWhatsappController.text.trim()}");
                                  print("superiorName: ${camNoteController.camBankerSuperiorNameController.text.trim()}");
                                  print("superiorMobile: ${camNoteController.camBankerSuperiorMobController.text.trim()}");
                                  print("superiorWhatsApp: ${camNoteController.camBankerSuperiorWhatsappController.text.trim()}");
                                  print("superiorEmail: ${camNoteController.camBankerSuperiorEmailController.text.trim()}");

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

                                   );
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