import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../common/helper.dart';

class PasswordController extends GetxController {

  var passwordStrength = "".obs;
  var passwordStrengthColor = Colors.transparent.obs;

  void checkPasswordStrength(String password) {
    if (password.isEmpty) {
      passwordStrength.value = "";
      passwordStrengthColor.value = Colors.transparent;
    } else if (password.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[a-z]').hasMatch(password) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      passwordStrength.value = AppText.weakPassword;
      passwordStrengthColor.value = Colors.red;
    } else if (password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password)) {
      passwordStrength.value = AppText.medium;
      passwordStrengthColor.value = Colors.orange;
    }
    if (password.length >= 10 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      passwordStrength.value = AppText.strong;
      passwordStrengthColor.value = Colors.green;
    }
  }
}
