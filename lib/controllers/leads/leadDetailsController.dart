import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';

class LeadDetailController extends GetxController{
  var firstName="".obs;
  var email="".obs;
  var isLoading = false.obs;
  var getLeadDetailModel = Rxn<GetLeadDetailModel>(); //
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

}