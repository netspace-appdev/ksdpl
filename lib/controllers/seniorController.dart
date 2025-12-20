import 'package:get/get.dart';

import '../common/helper.dart';
import '../models/GetSeniorListModel.dart';
import '../services/product_service.dart';

class SeniorScreenController extends GetxController{
  var isLoadingMainScreen = false.obs;
  var getSeniorListModel = Rxn<GetSeniorListModel>();


  void  getAllSeniorListApi() async {
    try {
      isLoadingMainScreen(true);

      var data = await ProductService.getAllSeniorListRequestApi();

      if(data['success'] == true){

        getSeniorListModel.value= GetSeniorListModel.fromJson(data);

        isLoadingMainScreen(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoadingMainScreen(false);
    } finally {

      isLoadingMainScreen(false);
    }
  }

}