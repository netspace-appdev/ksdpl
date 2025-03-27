
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetCountOfLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/dashboard/GetUpcomingDateOfBirthModel.dart';
import '../../models/dashboard/getBreakingNewsModel.dart';
import '../../services/dashboard_api_service.dart';


class SplashController extends GetxController {

  var isLoading = false.obs;
  GetEmployeeModel? getEmployeeModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var phone=StorageService.get(StorageService.PHONE);
    getEmployeeByPhoneNumberApi(phone: phone.toString());


  }

  void  getEmployeeByPhoneNumberApi({
    required String phone,

  }) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getEmployeeByPhoneNumberApi(phone: phone,);


      if(data['success'] == true){

        getEmployeeModel= GetEmployeeModel.fromJson(data);

        ToastMessage.msg(getEmployeeModel!.message!);
        StorageService.put(StorageService.EMPLOYEE_ID, getEmployeeModel!.data!.id.toString());
        isLoading(false);
        //getCountOfLeadsApi(employeeId: getEmployeeModel!.data!.id.toString(), applyDateFilter: "false");

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

}
