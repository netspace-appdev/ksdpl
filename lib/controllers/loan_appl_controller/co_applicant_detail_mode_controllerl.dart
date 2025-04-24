
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart' as state;
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;

class CoApplicantDetailController {
  LeadDDController leadDDController=Get.find();
  // Text controllers
  final TextEditingController coApFullNameController = TextEditingController();
  final TextEditingController coApFatherNameController = TextEditingController();
  final TextEditingController coApDobController = TextEditingController();
  final TextEditingController coApQqualiController = TextEditingController();
  final TextEditingController coApMaritalController = TextEditingController();
  final TextEditingController coApEmplStatusController = TextEditingController();
  final TextEditingController coApNationalityController = TextEditingController();
  final TextEditingController coApOccupationController = TextEditingController();
  final TextEditingController coApOccSectorController = TextEditingController();
  final TextEditingController coApEmailController = TextEditingController();
  final TextEditingController coApMobController = TextEditingController();
  final TextEditingController coApQualiController = TextEditingController();



  final TextEditingController coApCurrHouseFlatController = TextEditingController();
  final TextEditingController coApCurrBuildingNoController = TextEditingController();
  final TextEditingController coApCurrSocietyNameController = TextEditingController();
  final TextEditingController coApCurrLocalityController = TextEditingController();
  final TextEditingController coApCurrStreetNameController = TextEditingController();
  final TextEditingController coApCurrPinCodeController = TextEditingController();
  final TextEditingController coApCurrTalukaController = TextEditingController();

  final TextEditingController coApPermHouseFlatController = TextEditingController();
  final TextEditingController coApPermBuildingNoController = TextEditingController();
  final TextEditingController coApPermSocietyNameController = TextEditingController();
  final TextEditingController coApPermLocalityController = TextEditingController();
  final TextEditingController coApPermStreetNameController = TextEditingController();
  final TextEditingController coApPermPinCodeController = TextEditingController();
  final TextEditingController coApPermTalukaController = TextEditingController();

  var selectedGenderCoAP = Rxn<String>();

  // Dropdown selections
  var selectedStateCurr = Rxn<String>();
  var selectedDistrictCurr = Rxn<String>();
  var selectedCityCurr = Rxn<String>();

  var selectedStatePerm = Rxn<String>();
  var selectedDistrictPerm = Rxn<String>();
  var selectedCityPerm = Rxn<String>();
}
