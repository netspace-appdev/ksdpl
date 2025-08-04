import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';

import '../common/helper.dart';
import '../models/dashboard/PickLeadComTaskModel.dart';
import '../models/leads/GetCommonLeadListFModel.dart';
import '../services/drawer_api_service.dart';
import 'lead_dd_controller.dart';
import '../../models/dashboard/GetAllLeadsModel.dart';


class OpenPollFilterController extends GetxController{

  var isLoading = false.obs;
  var isConnectorChecked = false.obs;
  var selectedGender = Rxn<String>();
  LeadListController leadListController=Get.find();
  LeadDDController leadDDController=Get.find();
  var getAllLeadsModel = Rxn<GetAllLeadsModel>(); //
  var pickLeadComTaskModel = Rxn<PickLeadComTaskModel>(); //
  var getCommonLeadListFModel = Rxn<GetCommonLeadListFModel>(); //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCommonLeadListByFilterApi(
      stateId: "0",
      distId: "0",
      cityId:  "0",
      KsdplBranchId: "0",
    );
  }


  var fromWhere="".obs;

  pollFilterSubmit(){

    print("st==>${leadDDController.selectedState.value}");
    print("st==>${leadDDController.selectedDistrict.value}");
    print("st==>${leadDDController.selectedCity.value}");
    print("st==>${leadListController.eId}");
    print("st==>${leadListController.leadCode.value}");



    getCommonLeadListByFilterApi(
      stateId: leadDDController.selectedState.value??"0",
      distId: leadDDController.selectedDistrict.value??"0",
      cityId:  leadDDController.selectedCity.value??"0",
      KsdplBranchId: leadDDController.selectedKsdplBr.value??"0",
    );
  }

  clearFilter(){

    leadDDController.selectedState.value="0";
    leadDDController.selectedDistrict.value="0";
    leadDDController.selectedCity.value="0";
    leadDDController.selectedKsdplBr.value="0";

    getCommonLeadListByFilterApi(
      stateId: leadDDController.selectedState.value??"0",
      distId: leadDDController.selectedDistrict.value??"0",
      cityId:  leadDDController.selectedCity.value??"0",
      KsdplBranchId: leadDDController.selectedKsdplBr.value??"0",
    );
  }


/*  void  getAllLeadsApi({
    required String employeeId,
    required String leadStage,
    required stateId,
    required distId,
    required cityId,
    required campaign,
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getAllLeadsApi(
          employeeId:employeeId,
          leadStage: leadStage,
          stateId: stateId,
          distId: distId,
          cityId: cityId,
          campaign: campaign
      );


      if(data['success'] == true){

        getAllLeadsModel.value= GetAllLeadsModel.fromJson(data);


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        //  leadStageName2.value=leadStageName.value;
        getAllLeadsModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllLeadsApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }*/



  Future<void>  pickupLeadFromCommonTasksApi({
    required String leadId,
    required String employeeId,

  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.pickupLeadFromCommonTasksApi(
        leadId:leadId,
        employeeId: employeeId,

      );


      if(data['success'] == true){

        pickLeadComTaskModel.value= PickLeadComTaskModel.fromJson(data);


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        //  leadStageName2.value=leadStageName.value;
        pickLeadComTaskModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error pickLeadComTaskModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

 Future<void>  getCommonLeadListByFilterApi({
    String stateId="0",
    String distId="0",
    String cityId="0",
    String KsdplBranchId="0",

  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getCommonLeadListByFilterApi(

        stateId: stateId,
        distId: distId,
        cityId: cityId,
        KsdplBranchId: KsdplBranchId,
      );


      if(data['success'] == true){

        getCommonLeadListFModel.value= GetCommonLeadListFModel.fromJson(data);


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        //  leadStageName2.value=leadStageName.value;
        getCommonLeadListFModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCommonLeadListFModel here: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }
}