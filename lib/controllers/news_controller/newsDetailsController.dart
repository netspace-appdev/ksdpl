import 'package:get/get.dart';
import 'package:ksdpl/services/dashboard_api_service.dart';

import '../../common/base_url.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/dashboard/GetLeadWorkByLeadIdModel.dart';
import '../../models/dashboard/GetNewsByIdModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';

class NewsDetailsController extends GetxController{

  var isLoading = false.obs;
  var getNewsByIdModel = Rxn<GetNewsByIdModel>(); //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("lead histiry controller");
    dynamic arg= Get.arguments;
    print("args==>${arg.toString()}");
    getBreakingNewsByIdApi(newsId:arg["newsId"] );

  }

  void  getBreakingNewsByIdApi({
    required String newsId,
  }) async {
    try {
      dynamic arg= Get.arguments;
      print("getLeadWorkByLeadIdApi==>${arg["newsId"]}");
      isLoading(true);


      var data = await DashboardApiService.getBreakingNewsByIdApi(
          newsId: newsId
      );


      if(data['success'] == true){

        getNewsByIdModel.value= GetNewsByIdModel.fromJson(data);

        print("url-->${BaseUrl.imageBaseUrl+ getNewsByIdModel.value!.data!.imageUrl.toString()}");


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getNewsByIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error GetNewsByIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

}