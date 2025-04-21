import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

class LoanApplicationController extends GetxController{
  var firstName="".obs;
  var email="".obs;
  var isLoading = false.obs;
  var getLeadDetailModel = Rxn<GetLeadDetailModel>(); //
  var selectedGender = Rxn<String>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController qualiController = TextEditingController();
  final TextEditingController maritalController = TextEditingController();
  final TextEditingController emplStatusController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController occSectorController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobController = TextEditingController();



  var currentStep = 0.obs;
  var stepCompleted = List<bool>.filled(7, false).obs;
  final List<String> titles = [
    'Personal Information', 'Co-Applicant Details', 'Property Details', 'Family Members', 'Credit Cards', 'Financial Details', 'References'
  ];
  final scrollController = ScrollController();
  void nextStep() {
    if (currentStep.value < 6) {
      currentStep.value++;
      scrollToStep(currentStep.value);
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      scrollToStep(currentStep.value);
    }
  }

  void jumpToStep(int step) {
    // We only mark previous step completed if jumping forward
    if (step > currentStep.value) {
      stepCompleted[currentStep.value] = true;
    }
    currentStep.value = step;
    scrollToStep(step);
  }

  void scrollToStep(int index) {
    final itemWidth = 100.0; // Estimate based on your stepper tile size
    final offset = (index * itemWidth).clamp(
      0.0,
      scrollController.position.maxScrollExtent,
    );
    scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void markStepAsCompleted() {
    stepCompleted[currentStep.value] = true;
  }

  void saveForm() {
    print("Form Saved!");
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }


}