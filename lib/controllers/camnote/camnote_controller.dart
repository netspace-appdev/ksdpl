import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import 'package:ksdpl/controllers/product/view_product_controller.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
import 'package:ksdpl/services/product_service.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/ImagePickerMixin.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/loan_application/AddLoanApplicationModel.dart';
import '../../models/loan_application/GetLoanApplIdModel.dart';
import '../../models/loan_application/special_model/CoApplicantModel.dart';
import '../../models/loan_application/special_model/CreditCardModel.dart';
import '../../models/loan_application/special_model/FamilyMemberModel.dart';
import '../../models/loan_application/special_model/ReferenceModel.dart';
import '../../models/product/AddProductListModel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
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

class CamNoteController extends GetxController with ImagePickerMixin{

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




  var selectedStateProp = Rxn<String>();
  var selectedDistrictProp = Rxn<String>();
  var selectedCityProp = Rxn<String>();


  var coApplicantList = <CoApplicantDetailController>[].obs;
  var familyMemberApplList = <FamilyMemberController>[].obs;
  var creditCardsList = <CreditCardsController>[].obs;
  var referencesList = <ReferenceController>[].obs;

  var currentStep = 0.obs;
  var stepCompleted = List<bool>.filled(3, false).obs;
  LeadDDController leadDController=Get.find();
  final List<String> titles = [
    "Basic Details", "CAM Note", "Bank Details"
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

// Descriptions
  final TextEditingController prodDocumentDescriptionsController = TextEditingController();
  final TextEditingController prodProductDescriptionsController = TextEditingController();
  final TextEditingController prodNoOfDocController = TextEditingController();
  var prodSegmentList=["Insurance", "Secured","Unsecured", ];
  var selectedprodSegment = Rxn<String>();
  var customerCategoryList=["Salaried", "Salaried NRI","Self Employed Professional", "Self Employed Non Professional", "Non-Individual","Others"];
  var selectedCustomerCategories = <String>[].obs;
  var getAllProductCategoryModel = Rxn<productCat.GetAllProductCategoryModel>(); //
  var addProductListModel = Rxn<AddProductListModel>(); //
  var addProductDocumentModel = Rxn<AddProductDocumentModel>(); //
  RxList<productCat.Data> productCategoryList = <productCat.Data>[].obs;
  var isLoadingProductCategory = false.obs;
  var isProductLoading = false.obs;
  var selectedKsdplProduct = Rxn<int>();

  var selectedProductCategory = Rxn<int>();
  var selectedLoanProduct = Rxn<int>();
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
  var selectedNegProfile = <String>[].obs;
  var selectedProdDescr = <String>[].obs;
  var selectedNegArea = <String>[].obs;

  RxList<String> chips = <String>[].obs;
  TextEditingController chipTextController = TextEditingController();
  TextEditingController chipText2Controller = TextEditingController();
  TextEditingController chipText3Controller = TextEditingController();

  var getProductListById = Rxn<GetProductListById>(); //
  var getDocumentProductIdModel = Rxn<GetDocumentProductIdModel>(); //

///cam note
  final TextEditingController camTotalLoanAvailedController = TextEditingController();
  final TextEditingController camTotalLiveLoanController = TextEditingController();
  final TextEditingController camCibilController = TextEditingController();
  final TextEditingController camTotalEmiController = TextEditingController();
  final TextEditingController camEmiStoppedBeforeController = TextEditingController();
  final TextEditingController camEmiWillContinueController = TextEditingController();
  final TextEditingController camTotalOverdueCasesController = TextEditingController();
  final TextEditingController camTotalOverdueAmountController = TextEditingController();
  final TextEditingController camTotalEnquiriesController = TextEditingController();
  final TextEditingController camLoanSegmentController = TextEditingController();
  final TextEditingController camLoanProductController = TextEditingController();
  final TextEditingController camOfferedSecurityTypeController = TextEditingController();
  final TextEditingController camGeoLocationPropertyController = TextEditingController();
  final TextEditingController camGeoLocationResidenceController = TextEditingController();
  final TextEditingController camGeoLocationOfficeController = TextEditingController();
  final TextEditingController camPhotosOfPropertyController = TextEditingController();
  final TextEditingController camPhotosOfResidenceController = TextEditingController();
  final TextEditingController camPhotosOfOfficeController = TextEditingController();
  final TextEditingController camIncomeTypeController = TextEditingController();
  final TextEditingController camEarningCustomerAgeController = TextEditingController();
  final TextEditingController camNonEarningCustomerAgeController = TextEditingController();
  final TextEditingController camTotalFamilyIncomeController = TextEditingController();
  final TextEditingController camIncomeCanBeConsideredController = TextEditingController();
  final TextEditingController camLoanAmountRequestedController = TextEditingController();
  final TextEditingController camLoanTenorRequestedController = TextEditingController();
  final TextEditingController camRateOfInterestController = TextEditingController();
  final TextEditingController camProposedEmiController = TextEditingController();
  final TextEditingController camPropertyValueController = TextEditingController();
  final TextEditingController camFoirController = TextEditingController();
  final TextEditingController camLtvController = TextEditingController();



  final ImagePicker _picker = ImagePicker();
  @override
  final Map<String, Rx<File?>> imageMap = {};

  @override
  Future<void> pickImage(String key, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 75);
    if (image != null) {
      if (!imageMap.containsKey(key)) {
        imageMap[key] = Rx<File?>(null);
      }
      imageMap[key]!.value = File(image.path);
    }
  }

