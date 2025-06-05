import 'dart:convert';

import 'package:get/get.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import 'package:ksdpl/controllers/product/view_product_controller.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
import 'package:ksdpl/services/product_service.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/loan_application/AddLoanApplicationModel.dart';
import '../../models/loan_application/GetLoanApplIdModel.dart';
import '../../models/loan_application/special_model/CoApplicantModel.dart';
import '../../models/loan_application/special_model/CreditCardModel.dart';
import '../../models/loan_application/special_model/FamilyMemberModel.dart';
import '../../models/loan_application/special_model/ReferenceModel.dart';
import '../../models/product/AddProductListModel.dart';
import '../../models/product/GetAllNegativeProfileModel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import '../../models/product/GetAllNegativeProfileModel.dart' as negProfile;
import '../../models/product/GetAllProductCategoryModel.dart';
import '../../models/product/GetDocumentProductIdModel.dart';
import '../../models/product/GetProductListById.dart';
import '../../models/product/AddProductDocumentModel.dart';
import '../../services/loan_appl_service.dart';
import '../loan_appl_controller/co_applicant_detail_mode_controllerl.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../loan_appl_controller/credit_cards_model_controller.dart';
import '../loan_appl_controller/reference_model_controller.dart';

class AddProductController extends GetxController{

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


  var selectedStateProp = Rxn<String>();
  var selectedDistrictProp = Rxn<String>();
  var selectedCityProp = Rxn<String>();


  var coApplicantList = <CoApplicantDetailController>[].obs;
  var familyMemberApplList = <FamilyMemberController>[].obs;
  var creditCardsList = <CreditCardsController>[].obs;
  var referencesList = <ReferenceController>[].obs;

  var currentStep = 0.obs;
  var stepCompleted = List<bool>.filled(8, false).obs;
  LeadDDController leadDController=Get.find();
  final List<String> titles = [
    'Step 1', 'Step 2', 'Step 3', 'Step 4',
  ];

  var selectedBank = Rxn<int>();
  var selectedBankBranch = Rxn<int>();
  var selectedChannel = Rxn<int>();


  final scrollController = ScrollController();


  ///product
  // Email and Basic Info
  final TextEditingController prodBankersNameController = TextEditingController();
  final TextEditingController prodBankersMobController = TextEditingController();
  final TextEditingController prodBankersWhatsappController = TextEditingController();
  final TextEditingController prodBankersEmailController = TextEditingController();
  final TextEditingController prodMinCibilController = TextEditingController();
  final TextEditingController prodProductNameController = TextEditingController();

// Exclusions
  final TextEditingController prodCollateralSecurityExcludedController = TextEditingController();
  final TextEditingController prodProfileExcludedController = TextEditingController();

// Age Limits
  final TextEditingController prodAgeLimitEarningApplicantsController = TextEditingController();
  final TextEditingController prodAgeLimitNonEarningCoApplicantController = TextEditingController();
  final TextEditingController prodMinAgeEarningApplicantsController = TextEditingController();
  final TextEditingController prodMinAgeNonEarningApplicantsController = TextEditingController();

// Income & Loan Details
  final TextEditingController prodMinIncomeCriteriaController = TextEditingController();
  final TextEditingController prodMinLoanAmountController = TextEditingController();
  final TextEditingController prodMaxLoanAmountController = TextEditingController();
  final TextEditingController prodProfitPercentageController = TextEditingController();
  final TextEditingController prodMinTenorController = TextEditingController();
  final TextEditingController prodMaxTenorController = TextEditingController();
  final TextEditingController prodMinRoiController = TextEditingController();
  final TextEditingController prodMaxRoiController = TextEditingController();
  final TextEditingController prodMaxTenorEligibilityCriteriaController = TextEditingController();

// Geographical & Profile Restrictions
    final TextEditingController prodGeoLimitController = TextEditingController();
  final TextEditingController prodNegativeProfilesController = TextEditingController();
  final TextEditingController prodNegativeAreasController = TextEditingController();

// Property & Financial Ratios
  final TextEditingController prodMinPropertyValueController = TextEditingController();
  final TextEditingController prodMaxIirController = TextEditingController();
  final TextEditingController prodMaxFoirController = TextEditingController();
  final TextEditingController prodMaxLtvController = TextEditingController();

// Fees
  final TextEditingController prodProcessingFeeController = TextEditingController();
  final TextEditingController prodLegalFeeController = TextEditingController();
  final TextEditingController prodTechnicalFeeController = TextEditingController();
  final TextEditingController prodAdminFeeController = TextEditingController();
  final TextEditingController prodForeclosureChargesController = TextEditingController();
  final TextEditingController prodOtherChargesController = TextEditingController();
  final TextEditingController prodStampDutyController = TextEditingController();

  final TextEditingController prodProcessingChargesController = TextEditingController();

// TSR and Misc
  final TextEditingController prodTsrYearsController = TextEditingController();
  final TextEditingController prodTsrChargesController = TextEditingController();
  final TextEditingController prodValuationChargesController = TextEditingController();

  final TextEditingController prodProductValidateFromController = TextEditingController();
  final TextEditingController prodProductValidateToController = TextEditingController();
  final TextEditingController prodMaxTatController = TextEditingController();

  final TextEditingController prodFromAmtController = TextEditingController();
  final TextEditingController prodToAmtController = TextEditingController();
  final TextEditingController prodTotalOverdueCasesController = TextEditingController();
  final TextEditingController prodTotalOverdueAmtController = TextEditingController();
  final TextEditingController prodTotalEnquiriesController = TextEditingController();

// Descriptions
  final TextEditingController prodDocumentDescriptionsController = TextEditingController();
  final TextEditingController prodProductDescriptionsController = TextEditingController();
  final TextEditingController prodNoOfDocController = TextEditingController();
  var prodSegmentList=["Insurance", "Secured","Unsecured", ];
  var selectedprodSegment = Rxn<String>();
  RxList<String> customerCategoryList = [
    "Salaried",
    "Salaried NRI",
    "Self Employed Professional",
    "Self Employed Non Professional",
    "Non-Individual",
    "Others"
  ].obs;

