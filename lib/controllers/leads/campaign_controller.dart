/*
import 'package:get/get.dart';
import 'package:ksdpl/services/dashboard_api_service.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/GetCampaignNameModel.dart';
import '../../models/dashboard/GetLeadWorkByLeadIdModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';

class CampaignController extends GetxController{

  var isLoading = false.obs;
  var getCampaignNameModel = Rxn<GetCampaignNameModel>(); //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getLeadWorkByLeadIdApi(leadId:arg["leadId"] );

  }

  void  getCampaignNameApi() async {
    try {

      isLoading(true);

      var data = await DashboardApiService.getCampaignNameApi();


      if(data['success'] == true){

        getCampaignNameModel.value= GetCampaignNameModel.fromJson(data);




        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getCampaignNameModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCampaignNameModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

}*/
