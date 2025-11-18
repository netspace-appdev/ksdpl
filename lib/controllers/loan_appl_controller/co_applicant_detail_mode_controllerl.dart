
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
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart' as stateModel;

class CoApplicantDetailController {
  LeadDDController leadDDController=Get.find();
  // Text controllers
  final TextEditingController coApFullNameController = TextEditingController();
  final TextEditingController coApFatherNameController = TextEditingController();
  final TextEditingController coApDobController = TextEditingController();
  final TextEditingController coApQqualiController = TextEditingController();
  final TextEditingController coApMaritalController = TextEditingController();
  final TextEditingController coApEmplStatusController = TextEditingController();
  final TextEditingController coApNationalityController = TextEditingController();
  final TextEditingController coApOccupationController = TextEditingController();
  final TextEditingController coApOccSectorController = TextEditingController();
  final TextEditingController coApEmailController = TextEditingController();
  final TextEditingController coApMobController = TextEditingController();
  final TextEditingController coApQualiController = TextEditingController();



  final TextEditingController coApCurrHouseFlatController = TextEditingController();
  final TextEditingController coApCurrBuildingNoController = TextEditingController();
  final TextEditingController coApCurrSocietyNameController = TextEditingController();
  final TextEditingController coApCurrLocalityController = TextEditingController();
  final TextEditingController coApCurrStreetNameController = TextEditingController();
  final TextEditingController coApCurrPinCodeController = TextEditingController();
  final TextEditingController coApCurrTalukaController = TextEditingController();

  final TextEditingController coApPermHouseFlatController = TextEditingController();
  final TextEditingController coApPermBuildingNoController = TextEditingController();
  final TextEditingController coApPermSocietyNameController = TextEditingController();
  final TextEditingController coApPermLocalityController = TextEditingController();
  final TextEditingController coApPermStreetNameController = TextEditingController();
  final TextEditingController coApPermPinCodeController = TextEditingController();
  final TextEditingController coApPermTalukaController = TextEditingController();


  final TextEditingController coApOrgNameController = TextEditingController();
  final TextEditingController coApNatureOfBizController = TextEditingController();
  final TextEditingController coApStaffStrengthController = TextEditingController();
  final TextEditingController coApSalaryDateController = TextEditingController();

  /// 4 Nov
  final TextEditingController coApOfficeAdHouseFlatController = TextEditingController();
  final TextEditingController coApOfficeAdBuildingNoController = TextEditingController();
  final TextEditingController coApOfficeAdSocietyNameController = TextEditingController();
  final TextEditingController coApOfficeAdLocalityController = TextEditingController();
  final TextEditingController coApOfficeAdStreetNameController = TextEditingController();
  final TextEditingController coApOfficeAdPinCodeController = TextEditingController();
  final TextEditingController coApOfficeAdTalukaController = TextEditingController();



  var isSameAddressApl = false.obs;
  var selectedCountrCurr = Rxn<String>();
  var selectedCountryPerm = Rxn<String>();
  var selectedCountryOfficeAd = Rxn<String>();


  var ownershipList=["Owned", "Rented","Leased", "Jointly Owned", "Other"];
  var selectedOwnershipList = Rxn<String>();

  var selectedGenderCoAP = Rxn<String>();

  var getDistrictByStateModelCurr = Rxn<dist.GetDistrictByStateModel>(); //
  var getDistrictByStateModelPerm = Rxn<dist.GetDistrictByStateModel>(); //
  var getDistrictByStateModelOfficeAd = Rxn<dist.GetDistrictByStateModel>(); //

  var getCityByDistrictIdModelCurr = Rxn<city.GetCityByDistrictIdModel>(); //
  var getCityByDistrictIdModelPerm = Rxn<city.GetCityByDistrictIdModel>(); //
  var getCityByDistrictIdModelOfficeAd = Rxn<city.GetCityByDistrictIdModel>(); //

  var isStateLoadingCurr = false.obs;
  var isDistrictLoadingCurr = false.obs;
  var isCityLoadingCurr = false.obs;

  var isStateLoadingPerm = false.obs;
  var isDistrictLoadingPerm = false.obs;
  var isCityLoadingPerm = false.obs;

  var isDistrictLoadingOfficeAd = false.obs;
  var isCityLoadingOfficeAd = false.obs;

