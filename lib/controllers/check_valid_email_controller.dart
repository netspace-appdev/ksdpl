import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/common/helper.dart';

import '../../common/storage_service.dart';
import '../../services/home_service.dart';
import '../custom_widgets/SnackBarHelper.dart';
import '../models/CheckPhoneExistsModel.dart';
import '../models/LoginModel.dart';

class CheckValidEmailController extends GetxController {


  var isValidEmail = false.obs;
  /*CheckPhoneExistsModel? checkPhoneExistsModel;*/

  void checkValidEmail(String email) {
    // Regular expression to extract domain from email
    RegExp emailRegex = RegExp(r'@([a-zA-Z0-9.-]+)$');
    Match? match = emailRegex.firstMatch(email);

    if (match != null) {
      String domain = match.group(1) ?? "";

      // List of restricted domains
      List<String> restrictedDomains = ["gmail.com", "yahoo.com"];

      if (restrictedDomains.contains(domain.toLowerCase())) {
        print("Invalid email: Emails from $domain are not allowed.");

        isValidEmail.value=false;

        SnackbarHelper.showSnackbar(
            title: AppText.companyHeader,
            message: AppText.validEmailWarning
        );
       // ToastMessage.msg(AppText.validEmailWarning);
      } else {
        print("Valid email: $email");
        isValidEmail.value=true;
      }
    } else {
      print("Invalid email format.");
    }
  }
}
