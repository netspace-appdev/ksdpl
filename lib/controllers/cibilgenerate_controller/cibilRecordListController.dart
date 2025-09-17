import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/models/GetCustomerCibilDetailModel/GetCustomerCibilDetailModel.dart';
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

class CibilRecordListController extends GetxController{

  var isLoading = false.obs;
  var employee_id =  StorageService.get(StorageService.EMPLOYEE_ID).toString();
  var expenseList = <ExpenseData>[].obs;
  var CibilDetailList = <CibilData>[].obs;
  var getCustomerCibilDetailModel = Rxn<GetCustomerCibilDetailModel>();
  RxInt recordListLength = 0.obs;
  String? empId = StorageService.get(StorageService.EMPLOYEE_ID);

  RxBool hasMore = true.obs;
  RxInt currentPage = 1.obs;
  // final int pageSize = 20;
  final int pageSize = 200;

  RxBool isActive = false.obs;
  var isItemLoading = false.obs;
  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yy').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCustomerCibilDetailByUserIdApi( );
  }


/*
  void getCustomerCibilDetailByUserIdApi({
    bool isLoadMore = false,
  }) async {

    try {

      if (isLoading.value || (!hasMore.value && isLoadMore)) return;

      isLoading(true);

      if (!isLoadMore) {
        currentPage.value = 1; // Reset to first page on fresh load
        hasMore.value = true;
      }

      var data = await GenerateCibilServices.getCustomerCibilDetailByUserIdApiRequest(
        userId: empId??'',
        fromDate: "",
        toDate: "",
        pageNumber: currentPage.value,
        pageSize: pageSize,
      );


      if (data['success'] == true) {
        var newLeads =GetCustomerCibilDetailModel.fromJson(data);

        if (isLoadMore) {
          getCustomerCibilDetailModel.value!.data!.addAll(newLeads.data!);
        } else {
          getCustomerCibilDetailModel.value = newLeads;
        }
        getCustomerCibilDetailModel.value = newLeads;



        // If less data returned than requested pageSize, mark as no more
        if (newLeads.data!.length < pageSize) {
          hasMore.value = false;
        } else {
          currentPage.value++; // Ready for next page
        }
        recordListLength.value=getCustomerCibilDetailModel.value!.data!.length;
      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        //leadStageName2.value = leadStageName.value;
        getCustomerCibilDetailModel.value = null;
        hasMore.value = false;
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error getAllLeadsApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }*/
  void getCustomerCibilDetailByUserIdApi({
    bool isLoadMore = false,
  }) async {
    try {
      if (isLoading.value || (!hasMore.value && isLoadMore)) return;

      isLoading(true);

      if (!isLoadMore) {
        currentPage.value = 1;
        hasMore.value = true;
      }

      var data = await GenerateCibilServices.getCustomerCibilDetailByUserIdApiRequest(
        userId: empId ?? '',
        fromDate: "",
        toDate: "",
        pageNumber: currentPage.value,
        pageSize: pageSize,
      );

      if (data['success'] == true) {
        var newLeads = GetCustomerCibilDetailModel.fromJson(data);

        // 🚀 Instead of merging, just replace the list
        getCustomerCibilDetailModel.value = newLeads;

        // Update pagination flag
        if ((newLeads.data?.length ?? 0) < pageSize) {
          hasMore.value = false;
        } else {
          currentPage.value++;
        }

        recordListLength.value = getCustomerCibilDetailModel.value?.data?.length ?? 0;
      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        getCustomerCibilDetailModel.value = null;
        hasMore.value = false;
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error getCustomerCibilDetailByUserIdApi: $e");
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