  // Dropdown selections
  var selectedStateCurr = Rxn<String>();
  var selectedDistrictCurr = Rxn<String>();
  var selectedCityCurr = Rxn<String>();

  var selectedStatePerm = Rxn<String>();
  var selectedDistrictPerm = Rxn<String>();
  var selectedCityPerm = Rxn<String>();

  var selectedCityOfficeAd = Rxn<String>();
  var selectedDistrictOfficeAd = Rxn<String>();
  var selectedStateOfficeAd= Rxn<String>();

  RxList<city.Data> stateListPerm = <city.Data>[].obs;
  RxList<city.Data> stateListCurr = <city.Data>[].obs;
  RxList<city.Data> stateListOfficeAd = <city.Data>[].obs;


  RxList<dist.Data> districtListPerm = <dist.Data>[].obs;
  RxList<dist.Data> districtListCurr = <dist.Data>[].obs;
  RxList<dist.Data> districtListOfficeAd = <dist.Data>[].obs;

  RxList<city.Data> cityListPerm = <city.Data>[].obs;
  RxList<city.Data> cityListCurr = <city.Data>[].obs;
  RxList<city.Data> cityListOfficeAd = <city.Data>[].obs;


  int? getStateIdByName(String sName) {
    final states = leadDDController.getAllStateModel.value?.data;

    print("states----->dd--->${states}");
    print("sName----->dd--->${sName}");
    if (states == null || states.isEmpty) return null;

    final matchedState = states.firstWhere(
          (state) => state.stateName?.toLowerCase() == sName.toLowerCase(),
      orElse: () => stateModel.Data(id: -1),
    );
    print("matchedState.id----->dd--->${matchedState.id}");
    return matchedState.id != -1 ? matchedState.id : 0;
  }

