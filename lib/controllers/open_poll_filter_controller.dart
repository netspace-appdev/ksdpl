import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';

import '../common/helper.dart';
import '../models/dashboard/PickLeadComTaskModel.dart';
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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }


  var fromWhere="".obs;

  pollFilterSubmit(){
    // leadListController.stateIdMain.value="0";
    // leadListController.distIdMain.value="0";
    // leadListController.cityIdMain.value="0";
    // leadListController.leadCode.value="4";
    print("st==>${leadDDController.selectedState.value}");
    print("st==>${leadDDController.selectedDistrict.value}");
    print("st==>${leadDDController.selectedCity.value}");
    print("st==>${leadListController.eId}");

    getAllLeadsApi(
        leadStage:leadListController.leadCode.value,
        employeeId:"0",
        stateId:leadDDController.selectedState.value,
        distId: leadDDController.selectedDistrict.value,
        cityId: leadDDController.selectedCity.value,
        campaign: leadDDController.selectedCampaign.value,
    );
  }


  void  getAllLeadsApi({
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
  }



  void  pickupLeadFromCommonTasksApi({
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
}