import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../common/helper.dart';
import '../common/storage_service.dart';
import '../models/AdminSupervisorModel.dart';
import '../models/FunctionalSupervisorModel.dart';
import '../models/GetCampaignNameModel.dart';
import '../models/dashboard/GetAllBankModel.dart' as allBank;
import '../models/GetAllBranchByBankIdModel.dart';
import '../models/GetBankerRoleByLevelAndBankIdModel.dart';
import '../models/GetLevelOfBankerRoleModel.dart';
import '../models/dashboard/GetAllBranchBIModel.dart';
import '../models/dashboard/GetAllChannelModel.dart';
import '../models/dashboard/GetAllKsdplProductModel.dart' as ksdplProduct;
import '../models/dashboard/GetAllStateModel.dart' as stateModel;
import '../models/dashboard/GetCityByDistrictIdModel.dart';
import '../models/dashboard/GetDistrictByStateModel.dart';
import '../models/dashboard/GetProductListByBank.dart';
import '../models/leads/GetAllKsdplBranchModel.dart';
import '../models/leads/GetAllLeadStageModel.dart';
import '../models/loan_application/GetProductListByBankIdModel.dart' as prodList;
import '../services/drawer_api_service.dart';
import '../services/home_service.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/leads/GetAllLeadStageModel.dart' as stage;

class LeadDDController extends GetxController{
  var isLoading=false.obs;
  var banks = <Map<String, String>>[].obs; // List of banks [{id: "1", name: "Bank A"}]
  var getAllStateModel = Rxn<stateModel.GetAllStateModel>(); //
  var getDistrictByStateModel = Rxn<GetDistrictByStateModel>(); //
  var getCityByDistrictIdModel = Rxn<GetCityByDistrictIdModel>(); //
  var getAllBankModel = Rxn<allBank.GetAllBankModel>(); //
  var getAllKsdplProductModel = Rxn<ksdplProduct.GetAllKsdplProductModel>(); //
  var getProductListByBankIdModel = Rxn<prodList.GetProductListByBankIdModel>(); //
  var getProductListByBankModel = Rxn<GetProductListByBankModel>(); //
  var getAllKsdplBranchModel = Rxn<GetAllKsdplBranchModel>(); //
  var getAllLeadStageModel = Rxn<GetAllLeadStageModel>(); //
  var getAllBranchBIModel = Rxn<GetAllBranchBIModel>();
  var getAllChannelModel = Rxn<GetAllChannelModel>();
  var selectedState = Rxn<String>();
  var selectedDistrict = Rxn<String>();
  var selectedCity = Rxn<String>();
  var selectedBank = Rxn<String>();
  var selectedProdType = Rxn<String>();
  var currEmpStatus = Rxn<String>();
  var currEmpStList=[AppText.salaried, AppText.selfEmployed, AppText.unemployed, AppText.retired, AppText.student];
  var getCampaignNameModel = Rxn<GetCampaignNameModel>();
  var selectedCampaign = Rxn<String>();
  var selectedKsdplBr = Rxn<String>();
  var selectedStage = Rxn<String>();

  var selectedBankBranch = Rxn<String>();
  var selectedChannel = Rxn<String>();
  var selectedStageActive = RxnInt();

  var isStateLoading = false.obs;
  var isDistrictLoading = false.obs;
  var isCityLoading = false.obs;
  var isCampaignLoading = false.obs;
  var isKSDPLBrLoading = false.obs;
  var isBankLoading = false.obs;
  var isProductLoading = false.obs;
  var isLeadStageLoading = false.obs;
  var isBranchLoading = false.obs;
  var isChannelLoading = false.obs;
  var activeStatus = "".obs;


  var selectedStateCurr = Rxn<String>();
  var selectedDistrictCurr = Rxn<String>();
  var selectedCityCurr = Rxn<String>();

  var selectedStatePerm = Rxn<String>();
  var selectedDistrictPerm = Rxn<String>();
  var selectedCityPerm = Rxn<String>();

  /// new ids
  var selectedStateCurrId = Rxn<String>();
  var selectedDistrictCurrId = Rxn<String>();
  var selectedCityCurrv = Rxn<String>();

