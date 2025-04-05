
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetCountOfLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/dashboard/GetRemindersModel.dart';
import '../../models/dashboard/GetUpcomingDateOfBirthModel.dart';
import '../../models/dashboard/getBreakingNewsModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';
class DashboardController extends GetxController {

  var isLoading = false.obs;
  GetEmployeeModel? getEmployeeModel;
  var getCountOfLeadsModel = Rxn<GetCountOfLeadsModel>(); //
  var getBreakingNewsModel = Rxn<GetBreakingNewsModel>(); //
  var getUpcomingDateOfBirthModel = Rxn<GetUpcomingDateOfBirthModel>(); //
  var getRemindersModel = Rxn<GetRemindersModel>(); //
  ScrollController scrollReminderController = ScrollController();
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
        isLoading(false);
        getCountOfLeadsApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: "false");
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
   // await Future.delayed(Duration(seconds: 2));
    getCountOfLeadsApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: "false");
  }

}
