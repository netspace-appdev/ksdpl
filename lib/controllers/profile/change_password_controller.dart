import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../common/helper.dart';
import '../../models/SendMailToBankerAfterRegModel.dart';
import '../../models/drawer/ChangePasswordModel.dart';
import '../../services/drawer_api_service.dart';



class ChangePasswordController extends GetxController {

  var isLoading = false.obs;
  var oldObscurePassword = true.obs;
  var newObscurePassword = true.obs;
  var confirmObscurePassword = true.obs;


  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();




  ChangePasswordModel? changePasswordModel;

  void  changePasswordApi({
    required String newPassword,


  }) async {

    try {
      isLoading(true);


      var data = await DrawerApiService.changePasswordApi(
        newPassword:newPassword,

      );


      if(data['success'] == true){

        changePasswordModel= ChangePasswordModel.fromJson(data);

        ToastMessage.msg(changePasswordModel!.data!.toString());
        oldPassController.clear();
        newPassController.clear();
        confirmPassController.clear();
        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error editBankerRegistrationApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

}
