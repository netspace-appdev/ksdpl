import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/services/moreService.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/more/ChangePasswordResponseModel.dart';
import '../../models/more/CheckPasswordResponseModel.dart';


class ChangePasswordController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  var isLoading=false.obs;
  var checkpasswordresponse = Rxn<CheckPasswordResponseModel>();
  var changepasswordresponse = Rxn<ChangePasswordResponseModel>();

  var obscurePassword = true.obs;
  var obscureNewPassword = true.obs;
  var obscureConfirmPassword = true.obs;




  Future<void> CheckOldPasswordRequestApi() async {
    print('data is here');
    try {
      isLoading(true);

      var data = await MoreServices.checkOldPasswordRequestApi(
        OldPassword: oldPasswordController.text.trim(),
      );

      if (data['success'] == true) {
        checkpasswordresponse.value = CheckPasswordResponseModel.fromJson(data);
        ToastMessage.msg(data['data']?.toString() ?? '');
        await changePasswordRequestApi(); // 👈 Also added await
      }
      else if (data['success'] == false && data['data'] is List && (data['data'] as List).isEmpty) {
    //    ToastMessage.msg("Old password incorrect or empty");
      }
      else {
        ToastMessage.msg(data['data']?.toString() ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in checkOldPasswordRequestApi: ${e.toString()}");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }


  Future<void>  changePasswordRequestApi() async {
    //ChangePassword
    try {
      isLoading(true);

      var data = await MoreServices.changePasswordRequestApi(
          NewPassword: newPasswordController.text.trim().toString()
      );

      if (data['success'] == true) {
        changepasswordresponse.value = ChangePasswordResponseModel.fromJson(data);
        ToastMessage.msg(data['data']?.toString() ?? '');
        clearFormFields();
       

      } else if (data['success'] == false && (data['data'] as List).isEmpty) {

        // Handle empty case
      } else {
        ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in changePasswordRequestApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }





  }

  void clearFormFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
