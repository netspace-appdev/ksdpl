
import 'dart:io';

import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/controllers/dashboard/DashboardController.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:ksdpl/controllers/leads/seachLeadController.dart';
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
  var selectedPrevStage = Rxn<String>();
  var isLoading = false.obs;
  // GetAllLeadsModel? getAllLeadsModel;

  var getAllLeadsModel = Rxn<GetAllLeadsModel>(); //
  ///newly added for filter
  var filteredGetAllLeadsModel = Rxn<GetAllLeadsModel>();
  var isFilteredLoading = false.obs;
  var filteredHasMore = true.obs;
  var filteredCurrentPage = 1.obs;
  var isMainListMoreLoading = false.obs;
  var isDashboardLeadListMoreLoading = false.obs;
  ///newly added for filter end

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
  var fromWhereLeads="main".obs;
  var stateIdMain="0".obs;
  var distIdMain="0".obs;
  var cityIdMain="0".obs;
  var campaignMain="".obs;
  var fromDateMain="".obs;
  var toDateMain="".obs;
  var branchMain="0".obs;
  var uniqueLeadNumberMain="".obs;
  var leadMobileNumberMain="".obs;

  var selectedIndex = (1).obs;
  var leadId = RxnString();

  var eId="".obs;
  final TextEditingController openPollPercentController = TextEditingController();
  final TextEditingController followDateController = TextEditingController();
  final TextEditingController followTimeController = TextEditingController();
  final TextEditingController followDetailsController = TextEditingController();

  final TextEditingController callFeedbackController = TextEditingController();
  final TextEditingController leadFeedbackController = TextEditingController();

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController couldNotController = TextEditingController();
  GetEmployeeModel? getEmployeeModel;
  var isCallReminder=false.obs;
  var isFBDetailsShow=false.obs;

  RxInt currentPage = 1.obs;
  final int pageSize = 20;
  RxBool hasMore = true.obs;
  RxInt leadListLength = 0.obs;
  RxInt filteredLeadListLength = 0.obs;
  LeadDDController leadDDController=Get.put(LeadDDController());
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

    }else if( selectedIndex.value==2){
      leadCode.value="3";
      leadStageName.value="Ongoing Call";
      //working leads is now ongoing call
    }else if(selectedIndex.value==3){
      leadCode.value="13";
      leadStageName.value="Couldn't Connect";
    }else if(selectedIndex.value==4){
      leadCode.value="4";
      leadStageName.value="Interested Leads";
    }else if(selectedIndex.value==5){
      leadCode.value="5";
      leadStageName.value="Not Interested";
    }
    else if(selectedIndex.value==6){
      leadCode.value="6";
      leadStageName.value="Doable Leads";
    }
    else if(selectedIndex.value==7){
      leadCode.value="7";
      leadStageName.value="Not Doable";
    }
  }




  void filterSubmit(){
    var eId=StorageService.get(StorageService.EMPLOYEE_ID);
    getAllLeadsApi(
        leadStage: leadCode.value,
        employeeId:eId.toString(),
        stateId:stateIdMain.value,
        distId: distIdMain.value,
        cityId: cityIdMain.value,
        campaign: campaignMain.value,
        fromDate: fromDateMain.value,
        toDate: toDateMain.value,
        branch: branchMain.value,
        uniqueLeadNumber: uniqueLeadNumberMain.value,
        leadMobileNumber:leadMobileNumberMain.value

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
    required selectedStage,
  }){


    String selectedDate = followDateController.text; // MM/DD/YYYY
    String selectedTime = followTimeController.text; // HH:MM AM/PM


    String formattedDateTime="";

    if(isCallReminder.value){

      if (selectedDate.isEmpty || selectedTime.isEmpty) {
        ToastMessage.msg("Date or Time is empty!");
        return;
      }


      String combined = "$selectedDate $selectedTime";

// Parse using the right pattern
      DateTime parsedDateTime = DateFormat("yyyy-MM-dd h:mm a").parse(combined);

// Format to desired output
      String formatted = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(parsedDateTime);
      formattedDateTime=formatted.toString();

    }else{


      DateTime now = DateTime.now();

      var td=DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(now);
      formattedDateTime=td.toString();

    }







   // callStatus=="0" && currentLeadStage=="13"



    updateLeadStageApiForCall(
      id:leadId.toString(),
      active: leadDDController.selectedStageActive.value.toString(),
      // stage:selectedStage==""?currentLeadStage: selectedStage
      stage:(callStatus=="0" && currentLeadStage=="13")?currentLeadStage:selectedStage
    ).then((_){
      workOnLeadApi(
        // id:callStatus=="1"?id.toString():"0",
        id:id.toString(),
        leadId: leadId.toString(),
        leadStageStatus:(callStatus=="0" && currentLeadStage=="13")?currentLeadStage:selectedStage,
        feedbackRelatedToCall: callFeedbackController.text.trim(),
        feedbackRelatedToLead: leadFeedbackController.text.trim(),
        callStatus: callStatus,
        callDuration: callDuration,
        callStartTime: callStartTime,
        callEndTime: callEndTime,
        callReminder: formattedDateTime,
        reminderStatus:  isCallReminder.value?"1":"0",
      ).then((_){

        SearchLeadController searchLeadController=Get.find();

        getFilteredLeadsApi(
          employeeId: eId.value.toString(),
          leadStage: selectedPrevStage.value??"0",
          stateId: leadDDController.selectedState.value??"0",
          distId: leadDDController.selectedDistrict.value??"0",
          cityId:leadDDController.selectedCity.value??"0",
          campaign: leadDDController.selectedCampaign.value??"",
          fromDate:fromDateController.value.text.isEmpty?"":Helper.convertToIso8601(fromDateController.value.text),
          toDate: toDateController.value.text.isEmpty?"":Helper.convertToIso8601(toDateController.value.text),
          branch: leadDDController.selectedKsdplBr.value??"0",
          uniqueLeadNumber: searchLeadController.uniqueLeadNumberController.text,
          leadMobileNumber: searchLeadController.leadMobileNumberController.text,
        );
        DashboardController dashboardController=Get.find();
        dashboardController.getRemindersApi( employeeId: getEmployeeModel!.data!.id.toString());



      });
    });


  }



  void getAllLeadsApi({
    required String employeeId,
    required String leadStage,
    required stateId,
    required distId,
    required cityId,
    required campaign,
    required fromDate,
    required toDate,
    required branch,
    required leadMobileNumber,
    required uniqueLeadNumber,
    bool isLoadMore = false,
  }) async {

    try {

      if (isMainListMoreLoading.value || (!hasMore.value && isLoadMore)) return;

      isMainListMoreLoading(true);

      if (!isLoadMore) {
        currentPage.value = 1; // Reset to first page on fresh load
        hasMore.value = true;
      }

      var data = await DrawerApiService.getAllLeadsApi(
        employeeId: employeeId,
        leadStage: leadStage,
        stateId: stateId,
        distId: distId,
        cityId: cityId,
        campaign: campaign,
        pageNumber: currentPage.value,
        pageSize: pageSize,
        fromDate: fromDate,
        toDate: toDate,
        branch: branch,
        leadMobileNumber: leadMobileNumber,
        uniqueLeadNumber: uniqueLeadNumber
      );

      if (data['success'] == true) {
        var newLeads = GetAllLeadsModel.fromJson(data);

        if (isLoadMore) {
          getAllLeadsModel.value!.data!.addAll(newLeads.data!);
        } else {
          getAllLeadsModel.value = newLeads;
        }

        leadStageName2.value = leadStageName.value;

        // If less data returned than requested pageSize, mark as no more
        if (newLeads.data!.length < pageSize) {
          hasMore.value = false;
        } else {
          currentPage.value++; // Ready for next page
        }
        leadListLength.value=getAllLeadsModel.value!.data!.length;
      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        leadStageName2.value = leadStageName.value;
        getAllLeadsModel.value = null;
        hasMore.value = false;
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error getAllLeadsApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isMainListMoreLoading(false);
    }
  }


///new code for filter
  void getFilteredLeadsApi({
    required String employeeId,
    required String leadStage,
    required stateId,
    required distId,
    required cityId,
    required campaign,
    required fromDate,
    required toDate,
    required branch,
    required leadMobileNumber,
    required uniqueLeadNumber,
    bool isLoadMore = false,
  }) async {
    try {
      if (isFilteredLoading.value || (!filteredHasMore.value && isLoadMore)) return;

      isFilteredLoading(true);

      if (!isLoadMore) {
        filteredCurrentPage.value = 1;
        filteredHasMore.value = true;
      }

      var data = await DrawerApiService.getAllLeadsApi(
        employeeId: employeeId,
        leadStage: leadStage,
        stateId: stateId,
        distId: distId,
        cityId: cityId,
        campaign: campaign,
        pageNumber: filteredCurrentPage.value,
        pageSize: pageSize,
        fromDate: fromDate,
        toDate: toDate,
        branch: branch,
        leadMobileNumber: leadMobileNumber,
        uniqueLeadNumber: uniqueLeadNumber,
      );

      if (data['success'] == true) {
        var newLeads = GetAllLeadsModel.fromJson(data);

        if (isLoadMore) {
          filteredGetAllLeadsModel.value!.data!.addAll(newLeads.data!);
        } else {
          filteredGetAllLeadsModel.value = newLeads;
        }

        filteredLeadListLength.value=filteredGetAllLeadsModel.value!.data!.length;

        if (newLeads.data!.length < pageSize) {
          filteredHasMore.value = false;
        } else {
          filteredCurrentPage.value++;
        }

      }else if (data['success'] == false && (data['data'] as List).isEmpty) {

        filteredGetAllLeadsModel.value = null;
        filteredHasMore.value = false;
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error getFilteredLeadsApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isFilteredLoading(false);
    }
  }

///For new lead count list

  void getDetailsListOfLeadsForDashboardApi({
    required stageId,
    required applyDateFilter,
    bool isLoadMore = false,
  }) async {

    try {

      if (isMainListMoreLoading.value || (!hasMore.value && isLoadMore)) return;

      isMainListMoreLoading(true);

      if (!isLoadMore) {
        currentPage.value = 1; // Reset to first page on fresh load
        hasMore.value = true;
      }

      var data = await DrawerApiService.getDetailsListOfLeadsForDashboardApi(
          stageId: stageId,
          applyDateFilter:applyDateFilter ,
          pageNumber: currentPage.value,
          pageSize: pageSize,

      );

      if (data['success'] == true) {
        var newLeads = GetAllLeadsModel.fromJson(data);

        if (isLoadMore) {
          getAllLeadsModel.value!.data!.addAll(newLeads.data!);
        } else {
          getAllLeadsModel.value = newLeads;
        }

        //leadStageName2.value = leadStageName.value;

        // If less data returned than requested pageSize, mark as no more
        if (newLeads.data!.length < pageSize) {
          hasMore.value = false;
        } else {
          currentPage.value++; // Ready for next page
        }
        leadListLength.value=getAllLeadsModel.value!.data!.length;
      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        //leadStageName2.value = leadStageName.value;
        getAllLeadsModel.value = null;
        hasMore.value = false;
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error getAllLeadsApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isMainListMoreLoading(false);
    }
  }

  ///backup
/*
  void getDetailsListOfLeadsForDashboardApi({
    required stageId,
    required applyDateFilter,
    bool isLoadMore = false,
  }) async {

    try {

      if (isMainListMoreLoading.value || (!hasMore.value && isLoadMore)) return;

      isMainListMoreLoading(true);

      if (!isLoadMore) {
        currentPage.value = 1; // Reset to first page on fresh load
        hasMore.value = true;
      }

      var data = await DrawerApiService.getDetailsListOfLeadsForDashboardApi(
        stageId: stageId,
        applyDateFilter:applyDateFilter ,
        pageNumber: currentPage.value,
        pageSize: pageSize,

      );

      if (data['success'] == true) {
        var newLeads = GetAllLeadsModel.fromJson(data);

        if (isLoadMore) {
          getAllLeadsModel.value!.data!.addAll(newLeads.data!);
        } else {
          getAllLeadsModel.value = newLeads;
        }

        //leadStageName2.value = leadStageName.value;

        // If less data returned than requested pageSize, mark as no more
        if (newLeads.data!.length < pageSize) {
          hasMore.value = false;
        } else {
          currentPage.value++; // Ready for next page
        }
        leadListLength.value=getAllLeadsModel.value!.data!.length;
      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        //leadStageName2.value = leadStageName.value;
        getAllLeadsModel.value = null;
        hasMore.value = false;
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error getAllLeadsApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isMainListMoreLoading(false);
    }
  }
*/



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




      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value,
          campaign: campaignMain.value,
          fromDate: fromDateMain.value,
          toDate: toDateMain.value,
          branch: branchMain.value,
          uniqueLeadNumber: uniqueLeadNumberMain.value,
          leadMobileNumber:leadMobileNumberMain.value
      );

      isLoading(false);
    }
  }

  Future<void>  updateLeadStageApiForCall({
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


        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error updateLeadStageApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {




      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value,
          campaign: campaignMain.value,
          fromDate: fromDateMain.value,
          toDate: toDateMain.value,
          branch: branchMain.value,
          uniqueLeadNumber: uniqueLeadNumberMain.value,
          leadMobileNumber:leadMobileNumberMain.value
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
          campaign: campaignMain.value,
          fromDate: fromDateMain.value,
          toDate: toDateMain.value,
          branch: branchMain.value,
          uniqueLeadNumber: uniqueLeadNumberMain.value,
          leadMobileNumber:leadMobileNumberMain.value
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

        ToastMessage.msg(workOnLeadModel!.message.toString());

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error workOnLeadModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {




      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value,
          campaign: campaignMain.value,
          fromDate: fromDateMain.value,
          toDate: toDateMain.value,
          branch: branchMain.value,
          uniqueLeadNumber: uniqueLeadNumberMain.value,
          leadMobileNumber:leadMobileNumberMain.value
      );

      isLoading(false);
    }
  }


  Future<void> workOnLeadAndStageUpdateApi({
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

        ToastMessage.msg(workOnLeadModel!.message.toString());
         if (int.parse(leadStageStatus) == 3) {
          leadDDController.selectedStageActive.value = 1;
        } else if (int.parse(leadStageStatus) == 4) {
          leadDDController.selectedStageActive.value = 1;
        } else if (int.parse(leadStageStatus) == 5) {
          leadDDController.selectedStageActive.value = 0;
        }  else if (int.parse(leadStageStatus) == 6) {
          leadDDController.selectedStageActive.value = 1;
        } else if (int.parse(leadStageStatus) == 7) {
          leadDDController.selectedStageActive.value = 0;
        }else if (int.parse(leadStageStatus) == 13) {
          leadDDController.selectedStageActive.value = 0;
        }else {

        }
        updateLeadStageNewApi(
            id: leadId,
            stage: leadStageStatus,
            active: leadDDController.selectedStageActive.value.toString()
        );

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error workOnLeadModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {




      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value,
          campaign: campaignMain.value,
          fromDate: fromDateMain.value,
          toDate: toDateMain.value,
          branch: branchMain.value,
          uniqueLeadNumber: uniqueLeadNumberMain.value,
          leadMobileNumber:leadMobileNumberMain.value
      );

      isLoading(false);
    }
  }

  void  updateLeadStageNewApi({
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

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error updateLeadStageApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {




      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value,
          campaign: campaignMain.value,
          fromDate: fromDateMain.value,
          toDate: toDateMain.value,
          branch: branchMain.value,
          uniqueLeadNumber: uniqueLeadNumberMain.value,
          leadMobileNumber:leadMobileNumberMain.value
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
          campaign: campaignMain.value,
          fromDate: fromDateMain.value,
          toDate: toDateMain.value,
          branch: branchMain.value,
           uniqueLeadNumber: uniqueLeadNumberMain.value,
         leadMobileNumber:leadMobileNumberMain.value
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
        campaign: campaignMain.value,
        fromDate: fromDateMain.value,
        toDate: toDateMain.value,
        branch: branchMain.value,
        uniqueLeadNumber: uniqueLeadNumberMain.value,
        leadMobileNumber:leadMobileNumberMain.value
    );
  }

}
