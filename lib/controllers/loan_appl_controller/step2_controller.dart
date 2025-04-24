import 'package:get/get.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import 'co_applicant_detail_mode_controllerl.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../leads/loan_appl_controller.dart';

class Step2Controller extends GetxController{
  LoanApplicationController loanApplicationController=Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loanApplicationController.coApplicantList.add(CoApplicantDetailController());

  }

}