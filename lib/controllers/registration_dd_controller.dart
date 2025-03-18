import 'package:get/get.dart';

import '../common/helper.dart';
import '../models/AdminSupervisorModel.dart';
import '../models/FunctionalSupervisorModel.dart';
import '../models/dashboard/GetAllBankModel.dart';
import '../models/GetAllBranchByBankIdModel.dart';
import '../models/GetBankerRoleByLevelAndBankIdModel.dart';
import '../models/GetLevelOfBankerRoleModel.dart';
import '../services/home_service.dart';

class RegistrationDDController extends GetxController{
  var isLoading=false.obs;
  var banks = <Map<String, String>>[].obs; // List of banks [{id: "1", name: "Bank A"}]
  var branches = <Map<String, String>>[].obs;
  var roleLevelList = <Map<String, String>>[].obs;
  var roleList = <Map<String, String>>[].obs;
  var funcSupervisorList = <Map<String, String>>[].obs;
  var adminSupervisorList = <Map<String, String>>[].obs;

  var selectedBank = Rxn<String>(); // Stores selected bank ID
  var selectedBranch = Rxn<String>();
  var selectedRoleLevel = Rxn<String>();
  var selectedRole = Rxn<String>();
  var selectedFuncSupervisor = Rxn<String>();
  var selectedAdminSupervisor = Rxn<String>();

  GetAllBankModel? getAllBankModel;
  GetAllBranchByBankIdModel? getAllBranchByBankIdModel;
  GetLevelOfBankerRoleModel? getLevelOfBankerRoleModel;
  GetBankerRoleByLevelAndBankIdModel? getBankerRoleByLevelAndBankIdModel;
  FunctionalSupervisorModel? functionalSupervisorModel;
  AdminSupervisorModel? adminSupervisorModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // fetchAllBankApi();
   // getLevelOfBankerRoleApi();
  }

/*  void fetchAllBankApi() async {
    try {
      isLoading(true);


      var data = await ApiService.getAllBankApi();


      if(data['success'] == true){
        getAllBankModel= GetAllBankModel.fromJson(data);
        banks.value = getAllBankModel!.data!.map((bank) {
          return {
            "id": bank.id.toString(),  // Convert ID to String
            "name": bank.bankName ?? "Unknown Bank"  // Handle null case
          };
        }).toList();



        isLoading(false);
        ToastMessage.msg(getAllBankModel!.message!);

        
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error here: $e");
      // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }*/

  Future<void>  getAllBranchByBankIdApi(String bankId) async {
    print("getAllBranchByBankIdApi");

    try {
      isLoading(true);


      var data = await ApiService.getAllBranchByBankIdApi(bankId);


      if(data['success'] == true){


        getAllBranchByBankIdModel= GetAllBranchByBankIdModel.fromJson(data);
        if(getAllBranchByBankIdModel!.data!.isNotEmpty){

          branches.value = getAllBranchByBankIdModel!.data!.map((br) {
            return {
              "id": br.id.toString(),  // Convert ID to String
              "name": br.branchName ?? "Unknown Branch"  // Handle null case
            };
          }).toList();
        }else{

          selectedBranch.value="";
          branches.clear();
        }



        isLoading(false);
        ToastMessage.msg(getAllBranchByBankIdModel!.message!);


      }else{
        selectedBranch=Rxn<String>();
        branches.clear();
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error here: $e");
      // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(getAllBranchByBankIdModel!.message!);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void getLevelOfBankerRoleApi() async {
    try {
      isLoading(true);


      var data = await ApiService.getLevelOfBankerRoleApi();


      if(data['success'] == true){
        getLevelOfBankerRoleModel= GetLevelOfBankerRoleModel.fromJson(data);



        if(getLevelOfBankerRoleModel!.data!.isNotEmpty){
          roleLevelList.value = getLevelOfBankerRoleModel!.data!.map((rl) {
            return {
              "id": rl.id.toString(),  // Convert ID to String
              "name": rl.bankRoleLevel1 ?? "Unknown role level"  // Handle null case
            };
          }).toList();


        }
        isLoading(false);
        ToastMessage.msg(getLevelOfBankerRoleModel!.message!);


      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error : $e");
      // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void getBankerRoleByLevelAndBankIdApi(String levelId, String bankId) async {
    try {
      isLoading(true);


      var data = await ApiService.getBankerRoleByLevelAndBankIdApi(levelId,bankId);


      if(data['success'] == true){
        roleList.clear();
        selectedRole= Rxn<String>();



        getBankerRoleByLevelAndBankIdModel= GetBankerRoleByLevelAndBankIdModel.fromJson(data);



        if(getBankerRoleByLevelAndBankIdModel!.data!.isNotEmpty){
          roleList.value = getBankerRoleByLevelAndBankIdModel!.data!.map((rl2) {
            return {
              "id": rl2.id.toString(),  // Convert ID to String
              "name": rl2.originalRole ?? "Unknown role",  // Handle null case
              "shortRole": rl2.shortRole ?? "Unknown short Role"  // Handle null case
            };
          }).toList();


        }
        isLoading(false);
        ToastMessage.msg(getBankerRoleByLevelAndBankIdModel!.message!);


      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getLevelOfBankerRoleApi: $e");
      // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  Future<void>  functionalSupervisorApi(String bankId, String branchId,String shortName, String status) async {
    try {
      isLoading(true);


      var data = await ApiService. functionalSupervisorApi(bankId, branchId,shortName,status);


      if(data['success'] == true){

        functionalSupervisorModel= FunctionalSupervisorModel.fromJson(data);



        if(functionalSupervisorModel!.data!.isNotEmpty){
          funcSupervisorList.value = functionalSupervisorModel!.data!.map((fs) {
            return {
              "id": fs.id.toString(),  // Convert ID to String
              "name": fs.bankerName ?? AppText.unknownFunctionalSupervisor,  // Handle null case
              "contact": fs.contactNo ?? AppText.unknownContact,  // Handle null case
              "email": fs.email ?? AppText.unknownEmail  // Handle null case
            };
          }).toList();


        }
        isLoading(false);
        ToastMessage.msg(functionalSupervisorModel!.message!);


      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error functionalSupervisorApi: $e");
      // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  Future<void>  adminSupervisorApi(String bankId, String branchId,String shortName) async {
    try {
      isLoading(true);


      var data = await ApiService. adminSupervisorApi(bankId, branchId,shortName);


      if(data['success'] == true){

        adminSupervisorModel= AdminSupervisorModel.fromJson(data);



        if(adminSupervisorModel!.data!.isNotEmpty){
          adminSupervisorList.value = adminSupervisorModel!.data!.map((fs) {
            return {
              "id": fs.id.toString(),  // Convert ID to String
              "name": fs.bankerName ?? AppText.unknownAdminSupervisor,  // Handle null case
              "contact": fs.contactNo ?? AppText.unknownContact,  // Handle null case
              "email": fs.email ?? AppText.unknownEmail  // Handle null case
            };
          }).toList();


        }
        isLoading(false);
        ToastMessage.msg(adminSupervisorModel!.message!);


      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error adminSupervisorApi: $e");
      // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

}