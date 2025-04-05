import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/leadDetailsController.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomCard.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLabeledTimePicker.dart';
import '../../services/call_service.dart';


class LeadDetailsMain extends StatelessWidget {

  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());

  LeadListController leadListController = Get.put(LeadListController());
  LeadDetailController leadDetailController = Get.put(LeadDetailController());

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


          CustomCard(
            borderColor: AppColor.grey200,
            backgroundColor: AppColor.appWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lead Details",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),

                SizedBox(height: 10),

                // Status Tags
                Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text("Status",
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

                SizedBox(height: 10),

                DetailRow(label: "Date", value:Helper.formatDate(leadDetailController.getLeadDetailModel.value!.data!.assignedEmployeeDate.toString()) ),
                DetailRow(label: "Full Name", value: data.name.toString()),
                DetailRow(label: "Gender", value:  data.gender.toString()=="null"?AppText.customdash:data.gender.toString()),
                DetailRow(label: "Email", value: data.email.toString()=="null"||data.email.toString()==""?AppText.customdash:data.email.toString()),
                DetailRow(label: "Phone", value: data.mobileNumber.toString()),
                DetailRow(label: "Aadhar Card", value: data.adharCard.toString()=="null"?AppText.customdash:data.adharCard.toString()),
                DetailRow(label: "Pan No", value: data.panCard.toString()=="null"?AppText.customdash:data.panCard.toString()),
                DetailRow(label: "State", value: data.stateName.toString()=="null" ||data.stateName.toString()==""?AppText.customdash:data.stateName.toString()),
                DetailRow(label: "District", value: data.districtName.toString()=="null"||data.districtName.toString()==""?AppText.customdash:data.districtName.toString()),
                DetailRow(label: "City", value: data.cityName.toString()=="null"||data.cityName.toString()==""?AppText.customdash:data.cityName.toString()),
                DetailRow(label: "Monthly Income", value: data.monthlyIncome.toString()=="null"?AppText.customdash:data.monthlyIncome.toString()),
                DetailRow(label: "Loan Amount", value: data.loanAmountRequested.toString()=="null"?AppText.customdash:data.loanAmountRequested.toString()),
                DetailRow(label: "Campaign", value: data.campaign.toString()=="null"?AppText.customdash:data.campaign.toString()),
                DetailRow(label: "Employee Name", value: data.employeeName.toString()=="null"?AppText.customdash:data.employeeName.toString()),
                DetailRow(label: "Pickup Employee Name", value: data.pickedUpEmployeeName.toString()=="null"?AppText.customdash:data.pickedUpEmployeeName.toString()),
              ],
            ),
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

          // Lead Details Description
          const CustomCard(
            borderColor: AppColor.grey200,
            backgroundColor: AppColor.appWhite,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lead Details",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(
                  "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry.Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

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
          callService.makePhoneCall(
            phoneNumber:phoneNumber,
            leadId: leadId,
            currentLeadStage: leadStage,//newLeadStage,
            context: context,
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
    required BuildContext context,
    required leadId,
    required currentLeadStage,
    required callDuration,
    required callStartTime,
    required callEndTime,
    required callStatus,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: AppText.addFAndF,
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7, // Prevents overflow
            ),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(height: 10),
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
                  ],
                ),
              ),
            ),
          ),
          onSubmit: () {
            if (leadListController.callFeedbackController.text.isEmpty &&
                leadListController.leadFeedbackController.text.isEmpty) {
              ToastMessage.msg(AppText.addFeedbackFirst);
            } else {
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
                  fromWhere: "call"

              );
              Get.back();
            }

          },
        );
      },
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

// Helper Widget for Detail Rows
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(

            width: 120,
            child: Text("$label",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor)),
          ),
          Expanded(
              child: value==AppText.customdash?Row(children: [Text(":  ", style: TextStyle(fontSize: 14), maxLines: 1),Icon(Icons.horizontal_rule, size: 15,),],):Text(": "+value, style: TextStyle(fontSize: 14), maxLines: 1)),
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
