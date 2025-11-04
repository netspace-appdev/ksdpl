import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:ksdpl/common/CustomIconNewDialogBox.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import 'package:ksdpl/custom_widgets/CamImage.dart';
import '../../common/base_url.dart';
import '../../common/helper.dart';
import '../../custom_widgets/DocumentCamImage.dart';
import '../../custom_widgets/ImagePickerMixin.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../models/leads/UploadDocumentModel.dart';
import '../../models/loanApplicationDocumentByLoanIdModel.dart';
import '../../models/loanRemoveApplicationDocumentModel/RemovedLoanApplicationDocumentModel.dart';
import '../../models/loan_application/AddLoanApplicationModel.dart';
import '../../models/loan_application/GetDsaMappingByBankAndProductModel.dart';
import '../../models/loan_application/GetLoanApplIdModel.dart';
import '../../models/loan_application/special_model/CoApplicantModel.dart';
import '../../models/loan_application/special_model/CreditCardModel.dart';
import '../../models/loan_application/special_model/FamilyMemberModel.dart';
import '../../models/loan_application/special_model/ReferenceModel.dart';
import '../../models/sendMailAfterLoanSubmitModel/SendMailAfterLoanApplicationSubmitModel.dart';
import '../../services/loan_appl_service.dart';
import '../addDocumentControler/addDocumentModel/DocumentUploadModel.dart';
import '../addDocumentControler/addDocumentModel/addDocumentModel.dart';
import '../loan_appl_controller/co_applicant_detail_mode_controllerl.dart';
import 'package:flutter/material.dart';
import '../loan_appl_controller/credit_cards_model_controller.dart';
import '../loan_appl_controller/reference_model_controller.dart';
import 'addLeadController.dart';


class LoanApplicationController extends GetxController with ImagePickerMixin {
  final LeadListController leadListController =Get.find();
  final Addleadcontroller addLeadController =Get.find();
  var getLoanApplIdModel = Rxn<GetLoanApplIdModel>();
  var leadId = "".obs;
  var firstName = "".obs;
  var email = "".obs;
  var isLoading = false.obs;
  var isLoadingRemoveDoc = false.obs;
  var isloadData = false.obs;
  var isLoadingMainScreen = false.obs;
  var addLoanApplicationModel = Rxn<AddLoanApplicationModel>(); //
  var uploadDocumentModel = Rxn<UploadDocumentModel>(); //
  var loanApplicationDocumentByLoanIdModel = Rxn<LoanApplicationDocumentByLoanIdModel>(); //
  var removedLoanApplicationDocumentModel = Rxn<RemovedLoanApplicationDocumentModel>(); //
  var sendMailAfterLoanApplicationSubmitModel = Rxn<SendMailAfterLoanApplicationSubmitModel>(); //
  var getDsaMappingByBankAndProductModel = Rxn<GetDsaMappingByBankAndProductModel>(); //
  var selectedGender = Rxn<String>();
  final RxList<GlobalKey<FormState>> documentFormKeys = <GlobalKey<FormState>>[].obs;


  String get selectedGenderValue => selectedGender.value ?? "";
  var selectedGenderCoAP = Rxn<String>();
  var selectedGenderDependent = Rxn<String>();
  List<String> optionsPrevLoanAppl = ["Yes", "No"];
  var selectedPrevLoanAppl = (-1).obs;
  var ownershipList = ["Owned", "Rented", "Leased", "Jointly Owned", "Other"];
  var countryList = ["India",];
  var selectedOwnershipList = Rxn<String>();
  var selectedCountry = Rxn<String>();
  var selectedCountryPerm = Rxn<String>();
  var selectedCountryOfficeAd = Rxn<String>();
  var selectedProdTypeOrTypeLoan = Rxn<int>();
  var loanApplId = 0;
  var isSameAddressApl = false.obs;
  LeadDDController leadDDController = Get.find();

  Map<String, dynamic>? detailMap;

  var photosPropEnabled = true.obs;
  var photosResEnabled = true.obs;
  var photosOffEnabled = true.obs;


  final TextEditingController dsaCodeController = TextEditingController();
  final TextEditingController lanController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController laAppliedController = TextEditingController();
  final TextEditingController dsaStaffNController = TextEditingController();
  final TextEditingController ulnController = TextEditingController();
  final TextEditingController chCodeController = TextEditingController();
  final TextEditingController proFeeController = TextEditingController();
  final TextEditingController chqDDSNController = TextEditingController();
  final TextEditingController proFeeDateController = TextEditingController();
  final TextEditingController loPurposeController = TextEditingController();
  final TextEditingController schemeController = TextEditingController();
  final TextEditingController repayTpeController = TextEditingController();
  final TextEditingController loanTenureYController = TextEditingController();
  final TextEditingController monthInstaController = TextEditingController();
  final TextEditingController prevLoanApplController = TextEditingController();

  final TextEditingController loanRoiController = TextEditingController();

  final TextEditingController applFullNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController qualiController = TextEditingController();
  final TextEditingController maritalController = TextEditingController();
  TextEditingController emplStatusController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController occSectorController = TextEditingController();
  final TextEditingController applEmailController = TextEditingController();
  final TextEditingController applMobController = TextEditingController();

  final TextEditingController orgNameController = TextEditingController();
  final TextEditingController natureOfBizController = TextEditingController();
  final TextEditingController staffStrengthController = TextEditingController();
  final TextEditingController salaryDateController = TextEditingController();

  final TextEditingController houseFlatController = TextEditingController();
  final TextEditingController buildingNoController = TextEditingController();
  final TextEditingController societyNameController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController talukaController = TextEditingController();

  final TextEditingController houseFlatPermController = TextEditingController();
  final TextEditingController buildingNoPermController = TextEditingController();
  final TextEditingController societyNamePermController = TextEditingController();
  final TextEditingController localityPermController = TextEditingController();
  final TextEditingController streetNamePermController = TextEditingController();
  final TextEditingController pinCodePermController = TextEditingController();
  final TextEditingController talukaPermController = TextEditingController();


  final TextEditingController propPropIdController = TextEditingController();
  final TextEditingController propSurveyNoController = TextEditingController();
  final TextEditingController propFinalPlotNoNoController = TextEditingController();
  final TextEditingController propBlockNoController = TextEditingController();
  final TextEditingController  loanApplicationNoController = TextEditingController();

  final TextEditingController propHouseFlatController = TextEditingController();
  final TextEditingController propBuildingNameController = TextEditingController();
  final TextEditingController propSocietyNameController = TextEditingController();
  final TextEditingController propLocalityController = TextEditingController();
  final TextEditingController propStreetNameController = TextEditingController();
  final TextEditingController propPinCodeController = TextEditingController();
  final TextEditingController propTalukaController = TextEditingController();

  final TextEditingController fdGrossMonthlySalaryController = TextEditingController();
  final TextEditingController fdnNtMonthlySalaryController = TextEditingController();
  final TextEditingController fdAnnualBonusController = TextEditingController();
  final TextEditingController fdAvgMonOvertimeController = TextEditingController();
  final TextEditingController fdAvgMonCommissionController = TextEditingController();
  final TextEditingController fdAMonthlyPfDeductionController = TextEditingController();
  final TextEditingController fdOtherMonthlyIncomeController = TextEditingController();


  final TextEditingController bankerNameController = TextEditingController();
  final TextEditingController bankerMobileController = TextEditingController();
  final TextEditingController bankerWhatsappController = TextEditingController();
  final TextEditingController bankerEmailController = TextEditingController();

  //manshi
  final TextEditingController chargesDetailProcessingFees = TextEditingController();
  final TextEditingController chargesDetailAdminFeeChargess = TextEditingController();
  final TextEditingController chargesDetailForeclosureCharges = TextEditingController();
  final TextEditingController chargesDetailStampDuty = TextEditingController();
  final TextEditingController chargesDetailLegalVettingCharges = TextEditingController();
  final TextEditingController chargesDetailTechnicalInspectionCharges = TextEditingController();
  final TextEditingController chargesDetailOtherCharges = TextEditingController();
  final TextEditingController chargesDetailTSRLegalCharges = TextEditingController();
  final TextEditingController chargesDetailValuationCharges = TextEditingController();
  final TextEditingController chargesDetailProcessingCharges = TextEditingController();
  final TextEditingController submintdocumentName = TextEditingController();



  ///04 Nov
  final TextEditingController houseFlatOfficeAdController = TextEditingController();
  final TextEditingController buildingNoOfficeAdController = TextEditingController();
  final TextEditingController societyNameOfficeAdController = TextEditingController();
  final TextEditingController localityOfficeAdController = TextEditingController();
  final TextEditingController streetNameOfficeAdController = TextEditingController();
  final TextEditingController pinCodeOfficeAdController = TextEditingController();
  final TextEditingController talukaOfficeAdController = TextEditingController();

  var selectedStateProp = Rxn<String>();
  var selectedDistrictProp = Rxn<String>();
  var selectedCityProp = Rxn<String>();


  var coApplicantList = <CoApplicantDetailController>[].obs;
  var familyMemberApplList = <FamilyMemberController>[].obs;
  var creditCardsList = <CreditCardsController>[].obs;
  var referencesList = <ReferenceController>[].obs;
  RxList<DocumentCamImage> selectedImages = <DocumentCamImage>[].obs;

  var addDocumentList = <AdddocumentModel>[].obs;

  var isDSADisabled = false.obs;

  var isShortTrackActive = false.obs;

  var docCustomerStList=[AppText.available, AppText.notAvailable, AppText.willProvideLetterOn, AppText.substituteWillProvide,];
  void addAdditionalSrcDocument() {
    addDocumentList.add(AdddocumentModel());
    documentFormKeys.add(GlobalKey<FormState>());

  }

