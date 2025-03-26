
import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:phone_state/phone_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import '../common/helper.dart';
import '../controllers/leads/leadlist_controller.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/CustomBigDialogBox.dart';
import '../custom_widgets/CustomLabeledTextField.dart';

class CallService {
  StreamSubscription<PhoneState>? phoneStateSubscription;
  String? lastDialedNumber;
  LeadListController leadListController = Get.find();
  void makePhoneCall({
    required String phoneNumber,
    required String leadId,
    required String currentLeadStage,
    required BuildContext context,

}) async {
    final Uri phoneUri = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phoneUri)) {
      lastDialedNumber = phoneNumber;

      // Start listening to call status
      phoneStateSubscription = PhoneState.stream.listen((PhoneState event) {
        if (event.status == PhoneStateStatus.CALL_ENDED) {
          print("Call Ended, checking duration...");
          Future.delayed(Duration(seconds: 2), () => checkCallStatus(
            leadId: leadId,
            currentLeadStage: currentLeadStage,
              context: context
          ));
        }
      });

      await launchUrl(phoneUri);
    } else {
      print("Could not make the call");
    }
  }

  Future<void> checkCallStatus({
    required String leadId,
    required String currentLeadStage,
    required BuildContext context,
}) async {
    if (lastDialedNumber == null) return;

    Iterable<CallLogEntry> callLogs = await CallLog.query(
      number: lastDialedNumber,

    );

    if (callLogs.isNotEmpty) {
      CallLogEntry lastCall = callLogs.first;
      print("Call Type: ${lastCall.callType}");
      print("Duration: ${lastCall.duration} seconds");

      if (lastCall.duration! > 0) {
        print("✅ Call was connected and lasted ${lastCall.duration} seconds.");
        print("✅ Call started at ${lastCall.timestamp}");
        showCallFeedbackDialog(
          leadId: leadId,
          currentLeadStage: currentLeadStage,
          context: context,
          callDuration: lastCall.duration.toString(),
          callStartTime: convertTimestamp(lastCall.timestamp!)
        );
      } else {
        print("❌ Call was not answered or disconnected immediately.");
      }
    } else {
      print("No call log found.");
    }

    lastDialedNumber = null;
  }

  void dispose() {
    phoneStateSubscription?.cancel();
  }

  void showCallFeedbackDialog({
    required BuildContext context,
    required leadId,
    required currentLeadStage,
    required callDuration,
    required callStartTime,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,

          title: AppText.addFeedback,
          content: Form(
            child: Column(
              children: [
                SizedBox(height: 15,),
                CustomLabeledTextField(
                  label: AppText.callFeedback,
                  isRequired: false,
                  controller: leadListController.callFeedbackController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterCallFeedback,
                  //validator:  ValidationHelper.validateName,
                  isTextArea: true,

                ),
                SizedBox(height: 15,),
                CustomLabeledTextField(
                  label: AppText.leadFeedback,
                  isRequired: false,
                  controller: leadListController.leadFeedbackController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterLeadFeedback,
                  // validator:  ValidationHelper.validateName,
                  isTextArea: true,

                ),

              ],
            ),
          ),
          onSubmit: () {
            if(leadListController.callFeedbackController.text.isEmpty && leadListController.leadFeedbackController.text.isEmpty){
              ToastMessage.msg(AppText.addFeedbackFirst);
            }else{
              leadListController.workOnLeadApi(
                leadId: leadId.toString(),
                leadStageStatus: currentLeadStage,
                feedbackRelatedToCall:leadListController.callFeedbackController.text.trim().toString(),
                feedbackRelatedToLead:leadListController.leadFeedbackController.text.trim().toString(),
                callStatus: "1",
                callDuration: callDuration,
                callStartTime: callStartTime,
                callEndTime: "00:00",


              );
              Get.back();
            }



          },
        );
      },
    );
  }
  String convertTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return dateTime.toIso8601String();
  }
}
