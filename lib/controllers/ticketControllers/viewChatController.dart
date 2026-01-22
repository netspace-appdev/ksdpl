import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksdpl/home/custom_drawer.dart';
import 'package:ksdpl/home/raiseTIcket/viewTicketsScreen.dart';

import '../../common/helper.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../models/raiseTicketModel/ViewChatDetailModel.dart';
import '../../services/ticketService.dart';

class ViewChatController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController ticketNoController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  var isLoadingValue = RxBool(false);
  var isLoadingValue1 = RxBool(false);
  var isStatusUpdating = RxBool(false);

  var viewChatDetailModel = Rxn<ViewChatDetailModel>();

  Rx<File?> selectedFile = Rx<File?>(null);



  @override
  void onClose() {
    ticketNoController.dispose();
    subjectController.dispose();
    statusController.dispose();
    userNameController.dispose();
    categoryController.dispose();
    priorityController.dispose();
    super.onClose();
  }

  Future <void> getTicketById({int? id}) async {
    try {
      isLoadingValue(true);

      var data = await TicketService.getTicketByIdApi(id:id);

      if (data['success'] == true) {
        viewChatDetailModel.value = ViewChatDetailModel.fromJson(data);
        isLoadingValue(false);
        _setDataToControllers(viewChatDetailModel.value);

        //   SnackbarHelper.showSnackbar(title: AppText.success, message: data['message'] );
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

  void _setDataToControllers(ViewChatDetailModel? data) {
    ticketNoController.text = data?.data?.ticketNo ?? '';
    subjectController.text = data?.data?.subject ?? '';
    categoryController.text = data?.data?.category ?? '';
    priorityController.text = data?.data?.priority ?? '';

    // status is int? → convert to readable text if needed
    statusController.text = _getStatusText(data?.data?.status);

    // createdBy / name handling
    userNameController.text = data?.data?.name ?? '';
  }
  String _getStatusText(int? status) {
    switch (status) {
      case 1:
        return 'Open';
      case 2:
        return 'In Progress';
      case 3:
        return 'Closed';
      default:
        return '';
    }
  }

  Future<void> sendMessageApiRequest({File? image, required String ticketId, required String message}) async {

    try {
      isLoadingValue1(true);

      var data = await TicketService.sendMessageApi(
        ticketId:ticketId,
          message:message,
          image:image
      );

      if (data['success'] == true) {
           SnackbarHelper.showSnackbar(title: AppText.success, message: data['message'] );
           getTicketById(id:int.tryParse(ticketId));
        clear();

      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in updateBankerDetailApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoadingValue1(false);
    }
  }
  Future<void> statusUpdateTicketApiRequest({ required String TicketNo, required String PanelId,required String status }) async {

    try {
      isStatusUpdating(true);

      var data = await TicketService.statusUpdateTicketApi(
          TicketNo:TicketNo,
          PanelId:PanelId,
          status:status
      );

      if (data['success'] == true) {
           SnackbarHelper.showSnackbar(title: AppText.success, message: data['message'] );
           Get.to(() => ViewTicketListScreen());
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in updateBankerDetailApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isStatusUpdating(false);
    }
  }

  void clear() {
    messageController.clear();
    selectedFile.value = null;
  }

}