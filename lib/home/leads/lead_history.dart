import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/leadDetailsController.dart';
import '../../controllers/leads/lead_history_controller.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomCard.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLabeledTimePicker.dart';


class LeadHistory extends StatelessWidget {

  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());

  LeadListController leadListController = Get.put(LeadListController());
  LeadHistoryController leadHistoryController = Get.put(LeadHistoryController());

  @override
  Widget build(BuildContext context) {

   /* return SafeArea(
      child: Scaffold(

        backgroundColor: AppColor.backgroundColor,

        body: SingleChildScrollView(
          child: Column(
            children: [


              // White Container
              Align(
                alignment: Alignment.topCenter,  // Centers it
                child: Container(
                  width: double.infinity,
                  //height: MediaQuery.of(context).size.height,
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
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );*/
    return  Obx((){
      if (leadHistoryController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (leadHistoryController.getLeadWorkByLeadIdModel.value == null ||
          leadHistoryController.getLeadWorkByLeadIdModel.value!.data == null || leadHistoryController.getLeadWorkByLeadIdModel.value!.data=="") {
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

      return ListView.builder(
        itemCount:leadHistoryController.getLeadWorkByLeadIdModel.value!.data!.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var lead=leadHistoryController.getLeadWorkByLeadIdModel.value!.data![index];

          return CustomCard(
            borderColor: AppColor.grey200,
            backgroundColor: AppColor.appWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star_border_outlined),
                        Icon(Icons.list_alt_rounded),
                        if(lead.callStatus.toString()=="0")
                          Icon(Icons.published_with_changes_rounded),
                        if(lead.callStatus.toString()=="1")
                          Icon(Icons.call),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(Helper.formatTimeAgo(lead.workDate.toString()),
                          style: TextStyle(
                              fontSize: 14,color: AppColor.grey700)),
                    ),
                  ],
                ),
                // if(lead.callStatus.toString()=="1")
                Column(
                  children: [
                    Helper.customDivider(color: AppColor.grey200),
                    DetailRow(label: "Call Duration", value:lead.callDuration.toString()=="null"?"-": lead.callDuration.toString()),
                    DetailRow(label: "Call Start Time", value: lead.callStartTime.toString()=="null"?"-": lead.callStartTime.toString() ),
                    DetailRow(label: "Call End Time", value: lead.callEndTime.toString()=="null"?"-": lead.callEndTime.toString()),
                    DetailRow(label: "Call Reminder", value: lead.callReminder.toString()=="null"?AppText.noReminder: Helper.convertDateTime(lead.callReminder.toString())),
                    DetailRow(label: "Call Feedback", value: lead.feedBackRelatedToCall.toString()=="null"?"-":lead.feedBackRelatedToCall.toString() ),
                    DetailRow(label: "Lead Feedback", value: lead.feedBackRelatedToLead.toString()=="null"?"-":lead.feedBackRelatedToLead.toString() ),
                  ],
                ),
                Helper.customDivider(color: AppColor.grey200),

                DetailRow(label: "Lead Status", value: lead.previousStageName.toString(), value2: lead.stageName.toString(),),

                SizedBox(height: 10),

                _buildTextButton(
                  label:AppText.addFAndF,
                  context: context,
                  color: Colors.purple,
                  icon:  Icons.add_call,
                  leadId: lead.leadId.toString(),
                  label_code: "add_feedback",
                  currentLeadStage: lead.stageName.toString(),
                  callStatus:  lead.callStatus.toString(),
                  callDuration:  lead.callDuration.toString(),
                  callStartTime:  lead.callStartTime.toString(),
                  callEndTime:  lead.callEndTime.toString(),
                  id:  lead.id.toString(),
                  currentLeadStageId: lead.leadStageStatus.toString(),
                )

              ],
            ),
          );

        },
      );



    });
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


  Widget _buildTextButton({
    required String label,
    required BuildContext context,
    required Color color,
    required IconData icon,
    required String leadId,
    required String label_code,
    String? currentLeadStage,
    required String callDuration,
    required String callStartTime,
    required String callEndTime,
    required String callStatus,
    required String id,
    required String currentLeadStageId,
  }) {

    return InkWell(
      onTap: () {
        if (label_code == "add_feedback") {
          leadListController.callFeedbackController.clear();
          leadListController.leadFeedbackController.clear();
          leadListController.followDateController.clear();
          leadListController.followTimeController.clear();
          leadListController.isCallReminder.value=false;
          showCallFeedbackDialog(
              context: context,
              leadId: leadId,
              currentLeadStage: currentLeadStage.toString(),
              callDuration: callDuration,
              callStartTime: callStartTime,
              callEndTime: callEndTime,
              callStatus: callStatus,
            id: id,
            currentLeadStageId: currentLeadStageId

          );

        }else{

        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            width: label_code=="add_feedback"?MediaQuery.of(context).size.width*0.85: label_code=="open_poll"? MediaQuery.of(context).size.width*0.25 :MediaQuery.of(context).size.width*0.40,

            decoration: BoxDecoration(
              //color: color,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.grey700)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColor.grey700, size: 16),
                SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(fontSize: label_code=="open_poll"? 10:11, fontWeight: FontWeight.w600, color: AppColor.grey700),
                ),
              ],
            ),
          ),
        ],
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
    required id,
    required currentLeadStageId,
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
            /*  if(callStatus=="1"){
                callDuration=leadListController.workOnLeadModel!.data!.callDuration.toString();
                callStartTime=leadListController.workOnLeadModel!.data!.callStartTime.toString();
                callEndTime=leadListController.workOnLeadModel!.data!.callEndTime.toString();

              }*/
              print("id in box===>$id}");

              leadListController.callFeedbackSubmit(
                  leadId: leadId,
                  currentLeadStage: currentLeadStageId,
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
  final String? value2;

  DetailRow({required this.label, required this.value, this.value2});

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
          if(label=="Lead Status")
            Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${value}", style: TextStyle(fontSize: 14), maxLines: 1),
                    Icon(Icons.arrow_right_alt),
                    Flexible(
                        child: Text(value2.toString(), style: TextStyle(fontSize: 14),),

                    )
                  ],
                ))
          else
            Expanded(
              child: Text(": "+value, style: TextStyle(fontSize: 14), maxLines: 1)),
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
