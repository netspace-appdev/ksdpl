
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../controllers/dashboard/DashboardController.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/leadlist_controller.dart';
import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLabeledTimePicker.dart';
import '../../services/call_service.dart';
import '../custom_drawer.dart';
import 'package:ksdpl/models/leads/GetAllLeadStageModel.dart' as stage;

class GetAllReminderScreen extends StatelessWidget {
  LeadDDController leadDDController=Get.find();

  DashboardController dashboardController = Get.put(DashboardController());
  LeadListController leadListController =Get.put(LeadListController());
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        backgroundColor: AppColor.backgroundColor,

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
                          leadSection(context)
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


           Expanded(
             child: Center(
               child: Text(
                AppText.allReminders,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColor.grey3,
                    fontWeight: FontWeight.w700


                ),
                         ),
             ),
           ),

          InkWell(
            onTap: (){

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
      if (dashboardController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (dashboardController.getRemindersModel.value == null ||
          dashboardController.getRemindersModel.value!.data == null || dashboardController.getRemindersModel.value!.data!.isEmpty) {
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

      return  ListView.builder(
        itemCount: dashboardController.getRemindersModel.value!.data!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final lead = dashboardController.getRemindersModel.value!.data![index];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration:  BoxDecoration(
              border: Border.all(color: AppColor.grey200),
              color: AppColor.appWhite,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),

            ),
            child: Column(


              children: [
                /// Header with profile and menu icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primaryColor,
                              border: Border.all(color: AppColor.secondaryColor),
                            ),
                            child: Center(
                              child: Text(
                                lead.leadCustomerName==null?"N":lead.leadCustomerName!.isNotEmpty ? lead.leadCustomerName![0].toUpperCase() : "U", // Initial Letter
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Helper.capitalizeEachWord(lead.leadCustomerName.toString()),

                                // lead.name.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    decoration:  BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColor.grey200),
                                      color: AppColor.grey1,
                                    ),
                                  ),
                                  Text(
                                    lead.leadMobileNo.toString(),
                                    style: TextStyle(
                                      color: AppColor.grey700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10),

                /// Lead details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      _buildDetailRow("Email", lead.leadEmail.toString()),
                      _buildDetailRow("Upcoming reminder Date", Helper.convertDateTime(lead.callReminder.toString())),
                      _buildDetailRow("Last work date",Helper.convertDateTime(lead.workDate.toString()) ),
                      _buildDetailRow("Call Feedback",lead.feedBackRelatedToCall.toString() ),
                      _buildDetailRow("Lead Feedback",lead.feedBackRelatedToLead.toString() ),

                    ],
                  ),
                ),
                SizedBox(height: 10),

                _buildTextButton(
                  label:"Call Now",
                  context: context,
                  color: Colors.purple,
                  icon:  Icons.call,
                  leadId: lead.leadId.toString(),
                  label_code: "call",
                  leadMobileNo:  lead.leadMobileNo.toString(),
                  leadStageStatus: lead.leadStageStatus.toString(),
                ),

              ],
            ),
          );

        },
      );
    });
  }
  Widget _buildDetailRow(String label, String value) {
    //   String assigned = value.toString();
//    List<String> assignedParts = assigned.split('T');


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,

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
              label=="Assigned" ||  label=="Uploaded on"?": ${ Helper.formatDate(value)}":  ": ${value}",

              style: TextStyle(color: Colors.black87),
            ),
          ),
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
    required String leadMobileNo,
    required String leadStageStatus,
    String? currentLeadStage
  }) {

    return InkWell(
      onTap: () {
        leadListController.isFBDetailsShow.value=false;
        leadListController.followDateController.text="";
        leadListController.followTimeController.text="";
        leadDDController.selectedStage.value= leadStageStatus.toString();
        var temp=leadDDController.selectedStage.value??"0";
        leadListController.leadCode.value=temp;
        CallService callService = CallService();
        callService.makePhoneCall(
          phoneNumber:leadMobileNo.toString(),//leadMobileNo.toString(),//leadMobileNo.toString(),//leadMobileNo.toString(),//"+919399299880"
          leadId:  leadId.toString(),
          currentLeadStage:  leadStageStatus.toString(),
          context: context,
          showFeedbackDialog:showCallFeedbackDialog,
        );

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            width:
            MediaQuery.of(context).size.width*0.82,

            decoration: BoxDecoration(
              //color: color,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.grey700)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: label_code=="add_feedback"?AppColor.appWhite:AppColor.grey700, size: 16),
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

/*  void showCallFeedbackDialog({
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
        leadDDController.selectedStage.value=currentLeadStage;
        LeadListController leadListController =Get.find();
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
                    ///stage drodown
                    ///  add this line in dialog at first leadDDController.selectedStage.value=currentLeadStage;
                    const SizedBox(height: 20),

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
                      int leadCode = int.parse(leadListController.leadCode.value); // Assuming this is reactive or available

                      // Allowed stage IDs based on leadCode
                      List<int> allowedStageIds = [];

                      if (leadCode == 2) {
                        allowedStageIds = [4, 5,13];
                      }else if (leadCode == 3) {
                        allowedStageIds = [4, 5,13];
                      } else if (leadCode == 4) {
                        allowedStageIds = [6, 7];
                      } else {
                        allowedStageIds = [2, 3, 4, 5, 6, 7]; // Default to all or handle as needed
                      }

                      List<stage.Data> filteredStages = leadDDController
                          .getAllLeadStageModel.value!.data!
                          .where((lead) =>
                      lead.id != 1 && allowedStageIds.contains(lead.id))
                          .toList();

                      return CustomDropdown<stage.Data>(
                        items: filteredStages,
                        getId: (item) =>item.id.toString(),  // Adjust based on your model structure
                        getName: (item) => item.stageName.toString(),
                        selectedValue: filteredStages.firstWhereOrNull(
                              (item) => item.id.toString() == leadDDController.selectedStage.value,

                        ),
                        onChanged: (value) {
                          leadDDController.selectedStage.value =  value?.id?.toString();

                          if (int.parse(leadDDController.selectedStage.value!) == 3) {
                            leadDDController.selectedStageActive.value = 1;
                          } else if (int.parse(leadDDController.selectedStage.value!) == 4) {
                            leadDDController.selectedStageActive.value = 1;
                          } else if (int.parse(leadDDController.selectedStage.value!) == 5) {
                            leadDDController.selectedStageActive.value = 0;
                          }  else if (int.parse(leadDDController.selectedStage.value!) == 6) {
                            leadDDController.selectedStageActive.value = 1;
                          } else if (int.parse(leadDDController.selectedStage.value!) == 7) {
                            leadDDController.selectedStageActive.value = 0;
                          }else if (int.parse(leadDDController.selectedStage.value!) == 13) {
                            leadDDController.selectedStageActive.value = 0;
                          }else {

                          }

                          print("changed LeadStage==>${leadDDController.selectedStage.value}");
                        },
                      );
                    }),

                    const SizedBox(height: 20),


                    ///stage dd end


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
                  fromWhere: "call",
                  selectedStage: leadDDController.selectedStage.value

              );
              Get.back();
            }

          },
        );
      },
    );
  }*/

  ///new
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
                            /*int leadCode = int.parse(leadListController.leadCode.value); // Assuming this is reactive or available

                            // Allowed stage IDs based on leadCode
                            List<int> allowedStageIds = [];

                            if (leadCode == 2) {
                              allowedStageIds = [4, 5];
                            }else if (leadCode == 3) {
                              allowedStageIds = [4, 5,];
                            } else if (leadCode == 4) {
                              allowedStageIds = [6, 7,];
                            }else if (leadCode == 5) {
                              allowedStageIds = [4, 5,];
                            }else if (leadCode == 6) {
                              allowedStageIds = [6, 7];
                            }else if (leadCode == 7) {
                              allowedStageIds = [6, 7];
                            }else if (leadCode == 13) {
                              allowedStageIds = [4, 5,];
                            } else {
                              allowedStageIds = [4,5]; // Default to all or handle as needed
                            }

                            List<stage.Data> filteredStages = leadDDController
                                .getAllLeadStageModel.value!.data!
                                .where((lead) =>
                            lead.id != 1 && allowedStageIds.contains(lead.id))
                                .toList();
                           */ print("currentLeadStage we need it=======>${currentLeadStage}");
                            print("filteredleadCode we need it=======>${leadListController.filteredleadCode.value}");

                            final filteredStages = leadDDController.getFilteredStagesByLeadStageId(
                              currentLeadStage.toString(),
                            );

                            print("filteredStages we need it=======>${filteredStages.toString()}");
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
}


