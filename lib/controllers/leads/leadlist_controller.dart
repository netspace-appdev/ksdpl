
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetAllLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/drawer/UpdateLeadStageModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';


class LeadListController extends GetxController {

  var isLoading = false.obs;
  // GetAllLeadsModel? getAllLeadsModel;
  var getAllLeadsModel = Rxn<GetAllLeadsModel>(); //
  var getLeadDetailModel = Rxn<GetLeadDetailModel>(); //
  UpdateLeadStageModel? updateLeadStageModel;

  var interestLeadsCheck = false.obs; // Observable variable
  var assignedLeadsCheck = true.obs; // Observable variable
  var leadCode="2".obs;
  var leadStageName="Assigned Leads".obs;
  var leadStageName2="Assigned Leads".obs;

  var selectedIndex = (0).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var eId=StorageService.get(StorageService.EMPLOYEE_ID);
    getAllLeadsApi(
      leadStage: leadCode.value,
      employeeId:eId.toString()
    );

  }

  void toggleCheckboxInterested() {
    interestLeadsCheck.value = !interestLeadsCheck.value; // Toggle checkbox state
    assignedLeadsCheck.value = !assignedLeadsCheck.value;
    if(interestLeadsCheck.value){
      leadCode.value="4";
      leadStageName.value="Interested Leads";
      var eId=StorageService.get(StorageService.EMPLOYEE_ID);
      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.toString()
      );
    }
  }

  void toggleCheckboxAssigned() {
    assignedLeadsCheck.value = !assignedLeadsCheck.value; // Toggle checkbox state
    interestLeadsCheck.value = !interestLeadsCheck.value;
    if(assignedLeadsCheck.value){
      leadCode.value="2";
      leadStageName.value="Assigned Leads";
      var eId=StorageService.get(StorageService.EMPLOYEE_ID);
      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.toString()
      );
    }
  }


  void selectCheckbox(int index) {
    var eId=StorageService.get(StorageService.EMPLOYEE_ID);
    /*if (selectedIndex.value == index) {
      selectedIndex.value = -1; // Unselect if clicked again
    } else {
      selectedIndex.value = index; // Select new checkbox
    }*/
    selectedIndex.value = index;
    if( selectedIndex.value==0){
      leadCode.value="2";
      leadStageName.value="Assigned Leads";

    }else if(selectedIndex.value==1){
      leadCode.value="4";
      leadStageName.value="Interested Leads";
    }else if(selectedIndex.value==2){
      leadCode.value="5";
      leadStageName.value="Not Interested Leads";
    }
  }

  void filterSubmit(){
    var eId=StorageService.get(StorageService.EMPLOYEE_ID);
    getAllLeadsApi(
        leadStage: leadCode.value,
        employeeId:eId.toString()
    );
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
        leadStageName2.value=leadStageName.value;


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        leadStageName2.value=leadStageName.value;
        getAllLeadsModel.value=null;
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
          leadStage: leadCode.value,
          employeeId:eId.toString()
      );

      isLoading(false);
    }
  }

//change it
  void  getLeadDetailByIdApi({
    required String leadId,
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getLeadDetailByIdApi(
        leadId:leadId,
      );


      if(data['success'] == true){

        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);

        ToastMessage.msg(getLeadDetailModel!.value!.message!);



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


}
