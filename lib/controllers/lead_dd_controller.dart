import 'package:get/get.dart';

import '../common/helper.dart';
import '../models/AdminSupervisorModel.dart';
import '../models/FunctionalSupervisorModel.dart';
import '../models/GetAllBankModel.dart';
import '../models/GetAllBranchByBankIdModel.dart';
import '../models/GetBankerRoleByLevelAndBankIdModel.dart';
import '../models/GetLevelOfBankerRoleModel.dart';
import '../models/dashboard/GetAllStateModel.dart';
import '../models/dashboard/GetDistrictByStateModel.dart';
import '../services/drawer_api_service.dart';
import '../services/home_service.dart';

class LeadDDController extends GetxController{
  var isLoading=false.obs;
  var banks = <Map<String, String>>[].obs; // List of banks [{id: "1", name: "Bank A"}]
  var getAllStateModel = Rxn<GetAllStateModel>(); //
  var getDistrictByStateModel = Rxn<GetDistrictByStateModel>(); //
  var selectedState = Rxn<String>();
  var selectedDistrict = Rxn<String>();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fetchAllBankApi();
    // getLevelOfBankerRoleApi();
    getAllStateApi();
  }

  void  getAllStateApi() async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getAllStateApi();


      if(data['success'] == true){

        getAllStateModel.value= GetAllStateModel.fromJson(data);

        ToastMessage.msg(getAllStateModel!.value!.message!);


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

        ToastMessage.msg(getDistrictByStateModel!.value!.message!);


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



}