  void clearBeforeGoingOnLoanAppl(){
    coApplicantList.clear();
    familyMemberApplList.clear();
    creditCardsList.clear();
    referencesList.clear();
    addDocumentList.clear();
    print("length coApplicantList in controller--->${coApplicantList.length}");

    bankerNameController.clear();
    bankerMobileController.clear();
    bankerWhatsappController.clear();
    bankerEmailController.clear();
    chargesDetailProcessingFees.clear();
    chargesDetailAdminFeeChargess.clear();
    chargesDetailForeclosureCharges.clear();
    chargesDetailStampDuty.clear();
    chargesDetailLegalVettingCharges.clear();
    chargesDetailTechnicalInspectionCharges.clear();
    chargesDetailOtherCharges.clear();
    chargesDetailTSRLegalCharges.clear();
    chargesDetailValuationCharges.clear();
    chargesDetailProcessingCharges.clear();
  }

  void removeAdditionalSrcDocument(int index) {
    if (addDocumentList.length <= 1) {
      ToastMessage.msg("You can not delete this");
      return;
    }
    if (index >= 0 && index < addDocumentList.length) {
      // Hold reference to the item to be disposed
      final removed = addDocumentList[index];

      // Remove it first so GetBuilder/Obx UI doesn't rebuild with disposed controller
      addDocumentList.removeAt(index);
      documentFormKeys.removeAt(index);

      addDocumentList.refresh(); // If you're using an RxList

      // Dispose AFTER rebuild
      WidgetsBinding.instance.addPostFrameCallback((_) {
        removed.aiSourceController.dispose();
        removed.aiIncomeController.dispose();
      });
    } else {
      print("🧯 Invalid index passed to removeCoApplicant: $index");
    }
  }

  var currentStep = 0.obs;
  var stepCompleted = List<bool>.filled(11, false).obs;
  var stepCompletedShortTrack = List<bool>.filled(6, false).obs;
  LeadDDController leadDController = Get.find();
  final List<String> titles = [
    'Applicant’s Details', 'Co-Applicant Details', 'Property Details',
    'Family Members', 'Credit Cards', 'Financial Details', 'References\n',
    "Banker Details", "Charges Detail", "Submit Document", 'Final Submission'
  ];

  final List<String> shortTrackTitles = [
    'Applicant’s Details', 'Property Details',
    "Banker Details", "Charges Detail", "Submit Document", 'Final Submission'
  ];


  var selectedBank = Rxn<int>();
  var selectedBankBranch = Rxn<int>();
  var selectedChannel = Rxn<int>();

