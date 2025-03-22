import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';

import 'lead_dd_controller.dart';



class OpenPollFilterController extends GetxController{

  var isLoading = false.obs;
  var isConnectorChecked = false.obs;
  var selectedGender = Rxn<String>();
  LeadListController leadListController=Get.find();
  LeadDDController leadDDController=Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }


  var fromWhere="".obs;

  pollFilterSubmit(){
    leadListController.stateIdMain.value="0";
    leadListController.distIdMain.value="0";
    leadListController.cityIdMain.value="0";
    leadListController.leadCode.value="4";
    leadListController.getAllLeadsApi(
        leadStage:leadListController.leadCode.value,
        employeeId:leadListController.eId.toString(),
        stateId:leadDDController.selectedState.value,
        distId: leadDDController.selectedDistrict.value,
        cityId: leadDDController.selectedCity.value
    );
  }




}