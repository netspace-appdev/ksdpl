import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/CustomDialog.dart';
import '../../models/AddUserModel.dart';
import '../../models/BankersRegistrationModel.dart';
import '../../models/SendMailForVerificationModel.dart';
import '../../models/SendMailToBankerAfterRegModel.dart';
import '../../models/ValidateBankerRegRoleModel.dart';
import '../../models/dashboard/GetBankerByPhoneModel.dart';
import '../../models/drawer/GetBankerByIdModel.dart';
import '../../services/dashboard_api_service.dart';
import '../../services/drawer_api_service.dart';
import '../../services/home_service.dart';


class DashboardController extends GetxController {

  var isLoading = false.obs;

  SendMailToBankerAfterRegModel? sendMailToBankerAfterRegModel;


  GetBankerByPhoneModel? getBankerByPhoneModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var phone=StorageService.get(StorageService.PHONE);
    getBankerByPhoneApi(phone: phone.toString());
    
  }


  void  getBankerByPhoneApi({
    required String phone,

  }) async {
    try {
      isLoading(true);


      var data = await DashboardApiService.getBankerByPhoneApi(phone: phone,);


      if(data['success'] == true){

        getBankerByPhoneModel= GetBankerByPhoneModel.fromJson(data);

        ToastMessage.msg(getBankerByPhoneModel!.message!);
        StorageService.put(StorageService.BANKER_ID, getBankerByPhoneModel!.data!.id.toString());
        StorageService.put(StorageService.BANK_ID, getBankerByPhoneModel!.data!.bankId.toString());


        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error sendMailToBankerAfterRegistrationApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

}
