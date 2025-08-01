import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/models/more/ChangeEmailResponseModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/GenerateCibilResponseModel.dart';
import '../../services/moreService.dart';

class ChangeEmailController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


  var isLoading=false.obs;
  var _changeEmailResponseModel = Rxn<ChangeEmailResponseModel>();

  var obscurePassword = true.obs;
  String? phone = StorageService.get(StorageService.PHONE);


  @override
  void onInit() {
    super.onInit();
    if (phone != null) {
      mobileController.text = phone.toString();
  }
}

  Future<void>  changeEmailRequestApi() async {
    //ChangePassword
    try {
      isLoading(true);

      var data = await MoreServices.changeEmailRequestApi(
          Email: emailController.text.trim().toString(),
          PhoneNumber: phone.toString()
      );

      if (data['success'] == true) {
        _changeEmailResponseModel.value = ChangeEmailResponseModel.fromJson(data);
      //  StorageService.put(StorageService.EMAIL, _changeEmailResponseModel!.data!.email.toString());

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
    emailController.clear();

  }





}
