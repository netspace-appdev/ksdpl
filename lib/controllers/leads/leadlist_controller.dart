
import 'dart:io';

import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:ksdpl/controllers/dashboard/DashboardController.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/loan_appl_controller.dart';
import 'package:ksdpl/controllers/leads/seachLeadController.dart';
import 'package:pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../models/DisuburseDocDownloadModel.dart';
import '../../models/GetBankerDetailSanctionModel/GetBankerDetailSanctionModel.dart';
import '../../models/addDisburseHistory/AddDisburseHistoryModel.dart';
import '../../models/addSanctionDetails/AddSanctionDetailsModel.dart';
import '../../models/dashboard/GetAllLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/dashboard/LeadMoveToCommonTaskModel.dart';
import '../../models/dashboard/WorkOnLeadModel.dart';
import '../../models/disbursedModel/DisbursedHistoryModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/drawer/UpdateLeadStageModel.dart';
import '../../models/getDisburseHistoryByUniqueLeadNo/GetDisburseHistoryByUniqueLeadNoModel.dart';
import '../../models/leads/GetSoftSanctionByLeadIdAndBankIdModel.dart';
import '../../models/softSanctionByLeadId/SoftSanctionByLeadIdModel.dart';
import '../../models/update_loan_formModel/UpdateLoanFormModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../addDocumentControler/addDocumentModel/addDocumentModel.dart';
import 'lead_history_controller.dart';


class LeadListController extends GetxController {
  var selectedPrevStage = Rxn<String>();
  var isLoading = false.obs;
  var isOpenPollApiLoading = false.obs;
  var isLoad = false.obs;
  // GetAllLeadsModel? getAllLeadsModel;

  var getAllLeadsModel = Rxn<GetAllLeadsModel>(); //
  ///newly added for filter

  var isFilteredLoading = false.obs;
  var filteredHasMore = true.obs;
  var filteredCurrentPage = 1.obs;
  var isMainListMoreLoading = false.obs;
  var isDashboardLeadListMoreLoading = false.obs;
  ///newly added for filter end

  var getLeadDetailModel = Rxn<GetLeadDetailModel>(); //
  var updateLoanFormModel = Rxn<UpdateLoanFormModel>(); //
  var addSanctionDetailsModel = Rxn<AddSanctionDetailsModel>(); //
  var getSoftSanctionByLeadIdAndBankIdModel = Rxn<GetSoftSanctionByLeadIdAndBankIdModel>(); //

  var filteredGetAllLeadsModel = Rxn<GetAllLeadsModel>();
  var softSanctionByLeadIdModel = Rxn<SoftSanctionByLeadIdModel>();
  var getBankerDetailSanctionModel = Rxn<GetBankerDetailSanctionModel>();
  var getDisburseHistoryByUniqueLeadNoModel = Rxn<GetDisburseHistoryByUniqueLeadNoModel>();
  var addDisburseHistoryModel = Rxn<AddDisburseHistoryModel>();
  var disbursedHistoryModel = Rxn<DisbursedHistoryModel>();
  var disuburseDocDownloadModel = Rxn<DisuburseDocDownloadModel>();

  UpdateLeadStageModel? updateLeadStageModel;
  LeadMoveToCommonTaskModel? leadMoveToCommonTaskModel;
  WorkOnLeadModel? workOnLeadModel;

  var interestLeadsCheck = false.obs; // Observable variable
  var assignedLeadsCheck = true.obs; // Observable variable
  var leadCode="2".obs;
  var filteredleadCode="2".obs;
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
  var leadNameMain="".obs;

  var selectedIndex = (1).obs;
  var leadId = RxnString();
  var partialAmount = 0.0.obs;

  var eId="".obs;
  final TextEditingController openPollPercentController = TextEditingController();
  final TextEditingController updateLoanFormController = TextEditingController();
  final TextEditingController followDateController = TextEditingController();
  final TextEditingController followTimeController = TextEditingController();
  final TextEditingController followDetailsController = TextEditingController();

  final TextEditingController callFeedbackController = TextEditingController();
  final TextEditingController leadFeedbackController = TextEditingController();

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController couldNotController = TextEditingController();
  final TextEditingController sanctionDateController = TextEditingController();
  final TextEditingController sanctionAmountController = TextEditingController();
  final TextEditingController sanctionAmount2Controller = TextEditingController();
  final TextEditingController totalDisburseAmountController = TextEditingController();
  final TextEditingController uniqueLeadNoController = TextEditingController();
  final TextEditingController disburseDateController = TextEditingController();
  final TextEditingController partialAmountController = TextEditingController();
  final TextEditingController transactionDetailsController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController disbursedByController = TextEditingController();
  final TextEditingController SuperiorName = TextEditingController();
  final TextEditingController SuperiorEmail = TextEditingController();
  final TextEditingController superiorContact = TextEditingController();

  final TextEditingController aicFeedbackController = TextEditingController();
  final TextEditingController bankerEmail = TextEditingController();


  GetEmployeeModel? getEmployeeModel;
  var isCallReminder=false.obs;
  var isFBDetailsShow=false.obs;

  RxInt currentPage = 1.obs;
  final int pageSize = 20;
  RxBool hasMore = true.obs;
  RxInt leadListLength = 0.obs;
  RxInt filteredLeadListLength = 0.obs;
  LeadDDController leadDDController=Get.put(LeadDDController());

  var isDashboardLeads = false.obs;
  var isAicFBLoading = false.obs;

  var isLoad2 = false.obs;
  var rolRx = "".obs;