  var selectedStatePermId = Rxn<String>();
  var selectedDistrictPermId = Rxn<String>();
  var selectedCityPermId = Rxn<String>();

  /// mew ids end

  RxList<dist.Data> districtListPerm = <dist.Data>[].obs;
  RxList<dist.Data> districtListCurr = <dist.Data>[].obs;

  RxList<city.Data> cityListPerm = <city.Data>[].obs;
  RxList<city.Data> cityListCurr = <city.Data>[].obs;

  RxList<prodList.Data> prodListByBank = <prodList.Data>[].obs;
  var getDistrictByStateModelCurr = Rxn<GetDistrictByStateModel>(); //
  var getDistrictByStateModelPerm = Rxn<GetDistrictByStateModel>(); //
  var getDistrictByStateModelOfficeAd = Rxn<GetDistrictByStateModel>(); //

  var getCityByDistrictIdModelCurr = Rxn<GetCityByDistrictIdModel>(); //
  var getCityByDistrictIdModelPerm = Rxn<GetCityByDistrictIdModel>(); //
  var getCityByDistrictIdModelOfficeAd = Rxn<GetCityByDistrictIdModel>(); //

  RxList<allBank.Data> bankList = <allBank.Data>[].obs;

  RxList<ksdplProduct.Data> ksdplProductList = <ksdplProduct.Data>[].obs;
  var isStateLoadingCurr = false.obs;
  var isDistrictLoadingCurr = false.obs;
  var isCityLoadingCurr = false.obs;

  var isStateLoadingPerm = false.obs;
  var isDistrictLoadingPerm = false.obs;
  var isCityLoadingPerm = false.obs;


  ///04 Nov
  var selectedStateOfficeAd = Rxn<String>();
  var selectedDistrictOfficeAd = Rxn<String>();
  var selectedCityOfficeAd = Rxn<String>();

  var isStateLoadingOfficeAd = false.obs;
  var isDistrictLoadingOfficeAd = false.obs;
  var isCityLoadingOfficeAd= false.obs;

