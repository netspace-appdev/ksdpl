
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FamilyMemberController {
  var selectedGenderFam = Rxn<String>();
  var selectedFamDependent = Rxn<String>();
  bool? get isFamDependent {
    if (selectedFamDependent.value == -1) return null; // Means user didn't select anything
    return selectedFamDependent.value == 0; // 0 index = "Yes", so true
  }
  // Text controllers
  final TextEditingController famNameController = TextEditingController();
  final TextEditingController famDobController = TextEditingController();
  final TextEditingController famRelWithApplController = TextEditingController();
  final TextEditingController famMonthlyIncomeController = TextEditingController();
  final TextEditingController famEmployedWithController = TextEditingController();

}
