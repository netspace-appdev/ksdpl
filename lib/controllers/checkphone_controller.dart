import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/common/helper.dart';

import '../../common/storage_service.dart';
import '../../services/home_service.dart';
import '../custom_widgets/SnackBarHelper.dart';
import '../models/CheckPhoneExistsModel.dart';
import '../models/LoginModel.dart';

class CheckPhoneController extends GetxController {

  var isLoading = false.obs;
  var isPhoneNumberExists = false.obs;
  CheckPhoneExistsModel? checkPhoneExistsModel;

  void  checkPhoneNumberAlreadyExistsApi(String phone) async {
    try {
      isLoading(true);


      var data = await ApiService. CheckPhoneNumberAlreadyExistsApi(phone);


      if(data['success'] == true || data['success'] == false){

        checkPhoneExistsModel= CheckPhoneExistsModel.fromJson(data);

        if(checkPhoneExistsModel!.data==true){
          isPhoneNumberExists.value=true;


        }else if(checkPhoneExistsModel!.data==false){
          isPhoneNumberExists.value=false;

          SnackbarHelper.showSnackbar(
              title: AppText.mrb,
              message: checkPhoneExistsModel!.message.toString()
          );
        }else{

        }

        isLoading(false);


      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error checkPhoneNumberAlreadyExistsApi: $e");
      // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }
}
