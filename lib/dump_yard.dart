
/*
  void showFilterDialog({
    required BuildContext context,
  }) {
    List<String> options = ["Fresh Leads", "Interested Leads", "Not Interested Leads", "Doable Leads","Not Doable Leads"];
    //String? selectedOption = options[0]; // Default selection

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
                        "Filter",
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
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }*/

///call
/*void showCallFeedbackDialog({
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

*//*              String selectedDate = leadListController.followDateController.text; // MM/DD/YYYY
              String selectedTime = leadListController.followTimeController.text; // HH:MM AM/PM


              String formattedDateTime="";

              if(leadListController.isCallReminder.value){
                print("call reminder");
                if (selectedDate.isEmpty || selectedTime.isEmpty) {
                  ToastMessage.msg("Date or Time is empty!");
                  return;
                }

                DateTime parsedDate = DateFormat("MM-dd-yyyy").parse(selectedDate);


                DateTime parsedTime = DateFormat("hh:mm a").parse(selectedTime);


                DateTime combinedDateTime = DateTime(
                  parsedDate.year,
                  parsedDate.month,
                  parsedDate.day,
                  parsedTime.hour,
                  parsedTime.minute,
                );

                formattedDateTime = DateFormat("yyyy-MM-dd' 'HH:mm:ss.SS").format(combinedDateTime);

                print("Final Formatted DateTime if reminder is set: $formattedDateTime");
              }else{
                print("No call reminder");

                DateTime now = DateTime.now();

                formattedDateTime=now.toString();
                print("Final Formatted DateTime if reminder is not set: $formattedDateTime");
              }





              var remStatus=leadListController.isCallReminder.value?"1":"0";
              print("remStatus before passing: $remStatus");
              print("formattedDateTime before passing: $formattedDateTime");

              leadListController.workOnLeadApi(
                leadId: leadId.toString(),
                leadStageStatus: currentLeadStage,
                feedbackRelatedToCall: leadListController.callFeedbackController.text.trim(),
                feedbackRelatedToLead: leadListController.leadFeedbackController.text.trim(),
                callStatus: callStatus,
                callDuration: callDuration,
                callStartTime: callStartTime,
                callEndTime: callEndTime,
                callReminder: formattedDateTime,
                reminderStatus:  leadListController.isCallReminder.value?"1":"0",
              );*//*
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
                id: id

            );
            Get.back();
          }

        },
      );
    },
  );
}*/
///draower
/*import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:ksdpl/controllers/bot_nav_controller.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:shimmer/shimmer.dart';

import '../common/customListTIle.dart';
import '../common/storage_service.dart';
import '../controllers/leads/leadlist_controller.dart';
import '../custom_widgets/RoundedInitialContainer.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String firstName="user";
  String email="user@email.com";
  String role="";
  LeadListController leadListController = Get.find();
  Addleadcontroller addLeadController = Get.find();
  BotNavController botNavController=Get.find();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(

        padding: EdgeInsets.zero,
        children: [

          DrawerHeader(

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryDark, AppColor.primaryLight],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              image: DecorationImage(
                image: AssetImage(AppImage.backDrawer),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    RoundedInitialContainer(firstName: firstName,),
                    const SizedBox(height: 10),
                    Text(
                      firstName,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          role,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white70,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: 12.0),
                          child: Image.asset(AppImage.editImage, height: 18, width: 18,),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Navigation Items
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: Column(
              children: [
                CustomListTile(
                  title:  AppText.home,
                  imagePath:AppImage.home2,
                  onTap: () {
                    Navigator.pop(context);
                    botNavController.selectedIndex.value = 0;
                  },

                ),


                *//*ExpansionTile(
                 childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                 title: Text(AppText.myProfile),
                 leading: Image.asset(AppImage.manInBlack, height: 20,),
                 children: [
                   ListTile(

                     leading:  Icon(Icons.home,color: Theme.of(context).brightness == Brightness.dark?Colors.white54:AppColor.black54),
                     title:  Text("Edit profile", style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                     onTap: () {
                       //  Get.toNamed("/editProfile");
                     },
                   ),
                   ListTile(
                     leading:  Icon(Icons.lock,color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),
                     title:  Text(AppText.changePassword,style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                     onTap: () {
                       //  Get.toNamed("/changePassword");
                     },
                   ),
                 ],
               ),*//*

                *//*  CustomListTile(
                 title:  AppText.myProfile,
                 imagePath:AppImage.manInBlack,
                 onTap: () {
                   Navigator.pop(context);
                   // Add your navigation logic here
                 },

               ),*//*

                ExpansionTile(


                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  title:const Text(AppText.leads, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: Image.asset(AppImage.manInBlack, height: 20,),
                  children: [
                    ListTile(

                      leading:  Icon(Icons.add_task,color: AppColor.blackColor),
                      title:  Text("Add", style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                      onTap: () {
                        addLeadController.fromWhere.value="drawer";
                        Get.toNamed("/addLeadScreen");
                      },
                    ),
                    ListTile(//color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54
                      leading:  Icon(Icons.view_stream_outlined,color: AppColor.blackColor),
                      title:  Text("View",style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500)),
                      onTap: () {
                        leadListController.stateIdMain.value="0";
                        leadListController.distIdMain.value="0";
                        leadListController.cityIdMain.value="0";
                        leadListController.campaignMain.value="";
                        leadListController.fromWhere.value="drawer";
                        Get.toNamed("/leadListMain");
                      },
                    ),
                  ],
                ),

                CustomListTile(
                  title:  AppText.loanAppl,
                  imagePath:AppImage.manInBlack,
                  onTap: () {
                    Get.toNamed("/loanApplication");

                  },

                ),

                // Logout Button
                CustomListTile(
                  title:  AppText.logout,
                  imagePath:AppImage.powerIcon,
                  onTap: () {
                    StorageService.clear();
                    Get.offNamed("/login");
                  },

                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  loadData(){
    print("role===>${StorageService.get(StorageService.ROLE).toString()}");
    firstName=StorageService.get(StorageService.FIRST_NAME).toString();
    email=StorageService.get(StorageService.EMAIL).toString();
    role=StorageService.get(StorageService.ROLE).toString();
  }
}*/
