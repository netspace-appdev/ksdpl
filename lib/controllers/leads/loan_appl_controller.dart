import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

class LoanApplicationController extends GetxController{
  var firstName="".obs;
  var email="".obs;
  var isLoading = false.obs;
  var getLeadDetailModel = Rxn<GetLeadDetailModel>(); //
  var selectedGender = Rxn<String>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController qualiController = TextEditingController();
  final TextEditingController maritalController = TextEditingController();
  final TextEditingController emplStatusController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController occSectorController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobController = TextEditingController();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }


}