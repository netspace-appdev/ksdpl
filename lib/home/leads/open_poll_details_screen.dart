import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksdpl/common/validation_helper.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/leadDetailsController.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomCard.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLabeledTimePicker.dart';
import '../../services/call_service.dart';

import 'package:ksdpl/models/leads/GetAllLeadStageModel.dart' as stage;

class LeadDetailsMain extends StatelessWidget {

  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());

  LeadListController leadListController = Get.put(LeadListController());
  LeadDetailController leadDetailController = Get.put(LeadDetailController());
  LeadDDController leadDDController=Get.find();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        backgroundColor: AppColor.backgroundColor,

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [


                // White Container
                Align(
                  alignment: Alignment.topCenter,  // Centers it
                  child: Container(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height*0.5,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        leadSection(context),
                      ],
                    ),
                  ),
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
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          InkWell(
              onTap: (){
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppImage.arrowLeft,height: 24,),
              )),
          const Text(
            AppText.leadDetails,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700


            ),
          ),

          InkWell(
            onTap: (){
              //showFilterDialog(context: context);
            },
            child: Container(

              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  Widget leadSection(BuildContext context){
    return Obx((){
      if (leadDetailController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (leadDetailController.getLeadDetailModel.value == null ||
          leadDetailController.getLeadDetailModel.value!.data == null || leadDetailController.getLeadDetailModel.value!.data=="") {
        return  Container(
          height: MediaQuery.of(context).size.height*0.50,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration:  BoxDecoration(
            border: Border.all(color: AppColor.grey200),
            color: AppColor.appWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),

          ),
          child: const Column(
            children: [
              /// Header with profile and menu icon
              Align(
                alignment: Alignment.center,
                child: Text(
                  "No data found",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.grey700
                  ),
                ),
              ),

            ],
          ),
        );
      }

      var data=leadDetailController.getLeadDetailModel.value!.data!;


      return  Column(// height: MediaQuery.of(context).size.height*1.6, //magic
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lead Details Card


          Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              SizedBox(height: 20),
              buildCard("Basic Info", [
                DetailRow(label: "Unique Lead Number", value:leadDetailController.getLeadDetailModel.value!.data!.uniqueLeadNumber.toString()),
                DetailRow(label: "Name", value: data.name.toString()=="null"?AppText.customdash:data.name.toString()),
                DetailRow(label: "Date Of Birth", value: data.dateOfBirth.toString()=="null"?AppText.customdash:data.dateOfBirth.toString()),
                DetailRow(label: "Mobile Number", value:  data.mobileNumber.toString()=="null"?AppText.customdash:data.mobileNumber.toString()),
                DetailRow(label: "Email", value:  data.email.toString()=="null"?AppText.customdash:data.email.toString()),
                DetailRow(label: "Pin Code", value:  data.pincode.toString()=="null"?AppText.customdash:data.pincode.toString()),
                DetailRow(label: "Date", value:Helper.formatDate(leadDetailController.getLeadDetailModel.value!.data!.assignedEmployeeDate.toString()) ),
                DetailRow(label: "Gender", value:  data.gender.toString()=="null"?AppText.customdash:data.gender.toString()),
                DetailRow(label: "Street Address", value:  data.streetAddress.toString()=="null"?AppText.customdash:data.streetAddress.toString()),
                DetailRow(label: "State", value: data.stateName.toString()=="null" ||data.stateName.toString()==""?AppText.customdash:data.stateName.toString()),
                DetailRow(label: "District", value: data.districtName.toString()=="null"||data.districtName.toString()==""?AppText.customdash:data.districtName.toString()),
                DetailRow(label: "City", value: data.cityName.toString()=="null"||data.cityName.toString()==""?AppText.customdash:data.cityName.toString()),
                DetailRow(label: "Nationality", value:  data.nationality.toString()=="null"?AppText.customdash:data.nationality.toString()),
              ],
                  Icons.info_outline

              ),


              buildCard("Other Info", [
                DetailRow(label: "Aadhar Card", value:  data.adharCard.toString()=="null"?AppText.customdash: ValidationHelper.hideWithStars(data.adharCard.toString()) ),
                DetailRow(label: "Pan Card", value:  data.panCard.toString()=="null"?AppText.customdash: ValidationHelper.hideWithStars(data.panCard.toString()) ),
                DetailRow(label: "Employee Name", value: data.employeeName.toString()=="null"?AppText.customdash:data.employeeName.toString()),
                DetailRow(label: "Product", value: data.productName.toString()=="null"?AppText.customdash:data.productName.toString()),
                DetailRow(label: "Product Category Name", value: data.productCategoryName.toString()=="null"?AppText.customdash:data.productCategoryName.toString()),
                DetailRow(label: "Campaign", value: data.campaign.toString()=="null"?AppText.customdash:data.campaign.toString()),
                DetailRow(label: "Pickup Employee Name", value: data.pickedUpEmployeeName.toString()=="null"?AppText.customdash:data.pickedUpEmployeeName.toString()),
                DetailRow(label: "Moved to Open Poll", value: data.moveToCommon.toString()=="null"?AppText.customdash:data.moveToCommon.toString()),
                DetailRow(label: "Assigned Employee Percentage", value: data.assignedEmployeePercentage.toString()=="null"?AppText.customdash:data.assignedEmployeePercentage.toString()),
                DetailRow(label: "Bank Name", value: data.bankName.toString()=="null"?AppText.customdash:data.bankName.toString()),
                DetailRow(label: "Branch Name", value: data.branchName.toString()=="null"?AppText.customdash:data.branchName.toString()),
                DetailRow(label: "Source", value: data.source.toString()=="null"?AppText.customdash:data.source.toString()),
                DetailRow(label: "Product Typ", value: data.productType.toString()=="null"?AppText.customdash:data.productName.toString()),


                DetailRow(label: "Loan Application No", value: data.loanApplicationNo.toString()=="null"?AppText.customdash:data.loanApplicationNo.toString()),
              ],
                  Icons.info_outline

              ),
              buildCard("Financial Info", [
                DetailRow(label: "Sanction Amount", value: data.sanctionAmount.toString()=="null"?AppText.customdash:data.sanctionAmount.toString()),
                DetailRow(label: "Disburse Amount", value: data.disburseAmount.toString()=="null"?AppText.customdash:data.disburseAmount.toString()),
                DetailRow(label: "Monthly Income", value: data.monthlyIncome.toString()=="null"?AppText.customdash:data.monthlyIncome.toString()),
                DetailRow(label: "Loan Amount", value: data.loanAmountRequested.toString()=="null"?AppText.customdash:data.loanAmountRequested.toString()),
              ],
                  Icons.info_outline

              ),

              buildCard("Geo Location", [
                DetailRow(label: "Geo Location Of Property", value:  data.geoLocationOfProperty.toString()=="null"?AppText.customdash:data.geoLocationOfProperty.toString()),
                DetailRow(label: "Geo Location Of Residence", value:  data.geoLocationOfResidence.toString()=="null"?AppText.customdash:data.geoLocationOfResidence.toString()),
                DetailRow(label: "Geo Location Of Office", value:  data.geoLocationOfOffice.toString()=="null"?AppText.customdash:data.geoLocationOfOffice.toString()),

              ],
                  Icons.info_outline

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    child: Text("Stage",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color:AppColor.primaryColor)),
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      StatusChip(label: leadDetailController.getLeadDetailModel.value!.data!.stageName.toString(), color: Colors.orange),

                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),

          // Phone Number Card

          CustomCard(
            borderColor: AppColor.grey200,
            backgroundColor: AppColor.appWhite,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Phone Number",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(leadDetailController.getLeadDetailModel.value!.data!.mobileNumber.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,color: AppColor.black54)),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (leadDetailController.getLeadDetailModel.value!.data!.leadStage.toString()=="3" && leadDetailController.getLeadDetailModel.value!.data!.reminderDate.toString()=="null")?
                        _buildIconButton(icon: AppImage.call_disable, color: AppColor.orangeColor, phoneNumber: leadDetailController.getLeadDetailModel.value!.data!.mobileNumber.toString(), label: "call_disable",
                            leadId:leadDetailController.getLeadDetailModel.value!.data!.id.toString(), leadStage: leadDetailController.getLeadDetailModel.value!.data!.leadStage.toString(),
                            context: context):
                        _buildIconButton(icon: AppImage.call1, color: AppColor.orangeColor, phoneNumber: leadDetailController.getLeadDetailModel.value!.data!.mobileNumber.toString(), label: "call",
                            leadId:leadDetailController.getLeadDetailModel.value!.data!.id.toString(), leadStage: leadDetailController.getLeadDetailModel.value!.data!.leadStage.toString(),
                            context: context),
                        _buildIconButton(icon: AppImage.whatsapp, color: AppColor.orangeColor, phoneNumber:leadDetailController.getLeadDetailModel.value!.data!.mobileNumber.toString(), label: "whatsapp",
                            leadId:leadDetailController.getLeadDetailModel.value!.data!.id.toString(), leadStage: leadDetailController.getLeadDetailModel.value!.data!.leadStage.toString(),
                            context: context),
                        _buildIconButton(icon: AppImage.message1, color: AppColor.orangeColor, phoneNumber: leadDetailController.getLeadDetailModel.value!.data!.mobileNumber.toString(), label: "message",
                            leadId:leadDetailController.getLeadDetailModel.value!.data!.id.toString(), leadStage: leadDetailController.getLeadDetailModel.value!.data!.leadStage.toString(),
                            context: context),


                      ],
                    )
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 16),



          SizedBox(height: 20),
        ],
      );
    });

  }

  Widget _buildIconButton({
    required String icon,
    required Color color,
    required String phoneNumber,
    required String label,
    required String leadId,
    required String leadStage,
    required BuildContext context,
  }) {
    return IconButton(
      onPressed: () {
        if(label=="call"){
          //leadListController.makePhoneCall(phoneNumber);
          CallService callService = CallService();
          leadDDController.selectedStage.value=leadStage;
          callService.makePhoneCall(
            phoneNumber:phoneNumber,//"+919399299880",//phoneNumber,
            leadId: leadId,
            currentLeadStage: leadStage,//newLeadStage,

            showFeedbackDialog:showCallFeedbackDialog,
          );

        }
        if(label=="whatsapp"){
          leadListController.openWhatsApp(phoneNumber: phoneNumber, message: AppText.whatsappMsg);
        }
        if(label=="message"){
          leadListController.sendSMS(phoneNumber: phoneNumber, message: AppText.whatsappMsg);
        }

      },

      icon: Container(

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration:  BoxDecoration(
          border: Border.all(color: AppColor.grey200),
          color: AppColor.appWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),

        ),
        child: Center(
          // child: Icon(icon, color: color),
          child: Image.asset(icon, height: 12,),
        ),
      ),
    );
  }


  void showCallFeedbackDialog({
    /* required BuildContext context,*/
    required leadId,
    required currentLeadStage,
    required callDuration,
    required callStartTime,
    required callEndTime,
    required callStatus,
  }) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        if(currentLeadStage=="6"){
          leadListController.isFBDetailsShow.value=true;
        }
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: AppText.addFAndF,
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(Get.context!).size.height * 0.7, // Prevents overflow
            ),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Call and lead FB

                    const SizedBox(height: 20),

                    if(callStatus=="0" && (currentLeadStage=="13" || currentLeadStage=="4" || currentLeadStage=="5" || currentLeadStage=="6" || currentLeadStage=="7"))
                      CustomLabeledPickerTextField(
                        label: AppText.leadStage,
                        isRequired: false,
                        controller: leadListController.couldNotController,
                        inputType:TextInputType.name,
                        hintText: "",
                        enabled: false,
                      ),


                    ///Status change
                    if(callStatus=="1")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppText.leadStage,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.grey2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx((){
                            if (leadDDController.isLeadStageLoading.value) {
                              return  Center(child:CustomSkelton.leadShimmerList(context));
                            }
                            final filteredStages = leadDDController.getFilteredStagesByLeadStageId(
                              currentLeadStage.toString(),
                            );


                            return CustomDropdown<stage.Data>(
                              items: filteredStages,
                              getId: (item) =>item.id.toString(),  // Adjust based on your model structure
                              getName: (item) => item.stageName.toString(),
                              selectedValue: filteredStages.firstWhereOrNull(
                                    (item) => item.id.toString() == leadDDController.selectedStage.value,

                              ),
                              onChanged: (value) {
                                leadDDController.selectedStage.value =  value?.id?.toString();

                                if( leadDDController.selectedStage.value!=null){
                                  if (int.parse(leadDDController.selectedStage.value!) == 3) {
                                    leadDDController.selectedStageActive.value = 1;

                                  } else if (int.parse(leadDDController.selectedStage.value!) == 4) {
                                    leadDDController.selectedStageActive.value = 1;
                                    leadListController.isFBDetailsShow.value=true;

                                  } else if (int.parse(leadDDController.selectedStage.value!) == 5) {
                                    leadDDController.selectedStageActive.value = 0;
                                    leadListController.isFBDetailsShow.value=false;
                                  }  else if (int.parse(leadDDController.selectedStage.value!) == 6) {
                                    leadDDController.selectedStageActive.value = 1;
                                    leadListController.isFBDetailsShow.value=true;
                                  } else if (int.parse(leadDDController.selectedStage.value!) == 7) {
                                    leadDDController.selectedStageActive.value = 0;
                                    leadListController.isFBDetailsShow.value=false;
                                  }else if (int.parse(leadDDController.selectedStage.value!) == 13) {
                                    leadDDController.selectedStageActive.value = 0;
                                  }else {

                                  }


                                }


                              },
                            );
                          }),
                          const SizedBox(height: 20),
                          Obx(()=> Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (leadListController.isFBDetailsShow.value==true) ...[
                                SizedBox(height: 15),
                                CustomLabeledTextField(
                                  label: AppText.callFeedback,
                                  isRequired: false,
                                  controller: leadListController.callFeedbackController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterCallFeedback,
                                  isTextArea: true,
                                ),
                                SizedBox(height: 15),
                                CustomLabeledTextField(
                                  label: AppText.leadFeedback,
                                  isRequired: false,
                                  controller: leadListController.leadFeedbackController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterLeadFeedback,
                                  isTextArea: true,
                                ),
                                const SizedBox(height: 20),
                              ]
                            ],
                          ))
                        ],
                      ),


                    /// rest is cal reminder
                    Obx(()=>Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(leadListController.isFBDetailsShow.value==true || callStatus=="0")...[
                          Text(
                            "Need to set a reminder? select the checkbox",
                            style:  GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black54,
                              //fontWeight: FontWeight.w700


                            ),
                          ),
                          Row(
                            children: [
                              Obx(()=>Checkbox(
                                activeColor: AppColor.secondaryColor,
                                value: leadListController.isCallReminder.value,
                                onChanged: (bool? value) {

                                  leadListController.isCallReminder.value = value ?? false;

                                },
                              )),
                              Text(
                                AppText.callReminder,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Obx(()=> CustomLabeledPickerTextField(
                            label: AppText.selectDate,
                            isRequired: false,
                            controller: leadListController.followDateController,
                            inputType: TextInputType.name,
                            hintText: "MM/DD/YYYY",
                            isDateField: true,
                            enabled: leadListController.isCallReminder.value,
                          )),
                          Obx(()=>CustomLabeledTimePickerTextField(
                            label: AppText.selectTime,
                            isRequired: false,
                            controller: leadListController.followTimeController,
                            inputType: TextInputType.datetime,
                            hintText: "HH:MM AM/PM",
                            isTimeField: true,
                            enabled: leadListController.isCallReminder.value,
                          )),
                        ]
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          onSubmit: () {
            var id=leadListController.workOnLeadModel!.data!.id.toString();
            if(callStatus=="1"){
              callDuration=leadListController.workOnLeadModel!.data!.callDuration.toString();
              callStartTime=leadListController.workOnLeadModel!.data!.callStartTime.toString();
              callEndTime=leadListController.workOnLeadModel!.data!.callEndTime.toString();

            }


            leadListController.callFeedbackSubmit(
                leadId: leadId,
                currentLeadStage: currentLeadStage,
                callStatus: callStatus,
                callDuration: callDuration,
                callStartTime: callStartTime,
                callEndTime: callEndTime,
                id: id,
                fromWhere: "call",
                selectedStage: leadDDController.selectedStage.value

            );
            Get.offAllNamed("/bottomNavbar");

          },
        );
      },
    );
  }


  Widget buildCard(String title, List<Widget> children, IconData icon) {
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
            child: Row(
              children: [
                Icon(icon, color: Colors.white,),
                SizedBox(width: 5,),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
}


//details

// Helper Widget for Status Chips
class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(label, style: TextStyle(color: AppColor.appWhite, fontSize: 12)),
    );
  }
}


class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor
            ),
          ),
          const SizedBox(height: 4),
          value=="null" || value==AppText.customdash?
          Row(


            children: [
              Icon(Icons.horizontal_rule, size: 15,),
            ],):
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widget for Icon Buttons
class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  IconButtonWidget({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
        height: 27,
        width: 27,
        // color: color.withOpacity(0.2),
        decoration: BoxDecoration(

        ),
        child: Center(child: Icon(icon, color: color,size: 16,)),
      ),
    );
  }
}
