/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ksdpl/models/leads/GetAllLeadStageModel.dart' as stage;

import '../common/helper.dart';
import 'CustomBigDialogBox.dart';
import 'CustomDropdown.dart';
import 'CustomLabelPickerTextField.dart';
import 'CustomLabeledTextField.dart';
import 'CustomLabeledTimePicker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widgets/CustomBigDialogBox.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';

void showGenericCallFeedbackDialog({
  required BuildContext context,
  required String leadId,
  required String currentLeadStage,
  required String callDuration,
  required String callStartTime,
  required String callEndTime,
  required String callStatus,
  required TextEditingController callFeedbackController,
  required TextEditingController leadFeedbackController,
  required RxBool isCallReminder,
  required TextEditingController followDateController,
  required TextEditingController followTimeController,
  required RxString selectedStage,
  required RxInt selectedStageActive,
  required List<stage.Data> allStages,
  required VoidCallback onSubmit,
}) {
  showDialog(
    context: context,
    builder: (_) => CustomBigDialogBox(
      title: "Call Feedback",
      child: Column(
        children: [
          // ... Your custom form widgets
        ],
      ),
      onPressed: onSubmit,
    ),
  );
}

int _getActiveStage(int? id, List<stage.Data> stages) {
  final index = stages.indexWhere((element) => element.id == id);
  return index != -1 ? index : 0;
}


///👉 Then in each screen, define a lightweight function like this:

import 'package:your_app/widgets/dialogs/call_feedback_dialog_content.dart';

void showCallFeedbackDialog({
  required BuildContext context,
  required String leadId,
  required String currentLeadStage,
  required String callDuration,
  required String callStartTime,
  required String callEndTime,
  required String callStatus,
}) {
  final controller = Get.find<YourController>(); // Replace with your actual controller

  showGenericCallFeedbackDialog(
    context: context,
    leadId: leadId,
    currentLeadStage: currentLeadStage,
    callDuration: callDuration,
    callStartTime: callStartTime,
    callEndTime: callEndTime,
    callStatus: callStatus,
    callFeedbackController: controller.callFeedbackController,
    leadFeedbackController: controller.leadFeedbackController,
    isCallReminder: controller.isCallReminder,
    followDateController: controller.followDateController,
    followTimeController: controller.followTimeController,
    selectedStage: controller.selectedStage,
    selectedStageActive: controller.selectedStageActive,
    allStages: controller.getAllLeadStageModel.value!.data!,
    onSubmit: () {
      // Put your actual submit logic here
    },
  );
}
*/
