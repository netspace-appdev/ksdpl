import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import 'package:ksdpl/controllers/product/view_product_controller.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
import 'package:ksdpl/services/camnote_service.dart';
import 'package:ksdpl/services/product_service.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/ImagePickerMixin.dart';
import '../../models/camnote/GetProductDetailsByFilterModel.dart';
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
  var isBankerLoading = false.obs;
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
  var getProductDetailsByFilterModel = Rxn<GetProductDetailsByFilterModel>(); //
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

  final TextEditingController camBankerMobileNoController = TextEditingController();
  final TextEditingController camBankerNameController = TextEditingController();
  final TextEditingController camBankerWhatsappController = TextEditingController();
  final TextEditingController camBankerEmailController = TextEditingController();
  final TextEditingController camBankerSuperiorNameController = TextEditingController();
  final TextEditingController camBankerSuperiorMobController = TextEditingController();
  final TextEditingController camBankerSuperiorWhatsappController = TextEditingController();
  final TextEditingController camBankerSuperiorEmailController = TextEditingController();

  final Map<String, RxList<File>> imageMap = {};


  var selectedBank = Rxn<int>();
  var selectedBankBranch = Rxn<int>();
  var selectedBankerBranch = Rxn<int>();

  void clearImages(String key) {
    imageMap[key]?.clear();
  }



  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
      print("currentStep.value in next===>${currentStep.value.toString()}");
      if(currentStep.value==2){
        getProductDetailsByFilterApi(
          cibil: camCibilController.text.trim().toString()
        );
      }
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
    print("currentStep.value===>${currentStep.value.toString()}");
    if(currentStep.value==2){
      getProductDetailsByFilterApi(
          cibil: camCibilController.text.trim().toString()
      );
    }
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
  List<GlobalKey<FormState>> stepFormKeys = List.generate(3, (_) => GlobalKey<FormState>());
  var selectedCamIncomeTypeList = Rxn<String>();

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



      print("All steps valid! Submitting form...");
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



  void  getProductDetailsByFilterApi({
    String? cibil,
  }) async {
    try {
      isBankerLoading(true);


      var data = await CamNoteService.getProductDetailsByFilterApi(
        cibil: cibil,
      );


      if(data['success'] == true){


        getProductDetailsByFilterModel.value= GetProductDetailsByFilterModel.fromJson(data);



        isBankerLoading(false);


       /* if(docDescr!.isNotEmpty){
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


       */


      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getProductDetailsByFilterModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getProductDetailsByFilterModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isBankerLoading(false);
    } finally {

      isBankerLoading(false);
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