  @override
  void clearImage(String key) {
    imageMap[key]?.value = null;
  }



  void nextStep() {
    if (currentStep.value < 2) {
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
  List<GlobalKey<FormState>> stepFormKeys = List.generate(4, (_) => GlobalKey<FormState>());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void validateAndSubmit() {


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
      print("pdocDescr===>${ Helper.convertListToCsvSafe(selectedProdDescr.value)}");

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
        Negative_Profiles:Helper.convertListToCsvSafe(selectedNegProfile.value),
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
        NoOfDocument:"${selectedProdDescr.value?.length ?? 0}",
        Product_Validate_From_date:prodProductValidateFromController.text.isNotEmpty?Helper.convertToIso8601(prodProductValidateFromController.text):"",
        Product_Validate_To_date:prodProductValidateToController.text.isNotEmpty?Helper.convertToIso8601(prodProductValidateToController.text):"",
        Profit_Percentage:prodProfitPercentageController.text,
        KSDPLProductId:selectedKsdplProduct.value.toString(),
        docDescr:Helper.convertListToCsvSafe(selectedProdDescr.value),
      );

      print("All steps valid! Submitting form...");
    }


  }
  void validateAndUpdate() {





    if(selectedKsdplProduct.value==null){
      jumpToStep(0);

      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please Select KSDPL Product");
    }else{
      print("FD---->${prodProductValidateFromController.text.isNotEmpty?Helper.convertToIso8601(prodProductValidateFromController.text):""}");
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
        Negative_Profiles:Helper.convertListToCsvSafe(selectedNegProfile.value),
        Negative_Areas:Helper.convertListToCsvSafe(selectedNegArea.value),
        Maximum_TAT:prodMaxTatController.text,
        Minimum_Property_Value:prodMinPropertyValueController.text,
        Maximum_IIR:prodMaxIirController.text,
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
      );

      print("All steps valid! Submitting form...");
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
          Other_Charges: Other_Charges,
          Stamp_Duty: Stamp_Duty,
          TSR_Years: TSR_Years,
          TSR_Charges: TSR_Charges,
          Valuation_Charges: Valuation_Charges,
          NoOfDocument: NoOfDocument,
          Product_Validate_From_date: Product_Validate_From_date,
          Product_Validate_To_date: Product_Validate_To_date,
          Profit_Percentage: Profit_Percentage,
          docDescr: docDescr
      );

      print("Income_Types in API controller===>${Income_Types}");


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
          print("productDocument===>${documentPayload}");
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
  }) async {
    try {
      isLoading(true);
      print("Income_Types in API controlle updateProductListApir===>${Income_Types}");
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
          docDescr: docDescr
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
          print("productDocument===>${documentPayload}");
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

        print("here 1");

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

    print("customerCategory res===>${getProductListById.value!.data!.customerCategory}");
    print("selectedCustomerCategories res===>${ selectedCustomerCategories.value}");

    print("collateralSecurityCategory res===>${getProductListById.value!.data!.collateralSecurityCategory}");
    print("selectedCollSecCat res===>${ selectedCollSecCat.value}");


    print("incomeTypes res===>${getProductListById.value!.data!.incomeTypes}");
    print("selectedIncomeType res===>${ selectedIncomeType.value}");
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

    selectedNegProfile.assignAll(
        (getProductListById.value!.data!.negativeProfiles ?? "")
            .split(',')
            .map((e) => e.trim())
            .toList());

    selectedNegArea.assignAll(
        (getProductListById.value!.data!.negativeAreas ?? "")
            .split(',')
            .map((e) => e.trim())
            .toList());

  }

  Future <void> populateStep4Info() async{


    prodProductDescriptionsController.text=getProductListById.value!.data!.productDescription??"";




  }



  void  getDocumentListByProductIdApi({
    required String productId
  }) async {
    try {
      isLoadingMainScreen(true);

      var data = await ProductService.getDocumentListByProductIdApi(productId: productId);

      if(data['success'] == true){

        print("here 1");

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
