import 'dart:convert';

import 'package:get/get.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/loan_application/AddLoanApplicationModel.dart';
import '../../models/loan_application/GetLoanApplIdModel.dart';
import '../../models/loan_application/special_model/CoApplicantModel.dart';
import '../../models/loan_application/special_model/CreditCardModel.dart';
import '../../models/loan_application/special_model/FamilyMemberModel.dart';
import '../../models/loan_application/special_model/ReferenceModel.dart';
import '../../services/loan_appl_service.dart';
import '../loan_appl_controller/co_applicant_detail_mode_controllerl.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../loan_appl_controller/credit_cards_model_controller.dart';
import '../loan_appl_controller/reference_model_controller.dart';

class LoanApplicationController extends GetxController{

  var getLoanApplIdModel = Rxn<GetLoanApplIdModel>();
  var leadId="".obs;
  var firstName="".obs;
  var email="".obs;
  var isLoading = false.obs;
  var isLoadingMainScreen = false.obs;
  var addLoanApplicationModel = Rxn<AddLoanApplicationModel>(); //
  var selectedGender = Rxn<String>();
  String get selectedGenderValue => selectedGender.value ?? "";
  var selectedGenderCoAP = Rxn<String>();
  var selectedGenderDependent = Rxn<String>();
  List<String> optionsPrevLoanAppl = ["Yes", "No"];
  var selectedPrevLoanAppl = (-1).obs;
  var ownershipList=["Owned", "Rented","Leased", "Jointly Owned", "Other"];
  var countryList=["India",];
  var selectedOwnershipList = Rxn<String>();
  var selectedCountry = Rxn<String>();
  var selectedCountryPerm = Rxn<String>();
  var selectedProdTypeOrTypeLoan = Rxn<int>();
  var loanApplId = 0;
  var isSameAddressApl = false.obs;
  LeadDDController leadDDController = Get.find();

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


  final TextEditingController applFullNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController qualiController = TextEditingController();
  final TextEditingController maritalController = TextEditingController();
  final TextEditingController emplStatusController = TextEditingController();
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




  var selectedStateProp = Rxn<String>();
  var selectedDistrictProp = Rxn<String>();
  var selectedCityProp = Rxn<String>();


  var coApplicantList = <CoApplicantDetailController>[].obs;
  var familyMemberApplList = <FamilyMemberController>[].obs;
  var creditCardsList = <CreditCardsController>[].obs;
  var referencesList = <ReferenceController>[].obs;

  var currentStep = 0.obs;
  var stepCompleted = List<bool>.filled(10, false).obs;
  LeadDDController leadDController=Get.find();
  final List<String> titles = [
    'Personal Information', 'Co-Applicant Details', 'Property Details',
    'Family Members', 'Credit Cards', 'Financial Details', 'References\n',
    "Banker Details" ,"Charges Detail",'Final Submission'
  ];

  var selectedBank = Rxn<int>();
  var selectedBankBranch = Rxn<int>();
  var selectedChannel = Rxn<int>();

