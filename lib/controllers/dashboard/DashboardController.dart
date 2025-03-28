
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetCountOfLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/dashboard/GetUpcomingDateOfBirthModel.dart';
import '../../models/dashboard/getBreakingNewsModel.dart';
import '../../services/dashboard_api_service.dart';


class DashboardController extends GetxController {

  var isLoading = false.obs;
  GetEmployeeModel? getEmployeeModel;
  var getCountOfLeadsModel = Rxn<GetCountOfLeadsModel>(); //
  var getBreakingNewsModel = Rxn<GetBreakingNewsModel>(); //
  var getUpcomingDateOfBirthModel = Rxn<GetUpcomingDateOfBirthModel>(); //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var phone=StorageService.get(StorageService.PHONE);
    getEmployeeByPhoneNumberApi(phone: phone.toString());

    getBreakingNewsApi();
    getUpcomingDateOfBirthApi();
  }

  void  getEmployeeByPhoneNumberApi({
    required String phone,

  }) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getEmployeeByPhoneNumberApi(phone: phone,);


      if(data['success'] == true){

        getEmployeeModel= GetEmployeeModel.fromJson(data);


        StorageService.put(StorageService.EMPLOYEE_ID, getEmployeeModel!.data!.id.toString());
        isLoading(false);
        getCountOfLeadsApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: "false");

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getEmployeeByPhoneNumberApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }



  void  getCountOfLeadsApi({
    required employeeId,
    required applyDateFilter,

  }) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getCountOfLeadsApi(
        employeeId:employeeId,
        applyDateFilter:applyDateFilter,
      );


      if(data['success'] == true){

        getCountOfLeadsModel.value= GetCountOfLeadsModel.fromJson(data);





        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCountOfLeadsModel.value=null;
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

  void  getBreakingNewsApi() async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getBreakingNewsApi();


      if(data['success'] == true){

        getBreakingNewsModel.value= GetBreakingNewsModel.fromJson(data);





        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getBreakingNewsModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getBreakingNews: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getUpcomingDateOfBirthApi() async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getUpcomingDateOfBirthApi();


      if(data['success'] == true){

        getUpcomingDateOfBirthModel.value= GetUpcomingDateOfBirthModel.fromJson(data);





        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getUpcomingDateOfBirthModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getUpcomingDateOfBirthModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }
}