  RxList<String> selectedCustomerCategories = <String>[].obs;

  var getAllProductCategoryModel = Rxn<productCat.GetAllProductCategoryModel>(); //
  var addProductListModel = Rxn<AddProductListModel>(); //
  var addProductDocumentModel = Rxn<AddProductDocumentModel>(); //
  RxList<productCat.Data> productCategoryList = <productCat.Data>[].obs;
  RxList<negProfile.Data> negProfileApiList = <negProfile.Data>[].obs;
  var isLoadingProductCategory = false.obs;
  var isProductLoading = false.obs;
  var selectedKsdplProduct = Rxn<int>();

  var selectedProductCategory = Rxn<int>();
  var collSecCatList=[
    "Residential Plot",
    "Self Occupied Residential Property",
    "Rented Residential Property",
    "Self Occupied Property with tenant",
    "Self Occupied Commercial Property",
    "Rented Commercial Property",
    "Agriculture Land",
    "House on Agriculture Land",
    "Volatility Risk Premium",
    "Industrial",
    "Gold",
    "Legally Defective Title",
    "Property with Technical issues",
    "Others",
  ];
  var incomeTypeList=[
    "Bank Salary with PF",
    "Bank Salary without PF",
    "Cash Salary",
    "Regular 3 years ITR",
    "Regular Two Years ITR",
    "Irregular 3 years ITR",
    "Same date Two Years ITR",
    "One Year ITR",
    "GST Turnover Based Income Assessment",
    "Average Banking Balance Income Assessment",
    "PD Based Cash Flow Assessment",
    "Loan against rental receivables",
    "Other",
  ];
  var selectedCollSecCat = <String>[].obs;
  var selectedIncomeType = <String>[].obs;
  RxList<negProfile.Data> selectedNegProfile = <negProfile.Data>[].obs;
  var selectedProdDescr = <String>[].obs;
  var selectedNegArea = <String>[].obs;

  RxList<String> chips = <String>[].obs;
  TextEditingController chipTextController = TextEditingController();
  TextEditingController chipText2Controller = TextEditingController();
  TextEditingController chipText3Controller = TextEditingController();

  var getProductListById = Rxn<GetProductListById>(); //
  var getDocumentProductIdModel = Rxn<GetDocumentProductIdModel>(); //
  var getAllNegativeProfileModel = Rxn<GetAllNegativeProfileModel>(); //

  void addChip(String value) {
    if (value.trim().isNotEmpty && !chips.contains(value.trim())) {
      chips.add(value.trim());
      chipTextController.clear();
    }
  }
  void removeChip(String value) {
    chips.remove(value);
  }

