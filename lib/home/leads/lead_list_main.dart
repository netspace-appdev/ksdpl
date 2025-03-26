import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/storage_service.dart';
import '../../common/validation_helper.dart';
import '../../controllers/drawer_controller.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/leadlist_controller.dart';

import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomDialogBox.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../../custom_widgets/CustomLabeledTimePicker.dart';
import '../../custom_widgets/CustomTextFieldPrefix.dart';
import '../../exp.dart';
import '../../services/call_service.dart';
import '../custom_drawer.dart';

class LeadListMain extends StatelessWidget {
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  LeadListController leadListController = Get.find();
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Addleadcontroller addLeadController = Get.put(Addleadcontroller());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key:_scaffoldKey,

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

                        SizedBox(
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
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Obx(()=> Text(
                               leadListController.leadStageName2.value.toString(),
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             )),
                              InkWell(
                                onTap: (){
                                  addLeadController.fromWhere.value="leadList";
                                  Get.toNamed("/addLeadScreen");
                                },
                                child: const Row(

                                  children: [
                                    Icon(Icons.add,color: AppColor.orangeColor,size: 16,),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      AppText.addLead,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.orangeColor
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leadListController.fromWhere.value=="drawer"?
          InkWell(
            onTap: (){
              Get.back();
            },
              child: Image.asset(AppImage.arrowLeft,height: 24,)):
          InkWell(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(AppImage.drawerIcon)),

          Text(
            "Leads",
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
              fontWeight: FontWeight.w700


            ),
          ),

          InkWell(
            onTap: (){
              showFilterDialog(context: context,leadId: "0");
            },
            child: Container(

              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  BoxDecoration(
                color: AppColor.appWhite.withOpacity(0.15),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(child: Image.asset(AppImage.filterIcon, height: 17,)),
            ),
          )
        ],
      ),
    );
  }