  final scrollController = ScrollController();
  void nextStep() {
    if (currentStep.value < 10) {
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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    leadId.value = Get.arguments['uln'];
    ulnController.text =  leadId.value;
    getLoanApplicationDetailsByIdApi(id:leadId.value);

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
    leadDDController.selectedStatePerm.value = leadDDController.selectedStateCurr.value;

    // Now fetch districts and wait for the lists to update
    leadDDController.getDistrictByStateIdPermApi(stateId: leadDDController.selectedStatePerm.value).then((_) {
      leadDDController.districtListPerm.value = List.from(leadDDController.districtListCurr);
      leadDDController.selectedDistrictPerm.value = leadDDController.selectedDistrictCurr.value;

      // Now fetch cities and wait for the city list to update
      leadDDController.getCityByDistrictIdPermApi(districtId: leadDDController.selectedDistrictPerm.value).then((_) {
        leadDDController.cityListPerm.value = List.from(leadDDController.cityListCurr);
        leadDDController.selectedCityPerm.value = leadDDController.selectedCityCurr.value;
      });
    });
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
      print("🧯 Invalid index passed to removeCoApplicant: $index");
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
    leadDController.selectedStateCurr.value=null;
    leadDController.selectedDistrictCurr.value=null;
    leadDController.selectedCityCurr.value=null;
    leadDController. selectedStatePerm.value=null;
    leadDController.selectedDistrictPerm.value=null;
    leadDController.selectedCityPerm.value=null;

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

  }

  void onSaveLoanAppl() {
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
        city: cleanText(coAp.selectedCityCurr.value.toIntOrZero().toString()),
        taluka: cleanText(coAp.coApCurrTalukaController.text),
        district: cleanText(coAp.selectedDistrictCurr.value.toIntOrZero().toString()),
        state: cleanText(coAp.selectedStateCurr.value.toIntOrZero().toString()),
        country: cleanText(coAp.selectedCountrCurr.value.toIntOrZero().toString()),
        pinCode: cleanText(coAp.coApCurrPinCodeController.text)
      );

      final AddressModel permanentAddress = AddressModel(
          houseFlatNo: cleanText(coAp.coApPermHouseFlatController.text),
          buildingNo: cleanText(coAp.coApPermBuildingNoController.text),
          societyName: cleanText(coAp.coApPermSocietyNameController.text),
          locality: cleanText(coAp.coApPermLocalityController.text),
          streetName: cleanText(coAp.coApPermStreetNameController.text),
          city: cleanText(coAp.selectedCityPerm.value.toIntOrZero().toString()),
          taluka: cleanText(coAp.coApPermTalukaController.text),
          district: cleanText(coAp.selectedDistrictPerm.value.toIntOrZero().toString()),
          state: cleanText(coAp.selectedStatePerm.value.toIntOrZero().toString()),
          country: cleanText(coAp.selectedCountryPerm.value.toIntOrZero().toString()),
          pinCode: cleanText(coAp.coApPermPinCodeController.text)
      );

      final EmployerDetailsModel employerDetails=EmployerDetailsModel(
          organizationName: cleanText(coAp.coApOrgNameController.text),
          ownershipType: coAp.selectedCityPerm.value.toIntOrZero().toString(),
          natureOfBusiness:cleanText(coAp.coApNatureOfBizController.text),
          staffStrength: coAp.coApStaffStrengthController.toIntOrZero(),
          dateOfSalary:coAp.coApSalaryDateController.text.isNotEmpty?Helper.convertToIso8601(coAp.coApSalaryDateController.text):"",                ///its static
      );




      final coApModel = CoApplicantModel(
        name: cleanText(coAp.coApFullNameController.text),
        fatherName:cleanText(coAp.coApFatherNameController.text),
        gender: coAp.selectedGenderCoAP.value?? "",
        dateOfBirth:coAp.coApDobController.text.isNotEmpty?Helper.convertToIso8601(coAp.coApDobController.text):"",                ///its static
        qualification: cleanText(coAp.coApQualiController.text),
        emailID:  cleanText(coAp.coApEmailController.text),
        maritalStatus: cleanText(coAp.coApMaritalController.text),
        status:cleanText(coAp.coApEmplStatusController.text),                                            ///its static
        nationality: cleanText(coAp.coApNationalityController.text),
        occupation: cleanText(coAp.coApOccupationController.text),
        occupationSector: cleanText(coAp.coApOccupationController.text),
        mobile: cleanText(coAp.coApMobController.text),
        presentAddress:presentAddress,
        permanentAddress:permanentAddress,
        employerDetails:employerDetails,
      );
      coApplicantModels.add(coApModel);
    }


    for (var fam in familyMemberApplList) {
      final famModel = FamilyMemberModel(
        name: cleanText(fam.famNameController.text),
        birthDate: fam.famDobController.text.isNotEmpty?Helper.convertToIso8601(fam.famDobController.text):"",                      ///its static
        gender: fam.selectedGenderFam.value?? "",
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
        havingSince:cc.ccHavingSinceController.text.isNotEmpty?Helper.convertToIso8601(cc.ccHavingSinceController.text):"",                                   ///its static
        avgMonthlySpending: cc.ccAvgMonSpendingController.toIntOrZero(),
      );
      creditCardModel.add(ccModel);
    }


