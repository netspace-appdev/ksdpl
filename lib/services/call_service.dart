
import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
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
  bool _hasHandledCall = false;



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
      _hasHandledCall = false;
      // Start listening to call status
      phoneStateSubscription = PhoneState.stream.listen((PhoneState event) {
        if (event.status == PhoneStateStatus.CALL_ENDED && !_hasHandledCall) {
          _hasHandledCall = true;
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




      var callDuration=Helper.formatCallDuration(lastCall.duration!.toInt());
      var callStartTime = Helper.convertUnixTo12HourFormat(lastCall.timestamp!);
      var callEndTime = Helper.convertUnixTo12HourFormat(
          lastCall.timestamp! + (lastCall.duration!.toInt() * 1000)
      );

      print("✅ Call was connected and lasted ${lastCall.duration} seconds. which is ${callDuration} ");
      print("✅ callStartTime ${callStartTime} seconds. ");
      print("✅ callEndTime ${callEndTime} seconds. ");
      print("Good");
      leadListController.callFeedbackController.clear();
      leadListController.leadFeedbackController.clear();
      DateTime now = DateTime.now();
      var td=DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(now);
      leadListController.isCallReminder.value =false;
      var formattedDateTime=td.toString();
      if (lastCall.duration! > 0) {
        leadListController.workOnLeadApi(
          leadId: leadId.toString(),
          leadStageStatus: currentLeadStage,
          callStatus: "1",
          callDuration: callDuration,
          callStartTime: callStartTime,
          callEndTime: callEndTime,
          callReminder: formattedDateTime,
        ).then((_){
          print("lead state before===>${currentLeadStage}");
          print("lead state after===>${leadListController.workOnLeadModel!.data!.leadStageStatus}");
          showFeedbackDialog(
            leadId: leadId,
            currentLeadStage: leadListController.workOnLeadModel!.data!.leadStageStatus.toString(),
            context: context,
            callDuration: callDuration.toString(),
            callStartTime:callStartTime.toString(),
            callEndTime: callEndTime.toString(),
            callStatus: "1",
          );
        });


      } else {
        leadListController.couldNotController.text="Could not Connect";
        print("lead state not connnected===>${currentLeadStage}");
        leadListController.workOnLeadApi(
          leadId: leadId.toString(),
          leadStageStatus: currentLeadStage,
          callStatus: "0",
          callDuration: callDuration,
          callStartTime: callStartTime,
          callEndTime: callEndTime,
          callReminder: formattedDateTime,
        ).then((_){
          showFeedbackDialog(
            leadId: leadId,
            currentLeadStage: (currentLeadStage=="2" || currentLeadStage=="3")?"13":leadListController.workOnLeadModel!.data!.leadStageStatus.toString(),
            context: context,
            callDuration: callDuration.toString(),
            callStartTime:callStartTime.toString(),
            callEndTime: callEndTime.toString(),
            callStatus: "0",
          );
        });
        print("❌ Call was not answered or disconnected immediately.");
      }
    } else {
      print("No call log found.");
    }

    lastDialedNumber = null;
  }

  void dispose() {
    phoneStateSubscription?.cancel();
    phoneStateSubscription = null;
    _hasHandledCall = false;
  }

}