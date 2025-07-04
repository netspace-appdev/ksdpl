import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';


import '../../common/helper.dart';
import '../../models/dashboard/GetAllLeadsModel.dart';
import '../../models/dashboard/PickLeadComTaskModel.dart';
import '../../models/leads/GetCommonLeadListFModel.dart';
import '../../services/drawer_api_service.dart';


class SearchLeadController extends GetxController{

  var isLoading = false.obs;


  LeadListController leadListController = Get.find<LeadListController>();
  LeadDDController leadDDController=Get.find();
  var getAllLeadsModel = Rxn<GetAllLeadsModel>(); //

  var getCommonLeadListFModel = Rxn<GetCommonLeadListFModel>(); //
  final TextEditingController uniqueLeadNumberController = TextEditingController();
  final TextEditingController leadMobileNumberController = TextEditingController();
  final TextEditingController leadNameController = TextEditingController();
/*  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("on delete list");
    Get.delete<LeadListController>(tag: 'list');
  }*/
  void clearSearchFilter(){
    uniqueLeadNumberController.clear();
    leadMobileNumberController.clear();
    leadNameController.clear();

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Get.delete<LeadListController>(tag: 'search');
    super.dispose();
  }


  var fromWhere="".obs;

  pollFilterSubmit(){

    getCommonLeadListByFilterApi(
      stateId: leadDDController.selectedState.value??"0",
      distId: leadDDController.selectedDistrict.value??"0",
      cityId:  leadDDController.selectedCity.value??"0",
      KsdplBranchId: leadDDController.selectedKsdplBr.value??"0",
    );
  }



  void  getCommonLeadListByFilterApi({
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
      print("Error getCommonLeadListFModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }
}