  Widget searchArea(){
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            controller: _searchController,
            onChanged: (val){},
            hintText: "Search Leads...",
          ),
        ),
        Container(

          width: 50,
          height:50,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: const BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(child: Image.asset(AppImage.filterIcon, height: 22,)),
        )
      ],
    );
  }

  Widget leadSection(BuildContext context){
    return Obx((){
      if (leadListController.isLoading.value) {
        return  Center(child: CustomSkelton.productShimmerList(context));
      }
      if (leadListController.getAllLeadsModel.value == null ||
          leadListController.getAllLeadsModel.value!.data == null || leadListController.getAllLeadsModel.value!.data!.isEmpty) {
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
        itemCount: leadListController.getAllLeadsModel.value!.data!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final lead = leadListController.getAllLeadsModel.value!.data![index];

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
                                lead.name==null?"N":lead.name!.isNotEmpty ?  lead.name![0].toUpperCase() : "U", // Initial Letter
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Helper.capitalizeEachWord(lead.name.toString()),

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
                                    lead.mobileNumber.toString(),
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

                      if(leadListController.leadCode.value=="4" )
                        _buildTextButton(
                          label:AppText.openPoll,
                          context: context,
                          color: Colors.purple,
                          icon:  Icons.lock_open,
                          leadId: lead.id.toString(),
                          label_code: "open_poll",
                        ),
                      //Icon(Icons.more_vert, color: AppColor.grey1,), // Three dots menu icon
                    ],
                  ),
                ),
                SizedBox(height: 10),

                /// Lead details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      _buildDetailRow("Email", lead.email.toString()),
                      _buildDetailRow("Assigned", lead.assignedEmployeeDate.toString()),
                      _buildDetailRow("Uploaded on", lead.uploadedDate.toString()),
                      // _buildDetailRow("Uploaded by", lead.uploadedBy.toString()),
                      // _buildDetailRow("City", "Sagwada"),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                /// Action Buttons (Call, Chat, Mail, WhatsApp, Status)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      _buildIconButton(icon: AppImage.call1, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "call", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(),context: context),
                      _buildIconButton(icon: AppImage.whatsapp, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "whatsapp", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(), context: context),
                      _buildIconButton(icon: AppImage.message1, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "message", leadId: lead.id.toString(), currentLeadStage:  lead.leadStage.toString(),context: context),
                      //_buildIconButton(icon: AppImage.chat1, color: AppColor.orangeColor, phoneNumber: lead.mobileNumber.toString(), label: "chat" ),
                      InkWell(
                        onTap: () {
                          //Get.toNamed("/leadDetailsMain", arguments: {"leadId":lead.id.toString()});
                          Get.toNamed("/leadDetailsTab", arguments: {"leadId":lead.id.toString()});

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: AppColor.orangeColor, // Button background color
                            borderRadius: BorderRadius.circular(2), // Rounded corners
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.file_copy,size: 10,color: AppColor.appWhite,),
                              SizedBox(width: 5,),
                              Text(
                                AppText.details,
                                style: TextStyle(color: AppColor.appWhite),
                              )
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 10),

                /// Bottom Row Buttons (Assigned, Follow Up, Call Back, Employment)
                Row(
                  mainAxisAlignment:leadListController.leadCode.value=="6"? MainAxisAlignment.center: MainAxisAlignment.spaceBetween,
                  children: [
                    if(leadListController.leadCode.value=="2" ||leadListController.leadCode.value=="4" ||leadListController.leadCode.value=="6")
                    _buildTextButton(
                      label:AppText.followup,
                      context: context,
                      color: Colors.purple,
                      icon:  Icons.feedback,
                      leadId: lead.id.toString(),
                      label_code: "follow_up",
                    ),
                    if(leadListController.leadCode.value=="4")...[
                      _buildTextButton(
                        label:AppText.doable,
                        context: context,
                        color: Colors.purple,
                        icon:  Icons.thumb_up_alt_outlined,
                        leadId: lead.id.toString(),
                        label_code: "doable",
                      ),
                      _buildTextButton(
                        label:AppText.notDoable,
                        context: context,
                        color: Colors.purple,
                        icon:  Icons.thumb_down_alt_outlined,
                        leadId: lead.id.toString(),
                        label_code: "not_doable",
                      )
                    ]
                    else if(leadListController.leadCode.value=="2")...[

                      _buildTextButton(
                        label:AppText.interested,
                        context: context,
                        color: Colors.purple,
                        icon:  Icons.thumb_up_alt_outlined,
                        leadId: lead.id.toString(),
                        label_code: "interested",
                      ),
                      _buildTextButton(
                        label:AppText.notInterested,
                        context: context,
                        color: Colors.purple,
                        icon:  Icons.thumb_down_alt_outlined,
                        leadId: lead.id.toString(),
                        label_code: "not_interested",

                      ),
                    ]



                    //_buildTextButton("Details", context, Colors.pink, Icons.insert_drive_file,lead.id.toString()),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _buildTextButton(
                      label:AppText.addFeedback,
                      context: context,
                      color: Colors.purple,
                      icon:  Icons.add_call,
                      leadId: lead.id.toString(),
                      label_code: "add_feedback",
                      currentLeadStage: lead.leadStage.toString(),
                    ),
                  ],
                )

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
              label=="Assigned" ||  label=="Uploaded on"?": ${ Helper.formatDate(value)}":  ": ${value}",

              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget for icon buttons
  Widget _buildIconButton({
    required String icon,
    required Color color,
    required String phoneNumber,
    required String label,
    required String leadId,
    required String currentLeadStage,
    required BuildContext context,
}) {
    return IconButton(
      onPressed: () {
        if(label=="call"){
          // leadListController.makePhoneCall(phoneNumber);
          CallService callService = CallService();
          callService.makePhoneCall(
            phoneNumber: "+919399299880",//phoneNumber,
            leadId: leadId,
            currentLeadStage: currentLeadStage,
            context: context
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




  Widget _buildTextButton({
    required String label,
    required BuildContext context,
    required Color color,
    required IconData icon,
    required String leadId,
    required String label_code,
    String? currentLeadStage
}) {

    return InkWell(
      onTap: () {
        if (label == "Open Poll") {
          showOpenPollDialog2(context: context,leadId: leadId);
        }else if (label_code == "follow_up") {

           showFollowupDialog(
            context: context,
            leadId: leadId,
          );
        }else if (label_code == "add_feedback") {

          showCallFeedbackDialog(
            context: context,
            leadId: leadId,
            currentLeadStage: currentLeadStage.toString()
          );
        }else if (label_code == "interested" || label_code =="not_interested" || label_code == "doable" || label_code =="not_doable") {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialogBox(
                title: "Are you sure?",

                onYes: () {
                  if(label_code == "interested"){
                    leadListController.workOnLeadApi(
                      leadId: leadId.toString(),
                      leadStageStatus:"4",
                    );
                  }else if(label_code == "not_interested"){
                    leadListController.workOnLeadApi(
                      leadId: leadId.toString(),
                      leadStageStatus:"5",
                    );
                  }else if(label_code == "doable"){
                    leadListController.workOnLeadApi(
                      leadId: leadId.toString(),
                      leadStageStatus:"6",
                    );
                  }else if(label_code == "not_doable"){
                    leadListController.workOnLeadApi(
                      leadId: leadId.toString(),
                      leadStageStatus:"7",
                    );
                  }



                },
                onNo: () {

                },
              );
            },
          );
        }else{

        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            width: leadListController.leadCode.value == "6"?MediaQuery.of(context).size.width*0.80:MediaQuery.of(context).size.width*0.26,

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
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: AppColor.blackColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }







  void showLeadStatusDialog({
    required BuildContext context,
    required leadId,
  }) {
    List<String> options=[];
    if(leadListController.leadCode.value=="2"){
      options = ["Interested", "Not Interested"];
    }else  if(leadListController.leadCode.value=="4"){
      options = ["Doable", "Not Doable"];
    }else{

    }

    String? selectedOption = options[0]; // Default selection

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity, // Makes it full width
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔵 Title in Blue Strip
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:AppColor.primaryColor, // Title background color
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        gradient: LinearGradient(
                          colors: [AppColor.primaryLight, AppColor.primaryDark],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        "Select Status:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white, // Title text color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // 📝 Content (Radio Buttons)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.map((option) {
                          return RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value;
                              });
                            },
                            activeColor: AppColor.orangeColor, // Change active radio button color
                          );
                        }).toList(),
                      ),
                    ),

                    // 🟠 Buttons (Close & Submit)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColor.grey1,
                              side: BorderSide(color: AppColor.grey2),
                            ),
                            child: Text("Close", style: TextStyle(color: AppColor.grey2)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              String selectedValue = (selectedOption == "Interested") ? "4" : "5";
                              String activeValue = (selectedOption == "Interested") ? "1" : "0";

                              String selectedValueDoable = (selectedOption == "Doable") ? "6" : "7";
                              String activeValueDoable = (selectedOption == "Doable") ? "1" : "0";
                              if(leadListController.leadCode.value=="2"){
                                print("for intrested");

                                leadListController.workOnLeadApi(
                                  leadId: leadId.toString(),
                                  leadStageStatus:selectedValue,
                                );

                              }else  if(leadListController.leadCode.value=="4"){
                                print("for doable");
                                leadListController.workOnLeadApi(
                                  leadId: leadId.toString(),
                                  leadStageStatus:selectedValue,
                                );
                              }else{

                              }

                              Navigator.pop(context); // Close dialog after submission
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.orangeColor,
                            ),
                            child: Text("Submit", style: TextStyle(color: AppColor.appWhite)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }



