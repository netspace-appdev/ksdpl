import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/models/more/ChangeContactNoResponseModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/GenerateCibilResponseModel.dart';
import '../../models/more/ChangeEmailResponseModel.dart';
import '../../services/moreService.dart';

class ChangeContactController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  var isLoading=false.obs;
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  var obscurePassword = true.obs;
  var email= StorageService.get(StorageService.EMAIL);

  var _changePhoneResponseModel = Rxn<ChangeContactNoResponseModel>();

  @override
  void onInit() {
    super.onInit();
    if (email != null) {
      emailController.text = email.toString();
    }
  }


  Future<void>  changePhoneNumberRequestApi() async {
    //ChangePassword
    try {
      isLoading(true);

      var data = await MoreServices.changeUserPhoneNumberRequestApi(
          Email: email.toString(),
          PhoneNumber: mobileController.text.trim().toString()
      );

      if (data['success'] == true) {
        _changePhoneResponseModel.value = ChangeContactNoResponseModel.fromJson(data);

        ToastMessage.msg(data['data']?.toString() ?? '');

        clearFormFields();
        StorageService.clear();
        Get.offAllNamed("/login");

      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        // Handle empty case
      } else {
        ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in changeEmailResponse: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

  void clearFormFields() {
    mobileController.clear();

  }

}
