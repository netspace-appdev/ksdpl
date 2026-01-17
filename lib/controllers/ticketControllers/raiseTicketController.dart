import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksdpl/custom_widgets/CamImage.dart';
import 'package:ksdpl/models/raiseTicketModel/AddTicketModel.dart';
import 'package:ksdpl/services/ticketService.dart';

import '../../common/base_url.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/ImagePickerMixin.dart';
import '../../custom_widgets/SnackBarHelper.dart';

class RaiseTicketController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<DropdownItem> priorityList = [
    DropdownItem(id: 1, name: "High"),
    DropdownItem(id: 2, name: "Medium"),
    DropdownItem(id: 3, name: "Low"),
  ];

  final List<DropdownItem> queryTypeList = [
    DropdownItem(id: 1, name: "Technical"),
    DropdownItem(id: 2, name: "Legal"),
  ];



  RxString selectedType = "".obs;
  RxString selectedPriority = "".obs;

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController issueDetailController = TextEditingController();
  var addTicketModel = Rxn<AddTicketModel>(); //

  var isPackageMasterLoading=false.obs;
  var isLoading=false.obs;

  var isUserAIC = false.obs;

  var photosPropEnabled =true.obs;

  var isRequiredVisibleSecure = false.obs;


  Future <void> addTicketApiResponse({
    required String panelId,
    required String subject,
    required String category,
    required String issueDetails,
    required String priority,
    required String createdBy
  }) async {
    try {
      isLoading(true);

      var data = await TicketService.addTicketApi(
        id: '0',
        panelId: panelId,
        subject:subject,
        category: category,
        issueDetails: issueDetails,
        priority: priority,
      );

      if (data['success'] == true) {
        addTicketModel.value = AddTicketModel.fromJson(data);
        isLoading(false);
        clear();
        SnackbarHelper.showSnackbar(title: AppText.success, message: data['message'] );
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in updateBankerDetailApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }

  }

  void clear() {
    subjectController.clear();
    issueDetailController.clear();

    selectedType.value = "";
    selectedPriority.value = "";
  }


  String getPriorityName(int? id) {
    return priorityList
        .firstWhereOrNull((e) => e.id == id)
        ?.name ??
        "";
  }

  String getQueryTypeName(int? id) {
    return queryTypeList
        .firstWhereOrNull((e) => e.id == id)
        ?.name ??
        "";
  }

}

class DropdownItem {
  final int id;
  final String name;

  DropdownItem({required this.id, required this.name});
}