    for (var ref in referencesList) {
      final refModel = ReferenceModel(
      name:  cleanText(ref.refNameController.text),
      address:  cleanText(ref.refAddController.text),
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
    List<Map<String, dynamic>> coApPayload = coApplicantModels.map((e) => e.toMap()).toList();
    List<Map<String, dynamic>> famPayload = familyMembersModels.map((e) => e.toJson()).toList();
    List<Map<String, dynamic>>  ccPayload = creditCardModel.map((e) => e.toMap()).toList();
    List<Map<String, dynamic>>  refPayload = referenceModel.map((e) => e.toMap()).toList();


    addLoanApplicationApi(
      coApPayload:coApPayload,
      famPayload: famPayload,
      ccPayload: ccPayload,
      refPayload: refPayload,
    );
  }

  Future<void>addLoanApplicationApi({
    required List<Map<String, dynamic>> coApPayload,
    required List<Map<String, dynamic>> famPayload,
    required List<Map<String, dynamic>> ccPayload,
    required List<Map<String, dynamic>> refPayload,
  }) async {
    try {
      isLoading(true);
      var uln = Get.arguments['uln'];



      var data = await LoanApplService.addLoanApplicationApi(
        body:[
          {
            "id":loanApplId,
            "dsaCode": cleanText(dsaCodeController.text),
            "loanApplicationNo": cleanText(lanController.text),
            "bankId": selectedBank.value??0,
            "branchId": selectedBankBranch.value??0,
            "typeOfLoanId": selectedProdTypeOrTypeLoan.value??0,
            "panCardNumber":  cleanText(panController.text),
            "addharCardNumber":  cleanText(aadharController.text),
            "loanAmountApplied": laAppliedController.toIntOrZero(),
            "uniqueLeadNumber": uln,
            "channelId": selectedChannel.value,
            "channelCode": cleanText(chCodeController.text),
            "detailForLoanApplication": {
              "branch":selectedBankBranch.value,
              "dsaCode": cleanText(dsaCodeController.text),
              "dsaStaffName": cleanText(dsaStaffNController.text),
              "loanApplicationNo":cleanText(lanController.text),
              "processingFee":proFeeController.toIntOrZero(),
              "chqDdSlipNo": cleanText(chqDDSNController.text),
              "processingFeeDate":proFeeDateController.text.isNotEmpty?Helper.convertToIso8601(proFeeDateController.text):null,
              "loanPurpose": cleanText(loPurposeController.text),
              "scheme": cleanText(schemeController.text),
              "repaymentType": cleanText(repayTpeController.text),
              "typeOfLoan": cleanText(loanTenureYController.text),
              "loanAmountApplied": laAppliedController.text.toIntOrZero(),
              "loanTenureYears": loanTenureYController.toIntOrZero(),
              "monthlyInstallment":monthInstaController.toIntOrZero() ,
              "previousLoanApplied": isPreviousLoanApplied ?? false,
              "applicant": {
                "name": cleanText(applFullNameController.text),
                "fatherName": cleanText(fatherNameController.text),
                "gender": selectedGender.value.ddToString(),
                "dateOfBirth": dobController.text.isNotEmpty?Helper.convertToIso8601(dobController.text):null,
                "qualification": cleanText(qualiController.text),
                "maritalStatus": cleanText(maritalController.text),
                "status": cleanText(emplStatusController.text),
                "nationality": cleanText(nationalityController.text),
                "occupation":cleanText(occupationController.text),
                "occupationSector": cleanText(occSectorController.text),
                "presentAddress": {
                  "houseFlatNo": cleanText(houseFlatController.text),
                  "buildingNo": cleanText(buildingNoController.text),
                  "societyName": cleanText(societyNameController.text),
                  "locality": cleanText(localityController.text),
                  "streetName": cleanText(streetNameController.text),
                  "city": leadDDController.selectedCityCurr.value.ddToString(),
                  "taluka": cleanText(talukaController.text),
                  "district": leadDDController.selectedDistrictCurr.value.ddToString(),
                  "state": leadDDController.selectedStateCurr.value.ddToString(),
                  "country": selectedCountry.value.ddToString(),
                  "pinCode": cleanText(pinCodeController.text)
                },
                "permanentAddress": {
                  "houseFlatNo": cleanText(houseFlatPermController.text),
                  "buildingNo": cleanText(buildingNoPermController.text),
                  "societyName": cleanText(societyNamePermController.text),
                  "locality": cleanText(localityPermController.text),
                  "streetName":cleanText(streetNamePermController.text),
                  "city": leadDDController.selectedStatePerm.value.ddToString(),
                  "taluka": cleanText(talukaPermController.text),
                  "district": leadDDController.selectedDistrictPerm.value.ddToString(),
                  "state": leadDDController.selectedStatePerm.value.ddToString(),
                  "country": selectedCountryPerm.value.ddToString(),
                  "pinCode": cleanText(pinCodePermController.text)
                },
                "emailID": cleanText(applEmailController.text),
                "mobile": cleanText(applMobController.text),
                "employerDetails": {
                  "organizationName": cleanText(orgNameController.text),
                  "ownershipType": selectedOwnershipList.value.ddToString(),//"string",
                  "natureOfBusiness": cleanText(natureOfBizController.text),
                  "staffStrength": staffStrengthController.toIntOrZero(),
                  "dateOfSalary":salaryDateController.text.isNotEmpty?Helper.convertToIso8601(salaryDateController.text):null,             ///its static
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
              "societyBuildingName":  cleanText(propBuildingNameController.text),
              "streetName":  cleanText(propStreetNameController.text),
              "locality":  cleanText(propLocalityController.text),
              "city": selectedCityProp.value.ddToString(),
              "taluka":  cleanText(propTalukaController.text),
              "district": selectedDistrictProp.value.ddToString(),
              "state": selectedStateProp.value.ddToString(),
              "pincode":  cleanText(propPinCodeController.text),
            },
            "familyMembers":famPayload,
            "creditCards": ccPayload,
            "financialDetails": {
              "grossMonthlySalary": fdGrossMonthlySalaryController.toIntOrZero(),
              "netMonthlySalary": fdnNtMonthlySalaryController.toIntOrZero(),
              "annualBonus": fdAnnualBonusController.toIntOrZero(),
              "avgMonthlyOvertime": fdAvgMonOvertimeController.toIntOrZero(),
              "avgMonthlyCommission": fdAvgMonCommissionController.toIntOrZero(),
              "monthlyPFDeduction": fdAMonthlyPfDeductionController.toIntOrZero(),
              "otherMonthlyIncome": fdOtherMonthlyIncomeController.toIntOrZero(),
            },
            "references": refPayload,
            "bankerName": cleanText(bankerNameController.text),
            "bankerMobile": cleanText(bankerMobileController.text),
            "bankerWatsapp": cleanText(bankerWhatsappController.text),
            "bankerEmail": cleanText(bankerEmailController.text)
          }


        ]
      );



      if(data['success'] == true){

        addLoanApplicationModel.value= AddLoanApplicationModel.fromJson(data);
        ToastMessage.msg( addLoanApplicationModel.value!.message!.toString());


        clearForm();

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getLeadDetailByIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }


  }

  void clearForm() {
    // Clear text fields
    leadDController.selectedStateCurr.value=null;
    leadDController.selectedDistrictCurr.value=null;
    leadDController.selectedCityCurr.value=null;
    leadDController. selectedStatePerm.value=null;
    leadDController.selectedDistrictPerm.value=null;
    leadDController.selectedCityPerm.value=null;

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
  }




  String cleanText(String text) {
    return text.trim().isEmpty ? "" : text.trim();
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
    if (selectedPrevLoanAppl.value == -1) return null; // Means user didn't select anything
    return selectedPrevLoanAppl.value == 0; // 0 index = "Yes", so true
  }



  void debugPrintKeyVal(String key, dynamic value) {
    print("$key: ${value ?? 'null'}");
  }



  Future<void>getLoanApplicationDetailsByIdApi({
    required String id,
  }) async {
    try {
      isLoadingMainScreen(true);


      var req = await LoanApplService.getLoanApplicationDetailsByIdApi(id: id);

      var uln = Get.arguments['uln'];
      if(req['success'] == true){

        getLoanApplIdModel.value= GetLoanApplIdModel.fromJson(req);
        Map<String, dynamic>? detailMap;
        if (getLoanApplIdModel.value!.data!.detailForLoanApplication != null) {

          detailMap = jsonDecode(getLoanApplIdModel.value!.data!.detailForLoanApplication!);


          dsaStaffNController.text = detailMap?['DsaStaffName'] ?? '';
          proFeeController.text = detailMap?['ProcessingFee']?.toString() ?? '';
          chqDDSNController.text = detailMap?['ChqDdSlipNo'] ?? '';
          loPurposeController.text = detailMap?['LoanPurpose'] ?? '';
          schemeController.text = detailMap?['Scheme'] ?? '';
          repayTpeController.text = detailMap?['RepaymentType'] ?? '';
          loanTenureYController.text = detailMap?['LoanTenureYears']?.toString() ?? '';
          monthInstaController.text = detailMap?['MonthlyInstallment']?.toString() ?? '';
          selectedPrevLoanAppl.value = detailMap?['PreviousLoanApplied']?.toString()=="null"?-1:
          detailMap?['PreviousLoanApplied']?.toString()=="true"?0:1;
          proFeeDateController.text = Helper.convertFromIso8601(detailMap?['ProcessingFeeDate']) ?? 'null';
// For applicant
          final applicant = detailMap?['Applicant'];
          applFullNameController.text = applicant?['Name'] ?? '';
          fatherNameController.text = applicant?['FatherName'] ?? '';
          selectedGender.value = applicant?['Gender']?? '-1';

          dobController.text = Helper.convertFromIso8601(applicant?['DateOfBirth']) ?? 'null';
          qualiController.text = applicant?['Qualification'] ?? '';
          maritalController.text = applicant?['MaritalStatus'] ?? '';
          emplStatusController.text = applicant?['Status'] ?? '';
          nationalityController.text = applicant?['Nationality'] ?? '';
          occupationController.text = applicant?['Occupation'] ?? '';
          occSectorController.text = applicant?['OccupationSector'] ?? '';
          applEmailController.text = applicant?['EmailID'] ?? '';
          applMobController.text = applicant?['Mobile'] ?? '';

// Employer
          final employer = applicant?['EmployerDetails'];
          orgNameController.text = employer?['OrganizationName'] ?? '';
          selectedOwnershipList.value = employer?['OwnershipType']?? 'null';
          natureOfBizController.text = employer?['NatureOfBusiness'] ?? '';
          staffStrengthController.text = employer?['StaffStrength']?.toString() ?? '0';

          salaryDateController.text =  Helper.convertFromIso8601(applicant?['DateOfSalary']) ?? 'null';
 // Present Add
          final presentAdd = applicant?['PresentAddress'];
          houseFlatController.text = presentAdd?['HouseFlatNo'] ?? '';
          buildingNoController.text = presentAdd?['BuildingNo'] ?? '';
          societyNameController.text = presentAdd?['SocietyName'] ?? '';
          localityController.text = presentAdd?['Locality'] ?? '';
          streetNameController.text = presentAdd?['StreetName'] ?? '';
          leadDDController.selectedStateCurr.value = presentAdd?['State']==""?"0":presentAdd?['State'] ?? '0';

          await leadDDController.getDistrictByStateIdCurrApi(stateId: leadDDController.selectedStateCurr.value);
          leadDDController.selectedDistrictCurr.value =presentAdd?['District']==""?"0": presentAdd?['District'] ?? '0';

          await leadDDController.getCityByDistrictIdCurrApi(districtId: leadDDController.selectedDistrictCurr.value);
          leadDDController.selectedCityCurr.value = presentAdd?['City']==""?"0":presentAdd?['City'] ?? '0';

          talukaController.text = presentAdd?['Taluka'] ?? '';
          selectedCountry.value= presentAdd?['Country'] ?? '0';
          pinCodeController.text = presentAdd?['PinCode'] ?? '';

// Permanet Add
          final permanentAdd = applicant?['PermanentAddress'];
          houseFlatPermController.text = permanentAdd?['HouseFlatNo'] ?? '';
          buildingNoPermController.text = permanentAdd?['BuildingNo'] ?? '';
          societyNamePermController.text = permanentAdd?['SocietyName'] ?? '';
          localityPermController.text = permanentAdd?['Locality'] ?? '';
          streetNamePermController.text = permanentAdd?['StreetName'] ?? '';
          leadDDController.selectedStatePerm.value = permanentAdd?['State']==""?"0":permanentAdd?['State'] ?? '0';

          await leadDDController.getDistrictByStateIdPermApi(stateId: leadDDController.selectedStatePerm.value);
          leadDDController.selectedDistrictPerm.value =permanentAdd?['District']==""?"0": permanentAdd?['District'] ?? '0';

          await leadDDController.getCityByDistrictIdPermApi(districtId: leadDDController.selectedDistrictPerm.value);


          leadDDController.selectedCityPerm.value = permanentAdd?['City']==""?"0":permanentAdd?['City'] ?? '0';

          talukaPermController.text = permanentAdd?['Taluka'] ?? '';
          selectedCountryPerm.value= permanentAdd?['Country'] ?? '0';
          pinCodePermController.text = permanentAdd?['PinCode'] ?? '';



        }
        final data = getLoanApplIdModel.value!.data;

        dsaCodeController.text = data?.dsaCode ?? '';
        lanController.text = data?.loanApplicationNo ?? '';

        selectedBank.value =  data?.bankId ?? 0;

        await leadDDController.getAllBranchByBankIdApi(bankId: data?.bankId.toString() ?? "0");

        selectedBankBranch.value = data?.branchId ?? 0;

        if(data?.bankId!=0){
          await leadDDController.getProductListByBankIdApi(bankId: data?.branchId ?? 0);
        }
        selectedProdTypeOrTypeLoan.value=data?.typeOfLoan ?? 0;
        panController.text = data?.panCardNumber ?? '';
        aadharController.text = data?.addharCardNumber ?? '';
        laAppliedController.text = data?.loanAmountApplied.toString()?? "0";
        ulnController.text = uln;
        selectedChannel.value = data?.channelId ?? 0;
        chCodeController.text = data?.channelCode ?? '';
        bankerNameController.text=data?.bankerName ?? '';
        bankerMobileController.text=data?.bankerMobile ?? '';
        bankerWhatsappController.text=data?.bankerWatsapp ?? '';
        bankerEmailController.text=data?.bankerEmail ?? '';
        loanApplId=data?.id ?? 0;

        populateCoApplicantControllers();
        populatePropertyDetails();
        populateFinancialDetails();
        populateFamilyControllers();
        populateCreditCardControllers();
        populateReferenceControllers();
        isLoadingMainScreen(false);


      }else{
        ToastMessage.msg(req['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getLeadDetailByIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoadingMainScreen(false);
    } finally {

      isLoadingMainScreen(false);
    }
  }

  void populateCoApplicantControllers() async{
    coApplicantList.clear();
    final jsonStr = getLoanApplIdModel.value!.data!.coApplicantDetail;

    if (jsonStr != null) {
      final decoded = jsonDecode(jsonStr);

      // Check if it's actually a List of Maps
      if (decoded is List) {
        for (var item in decoded) {
          final coApController = CoApplicantDetailController();

          coApController.coApFullNameController.text = item["Name"] ?? '';
          coApController.coApFatherNameController.text = item["FatherName"] ?? '';
          coApController.selectedGenderCoAP.value = item["Gender"] ?? '';
          coApController.coApDobController.text =item["DateOfBirth"]==""?"": Helper.convertFromIso8601(item["DateOfBirth"]) ?? '';
          coApController.coApQualiController.text = item["Qualification"] ?? '';
          coApController.coApMaritalController.text = item["MaritalStatus"] ?? '';
          coApController.coApEmplStatusController.text = item["Status"] ?? '';
          coApController.coApNationalityController.text = item["Nationality"] ?? '';
          coApController.coApOccupationController.text = item["Occupation"] ?? '';
          coApController.coApOccSectorController.text = item["OccupationSector"] ?? '';
          coApController.coApEmailController.text = item["EmailID"] ?? '';
          coApController.coApMobController.text = item["Mobile"] ?? '';

          final presentAdd = item?['PresentAddress'];
          coApController.coApCurrHouseFlatController.text = presentAdd?["HouseFlatNo"] ?? '';
          coApController.coApCurrBuildingNoController.text = presentAdd?["BuildingNo"] ?? '';
          coApController.coApCurrSocietyNameController.text = presentAdd?["SocietyName"] ?? '';
          coApController.coApCurrLocalityController.text = presentAdd?["Locality"] ?? '';
          coApController.coApCurrStreetNameController.text = presentAdd?["StreetName"] ?? '';
          coApController.coApCurrPinCodeController.text = presentAdd?["PinCode"] ?? '';
          coApController.selectedStateCurr.value =presentAdd?['State']==""?"0":presentAdd?['State'] ?? '0';
          await coApController.getDistrictByStateIdCurrApi(stateId:  coApController.selectedStateCurr.value);
          coApController.selectedDistrictCurr.value =presentAdd?['District']==""?"0":presentAdd?['District'] ?? '0';
          await coApController.getCityByDistrictIdCurrApi(districtId: coApController.selectedDistrictCurr.value);
          coApController.selectedCityCurr.value =presentAdd?['City']==""?"0":presentAdd?['City'] ?? '0';
          coApController.coApCurrTalukaController.text = presentAdd?["Taluka"] ?? '';

          coApController.selectedCountrCurr.value =presentAdd?['Country']==""?"":presentAdd?['Country'];


          final permanentAdd = item?['PermanentAddress'];
          coApController.coApPermHouseFlatController.text = permanentAdd?["HouseFlatNo"] ?? '';
          coApController.coApPermBuildingNoController.text = permanentAdd?["BuildingNo"] ?? '';
          coApController.coApPermSocietyNameController.text = permanentAdd?["SocietyName"] ?? '';
          coApController.coApPermLocalityController.text = permanentAdd?["Locality"] ?? '';
          coApController.coApPermStreetNameController.text = permanentAdd?["StreetName"] ?? '';
          coApController.coApPermPinCodeController.text = permanentAdd?["PinCode"] ?? '';
          coApController.selectedStatePerm.value =permanentAdd?['State']==""?"0":permanentAdd?['State'] ?? '0';
          await coApController.getDistrictByStateIdPermApi(stateId:  coApController.selectedStatePerm.value);
          coApController.selectedDistrictPerm.value =permanentAdd?['District']==""?"0":permanentAdd?['District'] ?? '0';
          await coApController.getCityByDistrictIdPermApi(districtId: coApController.selectedDistrictPerm.value);
          coApController.selectedCityPerm.value =permanentAdd?['City']==""?"0":permanentAdd?['City'] ?? '0';
          coApController.coApPermTalukaController.text = permanentAdd?["Taluka"] ?? '';

          coApController.selectedCountryPerm.value =permanentAdd?['Country']==""?"":permanentAdd?['Country'];

          coApplicantList.add(coApController);
        }
      } else {
        print("Expected a List but got: ${decoded.runtimeType}");
      }
    }
  }

  void populatePropertyDetails() async{
    Map<String, dynamic>? propDetails;
    if (getLoanApplIdModel.value!.data!.detailForLoanApplication != null) {

      propDetails = jsonDecode(getLoanApplIdModel.value!.data!.loanDetails!);



      propPropIdController.text = propDetails?['PropertyId'] ?? '';
      propSurveyNoController.text = propDetails?['SurveyNo'] ?? '';
      propFinalPlotNoNoController.text = propDetails?['FinalPlotNo'] ?? '';
      propBlockNoController.text = propDetails?['BlockNo'] ?? '';
      propHouseFlatController.text = propDetails?['FlatHouseNo'] ?? '';
      propBuildingNameController.text = propDetails?['SocietyBuildingName'] ?? '';
      propStreetNameController.text = propDetails?['StreetName'] ?? '';
      propLocalityController.text = propDetails?['Locality'] ?? '';
      propLocalityController.text = propDetails?['Locality'] ?? '';
      propTalukaController.text = propDetails?['Taluka'] ?? '';
      propPinCodeController.text = propDetails?['Pincode'] ?? '';
      selectedStateProp.value = propDetails?['State']==""?"0":propDetails?['State'] ?? '0';
      await leadDDController.getDistrictByStateIdCurrApi(stateId: selectedStateProp.value);
      selectedDistrictProp.value =propDetails?['District']==""?"0":propDetails?['District'] ?? '0';
      await leadDDController.getCityByDistrictIdCurrApi(districtId: selectedDistrictProp.value);
      selectedCityProp.value = propDetails?['City']==""?"0":propDetails?['City'] ?? '0';
    }
  }

  void populateFinancialDetails() async{
    Map<String, dynamic>? finDetails;
    if (getLoanApplIdModel.value!.data!.financialDetails != null) {

      finDetails = jsonDecode(getLoanApplIdModel.value!.data!.financialDetails!);



      fdGrossMonthlySalaryController.text = finDetails?['GrossMonthlySalary'].toString() ?? '';
      fdnNtMonthlySalaryController.text = finDetails?['NetMonthlySalary'].toString() ?? '';
      fdAnnualBonusController.text = finDetails?['AnnualBonus'].toString() ?? '';
      fdAvgMonOvertimeController.text = finDetails?['AvgMonthlyOvertime'].toString() ?? '';
      fdAvgMonCommissionController.text = finDetails?['AvgMonthlyCommission'].toString() ?? '';
      fdAMonthlyPfDeductionController.text = finDetails?['MonthlyPFDeduction'].toString() ?? '';
      fdOtherMonthlyIncomeController.text = finDetails?['OtherMonthlyIncome'].toString() ?? '';

    }
  }

  void populateFamilyControllers() async{
    familyMemberApplList.clear();
    final jsonStr = getLoanApplIdModel.value!.data!.familyMembers;

    if (jsonStr != null) {
      final decoded = jsonDecode(jsonStr);

      // Check if it's actually a List of Maps
      if (decoded is List) {
        for (var item in decoded) {
          final famController = FamilyMemberController();


          // famController.coApFullNameController.text = item["Name"] ?? '';
          famController.famNameController.text= item["Name"] ?? '';
          famController.famDobController.text =item["BirthDate"]==""?"": Helper.convertFromIso8601(item["BirthDate"]) ?? '';
          famController.selectedGenderFam.value = item["Gender"] ?? '';
          famController.famRelWithApplController.text= item["RelationWithApplicant"] ?? '';
          famController.selectedFamDependent.value= item["Dependent"]== true ? "Yes" : "No";
          famController.famMonthlyIncomeController.text= item["MonthlyIncome"].toString() ?? '';
          famController.famEmployedWithController.text= item["EmployedWith"] ?? '';

          familyMemberApplList.add(famController);
        }
      } else {
        print("Expected a List but got: ${decoded.runtimeType}");
      }
    }
  }

  void populateCreditCardControllers() async{
    creditCardsList.clear();
    final jsonStr = getLoanApplIdModel.value!.data!.creditCards;

    if (jsonStr != null) {
      final decoded = jsonDecode(jsonStr);

      // Check if it's actually a List of Maps
      if (decoded is List) {
        for (var item in decoded) {
          final ccController = CreditCardsController();



           ccController.ccCompBankController.text= item["CompanyBank"] ?? '';
           ccController.ccCardNumberController.text= item["CardNumber"] ?? '';
           ccController.ccHavingSinceController.text=item["HavingSince"]==""?"": Helper.convertFromIso8601(item["HavingSince"]) ?? '';
           ccController.ccAvgMonSpendingController.text= item["AvgMonthlySpending"].toString() ?? '';


          creditCardsList.add(ccController);
        }
      } else {
        print("Expected a List but got: ${decoded.runtimeType}");
      }
    }
  }


  void populateReferenceControllers() async{
    referencesList.clear();
    final jsonStr = getLoanApplIdModel.value!.data!.referenceDetails;

    if (jsonStr != null) {
      final decoded = jsonDecode(jsonStr);

      // Check if it's actually a List of Maps
      if (decoded is List) {
        for (var item in decoded) {
          final refController = ReferenceController();



          refController.refNameController.text= item["Name"] ?? '';
          refController.refAddController.text= item["Address"] ?? '';
          refController.refMobController.text= item["Mobile"] ?? '';
          refController.refPhoneController.text= item["Phone"] ?? '';
          refController.refRelWithApplController.text= item["RelationWithApplicant"] ?? '';
          refController.selectedStatePerm.value = item?['State']==""?"0":item?['State'] ?? '0';
          await refController.getDistrictByStateIdPermApi(stateId:   refController.selectedStatePerm.value);
          refController.selectedDistrictPerm.value  =item?['District']==""?"0":item?['District'] ?? '0';
          await refController.getCityByDistrictIdPermApi(districtId:  refController.selectedDistrictPerm.value );
          refController.selectedCityPerm.value = item?['City']==""?"0":item?['City'] ?? '0';
          refController.refPincodeController.text= item?["PinCode"] ?? '';
          refController.selectedCountry.value =item?['Country']==""?"":item?['Country'] ?? '0';
          referencesList.add(refController);
        }
      } else {
        print("Expected a List but got: ${decoded.runtimeType}");
      }
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
