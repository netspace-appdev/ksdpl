
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


///New code
class CallService {
  StreamSubscription<PhoneState>? phoneStateSubscription;
  String? lastDialedNumber;
  LeadListController leadListController = Get.find();
  void makePhoneCall({
    required String phoneNumber,
    required String leadId,
    required String currentLeadStage,
    required BuildContext context,
    required Function({
    required BuildContext context,
    required String leadId,
    required String currentLeadStage,
    required String callDuration,
    required String callStartTime,
    required String callEndTime,
    required String callStatus,
    }) showFeedbackDialog,
  }) async {
    print("call service ");
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
              context: context,
            showFeedbackDialog: showFeedbackDialog
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
    required Function({
    required BuildContext context,
    required String leadId,
    required String currentLeadStage,
    required String callDuration,
    required String callStartTime,
    required String callEndTime,
    required String callStatus,
    }) showFeedbackDialog,
  }) async {
    if (lastDialedNumber == null) return;

    Iterable<CallLogEntry> callLogs = await CallLog.query(
      number: lastDialedNumber,

    );

    if (callLogs.isNotEmpty) {
      CallLogEntry lastCall = callLogs.first;
      print("Call Type: ${lastCall.callType}");
      print("Duration: ${lastCall.duration} seconds");

      print("✅ Call started at ${lastCall.timestamp}");
      var callDuration=Helper.formatCallDuration(lastCall.duration!.toInt());
      var callStartTime=Helper.convertUnixTo12HourFormat(lastCall.timestamp!+19800 );
      var callEndTime=Helper.convertUnixTo12HourFormat((lastCall.timestamp!+19800) +lastCall.duration!.toInt());
      print("✅ Call was connected and lasted ${lastCall.duration} seconds. which is ${callDuration} ");
      leadListController.callFeedbackController.clear();
      leadListController.leadFeedbackController.clear();

      if (lastCall.duration! > 0) {


        showFeedbackDialog(
            leadId: leadId,
            currentLeadStage: currentLeadStage,
            context: context,
            callDuration: callDuration.toString(),
            callStartTime:callStartTime.toString(),
            callEndTime: callEndTime.toString(),
          callStatus: "1",
        );
      } else {
        showFeedbackDialog(
          leadId: leadId,
          currentLeadStage: currentLeadStage,
          context: context,
          callDuration: callDuration.toString(),
          callStartTime:callStartTime.toString(),
          callEndTime: callEndTime.toString(),
          callStatus: "1",
        );
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

}