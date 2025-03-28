import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetLeadWorkByLeadIdModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';

class LeadHistoryController extends GetxController{

  var isLoading = false.obs;
  var getLeadWorkByLeadIdModel = Rxn<GetLeadWorkByLeadIdModel>(); //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("lead histiry controller");
    dynamic arg= Get.arguments;
    getLeadWorkByLeadIdApi(leadId:arg["leadId"] );

  }

  void  getLeadWorkByLeadIdApi({
    required String leadId,
  }) async {
    try {
      dynamic arg= Get.arguments;
      print("getLeadWorkByLeadIdApi==>${arg["leadId"]}");
      isLoading(true);


      var data = await DrawerApiService.getLeadWorkByLeadIdApi(
          leadId: leadId
      );


      if(data['success'] == true){

        getLeadWorkByLeadIdModel.value= GetLeadWorkByLeadIdModel.fromJson(data);




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