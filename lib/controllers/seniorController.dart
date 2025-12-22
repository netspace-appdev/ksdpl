import 'package:get/get.dart';


import '../common/helper.dart';
import '../models/GetSeniorListModel.dart';
import '../models/JobRoleModelResponse.dart';
import '../services/product_service.dart';

class SeniorScreenController extends GetxController{

  /// Loader
  final isLoadingMainScreen = false.obs;

  final Rxn<GetSeniorListModel> seniorListModel = Rxn<GetSeniorListModel>();
  final Rxn<JobRoleModelResponse> jobRoleListModel = Rxn<JobRoleModelResponse>();

  final Set<String> excludedRoles = {
    "INDEPENDENT BUSINESS MANAGER",
    "CHANNEL BUSINESS MANAGER",
  };

  List<Data> get seniorFilteredList {
    final list = seniorListModel.value?.data ?? [];

    return list.where((item) {
      final role = item.jobRole?.trim();
      return role == null || !excludedRoles.contains(role);
    }).toList();
  }


  List<JobRoleData> get jobRoleFiltered {
    final list = jobRoleListModel.value?.data ?? [];

    return list.where((item) {
      final role = item.name?.trim().toUpperCase();
      return role != null && !excludedRoles.contains(role);
    }).toList();


  }


  final selectedState = Rxn<String>();
  final selectedDistrict = Rxn<String>();
  final selectedCity = Rxn<String>();

  var selectedChannel = Rxn<int>();
  var selectedJobroleId = Rxn<String>();
  final isLoadingProductCategory = false.obs;



  Future<void> getAllSeniorListApi() async {
    try {
      isLoadingMainScreen.value = true;

      final data = await ProductService.getAllSeniorListRequestApi();

      if (data['success'] == true) {
        seniorListModel.value = GetSeniorListModel.fromJson(data);
      } else {
        ToastMessage.msg(
          data['message'] ?? AppText.somethingWentWrong,
        );
      }
    } catch (e) {
      print("Error getAllSeniorListApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoadingMainScreen.value = false;
    }
  }

  void filterSubmit() {
    /// Filtering already handled via getter
    /// Just call update() or rely on Obx
  }
}