  var isAICStageDropdownDisabled = false.obs;
  var isAICStageName = "".obs;
  var selectedValAicGradeList = Rxn<String>();
  String getApiGradeValue(String? selectedValue) {
    if (selectedValue == null || selectedValue.isEmpty) return '';

    if (selectedValue.contains('Grade-A')) return 'A-';
    if (selectedValue.contains('Grade-B')) return 'B-';
    if (selectedValue.contains('Grade-C')) return 'C-';
    if (selectedValue.contains('Grade-D')) return 'D-';

    return ''; // default fallback
  }

  var lehSelectedState = Rxn<String>();
  var lehSelectedDistrict = Rxn<String>();
  var lehSelectedCity = Rxn<String>();
  final TextEditingController lehZipController = TextEditingController();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    var phone=StorageService.get(StorageService.PHONE);
    getEmployeeByPhoneNumberApi(phone: phone.toString());
    DateTime now = DateTime.now();

    String today = DateFormat('dd-MM-yyyy').format(now);
   // String today = DateTime.now().toUtc().toIso8601String() + 'Z';

   // DateTime dateTime = DateTime.parse(today_);
   // String today = DateFormat('dd/MM/yyyy hh:mm:ss a').format(dateTime.toLocal());

    disburseDateController.text = today;
    var rawRole = StorageService.get(StorageService.ROLE).toString();
    rolRx.value = rawRole.replaceAll('[', '').replaceAll(']', '');

  }


  void makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phoneUri)) {

      await launchUrl(phoneUri);
      await Future.delayed(const Duration(seconds: 5)); // Wait before checking logs
      checkCallStatus(phoneNumber);


    } else {

      ToastMessage.msg(AppText.couldNotCall);
    }
  }

  Future<void> checkCallStatus(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 3)); // Allow time for call logs to update

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