  int? getDistrictIdByNameCurr(String dName) {
    //print("dName--dd------>${dName}");
    final dists = getDistrictByStateModelCurr.value?.data;

    dists!.forEach((ele){
      //print("ele--dd------>${ele.districtName}");
      //print("ele--dd------>${ele.id}");
    });
    if (dists == null || dists.isEmpty) return null;

    final matchedDist = dists.firstWhere(
          (dist) => dist.districtName?.toLowerCase() == dName.toLowerCase(),
      orElse: () => dist.Data(id: -1),

    );

   // print("matchedDist.id--dd------>${matchedDist.id}");
    return matchedDist.id != -1 ? matchedDist.id : null;
  }
  Future<void>   getDistrictByStateIdCurrApi({
    required stateId
  }) async {
    try {

      isDistrictLoadingCurr(true);


      var data = await DrawerApiService.getDistrictByStateIdApi(stateId: stateId);


      if(data['success'] == true){

        getDistrictByStateModelCurr.value= dist.GetDistrictByStateModel.fromJson(data);

        final List<dist.Data> districts = getDistrictByStateModelCurr.value?.data ?? [];
        districtListCurr.value = List<dist.Data>.from(districts);

        isDistrictLoadingCurr(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        getDistrictByStateModelCurr.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllStateApi:co applicant $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isDistrictLoadingCurr(false);
    } finally {

      isDistrictLoadingCurr(false);
    }
  }
  int? getDistrictIdByNamePerm(String dName) {
    print("dName coAp co--->${ dName}");
    final dists = getDistrictByStateModelPerm.value?.data;

    if (dists == null || dists.isEmpty) return null;

    final matchedDist = dists.firstWhere(
          (dist) => dist.districtName?.toLowerCase() == dName.toLowerCase(),
      orElse: () => dist.Data(id: -1),
    );


    return matchedDist.id != -1 ? matchedDist.id : null;
  }
 Future<void>  getDistrictByStateIdPermApi({
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
      print("Error getAllStateApi:coapplicant model $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isDistrictLoadingPerm(false);
    } finally {


      isDistrictLoadingPerm(false);
    }
  }


  Future<void>  getDistrictByStateIdOfficeAdApi({
    required stateId
  }) async {
    try {

      isDistrictLoadingOfficeAd(true);


      var data = await DrawerApiService.getDistrictByStateIdApi(stateId: stateId);


      if(data['success'] == true){

        getDistrictByStateModelOfficeAd.value= dist.GetDistrictByStateModel.fromJson(data);

        final List<dist.Data> districts = getDistrictByStateModelOfficeAd.value?.data ?? [];
        districtListOfficeAd.value = List<dist.Data>.from(districts);


        isDistrictLoadingOfficeAd(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getDistrictByStateModelOfficeAd.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error OfficeAd:coapplicant model $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isDistrictLoadingOfficeAd(false);
    } finally {


      isDistrictLoadingOfficeAd(false);
    }
  }

  int? getDistrictIdByNameOffAdd(String dName) {
    print("dName->${dName}");

    final dists = getDistrictByStateModelOfficeAd.value?.data;
    print("dists->${dists}");
    if (dists == null || dists.isEmpty) return null;

    final matchedDist = dists.firstWhere(
          (dist) => dist.districtName?.toLowerCase() == dName.toLowerCase(),
      orElse: () => dist.Data(id: -1),
    );


    return matchedDist.id != -1 ? matchedDist.id : null;
  }
/*  Future<void>  getDistrictByStateIdOfficeAdApi({
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
      print("Error getAllStateApi:coapplicant model $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isDistrictLoadingPerm(false);
    } finally {


      isDistrictLoadingPerm(false);
    }
  }*/

  Future<void>   getCityByDistrictIdCurrApi({
    required districtId
  }) async {
    try {

      isCityLoadingCurr(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModelCurr.value= city.GetCityByDistrictIdModel.fromJson(data);

        final List<city.Data> cities = getCityByDistrictIdModelCurr.value?.data ?? [];
        cityListCurr.value = List<city.Data>.from(cities);

        isCityLoadingCurr(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCityByDistrictIdModelCurr.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCityByDistrictId: $e");

      //ToastMessage.msg(AppText.somethingWentWrong);

      isCityLoadingCurr(false);
    } finally {


      isCityLoadingCurr(false);
    }
  }

  Future<void>   getCityByDistrictIdPermApi({
    required districtId
  }) async {
    try {

      isCityLoadingPerm(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModelPerm.value= city.GetCityByDistrictIdModel.fromJson(data);

        final List<city.Data> cities = getCityByDistrictIdModelPerm.value?.data ?? [];
        cityListPerm.value = List<city.Data>.from(cities);

        isCityLoadingPerm(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCityByDistrictIdModelPerm.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCityByDistrictId: $e");

     // ToastMessage.msg(AppText.somethingWentWrong);

      isCityLoadingPerm(false);
    } finally {


      isCityLoadingPerm(false);
    }
  }


  Future<void>   getCityByDistrictIdOfficeAdApi({
    required districtId
  }) async {
    try {

      isCityLoadingOfficeAd(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModelOfficeAd.value= city.GetCityByDistrictIdModel.fromJson(data);

        final List<city.Data> cities = getCityByDistrictIdModelOfficeAd.value?.data ?? [];
        cityListOfficeAd.value = List<city.Data>.from(cities);

        isCityLoadingOfficeAd(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCityByDistrictIdModelOfficeAd.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCityByDistrictId: $e");

    //  ToastMessage.msg(AppText.somethingWentWrong);

      isCityLoadingOfficeAd(false);
    } finally {


      isCityLoadingOfficeAd(false);
    }
  }


  void copyPresentToPermanentAddress() {
    // Text field values
    coApPermHouseFlatController.text = coApCurrHouseFlatController.text;
    coApPermBuildingNoController.text = coApCurrBuildingNoController.text;
    coApPermSocietyNameController.text = coApCurrSocietyNameController.text;
    coApPermLocalityController.text = coApCurrLocalityController.text;
    coApPermStreetNameController.text = coApCurrStreetNameController.text;
    coApPermPinCodeController.text = coApCurrPinCodeController.text;
    coApPermTalukaController.text = coApCurrTalukaController.text;


    // Copy state
    selectedStatePerm.value = selectedStateCurr.value;

    // Now fetch districts and wait for the lists to update
    getDistrictByStateIdPermApi(stateId: selectedStatePerm.value).then((_) {
     districtListPerm.value = List.from(districtListCurr);
      selectedDistrictPerm.value = selectedDistrictCurr.value;

      // Now fetch cities and wait for the city list to update
      getCityByDistrictIdPermApi(districtId: selectedDistrictPerm.value).then((_) {
        cityListPerm.value = List.from(cityListCurr);
        selectedCityPerm.value = selectedCityCurr.value;
      });
    });
  }

}
