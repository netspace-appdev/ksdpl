
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetAllLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/drawer/UpdateLeadStageModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';


class LeadListController extends GetxController {

  var isLoading = false.obs;
  // GetAllLeadsModel? getAllLeadsModel;
  var getAllLeadsModel = Rxn<GetAllLeadsModel>(); // ✅ Making it observable
  UpdateLeadStageModel? updateLeadStageModel;

  var interestLeadsCheck = false.obs; // Observable variable


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var eId=StorageService.get(StorageService.EMPLOYEE_ID);
    getAllLeadsApi(
      leadStage: "2",
      employeeId:eId.toString()
    );

  }

  void toggleCheckbox() {
    interestLeadsCheck.value = !interestLeadsCheck.value; // Toggle checkbox state
  }


  void  getAllLeadsApi({
    required String employeeId,
    required String leadStage,

  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getAllLeadsApi(
        employeeId:employeeId,
        leadStage: leadStage
      );


      if(data['success'] == true){

        getAllLeadsModel.value= GetAllLeadsModel.fromJson(data);

        ToastMessage.msg(getAllLeadsModel!.value!.message!);



        isLoading(false);

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



  void  updateLeadStageApi({
    required id,
    required stage,
    required active,

  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.updateLeadStageApi(
          id:id,
          stage: stage,
          active: active
      );


      if(data['success'] == true){

        updateLeadStageModel= UpdateLeadStageModel.fromJson(data);

        ToastMessage.msg(updateLeadStageModel!.message!);

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error updateLeadStageApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {
      print("run hua");


      var eId=StorageService.get(StorageService.EMPLOYEE_ID);
      getAllLeadsApi(
          leadStage: "2",
          employeeId:eId.toString()
      );

      isLoading(false);
    }
  }


}
