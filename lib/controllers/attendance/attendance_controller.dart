import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/services/dashboard_api_service.dart';

import '../../common/base_url.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/attandance/AddEmployeeLeaveDetailModel.dart';
import '../../models/attandance/GetAllLeaveDetailByEmpIdModel.dart';
import '../../models/attandance/GetAllLeaveTypeModel.dart' as leaveType;
import '../../models/attandance/GetAttendanceListEmpId.dart';
import '../../models/dashboard/GetLeadWorkByLeadIdModel.dart';
import '../../models/dashboard/GetNewsByIdModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/attendance_service.dart';
import '../../services/drawer_api_service.dart';

class AttendanceController extends GetxController{

  var isLoading = false.obs;
  var isAttendanceLoading = false.obs;
  var isLeavesLoading = false.obs;
  var isSendLoading = false.obs;

  var getAttendanceListEmpId = Rxn<GetAttendanceListEmpId>();
  var getAllLeaveTypeModel = Rxn<leaveType.GetAllLeaveTypeModel>();
  var getAllLeaveDetailByEmpIdModel = Rxn<GetAllLeaveDetailByEmpIdModel>();
  var addEmployeeLeaveDetailModel = Rxn<AddEmployeeLeaveDetailModel>();

  final TextEditingController atFromDateController = TextEditingController();
  final TextEditingController atToDateController = TextEditingController();

  final TextEditingController atStartDateController = TextEditingController();
  final TextEditingController atEndDateController = TextEditingController();
  final TextEditingController atTotalDaysController = TextEditingController();
  final TextEditingController atReasonController = TextEditingController();

  RxList<leaveType.Data> leaveTypeList = <leaveType.Data>[].obs;
  var selectedLeaveType = Rxn<int>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clearFields();
  }

  void calculateTotalDays() {
    final fromText = atStartDateController.text;
    final toText = atEndDateController.text;

    if (fromText.isNotEmpty && toText.isNotEmpty) {
      try {
        final fromDate = DateFormat('yyyy-MM-dd').parse(fromText);
        final toDate = DateFormat('yyyy-MM-dd').parse(toText);

        final totalDays = toDate.difference(fromDate).inDays + 1; // inclusive

        if (totalDays >= 0) {
          atTotalDaysController.text = totalDays.toString();
        } else {
          atTotalDaysController.text = '0'; // Optional safety
        }
      } catch (e) {
        atTotalDaysController.text = '0';
      }
    }
  }

  void clearFields(){
    atFromDateController.text="";
    atToDateController.text="";
    selectedLeaveType.value=null;
    atStartDateController.text="";
    atEndDateController.text="";
    atTotalDaysController.text="";
    atReasonController.text="";

  }

  void  getAttendanceListOfEmployeesByEmployeeIdApi({
    required String employeeId,
    String? fromDate,
    String? toDate,
  }) async {
    try {

      isAttendanceLoading(true);


      var data = await AttendanceService.getAttendanceListOfEmployeesByEmployeeIdApi(
          employeeId: employeeId,
          fromDate:fromDate,
          toDate:toDate,
      );


      if(data['success'] == true){

        getAttendanceListEmpId.value= GetAttendanceListEmpId.fromJson(data);



        isAttendanceLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAttendanceListEmpId.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error GetNewsByIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isAttendanceLoading(false);
    } finally {

      isAttendanceLoading(false);
    }
  }



  void  getAllLeaveTypeApi() async {
    try {

      isAttendanceLoading(true);


      var data = await AttendanceService.getAllLeaveTypeApi();


      if(data['success'] == true){

        getAllLeaveTypeModel.value= leaveType.GetAllLeaveTypeModel.fromJson(data);

        final List<leaveType.Data> allLT = getAllLeaveTypeModel.value?.data ?? [];

        final List<leaveType.Data> lts = allLT.where((cat) => cat.active == true).toList();

        leaveTypeList.value = lts;

        isAttendanceLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllLeaveTypeModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error GetNewsByIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isAttendanceLoading(false);
    } finally {

      isAttendanceLoading(false);
    }
  }

  void  getAllLeaveDetailByEmployeeIdApi({
    required String employeeId,
  }) async {
    try {

      isLeavesLoading(true);


      var data = await AttendanceService.getAllLeaveDetailByEmployeeIdApi(
        employeeId: employeeId,
      );


      if(data['success'] == true){

        getAllLeaveDetailByEmpIdModel.value= GetAllLeaveDetailByEmpIdModel.fromJson(data);



        isLeavesLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllLeaveDetailByEmpIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllLeaveDetailByEmpIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLeavesLoading(false);
    } finally {

      isLeavesLoading(false);
    }
  }

  void  addEmployeeLeaveDetailApi({
    required String id,
    required String employeeId,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String totalDays,
    required String reason,
  }) async {
    try {


      isSendLoading(true);


      var data = await AttendanceService.addEmployeeLeaveDetailApi(
        id: id,
        employeeId:employeeId,
        leaveType:leaveType,
        startDate:startDate,
        endDate:endDate,
        totalDays:totalDays,
        reason:reason,
      );

      if(data['success'] == true){
        addEmployeeLeaveDetailModel.value= AddEmployeeLeaveDetailModel.fromJson(data);


        ToastMessage.msg(addEmployeeLeaveDetailModel.value!.message.toString());
        isSendLoading(false);
        Get.back();
      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        addEmployeeLeaveDetailModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error GetNewsByIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isSendLoading(false);
    } finally {
      print("Error ---");
      isSendLoading(false);
    }
  }


}