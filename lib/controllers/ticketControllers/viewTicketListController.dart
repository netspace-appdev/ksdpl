import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/models/raiseTicketModel/ViewRaiseTicketListModel.dart';

import '../../common/helper.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../services/ticketService.dart';

class ViewRaiseListController extends GetxController{

  var isLoadingValue = RxBool(false);
  var viewRaiseTicketListModel = Rxn<ViewRaiseTicketListModel>(); //


  Future <void> getAllTicketApiResponse() async {
    try {
      isLoadingValue(true);

      var data = await TicketService.getAllTicketApi();

      if (data['success'] == true) {
        viewRaiseTicketListModel.value = ViewRaiseTicketListModel.fromJson(data);
        isLoadingValue(false);
        SnackbarHelper.showSnackbar(title: AppText.success, message: data['message'] );
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in updateBankerDetailApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoadingValue(false);
    }

  }


  String getStatusText(int? statusId) {
    switch (statusId) {
      case 1:
        return "Open";
      case 2:
        return "In Process";
      case 3:
        return "Closed";
      default:
        return "";
    }
  }
  Color getStatusColor(int? statusId) {
    switch (statusId) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.black;
    }
  }


}