/*  void showOpenPollDialog({
    required BuildContext context,
    required String leadId,
  }) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity, // Makes it full width
                padding: EdgeInsets.zero,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 🔵 Title in Blue Strip
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color:AppColor.primaryColor, // Title background color
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          gradient: LinearGradient(
                            colors: [AppColor.primaryLight, AppColor.primaryDark],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: const Text(
                          "Open Poll",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white, // Title text color
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // 📝 Content (Radio Buttons)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child:  Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Enter percent for leads",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.grey1, // Title text color
                                ),

                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFieldPrefix(
                              inputType:  TextInputType.number,
                              controller: leadListController.openPollPercentController,
                              hintText: "like 2.0 %",
                              validator: validatePercentage,
                              isPassword: false,
                              obscureText: false,
                            ),
                          ],
                        ),
                      ),

                      // 🟠 Buttons (Close & Submit)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColor.grey1,
                                side: BorderSide(color: AppColor.grey2),
                              ),
                              child: Text("Close", style: TextStyle(color: AppColor.grey2)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  leadListController.leadMoveToCommonTaskApi(
                                      leadId: leadId,
                                      percentage: leadListController.openPollPercentController.text.trim().toString()
                                  );
                                  Navigator.pop(context);
                                }

                               // Close dialog after submission
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.orangeColor,
                              ),
                              child: Text("Submit", style: TextStyle(color: AppColor.appWhite)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }*/

  String? validatePercentage(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.percentageRequired;
    } 
    return null;
  }

  void showFollowupDialog({
    required BuildContext context,
    required leadId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: AppText.setFollowup,
          content: Column(
            children: [
              CustomLabeledPickerTextField(
                label: AppText.selectDate,
                isRequired: true,
                controller: leadListController.followDateController,
                inputType: TextInputType.name,
                hintText: "MM/DD/YYYY",
                isDateField: true,
              ),
              CustomLabeledTimePickerTextField(
                label: AppText.selectTime,
                isRequired: true,
                controller: leadListController.followTimeController,
                inputType: TextInputType.datetime,
                hintText: "HH:MM AM/PM",
                isTimeField: true,
              ),
              SizedBox(height: 15,),
              CustomLabeledTextField(
                label: AppText.details,
                isRequired: true,
                controller: leadListController.followDetailsController,
                inputType: TextInputType.name,
                hintText: AppText.enterDetails,
                validator:  ValidationHelper.validateName,
                isTextArea: true,

              ),

            ],
          ),
          onSubmit: () {
            Get.back(); // Close dialog
            // Handle submission logic
          },
        );
      },
    );
  }


  void showFilterDialog({
    required BuildContext context,
    required leadId,
  }) {
    List<String> options = ["Fresh Leads", "Interested Leads", "Not Interested Leads", "Doable Leads","Not Doable Leads"];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: "Filter",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical:0 ),
                child:  Obx(()=>Column(
                  children: options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;

                    return CheckboxListTile(
                      activeColor: AppColor.secondaryColor,

                      title: Text(option),
                      value: leadListController.selectedIndex.value == index,
                      onChanged: (value) => leadListController.selectCheckbox(index),
                    );
                  }).toList(),
                )),
              ),

              // 🟠 Buttons (Close & Submit)
             /* Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColor.grey1,
                        side: BorderSide(color: AppColor.grey2),
                      ),
                      child: Text("Close", style: TextStyle(color: AppColor.grey2)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        leadListController.filterSubmit();
                        Navigator.pop(context); // Close dialog after submission
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.orangeColor,
                      ),
                      child: Text("Submit", style: TextStyle(color: AppColor.appWhite)),
                    ),
                  ],
                ),
              ),*/
            ],
          ),
          onSubmit: () {
            leadListController.filterSubmit();
            Navigator.pop(context); // Close dialog after submission
            // Handle submission logic
          },
        );
      },
    );
  }

  void showOpenPollDialog2({
    required BuildContext context,
    required leadId,
  }) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: "Open Poll",
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),


                // 📝 Content (Radio Buttons)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child:  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter percent for leads",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColor.grey1, // Title text color
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFieldPrefix(
                        inputType:  TextInputType.number,
                        controller: leadListController.openPollPercentController,
                        hintText: "like 2.0 %",
                        validator: validatePercentage,
                        isPassword: false,
                        obscureText: false,
                      ),
                    ],
                  ),
                ),
