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
  var selectedProdTypeOrTypeLoan = Rxn<String>();

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





  var selectedStateProp = Rxn<String>();
  var selectedDistrictProp = Rxn<String>();
  var selectedCityProp = Rxn<String>();


  var coApplicantList = <CoApplicantDetailController>[].obs;
  var familyMemberApplList = <FamilyMemberController>[].obs;
  var creditCardsList = <CreditCardsController>[].obs;
  var referencesList = <ReferenceController>[].obs;

  var currentStep = 0.obs;
  var stepCompleted = List<bool>.filled(7, false).obs;
  LeadDDController leadDController=Get.find();
  final List<String> titles = [
    'Personal Information', 'Co-Applicant Details', 'Property Details', 'Family Members', 'Credit Cards', 'Financial Details', 'References'
  ];

  var selectedBank = Rxn<int>();
  var selectedBankBranch = Rxn<int>();
  var selectedChannel = Rxn<String>();

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
    print("Form Saved!");
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    leadId.value = Get.arguments['leadId'];
    getLoanApplicationDetailsByIdApi(id:leadId.value);

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
          dateOfSalary:"2025-04-26T10:21:07.889Z",                ///its static
      );


      final coApModel = CoApplicantModel(
        name: cleanText(coAp.coApFullNameController.text),
        fatherName:cleanText(coAp.coApFatherNameController.text),
        gender: coAp.selectedGenderCoAP.value?? "",
        dateOfBirth:"2025-04-26T10:21:07.889Z",                ///its static
        qualification: cleanText(qualiController.text),
        emailID:  cleanText(coAp.coApEmailController.text),
        maritalStatus: cleanText(coAp.coApMaritalController.text),
        status: "",                                            ///its static
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
        birthDate: "2025-04-26T10:21:07.889Z",                ///its static
        gender: fam.selectedGenderFam.value?? "",
        relationWithApplicant: cleanText(fam.famRelWithApplController.text),
        dependent: fam.isFamDependent ?? false,
        monthlyIncome: fam.famMonthlyIncomeController.toIntOrZero(),
        employedWith: cleanText(fam.famEmployedWithController.text)
      );
      familyMembersModels.add(famModel);
    }

    for (var cc in creditCardsList) {
      final ccModel = CreditCardModel(
        companyBank: cleanText(cc.ccCompBankController.text),
        cardNumber: cleanText(cc.ccCardNumberController.text),
        havingSince: "2025-04-29T09:38:11.038Z",                             ///its static
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

    print("payload==>${coApPayload.toString()}");
    print("famPayload==>${famPayload.toString()}");
    print("ccPayload==>${ccPayload.toString()}");
    print("refPayload==>${refPayload.toString()}");
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

print("addLoanApplicationApi");

print("Helper.formatDate(proFeeDateController.text)===>${proFeeDateController.text.toString()}");
print("Helper.formatDate(proFeeDateController.text)===>${Helper.formatDate(proFeeDateController.text)}");



      print("leadId==>${leadId.value}");
      var data = await LoanApplService.addLoanApplicationApi(
        body:[
          {
            "id": leadId.value,
            "dsaCode": cleanText(dsaCodeController.text),
            "loanApplicationNo": cleanText(lanController.text),
            "bankId": selectedBank.value,
            "branchId": selectedBankBranch.value,
            "typeOfLoanId": selectedProdTypeOrTypeLoan.value.toIntOrZero(),
            "panCardNumber":  cleanText(panController.text),
            "addharCardNumber":  cleanText(aadharController.text),
            "loanAmountApplied": laAppliedController.toIntOrZero(),
            "uniqueLeadNumber": cleanText(ulnController.text),
            "channelId": selectedChannel.value.toIntOrZero(),
            "channelCode": cleanText(chCodeController.text),
            "detailForLoanApplication": {
              "branch":selectedBankBranch.value,
              "dsaCode": cleanText(dsaCodeController.text),
              "dsaStaffName": cleanText(dsaStaffNController.text),
              "loanApplicationNo":cleanText(lanController.text),
              "processingFee":proFeeController.toIntOrZero(),
              "chqDdSlipNo": cleanText(chqDDSNController.text),
              "processingFeeDate": "2025-04-29T13:36:29.953Z",                     ///its static
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
                "dateOfBirth": "2025-04-29T13:36:29.953Z",                 ///its static
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
                  "dateOfSalary": "2025-04-26T10:21:07.889Z"                  ///its static
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
              "societyBuildingName":  cleanText(propSocietyNameController.text),
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
            "references": refPayload
          }


        ]
      );
print("data in API cot-->${data.toString()}");



      if(data['success'] == true){

        addLoanApplicationModel.value= AddLoanApplicationModel.fromJson(data);
        ToastMessage.msg( addLoanApplicationModel.value!.message!.toString());


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




  String cleanText(String text) {
    return text.trim().isEmpty ? "" : text.trim();
  }

  int cleanInt(Rxn<String> rxnString) {
    if (rxnString.value != null && rxnString.value!.isNotEmpty) {
      return int.tryParse(rxnString.value!.trim()) ?? 0;
    }
    return 0;
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


      if(req['success'] == true){

        getLoanApplIdModel.value= GetLoanApplIdModel.fromJson(req);
        Map<String, dynamic>? detailMap;
        if (getLoanApplIdModel.value!.data!.detailForLoanApplication != null) {
          detailMap = jsonDecode(getLoanApplIdModel.value!.data!.detailForLoanApplication!);
        }
        final data = getLoanApplIdModel.value!.data;

        dsaCodeController.text = data?.dsaCode ?? '';
        lanController.text = data?.loanApplicationNo ?? '';
        selectedBank.value =  data?.bankId ?? 0;

        await leadDDController.getAllBranchByBankIdApi(bankId: data?.branchId ?? 0);
        await leadDDController.getProductListByBankIdApi(bankId: data?.branchId ?? 0);

        selectedBankBranch.value = data?.branchId ?? 0;
        // selectedProdTypeOrTypeLoan.value = data?.typeOfLoan ?? 0;
        // panController.text = data?.panCardNumber ?? '';
        // aadharController.text = data?.addharCardNumber ?? '';
        // laAppliedController.text = data?.loanAmountApplied?.toString() ?? '';
        // ulnController.text = data?.uniqueLeadNumber ?? '';
        // selectedChannel.value = data?.channelId ?? 0;
        // chCodeController.text = data?.channelCode ?? '';

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
