import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetLeadWorkByLeadIdModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';

class LeadDetailController extends GetxController{
  var firstName="".obs;
  var email="".obs;
  var isLoading = false.obs;
  var getLeadDetailModel = Rxn<GetLeadDetailModel>(); //
  var getLeadWorkByLeadIdModel = Rxn<GetLeadWorkByLeadIdModel>(); //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dynamic arg= Get.arguments;
    print("arg===>${arg["leadId"]}");
    getLeadDetailByIdApi(leadId:arg["leadId"] );

  }
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
      print("Error getLeadDetailByIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  getLeadWorkByLeadIdApi({
    required String leadId,
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getLeadWorkByLeadIdApi(
        leadId: leadId
      );


      if(data['success'] == true){

        getLeadWorkByLeadIdModel.value= GetLeadWorkByLeadIdModel.fromJson(data);

        ToastMessage.msg(getLeadWorkByLeadIdModel!.value!.message!);


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getLeadWorkByLeadIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getLeadWorkByLeadIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

}