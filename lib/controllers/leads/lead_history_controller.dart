import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetLeadWorkByLeadIdModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';

class LeadHistoryController extends GetxController{
  String? leadId;
  var isLoading = false.obs;
  var getLeadWorkByLeadIdModel = Rxn<GetLeadWorkByLeadIdModel>(); //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  /*  dynamic arg= Get.arguments;
    if(arg==null){
      getLeadWorkByLeadIdApi(leadId:leadId.toString() );
    }else{
      getLeadWorkByLeadIdApi(leadId:arg["leadId"] );
    }*/


  }

  void  getLeadWorkByLeadIdApi({
    required String leadId,
  }) async {
    try {

      dynamic arg= Get.arguments;

      isLoading(true);


      var data = await DrawerApiService.getLeadWorkByLeadIdApi(
          leadId: leadId
      );


      if(data['success'] == true){

        getLeadWorkByLeadIdModel.value= GetLeadWorkByLeadIdModel.fromJson(data);
        // print("getLeadWorkByLeadIdModel.value==?${getLeadWorkByLeadIdModel.value!.data![0].leadStageStatus.toString()}");





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