/*
                // 🟠 Buttons (Close & Submit)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColor.grey1,
                          side: BorderSide(color: AppColor.grey2),
                        ),
                        child: Text("Close", style: TextStyle(color: AppColor.grey2)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            leadListController.leadMoveToCommonTaskApi(
                                leadId: leadId,
                                percentage: leadListController.openPollPercentController.text.trim().toString()
                            );
                            Navigator.pop(context);
                          }

                          // Close dialog after submission
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.orangeColor,
                        ),
                        child: Text("Submit", style: TextStyle(color: AppColor.appWhite)),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              leadListController.leadMoveToCommonTaskApi(
                  leadId: leadId,
                  percentage: leadListController.openPollPercentController.text.trim().toString()
              );
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  void showCallFeedbackDialog({
    required BuildContext context,
    required leadId,
    required currentLeadStage,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: AppText.addFeedback,
          content: Form(
            child: Column(
              children: [
                SizedBox(height: 15,),
                CustomLabeledTextField(
                  label: AppText.callFeedback,
                  isRequired: false,
                  controller: leadListController.callFeedbackController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterCallFeedback,
                  //validator:  ValidationHelper.validateName,
                  isTextArea: true,

                ),
                SizedBox(height: 15,),
                CustomLabeledTextField(
                  label: AppText.leadFeedback,
                  isRequired: false,
                  controller: leadListController.leadFeedbackController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterLeadFeedback,
                 // validator:  ValidationHelper.validateName,
                  isTextArea: true,

                ),

              ],
            ),
          ),
          onSubmit: () {
            if(leadListController.callFeedbackController.text.isEmpty && leadListController.leadFeedbackController.text.isEmpty){
              ToastMessage.msg(AppText.addFeedbackFirst);
            }else{
              leadListController.workOnLeadApi(
                  leadId: leadId.toString(),
                  leadStageStatus: currentLeadStage,
                  feedbackRelatedToCall:leadListController.callFeedbackController.text.trim().toString(),
                  feedbackRelatedToLead:leadListController.leadFeedbackController.text.trim().toString(),
                  callStatus: "1",
                  callDuration: "00:00",
                callStartTime:  "00:00",
                callEndTime: "00:00",


              );
              Get.back();
            }
            print("currentLeadStage===>${currentLeadStage}");


          },
        );
      },
    );
  }
}