  RxList<dist.Data> districtListOfficeAd = <dist.Data>[].obs;
  RxList<city.Data> cityListOfficeAd = <city.Data>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("here KSD prod");
    getAllStateApi();
    getAllBankApi();
    getAllKsdplProductApi();
    getCampaignNameApi();
    getAllKsdplBranchApi();
    getAllLeadStageApi();
    getAllChannelListApi();
  }
  @override
  void onClose() {
    super.onClose();

    isLoading.value = false;
    banks.clear();

    getAllStateModel.value = null;
    getDistrictByStateModel.value = null;
    getCityByDistrictIdModel.value = null;
    getAllBankModel.value = null;
    getAllKsdplProductModel.value = null;
    getProductListByBankIdModel.value = null;
    getProductListByBankModel.value = null;
    getAllKsdplBranchModel.value = null;
    getAllLeadStageModel.value = null;
    getAllBranchBIModel.value = null;
    getAllChannelModel.value = null;
    getCampaignNameModel.value = null;

    selectedState.value = null;
    selectedDistrict.value = null;
    selectedCity.value = null;
    selectedBank.value = null;
    selectedProdType.value = null;
    currEmpStatus.value = null;
    selectedCampaign.value = null;
    selectedKsdplBr.value = null;
    selectedStage.value = null;
    selectedBankBranch.value = null;
    selectedChannel.value = null;
    selectedStageActive.value = 0;

    isStateLoading.value = false;
    isDistrictLoading.value = false;
    isCityLoading.value = false;
    isCampaignLoading.value = false;
    isKSDPLBrLoading.value = false;
    isBankLoading.value = false;
    isProductLoading.value = false;
    isLeadStageLoading.value = false;
    isBranchLoading.value = false;
    isChannelLoading.value = false;
    activeStatus.value = "";

    selectedStateCurr.value = null;
    selectedDistrictCurr.value = null;
    selectedCityCurr.value = null;

    selectedStatePerm.value = null;
    selectedDistrictPerm.value = null;
    selectedCityPerm.value = null;

    districtListPerm.clear();
    districtListCurr.clear();
    prodListByBank.clear();

    cityListPerm.clear();
    cityListCurr.clear();

    getDistrictByStateModelCurr.value = null;
    getDistrictByStateModelPerm.value = null;
    getCityByDistrictIdModelCurr.value = null;
    getCityByDistrictIdModelPerm.value = null;

    isStateLoadingCurr.value = false;
    isDistrictLoadingCurr.value = false;
    isCityLoadingCurr.value = false;
    isStateLoadingPerm.value = false;
    isDistrictLoadingPerm.value = false;
    isCityLoadingPerm.value = false;

    isStateLoadingOfficeAd = false.obs;
    isDistrictLoadingOfficeAd = false.obs;
    isCityLoadingOfficeAd= false.obs;

  }

  changeActiveStatus(String stage){
    if(stage=="4"){
      activeStatus.value="1";
    }else if(stage=="5"){
      activeStatus.value="0";
    }else if(stage=="6"){
      activeStatus.value="1";
    }else if(stage=="7"){
      activeStatus.value="0";
    }else if(stage=="13"){
      activeStatus.value="0";
    }else{
      activeStatus.value="0";
    }
  }
  List<stage.Data> getFilteredStagesByLeadStageId(String currentLeadStage) {
    try {
      int leadCode = int.tryParse(currentLeadStage) ?? 0;


      List<int> allowedStageIds;
      var rawRole = StorageService.get(StorageService.ROLE).toString();
      var role = rawRole.replaceAll('[', '').replaceAll(']', '');
      switch (leadCode) {
        case 2:
        case 3:
        case 5:
        case 13:
          allowedStageIds = [4, 5];
          break;
        case 4:
          role=="INDEPENDENT AREA HEAD"?allowedStageIds = [6, 7]:allowedStageIds = [4, 5]; //remove this line, added on 20 sep
        case 6:
        case 7:
          allowedStageIds = [6, 7];
          break;
        default:
          allowedStageIds = [];
      }

      final allStages = getAllLeadStageModel.value?.data ?? [];

      final filteredStages = allStages
          .where((lead) => lead.id != 1 && allowedStageIds.contains(lead.id))
          .toList();


      for (var ele in filteredStages) {
        print("Filtered stage: ${ele.stageName}");
      }

      return filteredStages;
    } catch (e) {

      return [];
    }
  }


  ///AIC stage only
  List<stage.Data> getAICStagesByLeadStageId(String currentLeadStage) {
    try {
      int leadCode = int.tryParse(currentLeadStage) ?? 0;


      List<int> allowedStageIds;
      var rawRole = StorageService.get(StorageService.ROLE).toString();
      var role = rawRole.replaceAll('[', '').replaceAll(']', '');
      switch (leadCode) {
        case 2:
        case 3:
        case 5:
        case 13:
          allowedStageIds = [4, 5];
          break;
        case 4:
          allowedStageIds = [4, 5]; //remove this line, added on 20 sep
        case 6:
        case 7:
          allowedStageIds = [6, 7];
          break;
        default:
          allowedStageIds = [];
      }

      final allStages = getAllLeadStageModel.value?.data ?? [];

      final filteredStages = allStages
          .where((lead) => lead.id != 1 && allowedStageIds.contains(lead.id))
          .toList();


      for (var ele in filteredStages) {
        print("Filtered stage: ${ele.stageName}");
      }

      return filteredStages;
    } catch (e) {

      return [];
    }
  }
  int? getStateIdByName(String sName) {
    final states = getAllStateModel.value?.data;

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
  Future<void>  getAllStateApi() async {
    try {
      isLoading(true);
      isStateLoading(true);


      var data = await DrawerApiService.getAllStateApi();


      if(data['success'] == true){

        getAllStateModel.value= stateModel.GetAllStateModel.fromJson(data);




          if (int.parse(getAllStateModel.value!.data![0].id.toString()) == 3) {
            selectedStageActive.value = 1;
          } else if (int.parse(getAllStateModel.value!.data![0].id.toString()) == 4) {
            selectedStageActive.value = 1;
          } else if (int.parse(getAllStateModel.value!.data![0].id.toString()) == 5) {
            selectedStageActive.value = 0;
          }  else if (int.parse(getAllStateModel.value!.data![0].id.toString()) == 6) {
            selectedStageActive.value = 1;
          } else if (int.parse(getAllStateModel.value!.data![0].id.toString()) == 7) {
            selectedStageActive.value = 0;
          }else if (int.parse(getAllStateModel.value!.data![0].id.toString()) == 13) {
           selectedStageActive.value = 0;
          }else {
            selectedStageActive.value = 0;
          }



        isLoading(false);
        isStateLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllStateModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllStateApi:lead_dd $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isStateLoading(false);
    } finally {

      isLoading(false);
      isStateLoading(false);
    }
  }


  void  getDistrictByStateIdApi({
    required stateId
  }) async {
    try {
      isLoading(true);
      isDistrictLoading(true);

      var data = await DrawerApiService.getDistrictByStateIdApi(stateId: stateId);

      if(data['success'] == true){

        getDistrictByStateModel.value= GetDistrictByStateModel.fromJson(data);

        final List<dist.Data> districts = getDistrictByStateModel.value?.data ?? [];
        districtListCurr.value = List<dist.Data>.from(districts);
        districtListPerm.value = List<dist.Data>.from(districts);

        isLoading(false);
        isDistrictLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
        getDistrictByStateModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllStateApi:leadcontroller $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isDistrictLoading(false);
    } finally {

      isLoading(false);
      isDistrictLoading(false);
    }
  }


  void  getCityByDistrictIdApi({
    required districtId
  }) async {
    try {
      isLoading(true);
      isCityLoading(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModel.value= GetCityByDistrictIdModel.fromJson(data);
        final List<city.Data> cities = getCityByDistrictIdModel.value?.data ?? [];
        cityListCurr.value = List<city.Data>.from(cities);


        isLoading(false);
        isCityLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCityByDistrictIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCityByDistrictId: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isCityLoading(false);
    } finally {

      isLoading(false);
    }
  }

  Future<void>  getAllBankApi() async {
    try {
      isLoading(true);
      isBankLoading(true);

      var data = await DrawerApiService.getAllBankApi();


      if(data['success'] == true){

        getAllBankModel.value= allBank.GetAllBankModel.fromJson(data);

        final List<allBank.Data> tempAllBank = getAllBankModel.value?.data ?? [];
        bankList.value = List<allBank.Data>.from(tempAllBank);

        isLoading(false);
        isBankLoading(false);
      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllBankModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllBankModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isBankLoading(false);
    } finally {

      isLoading(false);
      isBankLoading(false);
    }
  }

  Future<void>  getAllKsdplProductApi() async {
    try {
      isLoading(true);
      isProductLoading(true);

      var data = await DrawerApiService.getAllKsdplProductApi();


      if(data['success'] == true){

        getAllKsdplProductModel.value = ksdplProduct.GetAllKsdplProductModel.fromJson(data);


        final List<ksdplProduct.Data> tempAllPro = getAllKsdplProductModel.value?.data ?? [];
        ksdplProductList.value = List<ksdplProduct.Data>.from(tempAllPro);

        isLoading(false);
        isProductLoading(false);
      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        getAllKsdplProductModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllKsdplProductModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isProductLoading(false);
    } finally {

      isLoading(false);
      isProductLoading(false);
    }
  }

 /* Future<void>  getProductListByBankIdApi({required bankId}) async {
    try {

      isProductLoading(true);

      var data = await DrawerApiService.getProductListByBankIdApi(
          bankId: bankId.toString()
      );




      if(data['success'] == true){

        getAllKsdplProductModel.value= ksdplProduct.GetAllKsdplProductModel.fromJson(data);





        isProductLoading(false);
      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllKsdplProductModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getProductListByBankModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isProductLoading(false);
    } finally {


      isProductLoading(false);
    }
  }*/


  Future<void>  getProductListByBankIdApi({required bankId}) async {
    try {

      isProductLoading(true);

      var data = await DrawerApiService.getProductListByBankIdApi(
          bankId: bankId.toString()
      );




      if(data['success'] == true){

        getAllKsdplProductModel.value= ksdplProduct.GetAllKsdplProductModel.fromJson(data);
        getProductListByBankIdModel.value= prodList.GetProductListByBankIdModel.fromJson(data);
        final List<prodList.Data> prods = getProductListByBankIdModel.value?.data ?? [];
        prodListByBank.value = List<prodList.Data>.from(prods);




        isProductLoading(false);
      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllKsdplProductModel.value=null;
        getProductListByBankIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getProductListByBankModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isProductLoading(false);
    } finally {


      isProductLoading(false);
    }
  }

  void  getCampaignNameApi() async {
    print('here call co applicant job ');
    try {

      isLoading(true);
      isCampaignLoading(true);
      var data = await DrawerApiService.getCampaignNameApi();


      if(data['success'] == true){

        getCampaignNameModel.value= GetCampaignNameModel.fromJson(data);




        isLoading(false);
        isCampaignLoading(false);
      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCampaignNameModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCampaignNameModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isCampaignLoading(false);
    } finally {

      isLoading(false);
      isCampaignLoading(false);
    }
  }

  void  getAllKsdplBranchApi() async {
    try {
      isLoading(true);
      isKSDPLBrLoading(true);

      var data = await DrawerApiService.getAllKsdplBranchApi();


      if(data['success'] == true){

        getAllKsdplBranchModel.value= GetAllKsdplBranchModel.fromJson(data);




        isLoading(false);
        isKSDPLBrLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllKsdplBranchModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllKsdplBranchModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isKSDPLBrLoading(false);
    } finally {

      isLoading(false);
      isKSDPLBrLoading(false);
    }
  }

  void  getAllLeadStageApi() async {
    try {
      isLoading(true);
      isLeadStageLoading(true);


      var data = await DrawerApiService.getAllLeadStageApi();


      if(data['success'] == true){

        getAllLeadStageModel.value= GetAllLeadStageModel.fromJson(data);

      /*  getAllLeadStageModel.value!.data?.forEach((stage) {
          if (stage.id == 3) {
            selectedStageActive.value = 1;
          } else if (stage.id == 4) {
            selectedStageActive.value = 1;
          } else if (stage.id == 5) {
            selectedStageActive.value = 0;
          }  else if (stage.id == 6) {
            selectedStageActive.value = 1;
          } else if (stage.id == 7) {
            selectedStageActive.value = 0;
          }else if (stage.id == 13) {
            selectedStageActive.value = 0;
          }else {

          }
        });*/





        isLoading(false);
        isLeadStageLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllLeadStageModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllLeadStageModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isLeadStageLoading(false);
    } finally {

      isLoading(false);
      isLeadStageLoading(false);
    }
  }


  Future<void>  getAllBranchByBankIdApi({
    required bankId
  }) async {
    try {
      isLoading(true);
      isBranchLoading(true);
      print('bankID check${bankId}');


      var data = await DrawerApiService.getAllBranchByBankIdApi(bankId: bankId);


      if(data['success'] == true){

        getAllBranchBIModel.value= GetAllBranchBIModel.fromJson(data);

        isLoading(false);
        isBranchLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllBranchBIModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllBranchByBankIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      isBranchLoading(false);
    } finally {

      isLoading(false);
      isBranchLoading(false);
    }
  }

  void  getAllChannelListApi() async {
    try {

      isChannelLoading(true);


      var data = await DrawerApiService.getAllChannelListApi();


      if(data['success'] == true){

        getAllChannelModel.value= GetAllChannelModel.fromJson(data);


        isChannelLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllChannelModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllChannel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isChannelLoading(false);
    } finally {


      isChannelLoading(false);
    }
  }

  int? getDistrictIdByNameCurr(String dName) {
  //print("dName--dd------>${dName}");
    final dists = getDistrictByStateModelCurr.value?.data;

  dists!.forEach((ele){
   // print("ele--dd------>${ele.districtName}");
   // print("ele--dd------>${ele.id}");
  });
    if (dists == null || dists.isEmpty) return null;

    final matchedDist = dists.firstWhere(
          (dist) => dist.districtName?.toLowerCase() == dName.toLowerCase(),
      orElse: () => dist.Data(id: -1),

    );

 // print("matchedDist.id--dd------>${matchedDist.id}");
    return matchedDist.id != -1 ? matchedDist.id : null;
  }
  ///I am doing it for current and permanent address
  Future<void> getDistrictByStateIdCurrApi({
    required stateId
  }) async {
    try {

      print("stateId___>${stateId}");
      print("stateId___>here am facing big problem");

      isDistrictLoadingCurr(true);


      var data = await DrawerApiService.getDistrictByStateIdApi(stateId: stateId);


      if(data['success'] == true){

        getDistrictByStateModelCurr.value= GetDistrictByStateModel.fromJson(data);

        final List<dist.Data> districts = getDistrictByStateModelCurr.value?.data ?? [];
        districtListCurr.value = List<dist.Data>.from(districts);


        isDistrictLoadingCurr(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getDistrictByStateModelCurr.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getDistrictByStateIdCurrApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isDistrictLoadingCurr(false);
    } finally {


      isDistrictLoadingCurr(false);
    }
  }
  int? getDistrictIdByNamePerm(String dName) {

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

    print('state id is :'+stateId);
    try {

      isDistrictLoadingPerm(true);


      var data = await DrawerApiService.getDistrictByStateIdApi(stateId: stateId);


      if(data['success'] == true){

        getDistrictByStateModelPerm.value= GetDistrictByStateModel.fromJson(data);

        final List<dist.Data> districts = getDistrictByStateModelPerm.value?.data ?? [];
        districtListPerm.value = List<dist.Data>.from(districts);


        isDistrictLoadingPerm(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getDistrictByStateModelPerm.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllStateApi:lead controller ______ $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isDistrictLoadingPerm(false);
    } finally {


      isDistrictLoadingPerm(false);
    }
  }


  Future<void>  getDistrictByStateIdOfficeAdApi({
    required stateId
  }) async {

    print('state id is :'+stateId);
    try {

      isDistrictLoadingOfficeAd(true);


      var data = await DrawerApiService.getDistrictByStateIdApi(stateId: stateId);


      if(data['success'] == true){

        getDistrictByStateModelOfficeAd.value= GetDistrictByStateModel.fromJson(data);

        final List<dist.Data> districts = getDistrictByStateModelOfficeAd.value?.data ?? [];
        districtListOfficeAd.value = List<dist.Data>.from(districts);


        isDistrictLoadingOfficeAd(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getDistrictByStateModelOfficeAd.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getDistrictByStateIdOfficeAdApi:lead controller ______ $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isDistrictLoadingOfficeAd(false);
    } finally {


      isDistrictLoadingOfficeAd(false);
    }
  }


  Future<void>   getCityByDistrictIdCurrApi({
    required districtId
  }) async {
    print("getCityByDistrictIdCurrApi----->");
    try {

      isCityLoadingCurr(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModelCurr.value= GetCityByDistrictIdModel.fromJson(data);

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

      ToastMessage.msg(AppText.somethingWentWrong);

      isCityLoadingCurr(false);
    } finally {


      isCityLoadingCurr(false);
    }
  }

  Future<void>  getCityByDistrictIdPermApi({
    required districtId
  }) async {
    try {

      isCityLoadingPerm(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModelPerm.value= GetCityByDistrictIdModel.fromJson(data);

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

      ToastMessage.msg(AppText.somethingWentWrong);

      isCityLoadingPerm(false);
    } finally {


      isCityLoadingPerm(false);
    }
  }


  Future<void>  getCityByDistrictIdOfficeAdApi({
    required districtId
  }) async {
    try {

      isCityLoadingOfficeAd(true);


      var data = await DrawerApiService.getCityByDistrictIdApi(districtId: districtId);


      if(data['success'] == true){

        getCityByDistrictIdModelOfficeAd.value= GetCityByDistrictIdModel.fromJson(data);

        final List<city.Data> cities = getCityByDistrictIdModelOfficeAd.value?.data ?? [];
        cityListOfficeAd.value = List<city.Data>.from(cities);

        isCityLoadingOfficeAd(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCityByDistrictIdModelOfficeAd.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCityByDistrictIdOfficeAdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isCityLoadingOfficeAd(false);
    } finally {


      isCityLoadingOfficeAd(false);
    }
  }


}