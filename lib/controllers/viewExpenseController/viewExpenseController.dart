import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/services/generate_cibil_services.dart';
import 'package:ksdpl/services/product_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/AddEmployeeExpenseDetails/addEmployeeExpenseDetailsModel.dart';
import '../../models/IndividualLeadUploadModel.dart';
import '../../models/attandance/GetAllLeaveDetailByEmpIdModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/product/GetAllProductListModel.dart' as prod;
import '../../services/drawer_api_service.dart';
import '../../services/lead_api_service.dart';
import '../registration_dd_controller.dart';

class ViewExpenseController extends GetxController{

  var isLoading = false.obs;
 var employee_id =  StorageService.get(StorageService.EMPLOYEE_ID).toString();
  var expenseList = <ExpenseData>[].obs; // <- your list for UI


  var addEmployeeExpenseDetailsModel = Rxn<AddEmployeeExpenseDetailsModel>();

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yy').format(parsedDate);
    } catch (e) {
      return '';
    }
  }


  Future<void> getExpenseByEmployeeIDApi() async {
    try {
      isLoading(true);
      var data = await GenerateCibilServices.getExpenseByEmployeeIDApi(
        employeeId: employee_id,
      );

      if (data['success'] == true) {
        addEmployeeExpenseDetailsModel.value = AddEmployeeExpenseDetailsModel.fromJson(data);

        // Assuming your model has: List<ExpenseData> data;
        expenseList.value = addEmployeeExpenseDetailsModel.value?.data ?? [];

      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        expenseList.clear();
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error GetExpenseByEmployeeID: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
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
}