import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
  var viewChatDetailModel = Rxn<ViewChatDetailModel>();



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
      case 0:
        return 'Open';
      case 1:
        return 'In Progress';
      case 2:
        return 'Closed';
      default:
        return '';
    }
  }

}