import 'package:get/get.dart';

import '../common/helper.dart';
import '../models/AdminSupervisorModel.dart';
import '../models/FunctionalSupervisorModel.dart';
import '../models/GetCampaignNameModel.dart';
import '../models/dashboard/GetAllBankModel.dart';
import '../models/GetAllBranchByBankIdModel.dart';
import '../models/GetBankerRoleByLevelAndBankIdModel.dart';
import '../models/GetLevelOfBankerRoleModel.dart';
import '../models/dashboard/GetAllKsdplProductModel.dart';
import '../models/dashboard/GetAllStateModel.dart';
import '../models/dashboard/GetCityByDistrictIdModel.dart';
import '../models/dashboard/GetDistrictByStateModel.dart';
import '../models/dashboard/GetProductListByBank.dart';
import '../services/drawer_api_service.dart';
import '../services/home_service.dart';

class LeadDDController extends GetxController{
  var isLoading=false.obs;
  var banks = <Map<String, String>>[].obs; // List of banks [{id: "1", name: "Bank A"}]
  var getAllStateModel = Rxn<GetAllStateModel>(); //
  var getDistrictByStateModel = Rxn<GetDistrictByStateModel>(); //
  var getCityByDistrictIdModel = Rxn<GetCityByDistrictIdModel>(); //
  var getAllBankModel = Rxn<GetAllBankModel>(); //
  var getAllKsdplProductModel = Rxn<GetAllKsdplProductModel>(); //
  var getProductListByBankModel = Rxn<GetProductListByBankModel>(); //
  var selectedState = Rxn<String>();
  var selectedDistrict = Rxn<String>();
  var selectedCity = Rxn<String>();
  var selectedBank = Rxn<String>();
  var selectedProdType = Rxn<String>();
  var currEmpStatus = Rxn<String>();
  var currEmpStList=[AppText.employed, AppText.selfEmployed, AppText.unemployed, AppText.retired, AppText.student];
  var getCampaignNameModel = Rxn<GetCampaignNameModel>();
  var selectedCampaign = Rxn<String>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllStateApi();
    getAllBankApi();
    getAllKsdplProductApi();
    getCampaignNameApi();
  }

  void  getAllStateApi() async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getAllStateApi();


      if(data['success'] == true){

        getAllStateModel.value= GetAllStateModel.fromJson(data);




        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllStateModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllStateApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  void  getDistrictByStateIdApi({
    required stateId
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getDistrictByStateIdApi(stateId: stateId);


      if(data['success'] == true){

        getDistrictByStateModel.value= GetDistrictByStateModel.fromJson(data);




        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getDistrictByStateModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllStateApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  void  getCityByDistrictIdApi({
    required districtId
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModel.value= GetCityByDistrictIdModel.fromJson(data);


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCityByDistrictIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCityByDistrictId: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getAllBankApi() async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getAllBankApi();


      if(data['success'] == true){

        getAllBankModel.value= GetAllBankModel.fromJson(data);


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllBankModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllBankModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getAllKsdplProductApi() async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getAllKsdplProductApi();


      if(data['success'] == true){

        getAllKsdplProductModel.value= GetAllKsdplProductModel.fromJson(data);




        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllKsdplProductModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllKsdplProductModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getProductListByBankIdApi({required bankId}) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getProductListByBankIdApi(
        bankId: bankId
      );


      if(data['success'] == true){

        getAllKsdplProductModel.value= GetAllKsdplProductModel.fromJson(data);




        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllKsdplProductModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getProductListByBankModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getCampaignNameApi() async {
    try {

      isLoading(true);

      var data = await DrawerApiService.getCampaignNameApi();


      if(data['success'] == true){

        getCampaignNameModel.value= GetCampaignNameModel.fromJson(data);




        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCampaignNameModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCampaignNameModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }
}