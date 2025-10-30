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


class DisbursedHistoryListScreen extends StatelessWidget {
 // const DisbursedHistoryListScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());

  LeadListController leadListController = Get.put(LeadListController());
  LeadDetailController leadDetailController = Get.put(LeadDetailController());
  LeadDDController leadDDController=Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key:_scaffoldKey,
        backgroundColor: AppColor.backgroundColor,
   //     drawer:   CustomDrawer(),
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
                      height: MediaQuery.of(context).size.height*0.80,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //SizedBox(height: MediaQuery.of(context).size.height*0.1),
                              leadSection(context)
                          
                            ],
                          ),
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
              child: Image.asset(AppImage.arrowLeft,height: 40,width: 40,)),

          const Text(
            AppText.history,
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

  Widget leadSection(BuildContext context) {
    return Obx(() {
      if (leadListController.isLoading.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final model = leadListController.disbursedHistoryModel.value;

      if (model == null || model.data == null || model.data!.isEmpty) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.50,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey200),
            color: AppColor.appWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Text(
              "No data found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.grey700,
              ),
            ),
          ),
        );
      }

      final dataList = model.data!;

      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Basic Info
                /// Basic Info
            buildCard("${index + 1}", [
              DetailRow(label: "ID", value: data.id?.toString() ?? AppText.customdash),
              DetailRow(label: "Unique Lead Number", value: data.uniqueLeadNo?.toString() ?? AppText.customdash),
              DetailRow(label: "Date", value: data.date?.toString() ?? AppText.customdash),
              DetailRow(label: "Amount", value: data.amount?.toString() ?? AppText.customdash),
              DetailRow(label: "Actual Date", value: data.actualDate?.toString() ?? AppText.customdash),
              DetailRow(label: "Actual Amount", value: data.actualAmount?.toString() ?? AppText.customdash),
              DetailRow(label: "Transaction Details", value: data.transactionDetails?.toString() ?? AppText.customdash),
              DetailRow(label: "Disbursed By", value: data.disbursedBy?.toString() ?? AppText.customdash),
              DetailRow(label: "Contact No", value: data.contactNo?.toString() ?? AppText.customdash),
              DetailRow(label: "Loan Account No", value: data.loanAccountNo?.toString() ?? AppText.customdash),
              DetailRow(label: "Invoice Date", value: data.invoiceDate?.toString() ?? AppText.customdash),
              DetailRow(label: "Receipt Date", value: data.receiptDate?.toString() ?? AppText.customdash),

            ], Icons.numbers),


              const SizedBox(height: 16),

              ],
            ),
          );
        },
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
                              const Text(
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


