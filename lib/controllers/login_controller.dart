import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/common/helper.dart';

import '../../common/storage_service.dart';
import '../../services/home_service.dart';
import '../models/LoginModel.dart';

class LoginController extends GetxController {

  var isLoading = false.obs;
  var obscurePassword = true.obs;
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginModel? loginModel;

  void loginApi(String phoneNumber, String password) async {
    try {
      isLoading(true);


      var data = await ApiService.loginApi(phoneNumber,password);
      print("data in controller==>${data.toString()}");

      if(data['success'] == true){
        loginModel= LoginModel.fromJson(data);

        StorageService.put(StorageService.USER_ID, loginModel!.data!.id.toString());
        StorageService.put(StorageService.FIRST_NAME, loginModel!.data!.firstName.toString());
        StorageService.put(StorageService.EMAIL, loginModel!.data!.email.toString());
        StorageService.put(StorageService.TOKEN, loginModel!.data!.token.toString());
        StorageService.put(StorageService.PHONE, loginModel!.data!.phoneNumber.toString());


        isLoading(false);
        ToastMessage.msg(loginModel!.message!);

        Get.offAllNamed("/bottomNavbar");
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error here: $e");
     // Get.snackbar('Error', 'Failed to fetch data');
      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }
}
