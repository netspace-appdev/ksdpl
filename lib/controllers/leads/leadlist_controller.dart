
import 'dart:io';

import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/controllers/dashboard/DashboardController.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetAllLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/dashboard/GetRemindersModel.dart';
import '../../models/dashboard/LeadMoveToCommonTaskModel.dart';
import '../../models/dashboard/WorkOnLeadModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/drawer/UpdateLeadStageModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import 'lead_history_controller.dart';

class LeadListController extends GetxController {

  var isLoading = false.obs;
  // GetAllLeadsModel? getAllLeadsModel;

  var getAllLeadsModel = Rxn<GetAllLeadsModel>(); //
  var getLeadDetailModel = Rxn<GetLeadDetailModel>(); //
  UpdateLeadStageModel? updateLeadStageModel;
  LeadMoveToCommonTaskModel? leadMoveToCommonTaskModel;
  WorkOnLeadModel? workOnLeadModel;

  var interestLeadsCheck = false.obs; // Observable variable
  var assignedLeadsCheck = true.obs; // Observable variable
  var leadCode="2".obs;
  var leadStageName="Fresh Leads".obs;
  var leadStageName2="Fresh Leads".obs;
  var fromWhere="".obs;
  var stateIdMain="0".obs;
  var distIdMain="0".obs;
  var cityIdMain="0".obs;
  var campaignMain="".obs;

  var selectedIndex = (1).obs;
  var leadId = RxnString();

  var eId="".obs;
  final TextEditingController openPollPercentController = TextEditingController();
  final TextEditingController followDateController = TextEditingController();
  final TextEditingController followTimeController = TextEditingController();
  final TextEditingController followDetailsController = TextEditingController();

  final TextEditingController callFeedbackController = TextEditingController();
  final TextEditingController leadFeedbackController = TextEditingController();
  GetEmployeeModel? getEmployeeModel;
  var isCallReminder=false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    var phone=StorageService.get(StorageService.PHONE);
    getEmployeeByPhoneNumberApi(phone: phone.toString());



  }


  void makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phoneUri)) {

      await launchUrl(phoneUri);
      await Future.delayed(Duration(seconds: 5)); // Wait before checking logs
      checkCallStatus(phoneNumber);


    } else {

      ToastMessage.msg(AppText.couldNotCall);
    }
  }

  Future<void> checkCallStatus(String phoneNumber) async {
    await Future.delayed(Duration(seconds: 3)); // Allow time for call logs to update

    Iterable<CallLogEntry> callLogs = await CallLog.query(
      number: phoneNumber,
    );

    if (callLogs.isNotEmpty) {
      CallLogEntry lastCall = callLogs.first;
      print("Call Type: ${lastCall.callType}");
      print("Duration: ${lastCall.duration} seconds");

      if (lastCall.duration! > 0) {
        print("Call was connected and lasted ${lastCall.duration} seconds.");
      } else {
        print("Call was not answered or disconnected immediately.");
      }
    } else {
      print("No call log found for $phoneNumber.");
    }
  }

  void openWhatsApp({required String phoneNumber, String message = ""}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {

      ToastMessage.msg(AppText.couldNotWA);
    }
  }

  void sendSMS({required String phoneNumber, required String message}) async {
    String smsUrl = "sms:$phoneNumber?body=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(smsUrl))) {
      await launchUrl(Uri.parse(smsUrl));
    } else {
      ToastMessage.msg(AppText.couldNotMsg);
    }
  }




  void selectCheckbox(int index) {

    selectedIndex.value = index;
    if( selectedIndex.value==0){
      leadCode.value="0";
      leadStageName.value="All Leads";

    } else if( selectedIndex.value==1){
      leadCode.value="2";
      leadStageName.value="Fresh Leads";

    }else if(selectedIndex.value==2){
      leadCode.value="13";
      leadStageName.value="Couldn't Connect";
    }else if(selectedIndex.value==3){
      leadCode.value="4";
      leadStageName.value="Interested Leads";
    }else if(selectedIndex.value==4){
      leadCode.value="5";
      leadStageName.value="Not Interested Leads";
    }
    else if(selectedIndex.value==5){
      leadCode.value="6";
      leadStageName.value="Doable Leads";
    }
    else if(selectedIndex.value==6){
      leadCode.value="7";
      leadStageName.value="Not Doable Leads";
    }
  }