  void clearAllChips() {
    chips.clear();
    chipTextController.clear();
  }
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

  }

  final processingFeeFieldKey = GlobalKey<FormFieldState>();
  final processingFeeFocusNode = FocusNode();

  List<GlobalKey<FormState>> stepFormKeys = List.generate(4, (_) => GlobalKey<FormState>());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  bool validateAllSteps(List<GlobalKey<FormState>> stepFormKeys) {
    bool allValid = true;

    for (var formKey in stepFormKeys) {
      final isStepValid = formKey.currentState?.validate() ?? false;
      if (!isStepValid) {
        allValid = false;
      }
    }

    return allValid;
  }

  void validateAndSubmit() async {

  /*  for (int i = 0; i < stepFormKeys.length; i++) {
      print("✅ i==>${i}");
      final formKey = stepFormKeys[i];

      final formState = formKey.currentState;
      if (formState != null) {
        if (!formState.validate()) {
          // Jump to the step with the first error
          jumpToStep(i);

          await Future.delayed(Duration(milliseconds: 300)); // Let the UI update

          // Handle known field errors (like processing fee)
          if (i == 3) {
            final context = processingFeeFieldKey.currentContext;
            if (context != null) {
              Scrollable.ensureVisible(
                context,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                alignment: 0.3,
              );
              processingFeeFocusNode.requestFocus();
            }
          }

          return;
        }
      }
    }*/

    // All forms are valid!
    print("✅ All forms passed validation. Submit to API now.");
    if(selectedKsdplProduct.value==null){
      jumpToStep(0);

      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select KSDPL Product");
    }else if(selectedProductCategory.value==null){
      jumpToStep(0);

      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select Product Segment");
    }else if(prodProductNameController.text.isEmpty){
      jumpToStep(0);

      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please name the product");
    }else{

      print("neg pro==>${Helper.convertListToCsvSafe(
          selectedNegProfile.map((e) => e.negativeProfile.toString()).toList()
      )}");


      addProductListApi(
        Id: "0",
        BankId:selectedBank.value?.toString(),
        bankers_Name:prodBankersNameController.text,
        Bankers_Mobile_Number:prodBankersMobController.text,
        Bankers_WhatsApp_Number:prodBankersWhatsappController.text,
        BankersEmailId:prodBankersEmailController.text,
        Min_CIBIL:prodMinCibilController.text,
        Segment_Vertical:selectedProductCategory.value.toString(),
        Product:prodProductNameController.text,
        ProductDescription:prodProductDescriptionsController.text,
        Customer_Category:Helper.convertListToCsvSafe(selectedCustomerCategories.value),
        Collateral_Security_Category:Helper.convertListToCsvSafe(selectedCollSecCat.value),
        Collateral_Security_Excluded:prodCollateralSecurityExcludedController.text,
        Income_Types:Helper.convertListToCsvSafe(selectedIncomeType.value),
        Profile_Excluded:prodProfileExcludedController.text,
        Age_limit_Earning_Applicants:prodAgeLimitEarningApplicantsController.text,
        Age_limit_Non_Earning_Co_Applicant:prodAgeLimitNonEarningCoApplicantController.text,
        Minimum_age_earning_applicants:prodMinAgeEarningApplicantsController.text,
        Minimum_age_non_earning_applicants:prodMinAgeNonEarningApplicantsController.text,
        Minimum_Income_Criteria:prodMinIncomeCriteriaController.text,
         Minimum_Loan_Amount:prodMinLoanAmountController.text,
         Maximum_Loan_Amount:prodMinLoanAmountController.text,
         Min_Tenor:prodMinTenorController.text,
         Maximum_Tenor:prodMaxTenorController.text,
         Minimum_ROI: prodMinRoiController.text,
         Maximum_ROI:prodMaxRoiController.text,
         Maximum_Tenor_Eligibility_Criteria:prodMaxTenorEligibilityCriteriaController.text,
         Geo_Limit:prodGeoLimitController.text,
         Negative_Profiles:Helper.convertListToCsvSafe(
             selectedNegProfile.map((e) => e.negativeProfile.toString()).toList()
         ),
         Negative_Areas:Helper.convertListToCsvSafe(selectedNegArea.value),
         Maximum_TAT:prodMaxTatController.text,
         Minimum_Property_Value:prodMinPropertyValueController.text,
         Maximum_IIR:prodMaxIirController.text.isEmpty?prodMaxFoirController.text:prodMaxIirController.text,
         Maximum_FOIR:prodMaxFoirController.text,
         Maximum_LTV:prodMaxLtvController.text,
         Processing_Fee:prodProcessingFeeController.text,
         Legal_Fee:prodLegalFeeController.text,
         Technical_Fee:prodTechnicalFeeController.text,
         Admin_Fee:prodAdminFeeController.text,
         Foreclosure_Charges:prodForeclosureChargesController.text,
         Processing_Charges:prodProcessingChargesController.text,
         Other_Charges:prodOtherChargesController.text,
         Stamp_Duty:prodStampDutyController.text,
         TSR_Years:prodTsrYearsController.text,
         TSR_Charges:prodTsrChargesController.text,
         Valuation_Charges:prodValuationChargesController.text,
         NoOfDocument:"${selectedProdDescr.value?.length ?? 0}",
         Product_Validate_From_date:prodProductValidateFromController.text.isNotEmpty?Helper.convertToIso8601(prodProductValidateFromController.text):"",
         Product_Validate_To_date:prodProductValidateToController.text.isNotEmpty?Helper.convertToIso8601(prodProductValidateToController.text):"",
         Profit_Percentage:prodProfitPercentageController.text,
         KSDPLProductId:selectedKsdplProduct.value.toString(),
         docDescr:Helper.convertListToCsvSafe(selectedProdDescr.value),
        FromAmountRange:prodFromAmtController.text,
        ToAmountRange: prodToAmtController.text,
        TotalOverdueCases: prodTotalOverdueCasesController.text,
        TotalOverdueAmount: prodTotalOverdueAmtController.text,
        TotalEnquiries: prodTotalEnquiriesController.text,
      );

    }


  }
  void validateAndUpdate() {





    if(selectedKsdplProduct.value==null){
      jumpToStep(0);

      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select KSDPL Product");
    }else{

      updateProductListApi(
          Id: getProductListById.value!.data!.id.toString(),
          BankId:selectedBank.value?.toString(),
          bankers_Name:prodBankersNameController.text,
          Bankers_Mobile_Number:prodBankersMobController.text,
          Bankers_WhatsApp_Number:prodBankersWhatsappController.text,
          BankersEmailId:prodBankersEmailController.text,
          Min_CIBIL:prodMinCibilController.text,
          Segment_Vertical:selectedProductCategory.value.toString(),
          Product:prodProductNameController.text,
          ProductDescription:prodProductDescriptionsController.text,
          Customer_Category:Helper.convertListToCsvSafe(selectedCustomerCategories.value),
          Collateral_Security_Category:Helper.convertListToCsvSafe(selectedCollSecCat.value),
          Collateral_Security_Excluded:prodCollateralSecurityExcludedController.text,
          Income_Types:Helper.convertListToCsvSafe(selectedIncomeType.value),
          Profile_Excluded:prodProfileExcludedController.text,
          Age_limit_Earning_Applicants:prodAgeLimitEarningApplicantsController.text,
          Age_limit_Non_Earning_Co_Applicant:prodAgeLimitNonEarningCoApplicantController.text,
          Minimum_age_earning_applicants:prodMinAgeEarningApplicantsController.text,
          Minimum_age_non_earning_applicants:prodMinAgeNonEarningApplicantsController.text,
          Minimum_Income_Criteria:prodMinIncomeCriteriaController.text,
          Minimum_Loan_Amount:prodMinLoanAmountController.text,
          Maximum_Loan_Amount:prodMaxLoanAmountController.text,
          Min_Tenor:prodMinTenorController.text,
          Maximum_Tenor:prodMaxTenorController.text,
          Minimum_ROI: prodMinRoiController.text,
          Maximum_ROI:prodMaxRoiController.text,
          Maximum_Tenor_Eligibility_Criteria:prodMaxTenorEligibilityCriteriaController.text,
          Geo_Limit:prodGeoLimitController.text,
          Negative_Profiles:Helper.convertListToCsvSafe(
            selectedNegProfile.map((e) => e.negativeProfile.toString()).toList()
           ),
          Negative_Areas:Helper.convertListToCsvSafe(selectedNegArea.value),
          Maximum_TAT:prodMaxTatController.text,
          Minimum_Property_Value:prodMinPropertyValueController.text,
          Maximum_IIR:prodMaxIirController.text.isEmpty?prodMaxFoirController.text:prodMaxIirController.text,
          Maximum_FOIR:prodMaxFoirController.text,
          Maximum_LTV:prodMaxLtvController.text,
          Processing_Fee:prodProcessingFeeController.text,
          Legal_Fee:prodLegalFeeController.text,
          Technical_Fee:prodTechnicalFeeController.text,
          Admin_Fee:prodAdminFeeController.text,
          Foreclosure_Charges:prodForeclosureChargesController.text,
          Other_Charges:prodOtherChargesController.text,
          Stamp_Duty:prodStampDutyController.text,
          TSR_Years:prodTsrYearsController.text,
          TSR_Charges:prodTsrChargesController.text,
          Valuation_Charges:prodValuationChargesController.text,
          NoOfDocument:prodNoOfDocController.text,
          Product_Validate_From_date:prodProductValidateFromController.text.isNotEmpty?Helper.convertToIso8601(prodProductValidateFromController.text):"",
          Product_Validate_To_date:prodProductValidateToController.text.isNotEmpty?Helper.convertToIso8601(prodProductValidateToController.text):"",
          Profit_Percentage:prodProfitPercentageController.text,
          KSDPLProductId:selectedKsdplProduct.value.toString(),
        docDescr:Helper.convertListToCsvSafe(selectedProdDescr.value),
        Processing_Charges:prodProcessingChargesController.text,
      );

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


    ///product
    selectedprodSegment.value = null;
    selectedCustomerCategories.clear();
    selectedKsdplProduct.value = null;
    selectedProductCategory.value = null;
    selectedCollSecCat.clear();
    selectedIncomeType.clear();
    selectedNegProfile.clear();
    selectedNegArea.clear();

    // Clear chips
    chips.clear();
    chipTextController.dispose();
    chipText2Controller.dispose();
    chipText3Controller.dispose();

    // Dispose all TextEditingControllers
    prodBankersNameController.dispose();
    prodBankersMobController.dispose();
    prodBankersWhatsappController.dispose();
    prodBankersEmailController.dispose();
    prodMinCibilController.dispose();
    prodProductNameController.dispose();

    prodCollateralSecurityExcludedController.dispose();
    prodProfileExcludedController.dispose();

    prodAgeLimitEarningApplicantsController.dispose();
    prodAgeLimitNonEarningCoApplicantController.dispose();
    prodMinAgeEarningApplicantsController.dispose();
    prodMinAgeNonEarningApplicantsController.dispose();

    prodMinIncomeCriteriaController.dispose();
    prodMinLoanAmountController.dispose();
    prodMaxLoanAmountController.dispose();
    prodProfitPercentageController.dispose();
    prodMinTenorController.dispose();
    prodMaxTenorController.dispose();
    prodMinRoiController.dispose();
    prodMaxRoiController.dispose();
    prodMaxTenorEligibilityCriteriaController.dispose();

    prodGeoLimitController.dispose();
    prodNegativeProfilesController.dispose();
    prodNegativeAreasController.dispose();

    prodMinPropertyValueController.dispose();
    prodMaxIirController.dispose();
    prodMaxFoirController.dispose();
    prodMaxLtvController.dispose();

    prodProcessingFeeController.dispose();
    prodLegalFeeController.dispose();
    prodTechnicalFeeController.dispose();
    prodAdminFeeController.dispose();
    prodForeclosureChargesController.dispose();
    prodOtherChargesController.dispose();
    prodStampDutyController.dispose();

    prodTsrYearsController.dispose();
    prodTsrChargesController.dispose();
    prodValuationChargesController.dispose();

    prodProductValidateFromController.dispose();
    prodProductValidateToController.dispose();
    prodMaxTatController.dispose();

    prodDocumentDescriptionsController.dispose();
    prodProductDescriptionsController.dispose();
    prodNoOfDocController.dispose();

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


  ///product
  void clearForm() {
    // Clear text fields
    prodBankersNameController.clear();
    prodBankersMobController.clear();
    prodBankersWhatsappController.clear();
    prodBankersEmailController.clear();
    prodMinCibilController.clear();
    prodProductNameController.clear();

    prodCollateralSecurityExcludedController.clear();
    prodProfileExcludedController.clear();

    prodAgeLimitEarningApplicantsController.clear();
    prodAgeLimitNonEarningCoApplicantController.clear();
    prodMinAgeEarningApplicantsController.clear();
    prodMinAgeNonEarningApplicantsController.clear();

    prodMinIncomeCriteriaController.clear();
    prodMinLoanAmountController.clear();
    prodMaxLoanAmountController.clear();
    prodProfitPercentageController.clear();
    prodMinTenorController.clear();
    prodMaxTenorController.clear();
    prodMinRoiController.clear();
    prodMaxRoiController.clear();
    prodMaxTenorEligibilityCriteriaController.clear();

    prodGeoLimitController.clear();
    prodNegativeProfilesController.clear();
    prodNegativeAreasController.clear();

    prodMinPropertyValueController.clear();
    prodMaxIirController.clear();
    prodMaxFoirController.clear();
    prodMaxLtvController.clear();

    prodProcessingFeeController.clear();
    prodLegalFeeController.clear();
    prodTechnicalFeeController.clear();
    prodAdminFeeController.clear();
    prodForeclosureChargesController.clear();
    prodOtherChargesController.clear();
    prodStampDutyController.clear();

    prodTsrYearsController.clear();
    prodTsrChargesController.clear();
    prodValuationChargesController.clear();

    prodProductValidateFromController.clear();
    prodProductValidateToController.clear();
    prodMaxTatController.clear();

    prodDocumentDescriptionsController.clear();
    prodProductDescriptionsController.clear();
    prodNoOfDocController.clear();

    // Reset reactive values
    selectedprodSegment.value = null;
    selectedCustomerCategories.clear();
    selectedKsdplProduct.value = null;
    selectedProductCategory.value = null;
    selectedBank.value=null;
    selectedCollSecCat.clear();
    selectedIncomeType.clear();
    selectedNegProfile.clear();
    selectedNegArea.clear();

    // Clear chips
    chips.clear();
    chipTextController.clear();
    chipText2Controller.clear();
    chipText3Controller.clear();
  }

  Future<void>  getAllProductCategoryApi() async {
    try {
      isLoadingProductCategory(true);


      var data = await ProductService.getAllProductCategoryApi();


      if(data['success'] == true){


        getAllProductCategoryModel.value= GetAllProductCategoryModel.fromJson(data);


        final List<productCat.Data> allCategories = getAllProductCategoryModel.value?.data ?? [];

        final List<productCat.Data> activeCategories = allCategories.where((cat) => cat.active == true).toList();

        productCategoryList.value = activeCategories;





        isLoadingProductCategory(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllProductCategoryModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllLeadsApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoadingProductCategory(false);
    } finally {

      isLoadingProductCategory(false);
    }
  }

  void  addProductListApi({
    required String KSDPLProductId,
    String? Id,
    String? BankId,
    String? bankers_Name,
    String? Bankers_Mobile_Number,
    String? Bankers_WhatsApp_Number,
    String? BankersEmailId,
    String? Min_CIBIL,
    String? Segment_Vertical,
    String? Product,
    String? ProductDescription,
    String? Customer_Category,
    String? Collateral_Security_Category,
    String? Collateral_Security_Excluded,
    String? Income_Types,
    String? Profile_Excluded,
    String? Age_limit_Earning_Applicants,
    String? Age_limit_Non_Earning_Co_Applicant,
    String? Minimum_age_earning_applicants,
    String? Minimum_age_non_earning_applicants,
    String? Minimum_Income_Criteria,
    String? Minimum_Loan_Amount,
    String? Maximum_Loan_Amount,
    String? Min_Tenor,
    String? Maximum_Tenor,
    String? Minimum_ROI,
    String? Maximum_ROI,
    String? Maximum_Tenor_Eligibility_Criteria,
    String? Geo_Limit,
    String? Negative_Profiles,
    String? Negative_Areas,
    String? Maximum_TAT,
    String? Minimum_Property_Value,
    String? Maximum_IIR,
    String? Maximum_FOIR,
    String? Maximum_LTV,
    String? Processing_Fee,
    String? Legal_Fee,
    String? Technical_Fee,
    String? Admin_Fee,
    String? Foreclosure_Charges,
    String? Processing_Charges,
    String? Other_Charges,
    String? Stamp_Duty,
    String? TSR_Years,
    String? TSR_Charges,
    String? Valuation_Charges,
    String? NoOfDocument,
    String? Product_Validate_From_date,
    String? Product_Validate_To_date,
    String? Profit_Percentage,
    String? docDescr,
    String? FromAmountRange,
    String? ToAmountRange,
    String? TotalOverdueCases,
    String? TotalOverdueAmount,
    String? TotalEnquiries,
}) async {
    try {
      isLoading(true);


      var data = await ProductService.addProductListApi(
        KSDPLProductId: KSDPLProductId,
        Id: Id,
        BankId: BankId,
        bankers_Name: bankers_Name,
        Bankers_Mobile_Number: Bankers_Mobile_Number,
        Bankers_WhatsApp_Number: Bankers_WhatsApp_Number,
        BankersEmailId: BankersEmailId,
        Min_CIBIL: Min_CIBIL,
        Segment_Vertical: Segment_Vertical,
        Product: Product,
        ProductDescription: ProductDescription,
        Customer_Category: Customer_Category,
        Collateral_Security_Category: Collateral_Security_Category,
        Collateral_Security_Excluded: Collateral_Security_Excluded,
        Income_Types: Income_Types,
        Profile_Excluded: Profile_Excluded,
        Age_limit_Earning_Applicants: Age_limit_Earning_Applicants,
        Age_limit_Non_Earning_Co_Applicant: Age_limit_Non_Earning_Co_Applicant,
        Minimum_age_earning_applicants: Minimum_age_earning_applicants,
        Minimum_age_non_earning_applicants: Minimum_age_non_earning_applicants,
        Minimum_Income_Criteria: Minimum_Income_Criteria,
        Minimum_Loan_Amount: Minimum_Loan_Amount,
        Min_Tenor: Min_Tenor,
        Maximum_Tenor: Maximum_Tenor,
        Minimum_ROI: Minimum_ROI,
        Maximum_ROI: Maximum_ROI,
        Maximum_Tenor_Eligibility_Criteria: Maximum_Tenor_Eligibility_Criteria,
        Geo_Limit: Geo_Limit,
        Negative_Profiles: Negative_Profiles,
        Negative_Areas: Negative_Areas,
        Maximum_TAT: Maximum_TAT,
        Minimum_Property_Value: Minimum_Property_Value,
        Maximum_IIR: Maximum_IIR,
        Maximum_FOIR: Maximum_FOIR,
        Maximum_LTV: Maximum_LTV,
        Processing_Fee: Processing_Fee,
        Legal_Fee: Legal_Fee,
        Technical_Fee: Technical_Fee,
        Admin_Fee: Admin_Fee,
        Foreclosure_Charges: Foreclosure_Charges,
          Processing_Charges: Processing_Charges,
        Other_Charges: Other_Charges,
        Stamp_Duty: Stamp_Duty,
        TSR_Years: TSR_Years,
        TSR_Charges: TSR_Charges,
        Valuation_Charges: Valuation_Charges,
        NoOfDocument: NoOfDocument,
        Product_Validate_From_date: Product_Validate_From_date,
        Product_Validate_To_date: Product_Validate_To_date,
        Profit_Percentage: Profit_Percentage,
        docDescr: docDescr,
          FromAmountRange:FromAmountRange,
        ToAmountRange: ToAmountRange,
        TotalOverdueAmount: TotalOverdueAmount,
        TotalOverdueCases: TotalOverdueCases,
        TotalEnquiries: TotalEnquiries,

      );




      if(data['success'] == true){


        addProductListModel.value= AddProductListModel.fromJson(data);
        ToastMessage.msg(addProductListModel.value!.message!);


        isLoading(false);
        if(docDescr!.isNotEmpty){
          String productDocument = docDescr.toString();

          int productId = int.parse(addProductListModel.value!.data!.id.toString()); // replace with your actual productId
          String documentType = "O";

          List<Map<String, dynamic>> documentPayload = productDocument
              .split(',')
              .map((doc) => {
            "productId": productId,
            "documentName": doc.trim(),
            "documentType": documentType,
          })
              .toList();

          await ProductService.addProductDocumentApi(body: documentPayload);
        }


        clearForm();
        Get.back();

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        addProductListModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {
      clearForm();
      isLoading(false);
    }
  }

  void  updateProductListApi({
    required String KSDPLProductId,
    String? Id,
    String? BankId,
    String? bankers_Name,
    String? Bankers_Mobile_Number,
    String? Bankers_WhatsApp_Number,
    String? BankersEmailId,
    String? Min_CIBIL,
    String? Segment_Vertical,
    String? Product,
    String? ProductDescription,
    String? Customer_Category,
    String? Collateral_Security_Category,
    String? Collateral_Security_Excluded,
    String? Income_Types,
    String? Profile_Excluded,
    String? Age_limit_Earning_Applicants,
    String? Age_limit_Non_Earning_Co_Applicant,
    String? Minimum_age_earning_applicants,
    String? Minimum_age_non_earning_applicants,
    String? Minimum_Income_Criteria,
    String? Minimum_Loan_Amount,
    String? Maximum_Loan_Amount,
    String? Min_Tenor,
    String? Maximum_Tenor,
    String? Minimum_ROI,
    String? Maximum_ROI,
    String? Maximum_Tenor_Eligibility_Criteria,
    String? Geo_Limit,
    String? Negative_Profiles,
    String? Negative_Areas,
    String? Maximum_TAT,
    String? Minimum_Property_Value,
    String? Maximum_IIR,
    String? Maximum_FOIR,
    String? Maximum_LTV,
    String? Processing_Fee,
    String? Processing_Charges,
    String? Legal_Fee,
    String? Technical_Fee,
    String? Admin_Fee,
    String? Foreclosure_Charges,
    String? Other_Charges,
    String? Stamp_Duty,
    String? TSR_Years,
    String? TSR_Charges,
    String? Valuation_Charges,
    String? NoOfDocument,
    String? Product_Validate_From_date,
    String? Product_Validate_To_date,
    String? Profit_Percentage,
    String? docDescr,
    String? FromAmountRange,
    String? ToAmountRange,
    String? TotalOverdueCases,
    String? TotalOverdueAmount,
    String? TotalEnquiries,
  }) async {
    try {
      isLoading(true);

      var data = await ProductService.updateProductListApi(
        KSDPLProductId: KSDPLProductId,
        Id: Id,
        BankId: BankId,
        bankers_Name: bankers_Name,
        Bankers_Mobile_Number: Bankers_Mobile_Number,
        Bankers_WhatsApp_Number: Bankers_WhatsApp_Number,
        BankersEmailId: BankersEmailId,
        Min_CIBIL: Min_CIBIL,
        Segment_Vertical: Segment_Vertical,
        Product: Product,
        ProductDescription: ProductDescription,
        Customer_Category: Customer_Category,
        Collateral_Security_Category: Collateral_Security_Category,
        Collateral_Security_Excluded: Collateral_Security_Excluded,
        Income_Types: Income_Types,
        Profile_Excluded: Profile_Excluded,
        Age_limit_Earning_Applicants: Age_limit_Earning_Applicants,
        Age_limit_Non_Earning_Co_Applicant: Age_limit_Non_Earning_Co_Applicant,
        Minimum_age_earning_applicants: Minimum_age_earning_applicants,
        Minimum_age_non_earning_applicants: Minimum_age_non_earning_applicants,
        Minimum_Income_Criteria: Minimum_Income_Criteria,
        Minimum_Loan_Amount: Minimum_Loan_Amount,
        Maximum_Loan_Amount: Maximum_Loan_Amount,
        Min_Tenor: Min_Tenor,
        Maximum_Tenor: Maximum_Tenor,
        Minimum_ROI: Minimum_ROI,
        Maximum_ROI: Maximum_ROI,
        Maximum_Tenor_Eligibility_Criteria: Maximum_Tenor_Eligibility_Criteria,
        Geo_Limit: Geo_Limit,
        Negative_Profiles: Negative_Profiles,
        Negative_Areas: Negative_Areas,
        Maximum_TAT: Maximum_TAT,
        Minimum_Property_Value: Minimum_Property_Value,
        Maximum_IIR: Maximum_IIR,
        Maximum_FOIR: Maximum_FOIR,
        Maximum_LTV: Maximum_LTV,
        Processing_Fee: Processing_Fee,
        Legal_Fee: Legal_Fee,
        Technical_Fee: Technical_Fee,
        Admin_Fee: Admin_Fee,
        Foreclosure_Charges: Foreclosure_Charges,
        Other_Charges: Other_Charges,
        Stamp_Duty: Stamp_Duty,
        TSR_Years: TSR_Years,
        TSR_Charges: TSR_Charges,
        Valuation_Charges: Valuation_Charges,
        NoOfDocument: NoOfDocument,
        Product_Validate_From_date: Product_Validate_From_date,
        Product_Validate_To_date: Product_Validate_To_date,
        Profit_Percentage: Profit_Percentage,
        docDescr: docDescr,
          Processing_Charges: Processing_Charges,
        FromAmountRange:FromAmountRange,
        ToAmountRange: ToAmountRange,
        TotalOverdueAmount: TotalOverdueAmount,
        TotalOverdueCases: TotalOverdueCases,
        TotalEnquiries: TotalEnquiries,
      );


      if(data['success'] == true){


        addProductListModel.value= AddProductListModel.fromJson(data);

        ToastMessage.msg(addProductListModel.value!.message!);
        ViewProductController viewProductController=Get.find();
        viewProductController.getAllProductListApi();

        if(docDescr!.isNotEmpty){
          String productDocument = docDescr.toString();

          int productId = int.parse(addProductListModel.value!.data!.id.toString()); // replace with your actual productId
          String documentType = "O";

          List<Map<String, dynamic>> documentPayload = productDocument
              .split(',')
              .map((doc) => {
            "productId": productId,
            "documentName": doc.trim(),
            "documentType": documentType,
          })
              .toList();

          await ProductService.addProductDocumentApi(body: documentPayload);
        }

        clearForm();
        isLoading(false);
        Get.back();

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        addProductListModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  void  getProductListByIdApi({
    required String id
  }) async {
    try {
      isLoadingMainScreen(true);

      var data = await ProductService.getProductListByIdApi(id: id);

      if(data['success'] == true){



        getProductListById.value= GetProductListById.fromJson(data);

       await populateStep1Info();
        await populateStep2Info();
        await populateStep3Info();
        await populateStep4Info();

        isLoadingMainScreen(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoadingMainScreen(false);
    } finally {

      isLoadingMainScreen(false);
    }
  }



  Future <void> populateStep1Info() async{
    await leadDDController.getAllKsdplProductApi();
    selectedKsdplProduct.value=int.parse(getProductListById.value!.data!.ksdplProductId.toString());

    await leadDDController.getAllBankApi();
    selectedBank.value=int.parse(getProductListById.value!.data!.bankId.toString());
    prodBankersNameController.text=getProductListById.value!.data!.bankersName??"";
    prodBankersMobController.text=getProductListById.value!.data!.bankersMobileNumber??"";
    prodBankersWhatsappController.text=getProductListById.value!.data!.bankersWhatsAppNumber??"";
    prodBankersEmailController.text=getProductListById.value!.data!.bankersEmailID??"";

    prodMinCibilController.text=(getProductListById.value!.data!.minCIBIL ?? 0).toStringAsFixed(0);
    await getAllProductCategoryApi();
    selectedProductCategory.value=int.parse(getProductListById.value!.data!.segmentVertical.toString());
    prodProductNameController.text=getProductListById.value!.data!.product??"";

    selectedCustomerCategories.assignAll(
        (getProductListById.value!.data!.customerCategory ?? "")
            .split(',')
            .map((e) => e.trim())
            .toList());

    selectedCollSecCat.assignAll(
        (getProductListById.value!.data!.collateralSecurityCategory ?? "")
            .split(',')
            .map((e) => e.trim())
            .toList());

    prodCollateralSecurityExcludedController.text=getProductListById.value!.data!.collateralSecurityExcluded??"";
    prodProfileExcludedController.text=getProductListById.value!.data!.profileExcluded??"";
    selectedIncomeType.assignAll(
        (getProductListById.value!.data!.incomeTypes ?? "")
            .split(',')
            .map((e) => e.trim())
            .toList());
  }

  Future <void> populateStep2Info() async{

    prodAgeLimitEarningApplicantsController.text=(getProductListById.value!.data!.ageLimitEarningApplicants ?? 0).toStringAsFixed(0);
    prodAgeLimitNonEarningCoApplicantController.text=(getProductListById.value!.data!.ageLimitNonEarningCoApplicant ?? 0).toStringAsFixed(0);
    prodMinAgeEarningApplicantsController.text=(getProductListById.value!.data!.minimumAgeEarningApplicants ?? 0).toStringAsFixed(0);
    prodMinAgeNonEarningApplicantsController.text=(getProductListById.value!.data!.minimumAgeNonEarningApplicants ?? 0).toStringAsFixed(0);
    prodMinIncomeCriteriaController.text=(getProductListById.value!.data!.minimumIncomeCriteria ?? 0).toStringAsFixed(2);
    prodMinLoanAmountController.text=(getProductListById.value!.data!.minimumLoanAmount ?? 0).toStringAsFixed(2);
    prodMaxLoanAmountController.text=(getProductListById.value!.data!.maximumLoanAmount ?? 0).toStringAsFixed(2);
    prodProfitPercentageController.text=(getProductListById.value!.data!.profitPercentage ?? 0).toStringAsFixed(2);
    prodMinTenorController.text=(getProductListById.value!.data!.minTenor ?? 0).toStringAsFixed(0);
    prodMaxTenorController.text=(getProductListById.value!.data!.maximumTenor ?? 0).toStringAsFixed(0);
    prodMinRoiController.text=(getProductListById.value!.data!.minimumROI ?? 0).toStringAsFixed(2);
    prodMaxRoiController.text=(getProductListById.value!.data!.maximumROI ?? 0).toStringAsFixed(2);
    prodMaxTenorEligibilityCriteriaController.text=(getProductListById.value!.data!.maximumTenorEligibilityCriteria ?? 0).toStringAsFixed(0);
    prodGeoLimitController.text=getProductListById.value!.data!.geoLimit??"0";



  }

  Future <void> populateStep3Info() async{

    prodMinPropertyValueController.text=(getProductListById.value!.data!.minimumPropertyValue ?? 0).toStringAsFixed(2);
    prodMaxIirController.text=(getProductListById.value!.data!.maximumIIR ?? 0).toStringAsFixed(2);
    prodMaxFoirController.text=(getProductListById.value!.data!.maximumFOIR ?? 0).toStringAsFixed(2);
    prodMaxLtvController.text=(getProductListById.value!.data!.maximumLTV ?? 0).toStringAsFixed(2);
    prodProcessingFeeController.text=(getProductListById.value!.data!.processingFee ?? 0).toStringAsFixed(2);
    prodProcessingChargesController.text=(getProductListById.value!.data!.processingCharges ?? 0).toStringAsFixed(2);
    prodLegalFeeController.text=(getProductListById.value!.data!.legalFee ?? 0).toStringAsFixed(2);
    prodTechnicalFeeController.text=(getProductListById.value!.data!.technicalFee ?? 0).toStringAsFixed(2);
    prodAdminFeeController.text=(getProductListById.value!.data!.adminFee ?? 0).toStringAsFixed(2);
    prodForeclosureChargesController.text=(getProductListById.value!.data!.foreclosureCharges ?? 0).toStringAsFixed(2);
    prodOtherChargesController.text=(getProductListById.value!.data!.otherCharges ?? 0).toStringAsFixed(2);
    prodStampDutyController.text=(getProductListById.value!.data!.stampDuty ?? 0).toStringAsFixed(2);
    prodTsrYearsController.text=(getProductListById.value!.data!.tsRYears ?? 0).toStringAsFixed(2);
    prodTsrChargesController.text=(getProductListById.value!.data!.tsRCharges ?? 0).toStringAsFixed(2);
    prodValuationChargesController.text=(getProductListById.value!.data!.valuationCharges ?? 0).toStringAsFixed(2);
    prodProductValidateFromController.text=Helper.convertFromIso8601(getProductListById.value!.data!.productValidateFromDate);
    prodProductValidateToController.text=Helper.convertFromIso8601(getProductListById.value!.data!.productValidateToDate);
    prodMaxTatController.text=(getProductListById.value!.data!.maximumTAT ?? 0).toStringAsFixed(2);

    prodFromAmtController.text=(getProductListById.value!.data!.fromAmountRange ?? 0).toStringAsFixed(2);
    prodToAmtController.text=(getProductListById.value!.data!.toAmountRange ?? 0).toStringAsFixed(2);
    prodTotalOverdueCasesController.text=(getProductListById.value!.data!.totalOverdueCases ?? 0).toStringAsFixed(0);
    prodTotalOverdueAmtController.text=(getProductListById.value!.data!.totalOverdueAmount ?? 0).toStringAsFixed(2);
    prodTotalEnquiriesController.text=(getProductListById.value!.data!.totalEnquiries ?? 0).toStringAsFixed(0);

    var tempSelectedProfileNames = (getProductListById.value!.data!.negativeProfiles ?? "")
        .split(',')
        .map((e) => e.trim())
        .toList();

// Now match them with the actual objects
    final matchedProfiles = negProfileApiList
        .where((profile) => tempSelectedProfileNames.contains(profile.negativeProfile))
        .toList();

// Assign
    selectedNegProfile.assignAll(matchedProfiles);

/*    selectedNegProfile.assignAll(
        (getProductListById.value!.data!.negativeProfiles ?? "")
            .split(',')
            .map((e) => e.trim())
            .toList());*/

    selectedNegArea.assignAll(
        (getProductListById.value!.data!.negativeAreas ?? "")
            .split(',')
            .map((e) => e.trim())
            .toList());

  }

  Future <void> populateStep4Info() async{


    prodProductDescriptionsController.text=getProductListById.value!.data!.productDescription??"";




  }


  Future<void>addProductDocumentApi({
    required List<Map<String, dynamic>> coApPayload,

  }) async {
    try {
      isLoading(true);
      var uln = Get.arguments['uln'];


      var data = await ProductService.addProductDocumentApi(
          body:[
            {
              "id":loanApplId,
              "coApplicant": coApPayload,
              "bankerName": cleanText(bankerNameController.text),
            }
          ]
      );



      if(data['success'] == true){

        addProductDocumentModel.value= AddProductDocumentModel.fromJson(data);


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

  void  getDocumentListByProductIdApi({
    required String productId
  }) async {
    try {
      isLoadingMainScreen(true);

      var data = await ProductService.getDocumentListByProductIdApi(productId: productId);

      if(data['success'] == true){



        getDocumentProductIdModel.value= GetDocumentProductIdModel.fromJson(data);
        selectedProdDescr.assignAll(
          getDocumentProductIdModel.value!.data!
              .map((e) => e.documentName?.toString().trim())
              .where((name) => name != null && name.isNotEmpty)
              .cast<String>()
              .toList(),
        );

        isLoadingMainScreen(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoadingMainScreen(false);
    } finally {

      isLoadingMainScreen(false);
    }
  }


  void  getAllNegativeProfileApi() async {
    try {
      isLoadingMainScreen(true);

      var data = await ProductService.getAllNegativeProfileApi();

      if(data['success'] == true){


        getAllNegativeProfileModel.value= GetAllNegativeProfileModel.fromJson(data);

        final List<negProfile.Data> allNegProfiles = getAllNegativeProfileModel.value?.data ?? [];

        final List<negProfile.Data> activeNegProfile = allNegProfiles.where((cat) => cat.active == true).toList();

        negProfileApiList.value = activeNegProfile;



        isLoadingMainScreen(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

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
