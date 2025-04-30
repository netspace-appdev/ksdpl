
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../common/helper.dart';
import '../../common/notification_helper.dart';
import '../../common/storage_service.dart';
import '../../models/UpdateFCMTokenModel.dart';
import '../../models/dashboard/GetCountOfLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/dashboard/GetRemindersModel.dart';
import '../../models/dashboard/GetUpcomingDateOfBirthModel.dart';
import '../../models/dashboard/getBreakingNewsModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../../services/home_service.dart';
class DashboardController extends GetxController {

  var isLoading = false.obs;
  GetEmployeeModel? getEmployeeModel;
  var getCountOfLeadsModel = Rxn<GetCountOfLeadsModel>(); //
  var getBreakingNewsModel = Rxn<GetBreakingNewsModel>(); //
  var getUpcomingDateOfBirthModel = Rxn<GetUpcomingDateOfBirthModel>(); //
  var getRemindersModel = Rxn<GetRemindersModel>(); //
  ScrollController scrollReminderController = ScrollController();
  UpdateFCMTokenModel? updateFCMTokenModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var phone=StorageService.get(StorageService.PHONE);
    getEmployeeByPhoneNumberApi(phone: phone.toString());

    getBreakingNewsApi();
    getUpcomingDateOfBirthApi();

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

        getCountOfLeadsApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: "true");
        getRemindersApi( employeeId: getEmployeeModel!.data!.id.toString());

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
      print("Error getAllLeadsApi: $e");

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
      print("Error getBreakingNews: $e");

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
      print("Error getUpcomingDateOfBirthModel: $e");

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

       /* var rawDate="2025-04-12 17:52:00.000";
        DateTime dateTime = DateTime.parse(rawDate);


        if (dateTime.isAfter(DateTime.now())) {
          print("alarm");
          await NotificationHelper.scheduleReminder(
            id:1, //reminder.id,
            title: "test",//reminder.title,
            body: "demo",//reminder.body,
            scheduledDateTime: dateTime,
          );
        } else {
          print('⏰ Skipped past reminder:test');
        }*/

        for (var i = 0; i < getRemindersModel.value!.data!.length; i++) {
          final reminder = getRemindersModel.value!.data![i];

          // Assuming your date is stored in reminder.date as a String
          final rawDate = reminder.callReminder; // like "2025-04-12 17:38:00.000"

          try {
            final dateTime = DateTime.parse(rawDate!);

            if (dateTime.isAfter(DateTime.now())) {
              print("⏰ Scheduling alarm for $rawDate");

              await NotificationHelper.scheduleReminder(
                id: i + 1, // make sure ID is unique
                title: "Important Call Reminder"?? "Reminder",
                body: "Call to ${reminder.leadCustomerName}, you have set a reminder last time" ?? "Don't forget!",
                scheduledDateTime: dateTime,
              );
            } else {
              print("⏭️ Skipped past reminder: $rawDate");
            }
          } catch (e) {
            print("❌ Error parsing/scheduling reminder: $e");
          }
        }





        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getRemindersModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getRemindersModel: $e");

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
      print("data in controller==>${data.toString()}");

      if(data['success'] == true){
        updateFCMTokenModel= UpdateFCMTokenModel.fromJson(data);

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error here: $e");
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
      print('🔑 FCM Token: $token');
      return token ?? "";
    } catch (e) {
      print("❌ Error fetching FCM token: $e");
      return "";
    }
  }

  Future<String> getDeviceId() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('📱 Android Device ID: ${androidInfo.id}');
        return androidInfo.id ?? "no-id";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('📱 iOS Device ID: ${iosInfo.identifierForVendor}');
        return iosInfo.identifierForVendor ?? "no-id";
      } else {
        return "unsupported-platform";
      }
    } catch (e) {
      print("❌ Error fetching device ID: $e");
      return "unknown";
    }
  }


}