/*  void openWhatsApp({required String phoneNumber, String message = ""}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";
    print("Whatsapp----${url}");

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {

      ToastMessage.msg(AppText.couldNotWA);
    }
  }*/

  void openWhatsApp({required String phoneNumber, String message = ""}) async {
    // Ensure country code is included
    String fullPhone = phoneNumber.startsWith("+")
        ? phoneNumber.replaceAll("+", "")
        : "91$phoneNumber"; // 👈 default to India (+91)

    String url = "https://wa.me/$fullPhone?text=${Uri.encodeComponent(message)}";
    print("Whatsapp URL: $url");

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
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
    else if(selectedIndex.value==9){
      leadCode.value="9";
      leadStageName.value="Under Review";
    }
    else if(selectedIndex.value==8){
      leadCode.value="8";
      leadStageName.value="logged in";
    }
    else if(selectedIndex.value==10){
      leadCode.value="10";
      leadStageName.value="Sanction";
    }
    else if(selectedIndex.value==11){
      leadCode.value="11";
      leadStageName.value="Partial Disbursed";
    }
    else if(selectedIndex.value==12){
      leadCode.value="12";
      leadStageName.value="Fully Disbursed";
    }
  }




  void filterSubmit(){
    var eId=StorageService.get(StorageService.EMPLOYEE_ID);
    print("leadCode.value on filter===>${leadCode.value}");
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
        leadMobileNumber:leadMobileNumberMain.value,
        leadName:leadNameMain.value,

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
  }) async{


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
    var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();

    ///new code 3 july 2025 for status change in call
    try {
      // 1. Choose and call appropriate API
      if (callStatus=="0" && isCallReminder.value==false &&  fromWhere!="history_feedback") { // if something goes wrong just remove (&&  fromWhere!="history_feedback")
        print("see here--->condition 1");
        await updateLeadStageApiForCall(
        id: leadId,
        active: leadDDController.selectedStageActive.value.toString(),
        stage: (callStatus == "0" && currentLeadStage == "13")
            ? currentLeadStage
            : selectedStage,
        empId: empId,
        );
      }else if (callStatus=="0" && (isCallReminder.value==true || isCallReminder.value==false) && fromWhere=="history_feedback" ) { //Added new on 28 Aug'
        print("see here--->condition 2");
        print("see here--->${(callStatus=="0" && currentLeadStage=="13")?currentLeadStage:selectedStage}");
        await workOnLeadApi(
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
        );
        final LeadHistoryController leadHistoryController = Get.find();
        leadHistoryController.getLeadWorkByLeadIdApi(leadId: leadId);
      } else if (callStatus=="0" && isCallReminder.value==true) {
        print("see here--->condition 3");
        await workOnLeadApi(
          // id:callStatus=="1"?id.toString():"0",
          id:"0",
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
        );
      }
      else if (callStatus=="1" && selectedStage=="4") {
        // Add more if needed
        print("see here--->condition 4");
        await workOnLeadApi(
          // id:callStatus=="1"?id.toString():"0",
          id:"0",
          leadId: leadId.toString(),
          leadStageStatus:(callStatus=="0" && currentLeadStage=="13")?currentLeadStage:selectedStage,
          feedbackRelatedToCall: callFeedbackController.text.trim(),
          feedbackRelatedToLead: leadFeedbackController.text.trim(),
          callStatus: "0", //callStatus - changed on 31 Aug
          callDuration: callDuration,
          callStartTime: callStartTime,
          callEndTime: callEndTime,
          callReminder: formattedDateTime,
          reminderStatus:  isCallReminder.value?"1":"0",
        );
      }else if (callStatus=="1" && selectedStage=="5") {
        print("see here--->${(callStatus=="0" && currentLeadStage=="13")?currentLeadStage:selectedStage}");
        print("see here--->condition 5");
        await updateLeadStageApiForCall(
          id: leadId,
          active: leadDDController.selectedStageActive.value.toString(),
          stage: (callStatus == "0" && currentLeadStage == "13")
              ? currentLeadStage
              : selectedStage,
          empId: empId,
        );
      }else if (callStatus=="1" && selectedStage=="6") {
        print("see here--->condition 6");
        // Add more if needed
        await workOnLeadApi(
          // id:callStatus=="1"?id.toString():"0",
          id:"0",
          leadId: leadId.toString(),
          leadStageStatus:(callStatus=="0" && currentLeadStage=="13")?currentLeadStage:selectedStage,
          feedbackRelatedToCall: callFeedbackController.text.trim(),
          feedbackRelatedToLead: leadFeedbackController.text.trim(),
          callStatus: "0", //callStatus - changed on 31 Aug,
          callDuration: callDuration,
          callStartTime: callStartTime,
          callEndTime: callEndTime,
          callReminder: formattedDateTime,
          reminderStatus:  isCallReminder.value?"1":"0",
        );
      }else if (callStatus=="1" && selectedStage=="7") {
        print("see here--->condition 7");
        print("see here--->${(callStatus=="0" && currentLeadStage=="13")?currentLeadStage:selectedStage}");
        await updateLeadStageApiForCall(
          id: leadId,
          active: leadDDController.selectedStageActive.value.toString(),
          stage: (callStatus == "0" && currentLeadStage == "13")
              ? currentLeadStage
              : selectedStage,
          empId: empId,
        );
      }

      // 2. Then call common actions
      await callPostLeadUpdateAPIs();
    } catch (e) {
      print("Error in lead update: $e");
    }
    ///new code end
  }

  Future<void> callPostLeadUpdateAPIs() async {
    // You can even extract these as services if it grows further




    final SearchLeadController searchLeadController = Get.put(SearchLeadController());

    await getFilteredLeadsApi(
      employeeId: eId.value.toString(),
      leadStage: selectedPrevStage.value ?? "0",
      stateId: leadDDController.selectedState.value ?? "0",
      distId: leadDDController.selectedDistrict.value ?? "0",
      cityId: leadDDController.selectedCity.value ?? "0",
      campaign: leadDDController.selectedCampaign.value ?? "",
      fromDate: fromDateController.value.text.isEmpty
          ? ""
          : Helper.convertToIso8601(fromDateController.value.text),
      toDate: toDateController.value.text.isEmpty
          ? ""
          : Helper.convertToIso8601(toDateController.value.text),
      branch: leadDDController.selectedKsdplBr.value ?? "0",
      uniqueLeadNumber: searchLeadController.uniqueLeadNumberController.text,
      leadMobileNumber: searchLeadController.leadMobileNumberController.text,
      leadName: searchLeadController.leadNameController.text,
    );

    final DashboardController dashboardController = Get.find();
    await dashboardController.getRemindersApi(employeeId: getEmployeeModel!.data!.id.toString());
  }



  void onlyFollowupSubmit({
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

      workOnLeadApi(
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
          leadName: searchLeadController.leadNameController.text,
        );
        DashboardController dashboardController=Get.find();
        dashboardController.getRemindersApi( employeeId: getEmployeeModel!.data!.id.toString());



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
    required leadName,
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
        uniqueLeadNumber: uniqueLeadNumber,
        leadName: leadName
      );

      if (data['success'] == true) {
        var newLeads = GetAllLeadsModel.fromJson(data);

       /* if (isLoadMore) {
          getAllLeadsModel.value!.data!.addAll(newLeads.data!);
        } else {
          getAllLeadsModel.value = newLeads;
        }*/
        getAllLeadsModel.value = newLeads;///new change

        leadStageName2.value = leadStageName.value;

        print("hello hasMore.value=======>${hasMore.value}");
        // If less data returned than requested pageSize, mark as no more
        if (newLeads.data!.length < pageSize) {
          hasMore.value = false;
          print("hello hasMore.value=======>if----${hasMore.value}");
        } else {
          currentPage.value++; // Ready for next page
          print("hello hasMore.value=======>else----${hasMore.value}");
        }
        leadListLength.value=getAllLeadsModel.value!.data!.length;

        print("hello hasMore.value=======>else----${hasMore.value}");
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
  Future<void> getFilteredLeadsApi({
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
    required leadName,
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
        leadName:leadName,

      );

      if (data['success'] == true) {
        var newLeads = GetAllLeadsModel.fromJson(data);
/*
        if (isLoadMore) {
          filteredGetAllLeadsModel.value!.data!.addAll(newLeads.data!);
        } else {
          filteredGetAllLeadsModel.value = newLeads;
        }*/
        filteredGetAllLeadsModel.value = newLeads;

        filteredLeadListLength.value=filteredGetAllLeadsModel.value!.data!.length;

        if (newLeads.data!.length < pageSize) {
          filteredHasMore.value = false;
        } else {
          filteredCurrentPage.value++;
        }

      }else if (data['success'] == false && (data['data'] as List).isEmpty) {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
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

        /*if (isLoadMore) {
          getAllLeadsModel.value!.data!.addAll(newLeads.data!);
        } else {
          getAllLeadsModel.value = newLeads;
        }*/
        getAllLeadsModel.value = newLeads;



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


  void  updateLeadStageApi({
    required id,
    required stage,
    required active,
    required empId,

  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.updateLeadStageApi(
          id:id,
          stage: stage,
          active: active,
          empId: empId
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
          leadMobileNumber:leadMobileNumberMain.value,
        leadName:leadNameMain.value,
      );

      isLoading(false);
    }
  }

  Future<void>  updateLeadStageApiForCall({
    required id,
    required stage,
    required active,
    required empId,
  }) async {
    try {
      isLoading(true);

      var data = await DrawerApiService.updateLeadStageApi(
          id:id,
          stage: stage,
          active: active,
          empId: empId
      );

      if(data['success'] == true){

        updateLeadStageModel= UpdateLeadStageModel.fromJson(data);
        ToastMessage.msg(updateLeadStageModel?.message??'');


        isLoading(false);



      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error updateLeadStageApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

     if(isDashboardLeads.value==false){
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
         leadMobileNumber:leadMobileNumberMain.value,
         leadName:leadNameMain.value,
       );
     }else{
       ///new code 17 jul

        DashboardController dashboardController=Get.find();

        getDetailsListOfLeadsForDashboardApi(
          applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
          stageId: leadCode.value
        );

     }
      isLoading(false);
    }
  }


  Future <void>  leadMoveToCommonTaskApi({
    required leadId,
    required percentage,

  }) async {
    try {
      isOpenPollApiLoading(true);


      var data = await DrawerApiService.leadMoveToCommonTaskApi(
        leadId:leadId,
        percentage: percentage,

      );


      if(data['success'] == true){

        ///Change model

        leadMoveToCommonTaskModel= LeadMoveToCommonTaskModel.fromJson(data);



        isOpenPollApiLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error leadMoveToCommonTaskModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isOpenPollApiLoading(false);
    } finally {
      print("run hua");


/*

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
          leadMobileNumber:leadMobileNumberMain.value,
        leadName:leadNameMain.value,
      );
*/

      if(isDashboardLeads.value==false){
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
          leadMobileNumber:leadMobileNumberMain.value,
          leadName:leadNameMain.value,
        );
        SearchLeadController searchLeadController=Get.put(SearchLeadController());
        getFilteredLeadsApi(

          employeeId: eId.value.toString(),
          leadStage:leadDDController.selectedStage.value??"0",
          stateId: leadDDController.selectedState.value??"0",
          distId: leadDDController.selectedDistrict.value??"0",
          cityId:leadDDController.selectedCity.value??"0",
          campaign: leadDDController.selectedCampaign.value??"",
          fromDate: fromDateController.value.text.isEmpty?"":Helper.convertToIso8601(fromDateController.value.text),
          toDate: toDateController.value.text.isEmpty?"":Helper.convertToIso8601(toDateController.value.text),
          branch: leadDDController.selectedKsdplBr.value??"0",
          uniqueLeadNumber: searchLeadController.uniqueLeadNumberController.text,
          leadMobileNumber: searchLeadController.leadMobileNumberController.text,
          leadName: searchLeadController.leadNameController.text,
        );
      }else{
        ///new code 17 jul

        DashboardController dashboardController=Get.find();

        getDetailsListOfLeadsForDashboardApi(
            applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
            stageId: leadCode.value
        );

      }
      isOpenPollApiLoading(false);
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

      if(isDashboardLeads.value==false){
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
          leadMobileNumber:leadMobileNumberMain.value,
          leadName:leadNameMain.value,
        );
        SearchLeadController searchLeadController=Get.put(SearchLeadController());
        getFilteredLeadsApi(

            employeeId: eId.value.toString(),
            leadStage:leadDDController.selectedStage.value??"0",
            stateId: leadDDController.selectedState.value??"0",
            distId: leadDDController.selectedDistrict.value??"0",
            cityId:leadDDController.selectedCity.value??"0",
            campaign: leadDDController.selectedCampaign.value??"",
            fromDate: fromDateController.value.text.isEmpty?"":Helper.convertToIso8601(fromDateController.value.text),
            toDate: toDateController.value.text.isEmpty?"":Helper.convertToIso8601(toDateController.value.text),
            branch: leadDDController.selectedKsdplBr.value??"0",
            uniqueLeadNumber: searchLeadController.uniqueLeadNumberController.text,
            leadMobileNumber: searchLeadController.leadMobileNumberController.text,
            leadName: searchLeadController.leadNameController.text,
        );
      }else{
        ///new code 17 jul

        DashboardController dashboardController=Get.find();

        getDetailsListOfLeadsForDashboardApi(
            applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
            stageId: leadCode.value
        );

      }

      isLoading(false);
    }
  }

  int changeActiveStatus(String leadStageStatus) {
    int stageId = int.tryParse(leadStageStatus) ?? 0;
    int selectedStageActive;

    switch (stageId) {
      case 3:
      case 4:
      case 6:
        selectedStageActive = 1;
        break;
      case 5:
      case 7:
      case 13:
        selectedStageActive = 0;
        break;
      default:
        selectedStageActive = 1; // or maybe 0 or null depending on your logic
    }

    return selectedStageActive;
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
        var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();
        updateLeadStageNewApi(
            id: leadId,
            stage: leadStageStatus,
            active: leadDDController.selectedStageActive.value.toString(),
          empId: empId
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
          leadMobileNumber:leadMobileNumberMain.value,
        leadName:leadNameMain.value,
      );

      isLoading(false);
    }
  }

  void  updateLeadStageNewApi({
    required id,
    required stage,
    required active,
    required empId,
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.updateLeadStageApi(
          id:id,
          stage: stage,
          active: active,
        empId: empId,

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
          leadMobileNumber:leadMobileNumberMain.value,
        leadName:leadNameMain.value,
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
print('getLeadDetailModel${getLeadDetailModel.value?.data?.loanApplicationNo}');

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
         leadMobileNumber:leadMobileNumberMain.value,
          leadName:leadNameMain.value,
        );
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getEmployeeByPhoneNumberApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {
      if(isDashboardLeads.value==false){
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
          leadMobileNumber:leadMobileNumberMain.value,
          leadName:leadNameMain.value,
        );
      }else{
        ///new code 17 jul

        DashboardController dashboardController=Get.find();

        getDetailsListOfLeadsForDashboardApi(
            applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
            stageId: leadCode.value
        );

      }
      isLoading(false);
    }
  }


  Future<void> refreshItems() async {


    if(isDashboardLeads.value==false){
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
        leadMobileNumber:leadMobileNumberMain.value,
        leadName:leadNameMain.value,
      );
    }else{
      ///new code 17 jul

      DashboardController dashboardController=Get.find();

      getDetailsListOfLeadsForDashboardApi(
          applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
          stageId: leadCode.value
      );

    }
  }

 Future<void> updateLoanFormApiCall(String leadnumber) async {

   try {
     isLoad(true);

     var data = await DrawerApiService.updateLoanForm(
       uniqueLeadNumber: updateLoanFormController.text.trim(),
       LoanApplicationNumber:leadnumber??'',
     );

     if (data['success'] == true) {
       updateLoanFormModel.value = UpdateLoanFormModel.fromJson(data);
       isLoad(false);
       clear();
       Get.back();

     }
     else if (data['success'] == false && data['data'] is List && (data['data'] as List).isEmpty) {
       //    ToastMessage.msg("Old password incorrect or empty");
       isLoad(false);
      // Get.back();
     }
     else {
       ToastMessage.msg(data['data']?.toString() ?? AppText.somethingWentWrong);
     }
   } catch (e) {
     print("Error in checkOldPasswordRequestApi: ${e.toString()}");
     ToastMessage.msg(AppText.somethingWentWrong);
   } finally {
     if(isDashboardLeads.value==false){
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
         leadMobileNumber:leadMobileNumberMain.value,
         leadName:leadNameMain.value,
       );
     }else{
       ///new code 17 jul

       DashboardController dashboardController=Get.find();

       getDetailsListOfLeadsForDashboardApi(
           applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
           stageId: leadCode.value
       );

     }
     isLoad(false);
   }

 }

  void clear() {
    updateLoanFormController.clear();
    sanctionAmountController.clear();
    sanctionDateController.clear();

  }

