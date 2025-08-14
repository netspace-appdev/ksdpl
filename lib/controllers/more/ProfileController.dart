import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/models/more/ChangeEmailResponseModel.dart';
import '../../common/storage_service.dart';

class ProfileController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController profileEmailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController whatsappNoController = TextEditingController();
  final TextEditingController hireDateController = TextEditingController();
  final TextEditingController jobRoleController = TextEditingController();
  final TextEditingController workPlaceController = TextEditingController();
  final TextEditingController HireDateController = TextEditingController();
  final TextEditingController JobRoleController = TextEditingController();
  final TextEditingController WorkPlaceController = TextEditingController();
  var selectedGender = Rxn<String>();


  var isLoading=false.obs;
  var _changeEmailResponseModel = Rxn<ChangeEmailResponseModel>();

  var obscurePassword = true.obs;
  String? phone = StorageService.get(StorageService.PHONE);


  @override
  void onInit() {
    super.onInit();
    if (phone != null) {
     // mobileController.text = phone.toString();
    }
  }

/*
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
*/

  void clearFormFields() {
  //  emailController.clear();
  }

}
