
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetAllLeadsModel.dart';
import '../../models/dashboard/GetEmployeeModel.dart';
import '../../models/dashboard/LeadMoveToCommonTaskModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/drawer/UpdateLeadStageModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

class LeadListController extends GetxController {

  var isLoading = false.obs;
  // GetAllLeadsModel? getAllLeadsModel;
  var getAllLeadsModel = Rxn<GetAllLeadsModel>(); //
  var getLeadDetailModel = Rxn<GetLeadDetailModel>(); //
  UpdateLeadStageModel? updateLeadStageModel;
  LeadMoveToCommonTaskModel? leadMoveToCommonTaskModel;
  var interestLeadsCheck = false.obs; // Observable variable
  var assignedLeadsCheck = true.obs; // Observable variable
  var leadCode="2".obs;
  var leadStageName="Fresh Leads".obs;
  var leadStageName2="Fresh Leads".obs;
  var fromWhere="".obs;
  var stateIdMain="0".obs;
  var distIdMain="0".obs;
  var cityIdMain="0".obs;

  var selectedIndex = (0).obs;

  var eId="".obs;
  final TextEditingController openPollPercentController = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    eId.value=StorageService.get(StorageService.EMPLOYEE_ID).toString();
    getAllLeadsApi(
      leadStage: leadCode.value,
      employeeId:eId.toString(),
        stateId:stateIdMain.value,
        distId: distIdMain.value,
        cityId: cityIdMain.value
    );

  }


  void makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {

      ToastMessage.msg(AppText.couldNotCall);
    }
  }

  void openWhatsApp({required String phoneNumber, String message = ""}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {

      ToastMessage.msg(AppText.couldNotWA);
    }
  }

  void sendSMS({required String phoneNumber, required String message}) async {
    String smsUrl = "sms:$phoneNumber?body=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(smsUrl))) {
      await launchUrl(Uri.parse(smsUrl));
    } else {
      ToastMessage.msg(AppText.couldNotMsg);
    }
  }


  void selectCheckbox(int index) {

    selectedIndex.value = index;
    if( selectedIndex.value==0){
      leadCode.value="2";
      leadStageName.value="Fresh Leads";

    }else if(selectedIndex.value==1){
      leadCode.value="4";
      leadStageName.value="Interested Leads";
    }else if(selectedIndex.value==2){
      leadCode.value="5";
      leadStageName.value="Not Interested Leads";
    }
    else if(selectedIndex.value==3){
      leadCode.value="6";
      leadStageName.value="Doable Leads";
    }
    else if(selectedIndex.value==4){
      leadCode.value="7";
      leadStageName.value="Not Doable Leads";
    }
  }

  void filterSubmit(){
    var eId=StorageService.get(StorageService.EMPLOYEE_ID);
    getAllLeadsApi(
        leadStage: leadCode.value,
        employeeId:eId.toString(),
        stateId:stateIdMain.value,
        distId: distIdMain.value,
        cityId: cityIdMain.value
    );
  }


  void  getAllLeadsApi({
    required String employeeId,
    required String leadStage,
    required stateId,
    required distId,
    required cityId,
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getAllLeadsApi(
        employeeId:employeeId,
        leadStage: leadStage,
          stateId: stateId,
          distId: distId,
          cityId: cityId
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



      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value
      );

      isLoading(false);
    }
  }


  void  leadMoveToCommonTaskApi({
    required leadId,
    required percentage,

  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.leadMoveToCommonTaskApi(
        leadId:leadId,
        percentage: percentage,

      );


      if(data['success'] == true){

        ///Change model

        leadMoveToCommonTaskModel= LeadMoveToCommonTaskModel.fromJson(data);

        ToastMessage.msg(leadMoveToCommonTaskModel!.message!);

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error leadMoveToCommonTaskModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {
      print("run hua");



      getAllLeadsApi(
          leadStage: leadCode.value,
          employeeId:eId.value.toString(),
          stateId:stateIdMain.value,
          distId: distIdMain.value,
          cityId: cityIdMain.value
      );

      isLoading(false);
    }
  }
}