Future<void> addSanctionDetailsApi({required String uln}) async {
  try {
    isLoad(true);

    var data = await DrawerApiService.addSanctionDetailscallApi(
      UniqueLeadNo: uln,
      SanctionDate: sanctionDateController.text.trim()??'',
      SanctionAmount:sanctionAmountController.text.trim()??'',
    );

    if (data['success'] == true) {
      addSanctionDetailsModel.value = AddSanctionDetailsModel.fromJson(data);
      ToastMessage.msg(addSanctionDetailsModel.value?.message??'');

      isLoad(false);
      clear();
      Get.back();

    }
    else if (data['success'] == false && data['data'] is List && (data['data'] as List).isEmpty) {
      //    ToastMessage.msg("Old password incorrect or empty");
      isLoad(false);
      // Get.back();
    }
    else {
      ToastMessage.msg(data['data']?.toString() ?? AppText.somethingWentWrong);
    }
  } catch (e) {
    print("Error in checkOldPasswordRequestApi: ${e.toString()}");
    ToastMessage.msg(AppText.somethingWentWrong);
  } finally {
    if(isDashboardLeads.value==false){
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
        leadMobileNumber:leadMobileNumberMain.value,
        leadName:leadNameMain.value,
      );
    }else{
      ///new code 17 jul

      DashboardController dashboardController=Get.find();

      getDetailsListOfLeadsForDashboardApi(
          applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
          stageId: leadCode.value
      );

    }
    isLoad(false);
  }
}

  Future<void>callGetSoftSanctionByLeadIdAndBankIdApi(String leadID,) async {
    try {
      isLoad(true);

      var data = await DrawerApiService.callSoftSanctionByLeadIdApi(leadID: leadID, BankId: '0'
      );

      if (data['success'] == true) {
        addSanctionDetailsModel.value = AddSanctionDetailsModel.fromJson(data);
        ToastMessage.msg(addSanctionDetailsModel.value?.message??'');

        isLoad(false);
        clear();
        Get.back();

      }
      else if (data['success'] == false && data['data'] is List && (data['data'] as List).isEmpty) {
        //    ToastMessage.msg("Old password incorrect or empty");
        isLoad(false);
        // Get.back();
      }
      else {
        ToastMessage.msg(data['data']?.toString() ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in checkOldPasswordRequestApi: ${e.toString()}");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      if(isDashboardLeads.value==false){
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
          leadMobileNumber:leadMobileNumberMain.value,
          leadName:leadNameMain.value,
        );
      }else{
        ///new code 17 jul

        DashboardController dashboardController=Get.find();

        getDetailsListOfLeadsForDashboardApi(
            applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
            stageId: leadCode.value
        );

      }
      isLoad(false);
    }
  }




  Future<void> getSoftSanctionByLeadIdAndBankIdApiMethod({
    required String leadID,
    required String  bankId,
  }) async {
    print("getSoftSanctionByLeadIdAndBankIdApiMethod===>");
    try {

      isLoad(true);

      var data = await DrawerApiService.getSoftSanctionByLeadIdAndBankIdApiMethod(
        leadID: leadID,
        BankId: bankId,

      );

      if(data['success'] == true){

        getSoftSanctionByLeadIdAndBankIdModel.value= GetSoftSanctionByLeadIdAndBankIdModel.fromJson(data);
        final LoanApplicationController loanApplicationController=Get.find();
        loanApplicationController.bankerNameController.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.bankersName??"";
        loanApplicationController.bankerMobileController.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.bankersMobileNumber??"";
        loanApplicationController.bankerWhatsappController.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.bankersWhatsAppNumber??"";
        loanApplicationController.bankerEmailController.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.bankersEmailId??"";

        loanApplicationController.chargesDetailProcessingFees.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionProcessingFees.toString()??"0";
        loanApplicationController.chargesDetailAdminFeeChargess.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionApplicableAdminFee.toString()??"0";
        loanApplicationController.chargesDetailForeclosureCharges.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionApplicableForeclosureCharges.toString()??"0";
        loanApplicationController.chargesDetailStampDuty.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionStampDuty.toString()??"0";
        loanApplicationController.chargesDetailLegalVettingCharges.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionApplicableLegalFee.toString()??"0";
        loanApplicationController.chargesDetailTechnicalInspectionCharges.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionApplicableTechnicalFee.toString()??"0";
        loanApplicationController.chargesDetailOtherCharges.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionApplicableOtherCharges.toString()??"0";
        loanApplicationController.chargesDetailTSRLegalCharges.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionApplicableTsrcharges.toString()??"0";
        loanApplicationController.chargesDetailValuationCharges.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionApplicableValuationCharges.toString()??"0";
        loanApplicationController.chargesDetailProcessingCharges.text=getSoftSanctionByLeadIdAndBankIdModel.value?.data?.sanctionProcessingCharges.toString()??"0";
        final docs = getSoftSanctionByLeadIdAndBankIdModel.value?.data?.documents;
        print("docs=========>${docs}");
        loanApplicationController.documentListByBank.value =
        (docs?.isNotEmpty ?? false)
            ? docs!.split(',').map((e) => e.trim()).toList()
            : [];
        print("loanApplicationController.documentListByBank.value=========>${loanApplicationController.documentListByBank}");
        if(loanApplicationController.documentListByBank.isNotEmpty){
          loanApplicationController.addDocumentList.clear();
          for (int i = 0; i < loanApplicationController.documentListByBank.length; i++) {

            loanApplicationController.addDocumentList.add(
              AdddocumentModel(),
            );
            final ai = loanApplicationController.addDocumentList[i];
            ai.aiSourceController.text=loanApplicationController.documentListByBank[i];
            ai.isThisGenerated.value=true;
            ai.isDocNameDisabled.value=true;

            var responseModel = loanApplicationController.loanApplicationDocumentByLoanIdModel.value?.data;
            if (responseModel != null ) {
              bool documentExists = responseModel
                  .any((doc) => doc.imageName?.toLowerCase() == loanApplicationController.documentListByBank[i].toLowerCase());

              if (documentExists) {
                ai.isDocSubmitted.value = true;
                print("✅ isDocSubmitted ===>'${loanApplicationController.documentListByBank[i]}' found and marked as submitted!");
              } else {
                ai.isDocSubmitted.value = false;
                print("❌ isDocSubmitted ===> ${loanApplicationController.documentListByBank[i]}' not found in API response.");
              }
            }
            }

          loanApplicationController.addDocumentList.add(AdddocumentModel());

        }
        print(" loanApplicationController.addDocumentList=========>${ loanApplicationController.addDocumentList}");
        isLoad(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        final LoanApplicationController loanApplicationController=Get.find();
        getSoftSanctionByLeadIdAndBankIdModel.value=null;
        loanApplicationController.addDocumentList.clear();
        loanApplicationController.addDocumentList.add(AdddocumentModel());
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getSoftSanctionByLeadIdAndBankIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoad(false);

    } finally {


      isLoad(false);

    }
  }

  Future<void> callGetBankerDetailSanction(String phoneNo) async {
    try {
      isLoad(true);

      var data = await DrawerApiService.callGetBankerDetailSanctionApi(PhoneNo: phoneNo);

      if (data['success'] == true) {
        getBankerDetailSanctionModel.value = GetBankerDetailSanctionModel.fromJson(data);
      //  ToastMessage.msg(getBankerDetailSanctionModel.value?.message??'');
        disbursedByController.text=getBankerDetailSanctionModel.value?.data?.bankersName.toString()??'';

        isLoad(false);
       // clear();
      //  Get.back();
      }
      else if (data['success'] == false && data['data'] is List && (data['data'] as List).isEmpty) {
        //    ToastMessage.msg("Old password incorrect or empty");
        isLoad(false);
        // Get.back();
      }
      else {
       // ToastMessage.msg(data['data']?.toString() ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in checkOldPasswordRequestApi: ${e.toString()}");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      if(isDashboardLeads.value==false){
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
          leadMobileNumber:leadMobileNumberMain.value,
          leadName:leadNameMain.value,
        );
      }else{
        ///new code 17 jul

        DashboardController dashboardController=Get.find();

        getDetailsListOfLeadsForDashboardApi(
            applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
            stageId: leadCode.value
        );

      }
      isLoad(false);
    }
  }

 Future<void> callUpdateDisburseHistory(String loanAccountNo) async {
   final disburse = double.tryParse(partialAmountController.text ?? '0') ?? 0;
   if (disburse > partialAmount.value) {
     print('the amount${disburse}');
     print('the amount${partialAmount.value.toString().length}');
     return   SnackbarHelper.showSnackbar(title: "Incomplete Data", message: AppText.partialAmountCannotExceed??'');
   }
  else {

     try {
       isLoad2(true);

       var data = await DrawerApiService.callUpdateDisburseHistoryApi(
         sanctionAmount: sanctionAmount2Controller.text,
         totalDisburseAmount: totalDisburseAmountController.text,
         uniqueLeadNo: uniqueLeadNoController.text,
         disburseDate: disburseDateController.text,
         disburseAmount: partialAmountController.text,
         // partialAmount is actually disburseAmount
         transactionDetails: transactionDetailsController.text,
         contactNo: contactNoController.text,
         disbursedBy: disbursedByController.text,
         LoanAccountNo: loanAccountNo,
         bankerEmail: bankerEmail.text,
         SuperiorName: SuperiorName.text,
         SuperiorEmail: SuperiorEmail.text,
         SuperiorContact: superiorContact.text,

       );

       if (data['success'] == true) {
         addDisburseHistoryModel.value = AddDisburseHistoryModel.fromJson(data);
         ToastMessage.msg(addDisburseHistoryModel.value?.message ?? '');
         // disbursedByController.text=getBankerDetailSanctionModel.value?.data?.bankersName.toString()??'';

         isLoad2(false);
         clearhistory();
         Get.back();
       }
       else if (data['success'] == false && data['data'] is List &&
           (data['data'] as List).isEmpty) {
         //    ToastMessage.msg("Old password incorrect or empty");
         isLoad2(false);
         // Get.back();
       }

     } catch (e) {
       print("Error in checkOldPasswordRequestApi: ${e.toString()}");
      // ToastMessage.msg(AppText.somethingWentWrong);
     } finally {
       if (isDashboardLeads.value == false) {
         getAllLeadsApi(
           leadStage: leadCode.value,
           employeeId: eId.value.toString(),
           stateId: stateIdMain.value,
           distId: distIdMain.value,
           cityId: cityIdMain.value,
           campaign: campaignMain.value,
           fromDate: fromDateMain.value,
           toDate: toDateMain.value,
           branch: branchMain.value,
           uniqueLeadNumber: uniqueLeadNumberMain.value,
           leadMobileNumber: leadMobileNumberMain.value,
           leadName: leadNameMain.value,
         );
       } else {
         ///new code 17 jul

         DashboardController dashboardController = Get.find();

         getDetailsListOfLeadsForDashboardApi(
             applyDateFilter: dashboardController.isLeadCountYearly.toString(),
             //changeit
             stageId: leadCode.value
         );
       }
       isLoad2(false);
     }
   }
 }

  Future<void> callGetDisburseHistoryByUniqueLeadNoApi(String? loanApplicationNo) async {
    try {
      isLoad(true);

      var data = await DrawerApiService.callGetdisburseHistoryByUniqueNoApi(
        loanApplicationNo: loanApplicationNo,
      );

      if (data['success'] == true) {
        getDisburseHistoryByUniqueLeadNoModel.value = GetDisburseHistoryByUniqueLeadNoModel.fromJson(data);
       //ToastMessage.msg(getDisburseHistoryByUniqueLeadNoModel.value?.message??'');

        sanctionAmount2Controller.text= getDisburseHistoryByUniqueLeadNoModel.value?.data!.sanctionAmount.toString()??'';
        totalDisburseAmountController.text= getDisburseHistoryByUniqueLeadNoModel.value?.data!.disburseAmount.toString()??'';
        uniqueLeadNoController.text= getDisburseHistoryByUniqueLeadNoModel.value?.data!.uniqueLeadNumber.toString()??'';
        SuperiorName.text= disbursedHistoryModel.value?.data?[0].superiorName.toString()??'';
        SuperiorEmail.text= disbursedHistoryModel.value?.data?[0].superiorEmail.toString()??'';
        superiorContact.text= disbursedHistoryModel.value?.data?[0].superiorContact.toString()??'';
        bankerEmail.text= disbursedHistoryModel.value?.data?[0].bankerEmail.toString()??'';


        final sanction = double.tryParse(
            getDisburseHistoryByUniqueLeadNoModel.value?.data?.sanctionAmount.toString() ?? '0'
        ) ?? 0;

        final disburse = double.tryParse(
            getDisburseHistoryByUniqueLeadNoModel.value?.data?.disburseAmount.toString() ?? '0'
        ) ?? 0;

         partialAmount.value = sanction - disburse;

        isLoad(false);
        // clear();
        //  Get.back();
      }
      else if (data['success'] == false && data['data'] is List && (data['data'] as List).isEmpty) {
        //    ToastMessage.msg("Old password incorrect or empty");
        isLoad(false);
        // Get.back();
      }
      else {
       // ToastMessage.msg(data['data']?.toString() ?? AppText.somethingWentWrong);
      }
    } catch (e) {
     // print("Error in checkOldPasswordRequestApi: ${e.toString()}");
    //  ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      if(isDashboardLeads.value==false){
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
          leadMobileNumber:leadMobileNumberMain.value,
          leadName:leadNameMain.value,
        );
      }else{
        ///new code 17 jul

        DashboardController dashboardController=Get.find();

        getDetailsListOfLeadsForDashboardApi(
            applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
            stageId: leadCode.value
        );

      }
      isLoad(false);
    }
  }

  void clearhistory() {
     sanctionAmount2Controller.clear();
     totalDisburseAmountController.clear();
     uniqueLeadNoController.clear();
     disburseDateController.clear();
     partialAmountController.clear(); // partialAmount is actually disburseAmount
     transactionDetailsController.clear();
     contactNoController.clear();
     disbursedByController.clear();


  }
  Future<void> launchInBrowser(String url) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        //  ToastMessage.msg('Could not launch URL: $url');
      }
    } catch (e) {
      print("❌ Error launching URL: $e");
      // ToastMessage.msg('Something went wrong while opening the link.');
    }
  }

 Future <void> getHistoryOfDisbursedList(String? uniqueLeadNumber) async {
   try {
     isLoading(true);
     var data = await DashboardApiService.getHistoryOfDisbursedRequest(
       Utr: uniqueLeadNumber,

     );
     if(data['success'] == true){

      disbursedHistoryModel.value= DisbursedHistoryModel.fromJson(data);
      print("data disbursedHistoryModel: ${disbursedHistoryModel.value?.data?.length}");

      if(disbursedHistoryModel.value?.data==1){
         isLoading.value==true;
       }else{
         isLoading.value==false;
       }
       isLoading(false);

     }else if(data['success'] == false && (data['data'] as List).isEmpty ){
     }else{
       ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
     }
   } catch (e) {
     print("Error checkReceiptStatusForCamNoteApi: $e");

     ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);

   } finally {
     isLoading(false);
   }
 }

  Future<void> getDetailForDisuburseDocumentDownload(int? id) async {
    try {
      isLoading(true);
      var data = await DashboardApiService.getDetailForDisuburseDocumentDownloadApi(
        id: id.toString(),

      );
      if(data['success'] == true){
        disuburseDocDownloadModel.value= DisuburseDocDownloadModel.fromJson(data);

      /*  if(disuburseDocDownloadModel.value?.data==1){
          isLoading.value==true;
        }else{
          isLoading.value==false;
        }*/
        await generateDisburseDocFormPDF(disuburseDocDownloadModel.value);

        isLoading(false);

        changeStatusOfDisburseHistory(id);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error checkReceiptStatusForCamNoteApi: $e");

     // ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);

    } finally {
      isLoading(false);
    }
  }

  Future<void> changeStatusOfDisburseHistory(int? id) async {
    try {
      isLoading(true);
      var data = await DashboardApiService.changeStatusOfDisburseHistoryApi(
        id: id.toString(),
      );

      if(data['success'] == true){
        //disuburseDocDownloadModel.value= DisuburseDocDownloadModel.fromJson(data);
        /*  if(disuburseDocDownloadModel.value?.data==1){
          isLoading.value==true;
        }else{
          isLoading.value==false;
        }*/
        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error checkReceiptStatusForCamNoteApi: $e");

      // ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);

    } finally {
      isLoading(false);
    }
  }



  Future<void> generateDisburseDocFormPDF(DisuburseDocDownloadModel? model) async {
    final pdf = pw.Document();

    final headerStyle = pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold);
    final cellStyle = const pw.TextStyle(fontSize: 10);
    final labelStyle = pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Text(
                "Secured Cases",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 20),

            if (model?.data != null && model!.data!.isNotEmpty)
              ...List.generate(model.data!.length, (index) {
                final d = model.data![index];
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Table(
                      border: pw.TableBorder.all(width: 0.5),
                      columnWidths: {
                        0: const pw.FixedColumnWidth(30),
                        1: const pw.FlexColumnWidth(3),
                        2: const pw.FlexColumnWidth(3),
                      },
                      children: [
                        _buildRow("S. No", "${index + 1}", labelStyle, cellStyle),
                        _buildRow("Customer Name", d.name ?? '', labelStyle, cellStyle),
                        _buildRow("Firm/Company/Entity Name", d.firmName ?? '', labelStyle, cellStyle),
                        _buildRow("NBFC / Bank Name", d.bankName ?? '', labelStyle, cellStyle),
                        _buildRow("Loan Type", d.loanType ?? '', labelStyle, cellStyle),
                        _buildRow("Sanction Amount", d.sanctionAmount?.toStringAsFixed(2) ?? '', labelStyle, cellStyle),
                        _buildRow("Disbursed Amount", d.disburseAmount?.toStringAsFixed(2) ?? '', labelStyle, cellStyle),
                        _buildRow("Disbursed Type (Part / Full)", "Fully Disbursed", labelStyle, cellStyle),
                        _buildRow("Insurance Amount (If Any)", "0", labelStyle, cellStyle),
                        _buildRow("Application Number", d.loanApplicationNo ?? '', labelStyle, cellStyle),
                        _buildRow("LAN Number", d.uniqueLeadNo ?? '', labelStyle, cellStyle),
                        _buildRow("ROI%", d.sanctionROI?.toStringAsFixed(2) ?? '0.00%', labelStyle, cellStyle),
                        _buildRow("PF%", "0.00%", labelStyle, cellStyle),
                        _buildRow("OTC/CPD Clearance (N/A or Cleared)", "", labelStyle, cellStyle),
                        _buildRow("Cheque Handover Status (Yes/No)", "", labelStyle, cellStyle),
                        _buildRow("DSA Name/Code (In Which Case Booked)", d.dsaCode ?? '', labelStyle, cellStyle),
                        _buildRow("Subvention (If Any)", "0", labelStyle, cellStyle),
                        _buildRow("Reporting Manager Name", d.reportingManagerName ?? '', labelStyle, cellStyle),
                        _buildRow("Reporting Manager Number", d.reportingManagerNumber ?? '', labelStyle, cellStyle),
                        _buildRow("Disbursement Branch", d.branchName ?? '', labelStyle, cellStyle),
                        _buildRow("Disbursement Branch Address", d.branchAddress ?? '', labelStyle, cellStyle),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                  ],
                );
              })
            else
              pw.Center(child: pw.Text("No data available")),
          ];
        },
      ),
    );

    // Save the PDF file
    final outputDir = await getApplicationDocumentsDirectory();
    final file = File("${outputDir.path}/Secured_Cases_Report.pdf");
    await file.writeAsBytes(await pdf.save());

    // Open the PDF automatically
    await OpenFile.open(file.path);
  }

  pw.TableRow _buildRow(String label, String value, pw.TextStyle labelStyle, pw.TextStyle cellStyle) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text('', style: cellStyle), // empty first cell for S.No column
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(label, style: labelStyle),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(value, style: cellStyle),
        ),
      ],
    );
  }


 }


