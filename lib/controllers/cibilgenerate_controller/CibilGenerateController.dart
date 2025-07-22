import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksdpl/services/generate_cibil_services.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../home/RestrictedWebView.dart';
import '../../models/GenerateCibilResponseModel.dart';

class CibilGenerateController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController camReceivableDateController = TextEditingController();
  final TextEditingController camFullNameController = TextEditingController();
  final TextEditingController camCibilMobController = TextEditingController();
  final TextEditingController camTotalOverdueAmountController = TextEditingController();
  //final TextEditingController utrNumberController = TextEditingController();
  final TextEditingController camTransactionDetailsController = TextEditingController();
  var isLoading=false.obs;
  var generateCibilResponseModel = Rxn<GenerateCibilResponseModel>(); //



  Future<void> addCustomerCibilRequestApi() async {
    print('data is here');

    try {
      isLoading(true);

      String? empId = StorageService.get(StorageService.EMPLOYEE_ID);

      var data = await GenerateCibilServices.addCustomerCibilRequestApi(
        Id: '0', // If there's no ID at creation time, leave it blank or pass null
        Name: camFullNameController.text.trim(),
        Mobile: camCibilMobController.text.trim(),
        Amount: camTotalOverdueAmountController.text.trim(),
        ReceiveDate: camReceivableDateController.text.trim(),
        Utr: camTransactionDetailsController.text.trim(),
        User_ID: empId ?? '',
      );

      if (data['success'] == true) {
        generateCibilResponseModel.value = GenerateCibilResponseModel.fromJson(data);
        ToastMessage.msg(data['message']);
        print('data is here ${data['message']}');
        print('data is here ${data['data']['data']['redirect_url']}');

          Get.to(() => RestrictedWebView(

            url: generateCibilResponseModel.value?.data?.cibilData?.redirectUrl??'',
            title: "Cibil Generate",
          ));

      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        // Handle empty case
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in updateBankerDetailApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }
}