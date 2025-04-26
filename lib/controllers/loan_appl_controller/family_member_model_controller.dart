
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FamilyMemberController {
  var selectedGenderFam = Rxn<String>();
  var selectedGenderDependent = Rxn<String>();
  // Text controllers
  final TextEditingController famNameController = TextEditingController();
  final TextEditingController famDobController = TextEditingController();
  final TextEditingController famRelWithApplController = TextEditingController();
  final TextEditingController famMonthlyIncomeController = TextEditingController();
  final TextEditingController famEmployedWithController = TextEditingController();

}
