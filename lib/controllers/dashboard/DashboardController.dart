
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/helper.dart';
import '../../common/notification_helper.dart';
import '../../common/storage_service.dart';
import '../../models/UpdateFCMTokenModel.dart';
import '../../models/dashboard/GetCountOfLeadsModel.dart';
import '../../models/dashboard/GetDetailsCountOfLeadsForDashboardModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/dashboard/GetRemindersModel.dart';
import '../../models/dashboard/GetUpcomingDateOfBirthModel.dart';
import '../../models/dashboard/TodayWorkStatusRBModel.dart';
import '../../models/dashboard/getBreakingNewsModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../../services/home_service.dart';
class DashboardController extends GetxController {

  var isLoading = false.obs;
  GetEmployeeModel? getEmployeeModel;
  var getCountOfLeadsModel = Rxn<GetCountOfLeadsModel>(); //
  var getDetailsCountOfLeads = Rxn<GetDetailsCountOfLeadsForDashboardModel>(); //
  var getBreakingNewsModel = Rxn<GetBreakingNewsModel>(); //
  var getUpcomingDateOfBirthModel = Rxn<GetUpcomingDateOfBirthModel>(); //
  var todayWorkStatusRBModel = Rxn<TodayWorkStatusRBModel>(); //
  var getRemindersModel = Rxn<GetRemindersModel>(); //
  ScrollController scrollReminderController = ScrollController();
  UpdateFCMTokenModel? updateFCMTokenModel;
  List<int> fixedLeadIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  var isLeadCountYearly = 'false'.obs;

  var selectedIndex = (0).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var phone=StorageService.get(StorageService.PHONE);
    getEmployeeByPhoneNumberApi(phone: phone.toString());

    getBreakingNewsApi();
    getUpcomingDateOfBirthApi();

  }

  void selectCheckbox(int index) {

    selectedIndex.value = index;
    if( selectedIndex.value==0){
     isLeadCountYearly.value="false";

    } else if( selectedIndex.value==1){
      isLeadCountYearly.value="true";


    }else{

    }
  }


  void filterSubmit(){
    getDetailsCountOfLeadsForDashboardApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: isLeadCountYearly.value);
  }
  void scrollToLatestItem() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollReminderController.hasClients) {
        scrollReminderController.animateTo(
          0.0, // Since list is reversed, 0.0 is the latest item
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
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
        var genToekn=StorageService.get(StorageService.TOKEN);

        String fcmToken = await getFCMToken();
        String deviceId = await getDeviceId();

        await updateFCMTokenApi(
            id: getEmployeeModel!.data!.id.toString(),
            fcmToken: fcmToken,
            deviceID: deviceId,
            generalToken: genToekn.toString()
        );

        //getCountOfLeadsApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: "false");
        getDetailsCountOfLeadsForDashboardApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: isLeadCountYearly.value);
        getRemindersApi( employeeId: getEmployeeModel!.data!.id.toString());
        todayWorkStatusOfRoBmApi(employeeId: getEmployeeModel!.data!.id.toString());
      }else if (data['StatusCode'] == "You are not authorized" || data['Message'] == "401") {
        // Clear user datd
        StorageService.clear();
        ToastMessage.msg("Session expired. Please log in again.");

        // Navigate to login screen
        Get.offAllNamed("/login");
        return;
      }else{

        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {


      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }



  void  getCountOfLeadsApi({
    required employeeId,
    required applyDateFilter,

  }) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getCountOfLeadsApi(
        employeeId:employeeId,
        applyDateFilter:applyDateFilter,
      );


      if(data['success'] == true){

        getCountOfLeadsModel.value= GetCountOfLeadsModel.fromJson(data);





        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCountOfLeadsModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {


      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getDetailsCountOfLeadsForDashboardApi({
    required employeeId,
    required applyDateFilter,

  }) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getDetailsCountOfLeadsForDashboardApi(
        employeeId:employeeId,
        applyDateFilter:applyDateFilter,
      );


      if(data['success'] == true){

        getDetailsCountOfLeads.value= GetDetailsCountOfLeadsForDashboardModel.fromJson(data);





        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getDetailsCountOfLeads.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {


      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getBreakingNewsApi() async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getBreakingNewsApi();


      if(data['success'] == true){

        getBreakingNewsModel.value= GetBreakingNewsModel.fromJson(data);



        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getBreakingNewsModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {


      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getUpcomingDateOfBirthApi() async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getUpcomingDateOfBirthApi();


      if(data['success'] == true){

        getUpcomingDateOfBirthModel.value= GetUpcomingDateOfBirthModel.fromJson(data);


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getUpcomingDateOfBirthModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {


      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  todayWorkStatusOfRoBmApi({
    required employeeId
}) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.todayWorkStatusOfRoBmApi(employeeId: employeeId);


      if(data['success'] == true){

        todayWorkStatusRBModel.value= TodayWorkStatusRBModel.fromJson(data);


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        todayWorkStatusRBModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {


      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getRemindersApi({
    required String employeeId,
  }) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getRemindersApi(
        employeeId:employeeId,
      );


      if(data['success'] == true){

        getRemindersModel.value= GetRemindersModel.fromJson(data);

        getRemindersModel.value!.data!.forEach((ele){

        });


        for (var i = 0; i < getRemindersModel.value!.data!.length; i++) {
          final reminder = getRemindersModel.value!.data![i];

          // Assuming your date is stored in reminder.date as a String
          final rawDate = reminder.callReminder; // like "2025-04-12 17:38:00.000"

          try {
            final dateTime = DateTime.parse(rawDate!);

            if (dateTime.isAfter(DateTime.now())) {


              await NotificationHelper.scheduleReminder(
                id: i + 1, // make sure ID is unique
                title: "Important Call Reminder"?? "Reminder",
                body: "Call to ${reminder.leadCustomerName}, you have set a reminder last time" ?? "Don't forget!",
                scheduledDateTime: dateTime,
              );
            } else {

            }
          } catch (e) {

          }
        }

        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getRemindersModel.value=null;

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {


      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  Future<void> refreshItems() async {

    // getCountOfLeadsApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: "false");

    var phone=StorageService.get(StorageService.PHONE);
    getEmployeeByPhoneNumberApi(phone: phone.toString());

    getBreakingNewsApi();
    getUpcomingDateOfBirthApi();
  }

  Future<void>updateFCMTokenApi({
    required String id,
    required String deviceID,
    required String fcmToken,
    required String generalToken,
  }) async {
    try {
      isLoading(true);


      var data = await ApiService.updateFCMTokenApi(
          id: id,
          deviceID: deviceID,
          fcmToken: fcmToken,
          generalToken: generalToken

      );


      if(data['success'] == true){
        updateFCMTokenModel= UpdateFCMTokenModel.fromJson(data);

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {

      // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  Future<String> getFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      return token ?? "";
    } catch (e) {

      return "";
    }
  }

  Future<String> getDeviceId() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        return androidInfo.id ?? "no-id";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        return iosInfo.identifierForVendor ?? "no-id";
      } else {
        return "unsupported-platform";
      }
    } catch (e) {

      return "unknown";
    }
  }


}