/*  void selectCheckbox(int index) {

    selectedIndex.value = index;
    if( selectedIndex.value==0){
      leadCode.value="2";
      leadStageName.value="Fresh Leads";

    }else if(selectedIndex.value==1){
      leadCode.value="3";
      leadStageName.value="Working Leads";
    }else if(selectedIndex.value==2){
      leadCode.value="4";
      leadStageName.value="Interested Leads";
    }else if(selectedIndex.value==3){
      leadCode.value="5";
      leadStageName.value="Not Interested Leads";
    }
    else if(selectedIndex.value==4){
      leadCode.value="6";
      leadStageName.value="Doable Leads";
    }
    else if(selectedIndex.value==5){
      leadCode.value="7";
      leadStageName.value="Not Doable Leads";
    }
  }*/

  void filterSubmit(){
    var eId=StorageService.get(StorageService.EMPLOYEE_ID);
    getAllLeadsApi(
        leadStage: leadCode.value,
        employeeId:eId.toString(),
        stateId:stateIdMain.value,
        distId: distIdMain.value,
        cityId: cityIdMain.value,
        campaign: campaignMain.value
    );
  }

  void callFeedbackSubmit({
    required leadId,
    required currentLeadStage,
    required callStatus,
    required callDuration,
    required callStartTime,
    required callEndTime,
    String? id,
    required fromWhere,
}){
    

    String selectedDate = followDateController.text; // MM/DD/YYYY
    String selectedTime = followTimeController.text; // HH:MM AM/PM


    String formattedDateTime="";

    if(isCallReminder.value){
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


    }else{


      DateTime now = DateTime.now();

      formattedDateTime=now.toString();

    }





    var remStatus=isCallReminder.value?"1":"0";


    workOnLeadApi(
      id:callStatus=="1"?id.toString():"0",
      leadId: leadId.toString(),
      leadStageStatus: currentLeadStage,
      feedbackRelatedToCall: callFeedbackController.text.trim(),
      feedbackRelatedToLead: leadFeedbackController.text.trim(),
      callStatus: callStatus,
      callDuration: callDuration,
      callStartTime: callStartTime,
      callEndTime: callEndTime,
      callReminder: formattedDateTime,
      reminderStatus:  isCallReminder.value?"1":"0",
    ).then((_){
     if(fromWhere=="call"){
       LeadHistoryController leadHistoryController = Get.find();
       leadHistoryController.getLeadWorkByLeadIdApi(leadId: leadId.toString());
     }
     DashboardController dashboardController=Get.find();
     dashboardController.getRemindersApi( employeeId: getEmployeeModel!.data!.id.toString());
     print("only followup");
    });
  }


  void  getAllLeadsApi({
    required String employeeId,
    required String leadStage,
    required stateId,
    required distId,
    required cityId,
    required campaign,
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getAllLeadsApi(
        employeeId:employeeId,
        leadStage: leadStage,
          stateId: stateId,
          distId: distId,
          cityId: cityId,
        campaign: campaign,
      );


      if(data['success'] == true){

        getAllLeadsModel.value= GetAllLeadsModel.fromJson(data);


        leadStageName2.value=leadStageName.value;


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        leadStageName2.value=leadStageName.value;
        getAllLeadsModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllLeadsApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }



  void  updateLeadStageApi({
    required id,
    required stage,
    required active,

  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.updateLeadStageApi(
          id:id,
          stage: stage,
          active: active
      );


      if(data['success'] == true){

        updateLeadStageModel= UpdateLeadStageModel.fromJson(data);

        workOnLeadApi(
          leadId: id,
          leadStageStatus:stage,
        );

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error updateLeadStageApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {
      print("run hua");



      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value,
          campaign: campaignMain.value
      );

      isLoading(false);
    }
  }


  void  leadMoveToCommonTaskApi({
    required leadId,
    required percentage,

  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.leadMoveToCommonTaskApi(
        leadId:leadId,
        percentage: percentage,

      );


      if(data['success'] == true){

        ///Change model

        leadMoveToCommonTaskModel= LeadMoveToCommonTaskModel.fromJson(data);



        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error leadMoveToCommonTaskModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {
      print("run hua");



      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value,
          campaign: campaignMain.value
      );

      isLoading(false);
    }
  }


  Future<void> workOnLeadApi({
    required String leadId,
    String leadStageStatus = "0",
    String leadPercent = "0",
    String employeeId = "0",
    String? callEndTime,
    String callStatus = "0",
    String? callStartTime,
    String? feedbackRelatedToLead,
    String? callDuration,
    String? callReminder,
    String? feedbackRelatedToCall,
    String moveToCommon = "0",
    File? callRecordingPathUrl, // File upload
    String reminderStatus = "0",
    String id = "0",
  }) async {
    try {
      isLoading(true);

      var eId=StorageService.get(StorageService.EMPLOYEE_ID);

      var data = await DrawerApiService.workOnLeadApi(
          leadId:leadId,
          leadStageStatus: leadStageStatus,
          leadPercent: leadPercent,
          employeeId: eId.toString(),
          callEndTime: callEndTime,
          callStatus: callStatus,
          callStartTime: callStartTime,
          feedbackRelatedToLead: feedbackRelatedToLead,
          callDuration: callDuration,
          callReminder: callReminder,
          feedbackRelatedToCall: feedbackRelatedToCall,
          moveToCommon: moveToCommon,
          callRecordingPathUrl: callRecordingPathUrl,
        reminderStatus: reminderStatus,
        id: id,
      );


      if(data['success'] == true){

        workOnLeadModel= WorkOnLeadModel.fromJson(data);


        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error workOnLeadModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {
      print("run hua");



      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value,
          campaign: campaignMain.value
      );

      isLoading(false);
    }
  }


  void  getEmployeeByPhoneNumberApi({
    required String phone,

  }) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getEmployeeByPhoneNumberApi(phone: phone,);


      if(data['success'] == true){

        getEmployeeModel= GetEmployeeModel.fromJson(data);


        StorageService.put(StorageService.EMPLOYEE_ID, getEmployeeModel!.data!.id.toString());
        isLoading(false);
        eId.value=StorageService.get(StorageService.EMPLOYEE_ID).toString();

        getAllLeadsApi(
            leadStage: leadCode.value,
            employeeId:eId.toString(),
            stateId:stateIdMain.value,
            distId: distIdMain.value,
            cityId: cityIdMain.value,
            campaign: campaignMain.value
        );

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getEmployeeByPhoneNumberApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  Future<void> refreshItems() async {
    getAllLeadsApi(
        leadStage: leadCode.value,
        employeeId:eId.toString(),
        stateId:stateIdMain.value,
        distId: distIdMain.value,
        cityId: cityIdMain.value,
        campaign: campaignMain.value
    );
  }

}