  final scrollController = ScrollController();
  var documentListByBank = <String>[].obs;
  void nextStep() {

    if (currentStep.value < (isShortTrackActive.value?6: 11)) {
      currentStep.value++;
      print("currentStep--->${currentStep.value.toString()}");
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
    /*  if (step > currentStep.value) {
      stepCompleted[currentStep.value] = true;
    }*/
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

  }

  bool isPhotoUploaded(String key) {
    return _imageMap[key]?.isNotEmpty ?? false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
 /*   leadId.value = Get.arguments['uln'];
    ulnController.text = leadId.value;
    getLoanApplicationDetailsByIdApi(id: leadId.value);*/
  }

  void copyPresentToPermanentAddress() {
    // Text field values
    houseFlatPermController.text = houseFlatController.text;
    buildingNoPermController.text = buildingNoController.text;
    societyNamePermController.text = societyNameController.text;
    localityPermController.text = localityController.text;
    streetNamePermController.text = streetNameController.text;
    pinCodePermController.text = pinCodeController.text;
    talukaPermController.text = talukaController.text;
    selectedCountryPerm.value = selectedCountry.value;

    // Copy state
    leadDDController.selectedStatePerm.value =
        leadDDController.selectedStateCurr.value;
    ///New code on 24 Oct
    // Now fetch districts and wait for the lists to update
    if (leadDDController.selectedStatePerm.value != null ||
        leadDDController.selectedStatePerm.value!.isNotEmpty) {
      final stateId = leadDDController.getStateIdByName(leadDDController.selectedStatePerm.value.toString());
      leadDDController.getDistrictByStateIdPermApi(
          stateId: stateId.toString()).then((_) { //leadDDController.selectedStatePerm.value
        leadDDController.districtListPerm.value =
            List.from(leadDDController.districtListCurr);
        leadDDController.selectedDistrictPerm.value =
            leadDDController.selectedDistrictCurr.value;

        // Now fetch cities and wait for the city list to update
        final distId = leadDDController.getDistrictIdByNameCurr(leadDDController.selectedDistrictPerm.value.toString());
        leadDDController.getCityByDistrictIdPermApi(
            districtId: distId.toString()).then((_) { //leadDDController.selectedDistrictPerm.value

          leadDDController.cityListPerm.value =
              List.from(leadDDController.cityListCurr);
          leadDDController.selectedCityPerm.value =
              leadDDController.selectedCityCurr.value;
        });
      });
    }
  }

  void addCoApplicant() {
    coApplicantList.add(CoApplicantDetailController());
  }

  void addFamilyMember() {
    familyMemberApplList.add(FamilyMemberController());
  }

  void addCreditCard() {
    creditCardsList.add(CreditCardsController());
  }

  void addReference() {
    referencesList.add(ReferenceController());
  }

  void removeCoApplicant(int index) {
    if (coApplicantList.length <= 1) {
      ToastMessage.msg("You can not delete this");
      return;
    }
    if (index >= 0 && index < coApplicantList.length) {
      // Hold reference to the item to be disposed
      final removed = coApplicantList[index];

      // Remove it first so GetBuilder/Obx UI doesn't rebuild with disposed controller
      coApplicantList.removeAt(index);
      coApplicantList.refresh(); // If you're using an RxList

      // Dispose AFTER rebuild
      WidgetsBinding.instance.addPostFrameCallback((_) {
        removed.coApFullNameController.dispose();
        removed.coApFatherNameController.dispose();
        removed.coApDobController.dispose();
        removed.coApQqualiController.dispose();
        removed.coApMaritalController.dispose();
        removed.coApEmplStatusController.dispose();
        removed.coApNationalityController.dispose();
        removed.coApOccupationController.dispose();
        removed.coApOccSectorController.dispose();
        removed.coApEmailController.dispose();
        removed.coApMobController.dispose();
        removed.coApQualiController.dispose();

        removed.coApCurrHouseFlatController.dispose();
        removed.coApCurrBuildingNoController.dispose();
        removed.coApCurrSocietyNameController.dispose();
        removed.coApCurrLocalityController.dispose();
        removed.coApCurrStreetNameController.dispose();
        removed.coApCurrPinCodeController.dispose();
        removed.coApCurrTalukaController.dispose();

        removed.coApPermHouseFlatController.dispose();
        removed.coApPermBuildingNoController.dispose();
        removed.coApPermSocietyNameController.dispose();
        removed.coApPermLocalityController.dispose();
        removed.coApPermStreetNameController.dispose();
        removed.coApPermPinCodeController.dispose();
        removed.coApPermTalukaController.dispose();


        removed.selectedStateCurr.value = null;
        removed.selectedDistrictCurr.value = null;
        removed.selectedCityCurr.value = null;

        removed.selectedStatePerm.value = null;
        removed.selectedDistrictPerm.value = null;
        removed.selectedCityPerm.value = null;

        // Clear RxLists
        removed.stateListPerm.clear();
        removed.stateListCurr.clear();

        removed.districtListPerm.clear();
        removed.districtListCurr.clear();

        removed.cityListPerm.clear();
        removed.cityListCurr.clear();
      });
    } else {
    }
  }


  void removeFamilyMember(int index) {
    if (familyMemberApplList.length <= 1) {
      ToastMessage.msg("You can not delete this");
      return;
    }
    if (index >= 0 && index < familyMemberApplList.length) {
      // Hold reference to the item to be disposed
      final removed = familyMemberApplList[index];

      // Remove it first so GetBuilder/Obx UI doesn't rebuild with disposed controller
      familyMemberApplList.removeAt(index);
      familyMemberApplList.refresh(); // If you're using an RxList

      // Dispose AFTER rebuild
      WidgetsBinding.instance.addPostFrameCallback((_) {
        removed.famNameController.dispose();
        removed.famDobController.dispose();
        removed.famRelWithApplController.dispose();
        removed.famMonthlyIncomeController.dispose();
        removed.famEmployedWithController.dispose();

        removed.selectedGenderFam.value = null;
        removed.selectedFamDependent.value = null;
      });
    } else {
      print("🧯 Invalid index passed to removeCoApplicant: $index");
    }
  }


  void removeCreditCard(int index) {
    if (creditCardsList.length <= 1) {
      ToastMessage.msg("You can not delete this");
      return;
    }
    if (index >= 0 && index < creditCardsList.length) {
      // Hold reference to the item to be disposed
      final removed = creditCardsList[index];

      // Remove it first so GetBuilder/Obx UI doesn't rebuild with disposed controller
      creditCardsList.removeAt(index);
      creditCardsList.refresh(); // If you're using an RxList

      // Dispose AFTER rebuild
      WidgetsBinding.instance.addPostFrameCallback((_) {
        removed.ccCompBankController.dispose();
        removed.ccCardNumberController.dispose();
        removed.ccHavingSinceController.dispose();
        removed.ccAvgMonSpendingController.dispose();
      });
    } else {
      print("🧯 Invalid index passed to removeCoApplicant: $index");
    }
  }

  void removeReference(int index) {
    if (referencesList.length <= 1) {
      ToastMessage.msg("You can not delete this");
      return;
    }
    if (index >= 0 && index < referencesList.length) {
      // Hold reference to the item to be disposed
      final removed = referencesList[index];

      // Remove it first so GetBuilder/Obx UI doesn't rebuild with disposed controller
      referencesList.removeAt(index);
      referencesList.refresh(); // If you're using an RxList

      // Dispose AFTER rebuild
      WidgetsBinding.instance.addPostFrameCallback((_) {
        removed.refNameController.dispose();
        removed.refAddController.dispose();
        removed.refPhoneController.dispose();
        removed.refRelWithApplController.dispose();
        removed.refPincodeController.dispose();

        removed.stateListPerm.clear();
        removed.districtListPerm.clear();
        removed.cityListPerm.clear();

        removed.selectedStatePerm.value = null;
        removed.selectedDistrictPerm.value = null;
        removed.selectedCityPerm.value = null;
        removed.selectedCountry.value = null;
      });
    } else {
      print("🧯 Invalid index passed to removeCoApplicant: $index");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    leadDController.selectedStateCurr.value = null;
    leadDController.selectedDistrictCurr.value = null;
    leadDController.selectedCityCurr.value = null;
    leadDController.selectedStatePerm.value = null;
    leadDController.selectedDistrictPerm.value = null;
    leadDController.selectedCityPerm.value = null;
    isDSADisabled.close();

    dsaCodeController.dispose();
    loanApplicationNoController.dispose();
    lanController.dispose();
    panController.dispose();
    aadharController.dispose();
    laAppliedController.dispose();
    dsaStaffNController.dispose();
    ulnController.dispose();
    chCodeController.dispose();
    proFeeController.dispose();
    chqDDSNController.dispose();
    proFeeDateController.dispose();
    loPurposeController.dispose();
    schemeController.dispose();
    repayTpeController.dispose();
    loanTenureYController.dispose();
    monthInstaController.dispose();
    prevLoanApplController.dispose();

    applFullNameController.dispose();
    fatherNameController.dispose();
    dobController.dispose();
    qualiController.dispose();
    maritalController.dispose();
    emplStatusController.dispose();
    nationalityController.dispose();
    occupationController.dispose();
    occSectorController.dispose();
    applEmailController.dispose();
    applMobController.dispose();

    orgNameController.dispose();
    natureOfBizController.dispose();
    staffStrengthController.dispose();
    salaryDateController.dispose();

    houseFlatController.dispose();
    buildingNoController.dispose();
    societyNameController.dispose();
    localityController.dispose();
    streetNameController.dispose();
    pinCodeController.dispose();
    talukaController.dispose();

    houseFlatPermController.dispose();
    buildingNoPermController.dispose();
    societyNamePermController.dispose();
    localityPermController.dispose();
    streetNamePermController.dispose();
    pinCodePermController.dispose();
    talukaPermController.dispose();

    propPropIdController.dispose();
    propSurveyNoController.dispose();
    propFinalPlotNoNoController.dispose();
    propBlockNoController.dispose();

    propHouseFlatController.dispose();
    propBuildingNameController.dispose();
    propSocietyNameController.dispose();
    propLocalityController.dispose();
    propStreetNameController.dispose();
    propPinCodeController.dispose();
    propTalukaController.dispose();

    fdGrossMonthlySalaryController.dispose();
    fdnNtMonthlySalaryController.dispose();
    fdAnnualBonusController.dispose();
    fdAvgMonOvertimeController.dispose();
    fdAvgMonCommissionController.dispose();
    fdAMonthlyPfDeductionController.dispose();
    fdOtherMonthlyIncomeController.dispose();


    // Clear Rx variables
    selectedGender.value = null;
    selectedGenderCoAP.value = null;
    selectedGenderDependent.value = null;
    selectedPrevLoanAppl.value = -1;
    selectedOwnershipList.value = null;
    selectedCountry.value = null;
    selectedCountryPerm.value = null;
    selectedStateProp.value = null;
    selectedDistrictProp.value = null;
    selectedCityProp.value = null;

// Clear Lists (and dispose their controllers if needed)
    coApplicantList.clear();
    familyMemberApplList.clear();
    creditCardsList.clear();
    referencesList.clear();
    referencesList.clear();

    bankerNameController.dispose();
    bankerMobileController.dispose();
    bankerWhatsappController.dispose();
    bankerEmailController.dispose();
    chargesDetailProcessingFees.dispose();
    chargesDetailAdminFeeChargess.dispose();
    chargesDetailForeclosureCharges.dispose();
    chargesDetailStampDuty.dispose();
    chargesDetailLegalVettingCharges.dispose();
    chargesDetailTechnicalInspectionCharges.dispose();
    chargesDetailOtherCharges.dispose();
    chargesDetailTSRLegalCharges.dispose();
    chargesDetailValuationCharges.dispose();
    chargesDetailProcessingCharges.dispose();
  }

  void onSaveLoanAppl({required String status}) {
    final List<CoApplicantModel> coApplicantModels = [];
    final List<FamilyMemberModel> familyMembersModels = [];
    final List<CreditCardModel> creditCardModel = [];
    final List<ReferenceModel> referenceModel = [];

    for (var coAp in coApplicantList) {

      final AddressModel presentAddress = AddressModel(
          houseFlatNo: cleanText(coAp.coApCurrHouseFlatController.text),
          buildingNo: cleanText(coAp.coApCurrBuildingNoController.text),
          societyName: cleanText(coAp.coApCurrSocietyNameController.text),
          locality: cleanText(coAp.coApCurrLocalityController.text),
          streetName: cleanText(coAp.coApCurrStreetNameController.text),
          city: cleanText(coAp.selectedCityCurr.value.toString()),//cleanText(coAp.selectedCityCurr.value.toIntOrZero().toString()
          taluka: cleanText(coAp.coApCurrTalukaController.text),
          district: cleanText(
              coAp.selectedDistrictCurr.value.toString()),//toIntOrZero()
          state: cleanText(
              coAp.selectedStateCurr.value.toString()),//toIntOrZero()
          country: cleanText(
              coAp.selectedCountrCurr.value.toString()),//toIntOrZero()
          pinCode: cleanText(coAp.coApCurrPinCodeController.text)
      );

      final AddressModel permanentAddress = AddressModel(
          houseFlatNo: cleanText(coAp.coApPermHouseFlatController.text),
          buildingNo: cleanText(coAp.coApPermBuildingNoController.text),
          societyName: cleanText(coAp.coApPermSocietyNameController.text),
          locality: cleanText(coAp.coApPermLocalityController.text),
          streetName: cleanText(coAp.coApPermStreetNameController.text),
          city: cleanText(coAp.selectedCityPerm.value.toString()),//toIntOrZero()
          taluka: cleanText(coAp.coApPermTalukaController.text),
          district: cleanText(
              coAp.selectedDistrictPerm.value.toString()),//toIntOrZero()
          state: cleanText(
              coAp.selectedStatePerm.value.toString()),//toIntOrZero()
          country: cleanText(
              coAp.selectedCountryPerm.value.toString()),//toIntOrZero()
          pinCode: cleanText(coAp.coApPermPinCodeController.text)
      );

      final AddressModel officeAddress = AddressModel(
          houseFlatNo: cleanText(coAp.coApOfficeAdHouseFlatController.text),
          buildingNo: cleanText(coAp.coApOfficeAdBuildingNoController.text),
          societyName: cleanText(coAp.coApOfficeAdSocietyNameController.text),
          locality: cleanText(coAp.coApOfficeAdLocalityController.text),
          streetName: cleanText(coAp.coApOfficeAdStreetNameController.text),
          city: cleanText(coAp.selectedCityOfficeAd.value.toString()),//toIntOrZero()
          taluka: cleanText(coAp.coApOfficeAdTalukaController.text),
          district: cleanText(
              coAp.selectedDistrictOfficeAd.value.toString()),//toIntOrZero()
          state: cleanText(
              coAp.selectedStateOfficeAd.value.toString()),//toIntOrZero()
          country: cleanText(
              coAp.selectedCountryOfficeAd.value.toString()),//toIntOrZero()
          pinCode: cleanText(coAp.coApOfficeAdPinCodeController.text)
      );

      final EmployerDetailsModel employerDetails = EmployerDetailsModel(
        organizationName: cleanText(coAp.coApOrgNameController.text),
        ownershipType: coAp.selectedCityPerm.value.toIntOrZero().toString(),
        natureOfBusiness: cleanText(coAp.coApNatureOfBizController.text),
        staffStrength: coAp.coApStaffStrengthController.toIntOrZero(),
        dateOfSalary: coAp.coApSalaryDateController.text.isNotEmpty ? Helper
            .convertToIso8601(coAp.coApSalaryDateController.text) : "",

        ///its static
      );

      print("presentAddress--->${presentAddress}");


      final coApModel = CoApplicantModel(
        name: cleanText(coAp.coApFullNameController.text),
        fatherName: cleanText(coAp.coApFatherNameController.text),
        gender: coAp.selectedGenderCoAP.value ?? "",
        dateOfBirth: coAp.coApDobController.text.isNotEmpty ? Helper
            .convertToIso8601(coAp.coApDobController.text) : "",

        ///its static
        qualification: cleanText(coAp.coApQualiController.text),
        emailID: cleanText(coAp.coApEmailController.text),
        maritalStatus: cleanText(coAp.coApMaritalController.text),
        status: cleanText(coAp.coApEmplStatusController.text),

        ///its static
        nationality: cleanText(coAp.coApNationalityController.text),
        occupation: cleanText(coAp.coApOccupationController.text),
        occupationSector: cleanText(coAp.coApOccupationController.text),
        mobile: cleanText(coAp.coApMobController.text),
        presentAddress: presentAddress,
        permanentAddress: permanentAddress,
        officeAddress: officeAddress,
        employerDetails: employerDetails,
      );
      coApplicantModels.add(coApModel);
    }


    for (var fam in familyMemberApplList) {
      final famModel = FamilyMemberModel(
          name: cleanText(fam.famNameController.text),
          birthDate: fam.famDobController.text.isNotEmpty ? Helper
              .convertToIso8601(fam.famDobController.text) : "",

          ///its static
          gender: fam.selectedGenderFam.value ?? "",
          relationWithApplicant: cleanText(fam.famRelWithApplController.text),
          dependent: fam.isFamDependent,
          monthlyIncome: fam.famMonthlyIncomeController.toIntOrZero(),
          employedWith: cleanText(fam.famEmployedWithController.text)
      );
      familyMembersModels.add(famModel);
    }

    for (var cc in creditCardsList) {
      final ccModel = CreditCardModel(
        companyBank: cleanText(cc.ccCompBankController.text),
        cardNumber: cleanText(cc.ccCardNumberController.text),
        havingSince: cc.ccHavingSinceController.text.isNotEmpty ? Helper
            .convertToIso8601(cc.ccHavingSinceController.text) : "",

        ///its static
        avgMonthlySpending: cc.ccAvgMonSpendingController.toIntOrZero(),
      );
      creditCardModel.add(ccModel);
    }


    for (var ref in referencesList) {
      final refModel = ReferenceModel(
        name: cleanText(ref.refNameController.text),
        address: cleanText(ref.refAddController.text),
        city: ref.selectedCityPerm.value.ddToString(),
        district: ref.selectedDistrictPerm.value.ddToString(),
        state: ref.selectedStatePerm.value.ddToString(),
        country: ref.selectedCountry.value.ddToString(),
        pinCode: cleanText(ref.refPincodeController.text),
        phone: cleanText(ref.refPhoneController.text),
        mobile: cleanText(ref.refMobController.text),
        relationWithApplicant: cleanText(ref.refRelWithApplController.text),
      );
      referenceModel.add(refModel);
    }

    List<Map<String, dynamic>> coApPayload = coApplicantModels.map((e) =>
        e.toMap()).toList();
    List<Map<String, dynamic>> famPayload = familyMembersModels.map((e) =>
        e.toJson()).toList();
    List<Map<String, dynamic>> ccPayload = creditCardModel.map((e) => e.toMap())
        .toList();
    List<Map<String, dynamic>> refPayload = referenceModel.map((e) => e.toMap())
        .toList();


    addLoanApplicationApi(
      coApPayload: coApPayload,
      famPayload: famPayload,
      ccPayload: ccPayload,
      refPayload: refPayload,
        status: status,
    );
  }

  Future<void> addLoanApplicationApi({
    required List<Map<String, dynamic>> coApPayload,
    required List<Map<String, dynamic>> famPayload,
    required List<Map<String, dynamic>> ccPayload,
    required List<Map<String, dynamic>> refPayload,
    required String status,

  }) async
  {
    try {
      isLoading(true);

    //  print("coApPayload--->${coApPayload}");

      for (var item in coApPayload) {
        print("item['permanentAddress']=====>${item['permanentAddress']}");
      }

      for (var item in coApPayload) {
        print("item['officeAddress']=====>${item['officeAddress']}");
      }

      var uln = Get.arguments['uln'];


      var data = await LoanApplService.addLoanApplicationApi(
          body: [
            {
              "id": loanApplId,
              "dsaCode": cleanText(dsaCodeController.text),
              "loanApplicationNo": cleanText(lanController.text),
              "bankId": selectedBank.value ?? 0,
              "branchId": selectedBankBranch.value ?? 0,
              "typeOfLoanId": selectedProdTypeOrTypeLoan.value ?? 0,
              "panCardNumber": cleanText(panController.text),
              "addharCardNumber": cleanText(aadharController.text),
              "loanAmountApplied": laAppliedController.text.toIntOrZero(),
              "uniqueLeadNumber": uln,
              "channelId": selectedChannel.value,
              "channelCode": cleanText(chCodeController.text),
              "detailForLoanApplication": {
                "branch": selectedBankBranch.value,
                "dsaCode": cleanText(dsaCodeController.text),
                "dsaStaffName": cleanText(dsaStaffNController.text),
                "loanApplicationNo": cleanText(lanController.text),
                "processingFee": proFeeController.toIntOrZero(),
                "chqDdSlipNo": cleanText(chqDDSNController.text),
                "processingFeeDate": proFeeDateController.text.isNotEmpty
                    ? Helper.convertToIso8601(proFeeDateController.text)
                    : null,
                "loanPurpose": cleanText(loPurposeController.text),
                "scheme": cleanText(schemeController.text),
                "repaymentType": cleanText(repayTpeController.text),
                "typeOfLoan": cleanText(loanTenureYController.text),
                "loanAmountApplied": laAppliedController.text.toIntOrZero(),
                "loanTenureYears": loanTenureYController.toIntOrZero(),
                "monthlyInstallment": monthInstaController.toIntOrZero(),
                "previousLoanApplied": isPreviousLoanApplied ?? false,
                "applicant": {
                  "name": cleanText(applFullNameController.text),
                  "fatherName": cleanText(fatherNameController.text),
                  "gender": selectedGender.value.ddToString(),
                  "dateOfBirth": dobController.text.isNotEmpty ? Helper
                      .convertToIso8601(dobController.text) : null,
                  "qualification": cleanText(qualiController.text),
                  "maritalStatus": cleanText(maritalController.text),
                  "status": cleanText(emplStatusController.text),
                  "nationality": cleanText(nationalityController.text),
                  "occupation": cleanText(occupationController.text),
                  "occupationSector": cleanText(occSectorController.text),
                  "presentAddress": {
                    "houseFlatNo": cleanText(houseFlatController.text),
                    "buildingNo": cleanText(buildingNoController.text),
                    "societyName": cleanText(societyNameController.text),
                    "locality": cleanText(localityController.text),
                    "streetName": cleanText(streetNameController.text),
                    "city": leadDDController.selectedCityCurr.value
                        .ddToString(),
                    "taluka": cleanText(talukaController.text),
                    "district": leadDDController.selectedDistrictCurr.value
                        .ddToString(),
                    "state": leadDDController.selectedStateCurr.value
                        .ddToString(),
                    "country": selectedCountry.value.ddToString(),
                    "pinCode": cleanText(pinCodeController.text)
                  },
                  "permanentAddress": {
                    "houseFlatNo": cleanText(houseFlatPermController.text),
                    "buildingNo": cleanText(buildingNoPermController.text),
                    "societyName": cleanText(societyNamePermController.text),
                    "locality": cleanText(localityPermController.text),
                    "streetName": cleanText(streetNamePermController.text),
                    "city": leadDDController.selectedCityPerm.value
                        .ddToString(),
                    "taluka": cleanText(talukaPermController.text),
                    "district": leadDDController.selectedDistrictPerm.value
                        .ddToString(),
                    "state": leadDDController.selectedStatePerm.value
                        .ddToString(),
                    "country": selectedCountryPerm.value.ddToString(),
                    "pinCode": cleanText(pinCodePermController.text)
                  },
                  "officeAddress": {
                    "houseFlatNo": cleanText(houseFlatOfficeAdController.text),
                    "buildingNo": cleanText(buildingNoOfficeAdController.text),
                    "societyName": cleanText(societyNameOfficeAdController.text),
                    "locality": cleanText(localityOfficeAdController.text),
                    "streetName": cleanText(streetNameOfficeAdController.text),
                    "city": leadDDController.selectedCityOfficeAd.value
                        .ddToString(),
                    "taluka": cleanText(talukaOfficeAdController.text),
                    "district": leadDDController.selectedDistrictOfficeAd.value
                        .ddToString(),
                    "state": leadDDController.selectedStateOfficeAd.value
                        .ddToString(),
                    "country": selectedCountryOfficeAd.value.ddToString(),
                    "pinCode": cleanText(pinCodeOfficeAdController.text)
                  },
                  "emailID": cleanText(applEmailController.text),
                  "mobile": cleanText(applMobController.text),
                  "employerDetails": {
                    "organizationName": cleanText(orgNameController.text),
                    "ownershipType": selectedOwnershipList.value.ddToString(),
                    //"string",
                    "natureOfBusiness": cleanText(natureOfBizController.text),
                    "staffStrength": staffStrengthController.toIntOrZero(),
                    "dateOfSalary": salaryDateController.text.isNotEmpty
                        ? Helper.convertToIso8601(salaryDateController.text)
                        : null,

                    ///its static
                  }
                }
              },
              "coApplicant": coApPayload,
              "propertyDetails": {

                "propertyId": cleanText(propPropIdController.text),
                "surveyNo": cleanText(propSurveyNoController.text),
                "finalPlotNo": cleanText(propFinalPlotNoNoController.text),
                "blockNo": cleanText(propBlockNoController.text),
                "flatHouseNo": cleanText(propHouseFlatController.text),
                "societyBuildingName": cleanText(
                    propBuildingNameController.text),
                "streetName": cleanText(propStreetNameController.text),
                "locality": cleanText(propLocalityController.text),
                "city": selectedCityProp.value.ddToString(),
                "taluka": cleanText(propTalukaController.text),
                "district": selectedDistrictProp.value.ddToString(),
                "state": selectedStateProp.value.ddToString(),
                "pincode": cleanText(propPinCodeController.text),
              },
              "familyMembers": famPayload,
              "creditCards": ccPayload,
              "financialDetails": {
                "grossMonthlySalary": fdGrossMonthlySalaryController
                    .toIntOrZero(),
                "netMonthlySalary": fdnNtMonthlySalaryController.toIntOrZero(),
                "annualBonus": fdAnnualBonusController.toIntOrZero(),
                "avgMonthlyOvertime": fdAvgMonOvertimeController.toIntOrZero(),
                "avgMonthlyCommission": fdAvgMonCommissionController
                    .toIntOrZero(),
                "monthlyPFDeduction": fdAMonthlyPfDeductionController
                    .toIntOrZero(),
                "otherMonthlyIncome": fdOtherMonthlyIncomeController
                    .toIntOrZero(),
              },
              "references": refPayload,
              "bankerName": cleanText(bankerNameController.text),
              "bankerMobile": cleanText(bankerMobileController.text),
              "bankerWatsapp": cleanText(bankerWhatsappController.text),
              "bankerEmail": cleanText(bankerEmailController.text),

              "chargesDetailsDTO": {
                "adminFeeCharges": int.tryParse(chargesDetailAdminFeeChargess.text) ?? 0,
                "foreclosureChargesCharges": int.tryParse(chargesDetailForeclosureCharges.text) ?? 0,
                "legalVettingCharges": int.tryParse(chargesDetailLegalVettingCharges.text) ?? 0,
                "otherCharges": int.tryParse(chargesDetailOtherCharges.text) ?? 0,
                "processingCharges": int.tryParse(chargesDetailProcessingCharges.text) ?? 0,
                "processingFees": int.tryParse(chargesDetailProcessingFees.text) ?? 0,
                "stampDutyPercentage": int.tryParse(chargesDetailStampDuty.text) ?? 0,
                "technicalInspectionCharges": int.tryParse(chargesDetailTechnicalInspectionCharges.text) ?? 0,
                "tsrLegalCharges": int.tryParse(chargesDetailTSRLegalCharges.text) ?? 0,
                "valuationCharges": int.tryParse(chargesDetailValuationCharges.text) ?? 0,
              }
            }
          ]
      );


      if (data['success'] == true) {
        addLoanApplicationModel.value = AddLoanApplicationModel.fromJson(data);
        //ToastMessage.msg(addLoanApplicationModel.value!.message!.toString());
        print('status______${status}');

        if(status=="0"){
          SnackbarHelper.showSnackbar(
            title: "Data Saved",
            message: addLoanApplicationModel.value!.message!.toString(),
          );
          isLoading(false);
         ///this appears
          /*showDialog(
            context: Get.context!,
            builder: (context) {
              return CustomIconDialogNewBox(
                title: "Save Data",
                icon: Icons.info_outline,
                iconColor: AppColor.secondaryColor,
                description: addLoanApplicationModel.value!.message!.toString() ,
                onYes: () {
                },

              );
            },
          );*/
        }else if (status=="1"){

            sendMailToBankerAfterLoanApplicationSubmit(id:getLoanApplIdModel.value?.data?.id.toString()??'', status:status,);

        }else{

        }




      } else {
      //  ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error getLeadDetailByIdApi: $e");

    //  ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {
     // isLoading(false);
    }
  }

  void clearForm() {
    // Clear text fields
    leadDController.selectedStateCurr.value = null;
    leadDController.selectedDistrictCurr.value = null;
    leadDController.selectedCityCurr.value = null;
    leadDController.selectedStatePerm.value = null;
    leadDController.selectedDistrictPerm.value = null;
    leadDController.selectedCityPerm.value = null;

    dsaCodeController.dispose();
    lanController.dispose();
    panController.dispose();
    aadharController.dispose();
    laAppliedController.dispose();
    dsaStaffNController.dispose();
    ulnController.dispose();
    chCodeController.dispose();
    proFeeController.dispose();
    chqDDSNController.dispose();
    proFeeDateController.dispose();
    loPurposeController.dispose();
    schemeController.dispose();
    repayTpeController.dispose();
    loanTenureYController.dispose();
    monthInstaController.dispose();
    prevLoanApplController.dispose();

    applFullNameController.dispose();
    fatherNameController.dispose();
    dobController.dispose();
    qualiController.dispose();
    maritalController.dispose();
    emplStatusController.dispose();
    nationalityController.dispose();
    occupationController.dispose();
    occSectorController.dispose();
    applEmailController.dispose();
    applMobController.dispose();

    orgNameController.dispose();
    natureOfBizController.dispose();
    staffStrengthController.dispose();
    salaryDateController.dispose();

    houseFlatController.dispose();
    buildingNoController.dispose();
    societyNameController.dispose();
    localityController.dispose();
    streetNameController.dispose();
    pinCodeController.dispose();
    talukaController.dispose();

    houseFlatPermController.dispose();
    buildingNoPermController.dispose();
    societyNamePermController.dispose();
    localityPermController.dispose();
    streetNamePermController.dispose();
    pinCodePermController.dispose();
    talukaPermController.dispose();

    propPropIdController.dispose();
    propSurveyNoController.dispose();
    propFinalPlotNoNoController.dispose();
    propBlockNoController.dispose();

    propHouseFlatController.dispose();
    propBuildingNameController.dispose();
    propSocietyNameController.dispose();
    propLocalityController.dispose();
    propStreetNameController.dispose();
    propPinCodeController.dispose();
    propTalukaController.dispose();

    fdGrossMonthlySalaryController.dispose();
    fdnNtMonthlySalaryController.dispose();
    fdAnnualBonusController.dispose();
    fdAvgMonOvertimeController.dispose();
    fdAvgMonCommissionController.dispose();
    fdAMonthlyPfDeductionController.dispose();
    fdOtherMonthlyIncomeController.dispose();


    // Clear Rx variables
    selectedGender.value = null;
    selectedGenderCoAP.value = null;
    selectedGenderDependent.value = null;
    selectedPrevLoanAppl.value = -1;
    selectedOwnershipList.value = null;
    selectedCountry.value = null;
    selectedCountryPerm.value = null;
    selectedStateProp.value = null;
    selectedDistrictProp.value = null;
    selectedCityProp.value = null;

// Clear Lists (and dispose their controllers if needed)
    coApplicantList.clear();
    familyMemberApplList.clear();
    creditCardsList.clear();
    referencesList.clear();
    referencesList.clear();



    bankerNameController.dispose();
    bankerMobileController.dispose();
    bankerWhatsappController.dispose();
    bankerEmailController.dispose();
    chargesDetailProcessingFees.dispose();
    chargesDetailAdminFeeChargess.dispose();
    chargesDetailForeclosureCharges.dispose();
    chargesDetailStampDuty.dispose();
    chargesDetailLegalVettingCharges.dispose();
    chargesDetailTechnicalInspectionCharges.dispose();
    chargesDetailOtherCharges.dispose();
    chargesDetailTSRLegalCharges.dispose();
    chargesDetailValuationCharges.dispose();
    chargesDetailProcessingCharges.dispose();
  }


  String cleanText(String text) {
    return text
        .trim()
        .isEmpty ? "" : text.trim();
  }

  int cleanInt(Rxn<String> rxnString) {
    if (rxnString.value != null && rxnString.value!.isNotEmpty) {
      return int.tryParse(rxnString.value!.trim()) ?? 0;
    }
    return 0;
  }

  String cleanDateText(String? controller) {
    if (controller == null) return "null";
    final text = controller.trim();
    return text.isEmpty ? "" : text;
  }


  bool? get isPreviousLoanApplied {
    if (selectedPrevLoanAppl.value == -1)
      return null; // Means user didn't select anything
    return selectedPrevLoanAppl.value == 0; // 0 index = "Yes", so true
  }


  void debugPrintKeyVal(String key, dynamic value) {
    print("$key: ${value ?? 'null'}");
  }


  Future<void> getLoanApplicationDetailsByIdApi({ //getLoanApplicationDetailsByUniqueLeadNumber
    required String id,
  }) async {
    print("getLoanApplicationDetailsByIdApi===>${id}");
    try {
      isLoadingMainScreen(true);
      var req = await LoanApplService.getLoanApplicationDetailsByIdApi(id: id);
     // print('Get.arguments in api getloanaappl-========>${Get.arguments}');
     // var uln = Get.arguments['uln'];

      if (req['success'] == true) {

        getLoanApplIdModel.value = GetLoanApplIdModel.fromJson(req);

        if (getLoanApplIdModel.value!.data!.detailForLoanApplication != null) {
          detailMap = jsonDecode(getLoanApplIdModel.value!.data!.detailForLoanApplication!);




          getLoanApplicationDocumentByLoanIdApi(loanId: getLoanApplIdModel.value?.data?.id.toString()??'');

          dsaStaffNController.text = detailMap?['DsaStaffName'] ?? '';
          loanApplicationNoController.text = detailMap?['loanApplicationNo'] ?? '';
          proFeeController.text = detailMap?['ProcessingFee']?.toString() ?? '';
          chqDDSNController.text = detailMap?['ChqDdSlipNo'] ?? '';
          loPurposeController.text = detailMap?['LoanPurpose'] ?? '';
          schemeController.text = detailMap?['Scheme'] ?? '';
          repayTpeController.text = detailMap?['RepaymentType'] ?? '';
          loanTenureYController.text = detailMap?['LoanTenureYears'].toString() ?? '';
          monthInstaController.text = detailMap?['MonthlyInstallment']?.toString() ?? '';
          selectedPrevLoanAppl.value =
          detailMap?['PreviousLoanApplied']?.toString() == "null" ? -1 :
          detailMap?['PreviousLoanApplied']?.toString() == "true" ? 0 : 1;
          proFeeDateController.text =
              Helper.convertFromIso8601(detailMap?['ProcessingFeeDate']) ?? '';
// For applicant
          final applicant = detailMap?['Applicant'];

          applFullNameController.text = applicant?['Name'] ?? '';
          fatherNameController.text = applicant?['FatherName'] ?? '';
          selectedGender.value = applicant?['Gender'] ?? '-1';

          dobController.text =
              Helper.convertFromIso8601(applicant?['DateOfBirth']) ?? 'null';
          qualiController.text = applicant?['Qualification'] ?? '';
          maritalController.text = applicant?['MaritalStatus'] ?? '';
          emplStatusController.text = applicant?['Status'] ?? '';
          nationalityController.text = applicant?['Nationality'] ?? '';
          occupationController.text = applicant?['Occupation'] ?? '';
          occSectorController.text = applicant?['OccupationSector'] ?? '';
          applEmailController.text = applicant?['EmailID'] ?? '';
          applMobController.text = applicant?['Mobile'] ?? '';

          print('applicant? Mobile=========. ${applicant?['Mobile'] ?? ''}');
          print('applMobController.text=========. ${applMobController.text}');
// Employer
          final employer = applicant?['EmployerDetails'];
          orgNameController.text = employer?['OrganizationName'] ?? '';
          selectedOwnershipList.value = employer?['OwnershipType'] ?? 'null';
          natureOfBizController.text = employer?['NatureOfBusiness'] ?? '';
          staffStrengthController.text = employer?['StaffStrength']?.toString() ?? '0';

          salaryDateController.text =
              Helper.convertFromIso8601(applicant?['DateOfSalary']) ?? 'null';
          // Present Add
          final presentAdd = applicant?['PresentAddress'];
          houseFlatController.text = presentAdd?['HouseFlatNo'] ?? '';
          buildingNoController.text = presentAdd?['BuildingNo'] ?? '';
          societyNameController.text = presentAdd?['SocietyName'] ?? '';
          localityController.text = presentAdd?['Locality'] ?? '';
          streetNameController.text = presentAdd?['StreetName'] ?? '';
          leadDDController.selectedStateCurr.value =
          presentAdd?['State'] == "" ? "0" : presentAdd?['State'] ?? '0';

          print("leadDDController.selectedStateCurr.value----->${leadDDController.selectedStateCurr.value}");
          ///New code on 24 Oct
          if( presentAdd?['State'] != "" &&  presentAdd?['State'] != "0"){
            final stateId = leadDDController.getStateIdByName(leadDDController.selectedStateCurr.value.toString());

            await leadDDController.getDistrictByStateIdCurrApi(
                stateId: stateId.toString());//leadDDController.selectedStateCurr.value

            leadDDController.selectedDistrictCurr.value =
            presentAdd?['District'] == "" ? "0" : presentAdd?['District'] ?? '0';
            print(" leadDDController.selectedDistrictCurr.value======>${ leadDDController.selectedDistrictCurr.value}");
            ///New code on 24 Oct
            final distId = leadDDController.getDistrictIdByNameCurr(leadDDController.selectedDistrictCurr.value.toString());
            print("distId======>${distId}");
            await leadDDController.getCityByDistrictIdCurrApi(
                districtId: distId.toString());//eadDDController.selectedDistrictCurr.value
            leadDDController.selectedCityCurr.value =
            presentAdd?['City'] == "" ? "0" : presentAdd?['City'] ?? '0';
          }


          talukaController.text = presentAdd?['Taluka'] ?? '';
          selectedCountry.value = presentAdd?['Country'] ?? '0';
          pinCodeController.text = presentAdd?['PinCode'] ?? '';

// Permanet Add
          final permanentAdd = applicant?['PermanentAddress'];
          houseFlatPermController.text = permanentAdd?['HouseFlatNo'] ?? '';
          buildingNoPermController.text = permanentAdd?['BuildingNo'] ?? '';
          societyNamePermController.text = permanentAdd?['SocietyName'] ?? '';
          localityPermController.text = permanentAdd?['Locality'] ?? '';
          streetNamePermController.text = permanentAdd?['StreetName'] ?? '';
          leadDDController.selectedStatePerm.value =
          permanentAdd?['State'] == "" ? "0" : permanentAdd?['State'] ?? '0';
          ///New code on 24 Oct
          if( permanentAdd?['State'] != "" &&  permanentAdd?['State'] != "0"){
            final stateId2 = leadDDController.getStateIdByName(leadDDController.selectedStatePerm.value.toString());
            await leadDDController.getDistrictByStateIdPermApi(
                stateId: stateId2.toString());//leadDDController.selectedStatePerm.value
            leadDDController.selectedDistrictPerm.value =
            permanentAdd?['District'] == "" ? "0" : permanentAdd?['District'] ??
                '0';
            ///New code on 24 Oct
            print(" leadDDController.selectedDistrictPerm.value======>${ leadDDController.selectedDistrictPerm.value}");
            final distId2 =  leadDDController.getDistrictIdByNamePerm(leadDDController.selectedDistrictPerm.value.toString());
            print(" distId2======>${ distId2}");
            await leadDDController.getCityByDistrictIdPermApi(
                districtId: distId2.toString());//leadDDController.selectedDistrictPerm.value

            print("permanentAdd?['City']---->${permanentAdd?['City']}");
            leadDDController.selectedCityPerm.value =
            permanentAdd?['City'] == "" ? "0" : permanentAdd?['City'] ?? '0';
          }


          talukaPermController.text = permanentAdd?['Taluka'] ?? '';
          selectedCountryPerm.value = permanentAdd?['Country'] ?? '0';
          pinCodePermController.text = permanentAdd?['PinCode'] ?? '';
        }
        final data = getLoanApplIdModel.value!.data;

        dsaCodeController.text = data?.dsaCode ?? '';
        loanApplicationNoController.text = data?.loanApplicationNo ?? '';
        lanController.text = data?.loanApplicationNo ?? '';

        selectedBank.value = data?.bankId ?? 0;

        await leadDDController.getAllBranchByBankIdApi(
            bankId: data?.bankId.toString() ?? "0");

        await leadDDController.getProductListByBankIdApi(bankId: selectedBank.value.toString());

        await leadListController.getSoftSanctionByLeadIdAndBankIdApiMethod(bankId: selectedBank.value.toString() ,leadID: addLeadController.getLeadDetailModel.value!.data!.id!.toString());

        selectedBankBranch.value = data?.branchId ?? 0;


        selectedProdTypeOrTypeLoan.value = data?.typeOfLoan ?? 0;
        panController.text = data?.panCardNumber ?? '';
        aadharController.text = data?.addharCardNumber ?? '';
        laAppliedController.text = data?.loanAmountApplied.toString() ?? "";
        print('the data is here ${data?.loanAmountApplied.toString() ?? ""}');
        ulnController.text = id;//uln;
        selectedChannel.value = data?.channelId ?? 0;
        chCodeController.text = data?.channelCode ?? '';
        bankerNameController.text = data?.bankerName ?? '';
        bankerMobileController.text = data?.bankerMobile ?? '';
        bankerWhatsappController.text = data?.bankerWatsapp ?? '';
        bankerEmailController.text = data?.bankerEmail ?? '';
        chargesDetailProcessingFees.text = data?.chargesDetails?.processingFees?.toString() ?? '0';

        print('hfiufhsfhwowrffhoweowhje ${ data?.chargesDetails?.adminFeeCharges?.toString()}');

        chargesDetailAdminFeeChargess.text = data?.chargesDetails?.adminFeeCharges?.toString() ?? '0';
        chargesDetailForeclosureCharges.text = data?.chargesDetails?.foreclosureChargesCharges?.toString() ?? '0';
        chargesDetailStampDuty.text = data?.chargesDetails?.stampDutyPercentage?.toString() ?? '0';
        chargesDetailLegalVettingCharges.text = data?.chargesDetails?.legalVettingCharges?.toString() ?? '0';
        chargesDetailTechnicalInspectionCharges.text = data?.chargesDetails?.technicalInspectionCharges?.toString() ?? '0';
        chargesDetailOtherCharges.text = data?.chargesDetails?.otherCharges?.toString() ?? '0';
        chargesDetailTSRLegalCharges.text = data?.chargesDetails?.tsrLegalCharges?.toString() ?? '0';
        chargesDetailValuationCharges.text = data?.chargesDetails?.valuationCharges?.toString() ?? '0';
        chargesDetailProcessingCharges.text = data?.chargesDetails?.processingCharges?.toString() ?? '0';

        loanApplId = data?.id ?? 0;

        populateCoApplicantControllers();
        populatePropertyDetails();
        populateFinancialDetails();
        populateFamilyControllers();
        populateCreditCardControllers();
        populateReferenceControllers();
        isLoadingMainScreen(false);
      } else if(req['success'] == false && (req['data'] as List).isEmpty ){

        initializeImpFields();

      }else {
        ToastMessage.msg(req['message'] ?? AppText.somethingWentWrong);

      }
    } catch (e) {
      print("Error getloanaappl: $e");

     // ToastMessage.msg(AppText.somethingWentWrong);
      isLoadingMainScreen(false);
    } finally {
      isLoadingMainScreen(false);
    }
  }
  initializeImpFields(){

    referencesList.add(ReferenceController());
    coApplicantList.add(CoApplicantDetailController());
    familyMemberApplList.add(FamilyMemberController());
    creditCardsList.add(CreditCardsController());

    print("initializeImpFields--->referencesList==>${referencesList.length}");
    print("initializeImpFields--->coApplicantList===>${coApplicantList.length}");
    print("initializeImpFields--->familyMemberApplList===>${familyMemberApplList.length}");
    print("initializeImpFields--->creditCardsList===>${creditCardsList.length}");
  }

  void populateCoApplicantControllers() async {
    print('here call co applicant');

  //  coApplicantList.clear();
    final jsonStr = getLoanApplIdModel.value!.data!.coApplicantDetail;

    if (jsonStr != null) {
      final decoded = jsonDecode(jsonStr);

      // Check if it's actually a List of Maps
      if (decoded is List) {
        for (var item in decoded) {
          final coApController = CoApplicantDetailController();

          coApController.coApFullNameController.text = item["Name"] ?? '';
          coApController.coApFatherNameController.text =
              item["FatherName"] ?? '';
          coApController.selectedGenderCoAP.value = item["Gender"] ?? '';
          coApController.coApDobController.text =
          item["DateOfBirth"] == "" ? "" : Helper.convertFromIso8601(
              item["DateOfBirth"]) ?? '';
          coApController.coApQualiController.text = item["Qualification"] ?? '';
          coApController.coApMaritalController.text =
              item["MaritalStatus"] ?? '';
          coApController.coApEmplStatusController.text = item["Status"] ?? '';
          coApController.coApNationalityController.text =
              item["Nationality"] ?? '';
          coApController.coApOccupationController.text =
              item["Occupation"] ?? '';
          coApController.coApOccSectorController.text =
              item["OccupationSector"] ?? '';
          coApController.coApEmailController.text = item["EmailID"] ?? '';
          coApController.coApMobController.text = item["Mobile"] ?? '';

          final presentAdd = item?['PresentAddress'];
          coApController.coApCurrHouseFlatController.text =
              presentAdd?["HouseFlatNo"] ?? '';
          coApController.coApCurrBuildingNoController.text =
              presentAdd?["BuildingNo"] ?? '';
          coApController.coApCurrSocietyNameController.text =
              presentAdd?["SocietyName"] ?? '';
          coApController.coApCurrLocalityController.text =
              presentAdd?["Locality"] ?? '';
          coApController.coApCurrStreetNameController.text =
              presentAdd?["StreetName"] ?? '';
          coApController.coApCurrPinCodeController.text =
              presentAdd?["PinCode"] ?? '';
          coApController.selectedStateCurr.value =
          presentAdd?['State'] == "" ? "0" : presentAdd?['State'] ?? '0';

          if(presentAdd?['State'] != "" && presentAdd?['State'] != "0"){
            print("here coApController.selectedStateCurr.value---->${coApController.selectedStateCurr.value}");
            print("here presentAdd?['State']---->${presentAdd?['State']}");
            final stateId = leadDDController.getStateIdByName(coApController.selectedStateCurr.value.toString());
            print("stateId----->coappl--->${stateId}");
            await coApController.getDistrictByStateIdCurrApi(
                stateId:stateId.toString());//coApController.selectedStateCurr.value
            coApController.selectedDistrictCurr.value =
            presentAdd?['District'] == "" ? "0" : presentAdd?['District'] ?? '0';
            print("coApController.selectedDistrictCurr.value----->coappl--->${coApController.selectedDistrictCurr.value}");
            print(" presentAdd?['District']----->coappl--->${ presentAdd?['District']}");
            final distId = coApController.getDistrictIdByNameCurr( coApController.selectedDistrictCurr.value.toString());
            print("distId----->coappl--->${distId}");
            await coApController.getCityByDistrictIdCurrApi(
                districtId: distId.toString());//coApController.selectedDistrictCurr.value
            coApController.selectedCityCurr.value =
            presentAdd?['City'] == "" ? "0" : presentAdd?['City'] ?? '0';
          }
          ///New code on 24 Oct


          coApController.coApCurrTalukaController.text =
              presentAdd?["Taluka"] ?? '';

          coApController.selectedCountrCurr.value =
          presentAdd?['Country'] == "" ? "" : presentAdd?['Country'];


          final permanentAdd = item?['PermanentAddress'];
          coApController.coApPermHouseFlatController.text =
              permanentAdd?["HouseFlatNo"] ?? '';
          coApController.coApPermBuildingNoController.text =
              permanentAdd?["BuildingNo"] ?? '';
          coApController.coApPermSocietyNameController.text =
              permanentAdd?["SocietyName"] ?? '';
          coApController.coApPermLocalityController.text =
              permanentAdd?["Locality"] ?? '';
          coApController.coApPermStreetNameController.text =
              permanentAdd?["StreetName"] ?? '';
          coApController.coApPermPinCodeController.text =
              permanentAdd?["PinCode"] ?? '';
          coApController.selectedStatePerm.value =
          permanentAdd?['State'] == "" ? "0" : permanentAdd?['State'] ?? '0';
          print(" coApController.selectedStatePerm.value--->${ coApController.selectedStatePerm.value}");
          print(" cpermanentAdd?['State']--->${ permanentAdd?['State']}");
          if(permanentAdd?['State'] != "" && permanentAdd?['State'] != "0"){
            final stateId2 = coApController.getStateIdByName(coApController.selectedStatePerm.value.toString());
            print("stateId2--->${stateId2}");
            await coApController.getDistrictByStateIdPermApi(
                stateId: stateId2.toString());
            coApController.selectedDistrictPerm.value =
            permanentAdd?['District'] == "" ? "0" : permanentAdd?['District'] ??
                '0';
            /// ///New code on 24 Oct
            print(" coApController.selectedDistrictPerm.value--->${ coApController.selectedDistrictPerm.value}");
            print(" permanentAdd?['District']--->${ permanentAdd?['District']}");
            final distId2 =  coApController.getDistrictIdByNamePerm(leadDDController.selectedDistrictPerm.value.toString());
            print("distId2--->${ distId2}");
            await coApController.getCityByDistrictIdPermApi(
                districtId: distId2.toString());//coApController.selectedDistrictPerm.value
            coApController.selectedCityPerm.value =
            permanentAdd?['City'] == "" ? "0" : permanentAdd?['City'] ?? '0';
          }


          coApController.coApPermTalukaController.text =
              permanentAdd?["Taluka"] ?? '';

          coApController.selectedCountryPerm.value =
          permanentAdd?['Country'] == "" ? "" : permanentAdd?['Country'];

          coApplicantList.add(coApController);//25 Oct  uncomment it
        }
      } else {
        print("Expected a List but got: ${decoded.runtimeType}");
      }
    }
  }

  void populatePropertyDetails() async {
    Map<String, dynamic>? propDetails;
    if (getLoanApplIdModel.value!.data!.detailForLoanApplication != null) {
      propDetails = jsonDecode(getLoanApplIdModel.value!.data!.loanDetails!);


      propPropIdController.text = propDetails?['PropertyId'] ?? '';
      propSurveyNoController.text = propDetails?['SurveyNo'] ?? '';
      propFinalPlotNoNoController.text = propDetails?['FinalPlotNo'] ?? '';
      propBlockNoController.text = propDetails?['BlockNo'] ?? '';
      propHouseFlatController.text = propDetails?['FlatHouseNo'] ?? '';
      propBuildingNameController.text =
          propDetails?['SocietyBuildingName'] ?? '';
      propStreetNameController.text = propDetails?['StreetName'] ?? '';
      propLocalityController.text = propDetails?['Locality'] ?? '';
      propLocalityController.text = propDetails?['Locality'] ?? '';
      propTalukaController.text = propDetails?['Taluka'] ?? '';
      propPinCodeController.text = propDetails?['Pincode'] ?? '';
      selectedStateProp.value =
      propDetails?['State'] == "" ? "0" : propDetails?['State'] ?? '0';
      ///New code on 24 Oct
      if(propDetails?['State'] != "" && propDetails?['State']  != "0"){
        final stateId = leadDDController.getStateIdByName(selectedStateProp.value.toString());

        await leadDDController.getDistrictByStateIdCurrApi(
            stateId: stateId.toString());//selectedStateProp.value
        selectedDistrictProp.value =
        propDetails?['District'] == "" ? "0" : propDetails?['District'] ?? '0';
        final distId = leadDDController.getDistrictIdByNameCurr( selectedDistrictProp.value.toString());
        await leadDDController.getCityByDistrictIdCurrApi(
            districtId: distId.toString());//selectedDistrictProp.value
        selectedCityProp.value =
        propDetails?['City'] == "" ? "0" : propDetails?['City'] ?? '0';
      }


    }
  }

  void populateFinancialDetails() async {
    Map<String, dynamic>? finDetails;
    if (getLoanApplIdModel.value!.data!.financialDetails != null) {
      finDetails =
          jsonDecode(getLoanApplIdModel.value!.data!.financialDetails!);


      fdGrossMonthlySalaryController.text =
          finDetails?['GrossMonthlySalary'].toString() ?? '';
      fdnNtMonthlySalaryController.text =
          finDetails?['NetMonthlySalary'].toString() ?? '';
      fdAnnualBonusController.text =
          finDetails?['AnnualBonus'].toString() ?? '';
      fdAvgMonOvertimeController.text =
          finDetails?['AvgMonthlyOvertime'].toString() ?? '';
      fdAvgMonCommissionController.text =
          finDetails?['AvgMonthlyCommission'].toString() ?? '';
      fdAMonthlyPfDeductionController.text =
          finDetails?['MonthlyPFDeduction'].toString() ?? '';
      fdOtherMonthlyIncomeController.text =
          finDetails?['OtherMonthlyIncome'].toString() ?? '';
    }
  }

  void populateFamilyControllers() async {
    familyMemberApplList.clear();
    final jsonStr = getLoanApplIdModel.value!.data!.familyMembers;

    if (jsonStr != null) {
      final decoded = jsonDecode(jsonStr);

      // Check if it's actually a List of Maps
      if (decoded is List) {
        for (var item in decoded) {
          final famController = FamilyMemberController();


          // famController.coApFullNameController.text = item["Name"] ?? '';
          famController.famNameController.text = item["Name"] ?? '';
          famController.famDobController.text =
          item["BirthDate"] == "" ? "" : Helper.convertFromIso8601(
              item["BirthDate"]) ?? '';
          famController.selectedGenderFam.value = item["Gender"] ?? '';
          famController.famRelWithApplController.text =
              item["RelationWithApplicant"] ?? '';
          famController.selectedFamDependent.value =
          item["Dependent"] == true ? "Yes" : "No";
          famController.famMonthlyIncomeController.text =
              item["MonthlyIncome"].toString() ?? '';
          famController.famEmployedWithController.text =
              item["EmployedWith"] ?? '';

          familyMemberApplList.add(famController);
        }
      } else {
        print("Expected a List but got: ${decoded.runtimeType}");
      }
    }
  }

  void populateCreditCardControllers() async {
    creditCardsList.clear();
    final jsonStr = getLoanApplIdModel.value!.data!.creditCards;

    if (jsonStr != null) {
      final decoded = jsonDecode(jsonStr);

      // Check if it's actually a List of Maps
      if (decoded is List) {
        for (var item in decoded) {
          final ccController = CreditCardsController();


          ccController.ccCompBankController.text = item["CompanyBank"] ?? '';
          ccController.ccCardNumberController.text = item["CardNumber"] ?? '';
          ccController.ccHavingSinceController.text =
          item["HavingSince"] == "" ? "" : Helper.convertFromIso8601(
              item["HavingSince"]) ?? '';
          ccController.ccAvgMonSpendingController.text =
              item["AvgMonthlySpending"].toString() ?? '';


          creditCardsList.add(ccController);
        }
      } else {
        print("Expected a List but got: ${decoded.runtimeType}");
      }
    }
  }


  void populateReferenceControllers() async {
   // referencesList.clear();
    final refList = getLoanApplIdModel.value?.data?.referenceDetails;
    print('here referal test here ');



    if (refList != null) {
        print('here referal${refList.length}');

      for (var item in refList) {
        final refController = ReferenceController();
        print('here referal');

        refController.refNameController.text = item.name ?? '';
        refController.refAddController.text = item.address ?? '';
        refController.refMobController.text = item.mobile ?? '';
        refController.refPhoneController.text = item.phone ?? '';
        refController.refRelWithApplController.text = item.relationWithApplicant ?? '';
        refController.selectedStatePerm.value = item.state == "" ? "0" : item.state ?? '0';
        if(refController.selectedStatePerm.value != "" && refController.selectedStatePerm.value != "0"){
          await refController.getDistrictByStateIdPermApi(
            stateId: refController.selectedStatePerm.value,
          );

          refController.selectedDistrictPerm.value = item.district == "" ? "0" : item.district ?? '0';
          /// ///New code on 24 Oct
          final distId2 =  leadDDController.getDistrictIdByNamePerm(refController.selectedDistrictPerm.value.toString());
          await refController.getCityByDistrictIdPermApi(
            districtId: distId2,//refController.selectedDistrictPerm.value
          );

          refController.selectedCityPerm.value = item.city == "" ? "0" : item.city ?? '0';
        }


        refController.refPincodeController.text = item.pinCode ?? '';
        refController.selectedCountry.value = item.country == "" ? "" : item.country ?? '0';

        referencesList.add(refController);
      }
    }
  }

  final Map<String, RxList<CamImage>> _imageMap = {};

  @override
  Map<String, RxList<CamImage>> get imageMap => _imageMap;

  void loadApiImagesForKey(String key, String imageUrlsFromApi) {
    final urls = imageUrlsFromApi.split(',');
    final fullUrls = urls.map((path) => BaseUrl.imageBaseUrl + path)
        .toList(); // adjust base url
    addNetworkImages(key, fullUrls);
  }

  List<File> getPropertyImageFiles() {
    return getImages('property_photo')
        .where((img) => img.isLocal && img.file != null)
        .map((img) => img.file!)
        .toList();
  }

  Future<void> onSubmitDocuments() async {
    final List<DocumentUploadModel> documents = [];

    for (var doc in addDocumentList) {
      final name = doc.aiSourceController.text.trim();
      final List<File> images = doc.selectedImages
          .where((img) => img.isLocal)
          .map((img) => img.file!)
          .toList();

      if (name.isEmpty || images.isEmpty) {
        SnackbarHelper.showSnackbar(
          title: "Submit Document Page",
          message: "Please enter document name and upload at least one image for all documents.",
        );
        return;
      }

      documents.add(DocumentUploadModel(name: name, images: images));
    }

    final List<Map<String, dynamic>> payload =
    documents.map((e) => e.toMap()).toList();

    try {
      isLoading(true);
      await addAdditionalDocumentApi(documentPayload: payload);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addAdditionalDocumentApi({
    required List<Map<String, dynamic>> documentPayload,
  }) async {
    // Handle API call here
    print("Payload: $documentPayload");

  }


  Future<void> submitDoc({required AdddocumentModel doc}) async {

    print('selectedDocStatusCus===>${doc.selectedDocStatusCus}');
    print('aiSourceController===>${doc.aiSourceController.text}');

      final loanId = getLoanApplIdModel.value?.data?.id.toString() ?? '';
      final docName = doc.aiSourceController.text.trim();

      if (docName.isEmpty) {
        SnackbarHelper.showSnackbar(
          title: "Submit Document Page",
          message: "Please enter the document name.",
        );
        return;
      }
    if (doc.isThisGenerated.value && (doc.selectedDocStatusCus.value==null || doc.selectedDocStatusCus.value!.isEmpty)  ) {
      SnackbarHelper.showSnackbar(
        title: "Submit Document Status",
        message: "Please enter the document status",
      );
      return;
    }

      final images = doc.selectedImages
          .where((img) => img.file != null)
          .map((img) => img.file!)
          .toList();

      if (images.isEmpty) {
        SnackbarHelper.showSnackbar(
          title: "Submit Document Page",
          message: "Please upload at least one image.",
        );
        return;
      }

      List<Map<String, dynamic>> imageMap = images.map((file) {
        return {
          'fileName': file.path.split('/').last,
          'filePath': file.path,
        };
      }).toList();

      isLoading(true);
      print('imageMap______$loanId');
      try {
        await SubmittLoanDocumentApi(
          id: '0',
          LoanId: loanId,
          ImageName: docName,
          imageMap: imageMap,
          doc:doc,
          customerStatus:doc.selectedDocStatusCus.value.toString()
        );

        print('Submit doc API successs');

      } catch (e) {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: "Failed to submit document.",
        );
      } finally {
        isLoading(false);
      }
    }




  Future<void> SubmittLoanDocumentApi({
    required String id,
    required String LoanId,
    required String ImageName,
    required List<Map<String, dynamic>> imageMap,
    required AdddocumentModel doc,
    required String customerStatus,
  })
  async {
    try {
      isLoading(true);
      // API Call
      var data = await LoanApplService.SubmittLoanDocumentApi(
        id: id,
        LoanId: LoanId,
        ImageName: ImageName,
        imageMap: imageMap,
        customerStatus: customerStatus
      );

      // Handle response
      if (data['success'] == true) {
        uploadDocumentModel.value = UploadDocumentModel.fromJson(data);
        ToastMessage.msg(uploadDocumentModel.value!.message.toString());
        // ✅ Clear data after success
        print('loan idd  ${LoanId}');
        getLoanApplicationDocumentByLoanIdApi(loanId: LoanId);

        doc.aiSourceController.clear();
        doc.selectedImages.clear();

       // clearField();

      } else {
        //ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error SubmittLoanDocumentApi: $e");
   //   ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

  List<File> getUploadedImageFiles(String key) {
    return getImages(key)
        .where((img) => img.isLocal && img.file != null)
        .map((img) => img.file!)
        .toList();
  }


  void clearField() {
    Get.back();
  }

  Future<void> getLoanApplicationDocumentByLoanIdApi({
    required String loanId
  })
  async {

      try {
        isloadData(true);

        var data = await LoanApplService.getLoanApplicationDocumentByLoanIdApi(
          loanId: loanId,
        );

        // Handle response
        if (data['success'] == true) {
          loanApplicationDocumentByLoanIdModel.value = LoanApplicationDocumentByLoanIdModel.fromJson(data);
          await leadListController.getSoftSanctionByLeadIdAndBankIdApiMethod(bankId: selectedBank.value.toString() ,leadID: addLeadController.getLeadDetailModel.value!.data!.id!.toString());
          //ToastMessage.msg(uploadDocumentModel.value!.message.toString());
        } else {
        //  ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
        }
      } catch (e) {
        print("Error SubmittLoanDocumentApi: $e");
     //   ToastMessage.msg(AppText.somethingWentWrong);
      } finally {
        isloadData(false);
      }
  }


  Future<void> submitRemoveDocumentApi({
    required String DocumentId
  })
  async {

    try {
      isLoadingRemoveDoc(true);

      var data = await LoanApplService.getLoanApplicationRemoveDocumentApi(
        DocumentId: DocumentId,
      );
      // Handle response
      if (data['success'] == true) {
        removedLoanApplicationDocumentModel.value = RemovedLoanApplicationDocumentModel.fromJson(data);
        getLoanApplicationDocumentByLoanIdApi(loanId: getLoanApplIdModel.value?.data?.id.toString()??'');
        //ToastMessage.msg(uploadDocumentModel.value!.message.toString());
      } else {
        //  ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error SubmittLoanDocumentApi: $e");
     // ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoadingRemoveDoc(false);
    }
  }

 Future <void> sendMailToBankerAfterLoanApplicationSubmit( {
   required String id,
   required String status,
 })
 async {
   try {
     isLoading(true);

     var data = await LoanApplService.sendMailToBankerAfterLoanApplicationSubmit(
       id: id,
     );
     // Handle response
     if (data['success'] == true) {
       sendMailAfterLoanApplicationSubmitModel.value = SendMailAfterLoanApplicationSubmitModel.fromJson(data);

       if(status=="1"){
         print("status in mail send--->${status}");
      //   await Future.delayed(Duration(milliseconds: 100));

         Get.back();
         showDialog(
           context: Get.context!,
            barrierDismissible:false,
           builder: (context) {
             return CustomIconDialogNewBox(
               title: "Successful",
               icon: Icons.check_circle_outline,
               iconColor: AppColor.secondaryColor,

               description: "Loan application has been sent successfully." ,
               onYes: () {
                 Get.back();
               //  Get.toNamed("/addLeadScreen");
               },

             );
           },
         );
         isLoading(false);
      /* SnackbarHelper.showSnackbar(title: "Successful", message: sendMailAfterLoanApplicationSubmitModel.value!.message!.toString(),position: SnackPosition.BOTTOM);
        Get.back();*/
       }
     } else {
       //  ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
     }
   } catch (e) {
     print("Error SendMailAfterLoanApplicationSubmitModel: $e");
    // ToastMessage.msg(AppText.somethingWentWrong);
   } finally {
     isLoading(false);
   }
 }


  Future <void> getDsaMappingByBankAndProductApi( {
    required String BankId,
    required String ProductId,
  })
  async {
    try {
      isLoading(true);

      var data = await LoanApplService.getDsaMappingByBankAndProductApi(
        BankId: BankId,
        ProductId: ProductId,
      );
      // Handle response
      if (data['success'] == true) {
        getDsaMappingByBankAndProductModel.value = GetDsaMappingByBankAndProductModel.fromJson(data);
        dsaCodeController.text=getDsaMappingByBankAndProductModel.value?.data?.first.firmNameWithCode??"";
        isDSADisabled.value=true;
      } else {
        isDSADisabled.value=false;
          //ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error SendMailAfterLoanApplicationSubmitModel: $e");
     //  ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }


}

extension ParseStringExtension on String? {
  int toIntOrZero() {
    if (this != null && this!.isNotEmpty) {
      return int.tryParse(this!.trim()) ?? 0;
    }
    return 0;
  }
}
extension TextEditingControllerExtension on TextEditingController {
  int toIntOrZero() {
    if (text.isNotEmpty) {
      return int.tryParse(text.trim()) ?? 0;
    }
    return 0;
  }
}

extension ddToStringExt on String? {
  String ddToString() {
    return this ?? "";
  }
}
