
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart' as state;
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;

import '../../common/helper.dart';
import '../../services/drawer_api_service.dart';

class ReferenceController {
  LeadDDController leadDDController=Get.find();
  // Text controllers
  final TextEditingController refNameController = TextEditingController();
  final TextEditingController refAddController = TextEditingController();
  final TextEditingController refPhoneController = TextEditingController();
  final TextEditingController refMobController = TextEditingController();
  final TextEditingController refRelWithApplController = TextEditingController();
  final TextEditingController refPincodeController = TextEditingController();

  var countryList=["India",];
  var selectedCountry = Rxn<String>();

  var getDistrictByStateModelPerm = Rxn<dist.GetDistrictByStateModel>(); //
  var getCityByDistrictIdModelPerm = Rxn<city.GetCityByDistrictIdModel>(); //


  var isStateLoadingPerm = false.obs;
  var isDistrictLoadingPerm = false.obs;
  var isCityLoadingPerm = false.obs;


  var selectedStatePerm = Rxn<String>();
  var selectedDistrictPerm = Rxn<String>();
  var selectedCityPerm = Rxn<String>();

  RxList<city.Data> stateListPerm = <city.Data>[].obs;
  RxList<dist.Data> districtListPerm = <dist.Data>[].obs;
  RxList<city.Data> cityListPerm = <city.Data>[].obs;

  void  getDistrictByStateIdPermApi({
    required stateId
  }) async {
    try {

      isDistrictLoadingPerm(true);


      var data = await DrawerApiService.getDistrictByStateIdApi(stateId: stateId);


      if(data['success'] == true){

        getDistrictByStateModelPerm.value= dist.GetDistrictByStateModel.fromJson(data);

        final List<dist.Data> districts = getDistrictByStateModelPerm.value?.data ?? [];
        districtListPerm.value = List<dist.Data>.from(districts);


        isDistrictLoadingPerm(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getDistrictByStateModelPerm.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllStateApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isDistrictLoadingPerm(false);
    } finally {


      isDistrictLoadingPerm(false);
    }
  }

  void  getCityByDistrictIdPermApi({
    required districtId
  }) async {
    try {

      isCityLoadingPerm(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModelPerm.value= city.GetCityByDistrictIdModel.fromJson(data);



        isCityLoadingPerm(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCityByDistrictIdModelPerm.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCityByDistrictId: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isCityLoadingPerm(false);
    } finally {


      isCityLoadingPerm(false);
    }
  }



}
