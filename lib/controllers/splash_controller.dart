
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

 // var isLoading = false.obs;
  GetEmployeeModel? getEmployeeModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }



  void checkTokenAndNavigate() async {
    bool isValid = await DashboardApiService.validateToken();

    if (isValid) {
      Get.offAllNamed("/bottomNavbar");// or Product List screen // User is logged in
    } else {
      // Clear token or user data
      StorageService.delete(StorageService.TOKEN); // Clear invalid token

      // Optional toast
      ToastMessage.msg("Session expired. Please login again.");

      Get.offAllNamed("/login");
    }
  }


}
