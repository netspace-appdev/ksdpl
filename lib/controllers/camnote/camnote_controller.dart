import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import 'package:ksdpl/controllers/product/view_product_controller.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
import 'package:ksdpl/services/camnote_service.dart';
import 'package:ksdpl/services/product_service.dart';

import '../../common/base_url.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/CamImage.dart';
import '../../custom_widgets/ImagePickerMixin.dart';
import '../../models/camnote/AddAdSrcIncomModel.dart';
import '../../models/camnote/AddBankerDetail.dart';
import '../../models/camnote/AddCamNoteDetail.dart';
import '../../models/camnote/AddCibilDetailsModel.dart';
import '../../models/camnote/AddCustomerDetailsModel.dart';
import '../../models/camnote/GenerateCibilAadharModel.dart';
import '../../models/camnote/GetAddIncUniqueLeadModel.dart';
import '../../models/camnote/GetAllPackageMasterModel.dart' as pkg;
import '../../models/camnote/GetBankerDetailModelForCheck.dart';
import '../../models/camnote/GetBankerDetailsByIdModel.dart';
import '../../models/camnote/GetCamNoteDetailByIdModeli.dart';
import '../../models/camnote/GetCamNoteDetailsByLeadIdForUpdateModel.dart';
import '../../models/camnote/GetCamNoteLeadIdModel.dart';
import '../../models/camnote/GetPackageDetailsByIdModel.dart';
import '../../models/camnote/GetProductDetailBySegmentAndProductModel.dart' as otherBankBranch;
import '../../models/camnote/GetProductDetailsByFilterModel.dart' as pdFModel;
import '../../models/camnote/RequestForFinancialServicesModel.dart';
import '../../models/camnote/SendMailForLocationOfCustomerModel.dart';
import '../../models/camnote/SendMailToBankerCamNoteModel.dart';
import '../../models/camnote/UpdateBankerDetailModel.dart';
import '../../models/camnote/fetchBankDetailSegKSDPLProdModel.dart' as otherBank;
import '../../models/camnote/special_model/IncomeModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/getLeadDetailByCustomerNumber/getLeadDetailByCustomerNumberModel.dart';
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
import '../../services/new_dd_service.dart';
import '../dashboard/DashboardController.dart';
import '../leads/add_income_model_controller.dart';
import '../leads/leadlist_controller.dart';
import '../loan_appl_controller/co_applicant_detail_mode_controllerl.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../loan_appl_controller/credit_cards_model_controller.dart';
import '../loan_appl_controller/reference_model_controller.dart';
import '../new_dd_controller.dart';
import 'calculateCibilData.dart';
import '../../models/product/GetProductListById.dart'as gpli;


var getBankerDetailsByIdModel = Rxn<GetBankerDetailsByIdModel>(); //
var getPackageDetailsByIdModel = Rxn<GetPackageDetailsByIdModel>(); //

class CamNoteController extends GetxController with ImagePickerMixin{
  final Addleadcontroller addleadcontroller = Get.find();
  var getLoanApplIdModel = Rxn<GetLoanApplIdModel>();
  var leadId="".obs;
  var firstName="".obs;
  var email="".obs;
  var isLoading = false.obs;
  var isaddedMobileNumber = false.obs;
  var isLoadingCibil = false.obs;

  var isAllCamnoteSubmit = false.obs;

  var isBankerLoading = false.obs;
  var isBankerSuperiorLoading = false.obs;
  var isLoadingMainScreen = false.obs;
  var addLoanApplicationModel = Rxn<AddLoanApplicationModel>(); //
  var addAdSrcIncomModel = Rxn<AddAdSrcIncomModel>(); //
  var getAllPackageMasterModel = Rxn<pkg.GetAllPackageMasterModel>(); //
  var updateBankerDetailModel = Rxn<UpdateBankerDetailModel>(); //
  var addBankerDetail = Rxn<AddBankerDetail>(); //
  var getBankerDetailModelForCheck = Rxn<GetBankerDetailModelForCheck>(); //
  var getAddIncUniqueLeadModel = Rxn<GetAddIncUniqueLeadModel>(); //
  var addCamNoteDetail = Rxn<AddCamNoteDetail>(); //
  var addCustomerDetailsModel = Rxn<AddCustomerDetailsModel>(); //
  var generateCibilAadharModel = Rxn<GenerateCibilAadharModel>(); //
  var addCibilDetailsModel = Rxn<AddCibilDetailsModel>(); //
  var editCamNoteDetail = Rxn<AddCamNoteDetail>(); //
  var fetchBankDetailSegKSDPLProdModel = Rxn<otherBank.FetchBankDetailSegKSDPLProdModel>(); //
  var getProductDetailBySegmentAndProductModel = Rxn<otherBankBranch.GetProductDetailBySegmentAndProductModel>(); //
  SendMailToBankerCamNoteModel? sendMailToBankerCamNoteModel;


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
  var isOfferedSecurityMandatory = false.obs;

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

  var getLeadId = Rxn<String>();
  var prodSegmentList=["Insurance", "Secured","Unsecured", ];
  var selectedprodSegment = Rxn<String>();
  var customerCategoryList=["Salaried", "Salaried NRI","Self Employed Professional", "Self Employed Non Professional", "Non-Individual","Others"];
  var selectedCustomerCategories = <String>[].obs;
  var getAllProductCategoryModel = Rxn<productCat.GetAllProductCategoryModel>(); //
  var addProductListModel = Rxn<AddProductListModel>(); //
  var addProductDocumentModel = Rxn<AddProductDocumentModel>(); //
  var getProductDetailsByFilterModel = Rxn<pdFModel.GetProductDetailsByFilterModel>(); //
  var getCamNoteLeadIdModel = Rxn<GetCamNoteLeadIdModel>(); //
  var getCamNoteDetailByIdModel = Rxn<GetCamNoteDetailByIdModel>(); //
  var requestForFinancialServicesModel = Rxn<RequestForFinancialServicesModel>(); //
  var getLeadDetailByCustomerNumberModel = Rxn<GetLeadDetailByCustomerNumberModel>(); //
  var getCamNoteDetailsModel = Rxn<GetCamNoteDetailsByLeadIdForUpdateModel>(); //
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

  // var getProductListById = Rxn<GetProductListById>(); //
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
  final TextEditingController camGeoLocationPropertyLatController = TextEditingController();
  final TextEditingController camGeoLocationPropertyLongController = TextEditingController();
  final TextEditingController camGeoLocationResidenceLatController = TextEditingController();
  final TextEditingController camGeoLocationResidenceLongController = TextEditingController();
  final TextEditingController camGeoLocationOfficeLatController = TextEditingController();
  final TextEditingController camGeoLocationOfficeLongController = TextEditingController();
  final TextEditingController camPhotosOfPropertyController = TextEditingController();
  final TextEditingController camPhotosOfResidenceController = TextEditingController();
  final TextEditingController camPhotosOfOfficeController = TextEditingController();
  final TextEditingController camIncomeTypeController = TextEditingController();
  final TextEditingController camEarningCustomerAgeController = TextEditingController();
  final TextEditingController camNonEarningCustomerAgeController = TextEditingController();
  final TextEditingController camTotalFamilyIncomeController = TextEditingController();
  final TextEditingController camIncomeCanBeConsideredController = TextEditingController();
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

  final TextEditingController camPackageNameController = TextEditingController();
  final TextEditingController camPackageAmtController = TextEditingController();
  final TextEditingController camReceivableAmtController = TextEditingController();
  final TextEditingController camReceivableDateController = TextEditingController();
  final TextEditingController camTransactionDetailsController = TextEditingController();
  final TextEditingController camRemarkController = TextEditingController();
  final TextEditingController camLoanAmtReqController = TextEditingController();

  var selectedGender = Rxn<String>();
  var selectedGenderGenCibil = Rxn<String>();
  ///cam 1 form
  final TextEditingController camFullNameController = TextEditingController();
  final TextEditingController camDobController = TextEditingController();
  final TextEditingController camPhoneController = TextEditingController();
  final TextEditingController camGenderController = TextEditingController();
  final TextEditingController camEmailController = TextEditingController();
  final TextEditingController camAadharController = TextEditingController();
  final TextEditingController camPanController = TextEditingController();
  final TextEditingController camStreetAddController = TextEditingController();
  final TextEditingController camZipController = TextEditingController();
  final TextEditingController camNationalityController = TextEditingController();
  final TextEditingController camCurrEmpStController = TextEditingController();
  final TextEditingController camEmployerNameController = TextEditingController();
  final TextEditingController camMonthlyIncomeController = TextEditingController();
  final TextEditingController camAddSourceIncomeController = TextEditingController();
  final TextEditingController camBranchLocController = TextEditingController();
  final TextEditingController camWhatsappController = TextEditingController();

  final TextEditingController camCibilMobController = TextEditingController();

  // 26 Sep
  final TextEditingController camClosedCasesController = TextEditingController();
  final TextEditingController camWrittenOffCasesController = TextEditingController();
  final TextEditingController camSettlementCasesController = TextEditingController();
  final TextEditingController camSuitFiledWillfulDefaultCasesController = TextEditingController();
  final TextEditingController camTotalSanctionedAmountController = TextEditingController();
  final TextEditingController camCurrentBalanceController = TextEditingController();
  final TextEditingController camClosedAmountController = TextEditingController();
  final TextEditingController camWrittenOffAmountController = TextEditingController();
  final TextEditingController camSettlementAmountController = TextEditingController();
  final TextEditingController camSuitFiledWillfulDefaultAmountController = TextEditingController();
  final TextEditingController camStandardCountController = TextEditingController();
  final TextEditingController camNumberOfDaysPastDueCountController = TextEditingController();
  final TextEditingController camLossCountController = TextEditingController();
  final TextEditingController camSubstandardCountController = TextEditingController();
  final TextEditingController camDoubtfulCountController = TextEditingController();
  final TextEditingController camSpecialMentionAccountCountController = TextEditingController();
  final TextEditingController camNptController = TextEditingController();
  final TextEditingController camTotalCountsController = TextEditingController();
  final TextEditingController camCurrentlyCasesBeingServedController = TextEditingController();
  final TextEditingController camCasesToBeForeclosedOnOrBeforeDisbController = TextEditingController();
  final TextEditingController camCasesToBeContenuedController = TextEditingController();
  final TextEditingController camEmisOfExistingLiabilitiesController = TextEditingController();
  final TextEditingController camIirController = TextEditingController();
  var camSelectedState = Rxn<String>();
  var camSelectedDistrict = Rxn<String>();
  var camSelectedCity = Rxn<String>();
  var camCurrEmpStatus = Rxn<String>();
  var camSelectedBank = Rxn<String>();
  var camSelectedProdSegment = Rxn<int>();
  var camSelectedProdType = Rxn<String>();
  var camSelectedIndexRelBank = (-1).obs;
  var isSameAsPhone = false.obs; // observable boolean
  ///end
  var uniqueLeadNUmber="";
  var loanApplicationNumber="";


  var isPackageLoading = false.obs;
  var selectedPackage = Rxn<int>();
  var selectedBankBranch = Rxn<int>();
  var selectedBankerBranch = Rxn<int>();
  var selectedIndexGenCibil = (-1).obs;
  var enableAllCibilFields = true.obs;
  var fromDoableOrInterested="".obs;
  void selectCheckboxCibil(int index) {
    selectedIndexGenCibil.value = index;
  }

  var isUserAIC = false.obs;
  // final Map<String, RxList<File>> imageMap = {};
  final Map<String, RxList<CamImage>> _imageMap = {};

  var maxAllowedBank = -1.obs;

  @override
  Map<String, RxList<CamImage>> get imageMap => _imageMap;
  void loadApiImagesForKey(String key, String imageUrlsFromApi) {
    final urls = imageUrlsFromApi.split(',');
    final fullUrls = urls.map((path) => BaseUrl.imageBaseUrl + path).toList(); // adjust base url
    addNetworkImages(key, fullUrls);
  }


  final List<Map<String, dynamic>> bankerThemes = [
    {
      "containerColor": Colors.transparent,
      "textColor": AppColor.blackColor,
      "iconColor": AppColor.grey700,
    },
    {
      "containerColor": Colors.green,
      "textColor": AppColor.appWhite,
      "iconColor": AppColor.appWhite,
    },

    {
      "containerColor": Colors.transparent,
      "textColor": Colors.grey,
      "iconColor": Colors.grey,
    },

  ];

  final List<Map<String, dynamic>> bankerContainerThemes = [
    {
      "containerColor": AppColor.grey200,
      "borderColor":  AppColor.grey200,
      "textColor": AppColor.blackColor,
    },
    {
      "containerColor": Colors.green,
      "borderColor": AppColor.appWhite,
      "textColor": AppColor.appWhite,
    },

  ];
  var infoFilledBankers = <String>{}.obs;
  var selectedBankers = <String>{}.obs;
  var isGenerateCibilVisible = false.obs;
  var isRequiredVisibleSecure = false.obs;
  Map<String, String> bankerBranchMap = {};

  var geoLocPropLatEnabled =true.obs;
  var geoLocPropLongEnabled =true.obs;

  var geoLocResLatEnabled =true.obs;
  var geoLocResLongEnabled =true.obs;

  var geoLocOffLatEnabled =true.obs;
  var geoLocOffLongEnabled =true.obs;


  var photosPropEnabled =true.obs;
  var photosResEnabled =true.obs;
  var photosOffEnabled =true.obs;

  void markBankerAsSubmitted(String boxId) {
    infoFilledBankers.add(boxId);
  }

  bool isBankerSubmitted(String bankId) {
    return infoFilledBankers.contains(bankId);
  }

  void toggleBankerSelection(String bankId) {
    if (selectedBankers.contains(bankId)) {
      selectedBankers.remove(bankId);
    } else {
      selectedBankers.add(bankId);
    }
  }

  bool isBankerSelected(String bankId) => selectedBankers.contains(bankId);
  final RxSet<String> camNoteLeadBankIds = <String>{}.obs;

  void clearBankerDetails(){

    selectedBankerBranch.value= null;
    camBankerMobileNoController.clear();
    camBankerNameController.clear();
    camBankerWhatsappController.clear();
    camBankerEmailController.clear();
    camBankerSuperiorNameController.clear();
    camBankerSuperiorMobController.clear();
    camBankerSuperiorWhatsappController.clear();
    camBankerSuperiorEmailController.clear();
  }
  void clearBankDetails(){
    selectedBankBranch.value= null;
    selectedBankerBranch.value= null;
    camBankerMobileNoController.clear();
    camBankerNameController.clear();
    camBankerWhatsappController.clear();
    camBankerEmailController.clear();
    camBankerSuperiorNameController.clear();
    camBankerSuperiorMobController.clear();
    camBankerSuperiorWhatsappController.clear();
    camBankerSuperiorEmailController.clear();
  }

  var addIncomeList = <AddIncomeModelController>[].obs;

  void addAdditionalSrcIncome() {
    addIncomeList.add(AddIncomeModelController());
  }

  void removeAdditionalSrcIncome(int index) {
    if (addIncomeList.length <= 1) {
      ToastMessage.msg("You can not delete this");
      return;
    }
    if (index >= 0 && index < addIncomeList.length) {
      // Hold reference to the item to be disposed
      final removed = addIncomeList[index];

      // Remove it first so GetBuilder/Obx UI doesn't rebuild with disposed controller
      addIncomeList.removeAt(index);
      addIncomeList.refresh(); // If you're using an RxList

      // Dispose AFTER rebuild
      WidgetsBinding.instance.addPostFrameCallback((_) {
        removed.aiSourceController .dispose();
        removed.aiIncomeController .dispose();
      });
    } else {
    }
  }
  void s(String key) {
    imageMap[key]?.clear();
  }
  void selectCheckboxRelBank(int index) {

    camSelectedIndexRelBank.value = index;
  }
  RxList<pkg.Data> packageList = <pkg.Data>[].obs;
  var isLoadingPackage = false.obs;

  RxList<otherBank.Data> getOtherBankList = <otherBank.Data>[].obs;
  RxList<otherBankBranch.Data> getOtherBankBranchList = <otherBankBranch.Data>[].obs;

  var selectedOtherBank = 0.obs;
  var selectedOtherBankBranch = 0.obs;
  var isOtherBankLoading = false.obs;
  var isOtherBankBrLoading = false.obs;
  var getProductListById = Rxn<gpli.GetProductListById>(); //
  var sendMailForLocationOfCustomerModel = Rxn<SendMailForLocationOfCustomerModel>(); //

  void nextStep(int tappedIndex) {
    if (currentStep.value < 2) {
      currentStep.value++;
      scrollToStep(currentStep.value);
    }

    if(currentStep.value==1 || currentStep.value==2){
      setAgeFromDob(camDobController, camEarningCustomerAgeController);
    }

    if(currentStep.value==1){
      if(getCamNoteLeadIdModel.value!.data!.isNotEmpty){
        getCamNoteDetailsByLeadIdForUpdateApi(getLeadId.value.toString());
      }

    }

  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      scrollToStep(currentStep.value);
    }
  }

  void jumpToStep(int step) {

    if(step==1 || step==2){
      setAgeFromDob(camDobController, camEarningCustomerAgeController);
    }
    if(step==1){
      print("1");
      getCamNoteDetailsByLeadIdForUpdateApi(getLeadId.value.toString());
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

  void saveForm(String autoIndividual) async {
    if(camFullNameController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter full name");
      return;
    }else if(camDobController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter DOB");
      return;
    }else if(camPhoneController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Phone Number");
      return;
    }else if(selectedGender.value==null || selectedGender.value==""){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Gender");
      return;
    }else if(camLoanAmtReqController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Loan Amount");
      return;
    }else if(camEmailController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter email");
      return;
    }else if(camAadharController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Aadhar");
      return;
    }else if(camSelectedState.value==null || camSelectedState.value=="0"){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please select state");
      return;
    }else if(camSelectedDistrict.value == null || camSelectedDistrict.value=="0"){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please select district");
      return;
    }else if(camSelectedCity.value == null || camSelectedCity.value=="0"){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please select city");
      return;
    }else if(camZipController.text.isEmpty ){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please select zipcode");
      return;
    }else if(camSelectedProdSegment.value==null ||  camSelectedProdSegment.value==0){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Loan Segment");
      return;
    }else if(camSelectedProdType.value==null || camSelectedProdType.value=="0"){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter KSDPL Product");
      return;
    }

    if (!packageFieldsIfRequired()) return;
    if (!securedFieldsIfRequired()) return;
    if (!idOfferedScurityRequired()) return;

    isAllCamnoteSubmit(true);

      final productList = getProductDetailsByFilterModel.value?.data ?? [];

      if(productList.isNotEmpty){
        for (var bankerId in selectedBankers) {
          productList.forEach((ele){

          });
          final matchingProducts = productList.where((product) => product.bankId.toString() == bankerId);
          print("matchingProducts-->${matchingProducts}");
          for (var product in matchingProducts) {
            print("inside this-->3");
            final bankId = product.bankId;
            final bankersName = product.bankersName;
            final bankersMobileNumber = product.bankersMobileNumber;
            final bankersWhatsAppNumber = product.bankersWhatsAppNumber;
            final bankersEmailID = product.bankersEmailID;



            final branchId = bankerBranchMap[bankId.toString()];

            if (branchId != null) {
              print("Found stored branchId: $branchId for bankId: $bankId");
              // Use this in your next API call
            } else {
              print("No branchId stored yet for bankId: $bankId");
            }

            print("inside this-->4");
            addCamNoteDetailApi(
              Id:"0",
              LeadID:getLeadId.value.toString(),
              BankId: bankId.toString(),
              BankersName: bankersName,
              BankersMobileNumber: bankersMobileNumber,
              BankersEmailID: bankersEmailID,
              BankersWhatsAppNumber: bankersWhatsAppNumber,
              Cibil: camCibilController.text.trim().toString(),
              TotalLoanAvailedOnCibil: camTotalLoanAvailedController.text.trim().toString(),
              TotalLiveLoan: camTotalLiveLoanController.text.trim().toString(),
              TotalEMI:camTotalEmiController.text.trim().toString(),
              EMIStoppedOnBeforeThisLoan:camEmiStoppedBeforeController.text.trim().toString(),
              EMIWillContinue:camEmiWillContinueController.text.trim().toString(),
              TotalOverdueCasesAsPerCibil:camTotalOverdueCasesController.text.trim().toString(),
              TotalOverdueAmountAsPerCibil:camTotalOverdueAmountController.text.trim().toString(),
              TotalEnquiriesMadeAsPerCibil:camTotalEnquiriesController.text.trim().toString(),
              LoanSegment:camSelectedProdSegment.value.toString(),
              LoanProduct:camSelectedProdType.value.toString(),
              OfferedSecurityType: camOfferedSecurityTypeController.text.toString(),
              IncomeType:(selectedCamIncomeTypeList.value==null||selectedCamIncomeTypeList.value=="null")?"":selectedCamIncomeTypeList.value,
                EarningCustomerAge: camEarningCustomerAgeController.text.trim().toString(),
              NonEarningCustomerAge: camNonEarningCustomerAgeController.text.trim().toString(),
              TotalFamilyIncome: camTotalFamilyIncomeController.text.trim().toString(),
              IncomeCanBeConsidered: camIncomeCanBeConsideredController.text.trim().toString(),
              LoanAmountRequested: camLoanAmtReqController.text.trim().toString(),
              LoanTenorRequested: camLoanTenorRequestedController.text.trim().toString(),
              ROI: camRateOfInterestController.text.trim().toString(),
              ProposedEMI: camProposedEmiController.text.trim().toString(),
              PropertyValueAsPerCustomer: camPropertyValueController.text.trim().toString(),
              FOIR: camFoirController.text.trim().toString(),
              LTV: camLtvController.text.trim().toString(),
              BranchOfBank: branchId.toString(),
              SanctionProcessingCharges:"0",
              Autoindividual: autoIndividual,

              ///Newly Added on 26 Sep
              ClosedCases: camClosedCasesController.text.trim().toString(),
              WrittenOffCases: camWrittenOffCasesController.text.trim().toString(),
              SettlementCases: camSettlementCasesController.text.trim().toString(),
              Suit_Filed_Willful_Default_Cases: camSuitFiledWillfulDefaultCasesController.text.trim().toString(),
              TotalSanctionedAmount: camTotalSanctionedAmountController.text.trim().toString(),
              CurrentBalance: camCurrentBalanceController.text.trim().toString(),
              ClosedAmount: camClosedAmountController.text.trim().toString(),
              WrittenOffAmount: camWrittenOffAmountController.text.trim().toString(),
              SettlementAmount: camSettlementAmountController.text.trim().toString(),
              Suit_Filed_Willful_Default_Amount: camSuitFiledWillfulDefaultAmountController.text.trim().toString(),
              Standard_Count: camStandardCountController.text.trim().toString(),
              Number_of_days_past_due_Count: camNumberOfDaysPastDueCountController.text.trim().toString(),
              Loss_Count: camLossCountController.text.trim().toString(),
              Substandard_Count: camSubstandardCountController.text.trim().toString(),
              Doubtful_Count: camDoubtfulCountController.text.trim().toString(),
              Special_Mention_account_Count: camSpecialMentionAccountCountController.text.trim().toString(),
              NPT: camNptController.text.trim().toString(),
              TotalCounts: camTotalCountsController.text.trim().toString(),
              CurrentlyCasesBeingServed: camCurrentlyCasesBeingServedController.text.trim().toString(),
              CasesToBeForeclosedOnOrBeforeDisb: camCasesToBeForeclosedOnOrBeforeDisbController.text.trim().toString(),
              CasesToBeContenued: camCasesToBeContenuedController.text.trim().toString(),
              EMIsOfExistingLiabilities: camEmisOfExistingLiabilitiesController.text.trim().toString(),
              IIR: camIirController.text.trim().toString(),
            );

          }
        }
      }else{
        SnackbarHelper.showSnackbar(title: "Incomplete Data", message: "Please select a bank first");
      }
   // }
  }

  bool packageFieldsIfRequired() {
    print("amt--->${camReceivableAmtController.text}");
    // If no package is selected, skip validation
    if (selectedPackage.value == 0) return true;

    // Start validating each required field
    if (camPackageAmtController.text.isEmpty) {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter package amount");
      return false;
    } else if (camReceivableAmtController.text.isEmpty) {
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1",
          message: "Please enter received amount");
      return false;
    } else if (double.tryParse(camReceivableAmtController.text ?? "0")! < 118) {
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1",
          message: "Amount must not be less than 118");
      return false;
    }
    else if (camReceivableDateController.text.isEmpty) {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter received date");
      return false;
    } else if (camTransactionDetailsController.text.isEmpty) {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter UTR");
      return false;
    }
    // All fields are filled
    return true;
  }

  bool securedFieldsIfRequired() {
    // If no package is selected, skip validation
    if (!isRequiredVisibleSecure.value) return true;

    // Start validating each required field
    if (camGeoLocationPropertyLatController.text.isEmpty) {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter latitude of property");
      return false;
    }else if (camGeoLocationPropertyLongController.text.isEmpty)  {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter longitude of property");
      return false;
    }else if (camGeoLocationResidenceLatController.text.isEmpty)  {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter latitude of residence");
      return false;
    }else if (camGeoLocationResidenceLongController.text.isEmpty)  {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter longitude of residence");
      return false;
    }else if (camGeoLocationOfficeLatController.text.isEmpty)  {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter latitude of office");
      return false;
    }else if (camGeoLocationOfficeLongController.text.isEmpty)  {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 1", message: "Please enter longitude of office");
      return false;
    }

    final images = getImages('property_photo');

    if (images.isEmpty) {
      SnackbarHelper.showSnackbar(
        title: "Incomplete Step 1",
        message: "Please upload at least one property photo.",
      );
      return false;
    }
    // All fields are filled
    return true;
  }


  bool idOfferedScurityRequired() {
    // If no package is selected, skip validation
    if (!isOfferedSecurityMandatory.value) return true;

    // Start validating each required field
    if (camOfferedSecurityTypeController.text.isEmpty) {
      SnackbarHelper.showSnackbar(
          title: "Incomplete Step 2", message: "Please enter offered security type");
      return false;
    }
    // All fields are filled
    return true;
  }

  void saveSubmitDetails() async{
    print("saveSubmitDetails");
    print("camSelectedState.value===>${camSelectedState.value}");
    print("camSelectedDistrict.value===>${camSelectedDistrict.value}");
    print("camSelectedCity.value===>${camSelectedCity.value}");


   /* else if(isaddedMobileNumber.value == false){
    SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "This Number already added ");
    return;
    }*/
    if(camFullNameController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter full name");
      return;
    }else if(camDobController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter DOB");
      return;
    }else if(camPhoneController.text.isEmpty){//
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Phone Number");
      return;
    }else if(camWhatsappController.text.isEmpty){//camWhatsappController
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Whatsapp Number");
      return;
    }else if(selectedGender.value==null || selectedGender.value==""){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Gender");
      return;
    }else if(camLoanAmtReqController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Loan Amount");
      return;
    }else if(camEmailController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter email");
      return;
    }else if(camAadharController.text.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Aadhar");
      return;
    }else if(camSelectedState.value==null || camSelectedState.value=="0"){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please select state");
      return;
    }else if(camSelectedDistrict.value == null || camSelectedDistrict.value=="0"){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please select district");
      return;
    }else if(camSelectedCity.value == null || camSelectedCity.value=="0"){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please select city");
      return;
    }else if(camZipController.text.isEmpty ){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please select zipcode");
      return;
    }else if(camSelectedProdSegment.value==null ||  camSelectedProdSegment.value==0){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter Loan Segment");
      return;
    }else if(camSelectedProdType.value==null || camSelectedProdType.value=="0"){
      SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "Please enter KSDPL Product");
    return;
    }

    if (!packageFieldsIfRequired()) return;
    if (!securedFieldsIfRequired()) return;

      print("I am here-===>2");

      print("I am here-===>3");
      isAllCamnoteSubmit(true);
      final List<IncomeModel> addIncomeSrcModels = [];

      for (var ai in addIncomeList) {
        final aiModel = IncomeModel(
          uniqueLeadNumber: uniqueLeadNUmber,
          description: cleanText(ai.aiSourceController.text),
          amount: ai.aiIncomeController.text.toDoubleOrZero(),
        );

        addIncomeSrcModels.add(aiModel);
      }

      List<Map<String, dynamic>> aiPayload = addIncomeSrcModels.map((e) => e.toMap()).toList();

      if(aiPayload.isNotEmpty){
        await addAdditionalSourceIncomeApi(aiPayload:aiPayload);
      }


      if (selectedGender.value==null) {
        ToastMessage.msg("Please select gender");
      }else {
        Addleadcontroller addLeadController =Get.find();
        List<File> propertyPhotos = getImages("property_photo")
            .where((img) => img.isLocal)
            .map((img) => img.file!)
            .toList();

        List<File> residencePhotos = getImages("residence_photo")
            .where((img) => img.isLocal)
            .map((img) => img.file!)
            .toList();

        List<File> officePhotos = getImages("office_photo")
            .where((img) => img.isLocal)
            .map((img) => img.file!)
            .toList();

        await addLeadController.fillLeadFormApi(
          id: getLeadId.value.toString(),
          dob: camDobController.text.toString(),
          gender: selectedGender.toString(),
          loanAmtReq:camLoanAmtReqController.text.toString(),
          email: camEmailController.text.toString(),
          aadhar: camAadharController.text.toString(),
          pan: camPanController.text.toString(),
          streetAdd: camStreetAddController.text.toString(),
          state:  camSelectedState.value.toString(),
          district: camSelectedDistrict.value.toString(),
          city: camSelectedCity.value.toString(),
          zip: camZipController.text.toString(),
          nationality: camNationalityController.text.toString(),
          currEmpSt: camCurrEmpStatus.value,
          employerName: camEmployerNameController.text.toString(),
          monthlyIncome:camMonthlyIncomeController.text.toString(),
          ///Now this is not working, Have different API for Additional source of income
          addSrcIncome: "",
          prefBank: camSelectedBank.value.toString(),
          exRelBank:camSelectedIndexRelBank.value==-1?"":camSelectedIndexRelBank.value==0?"Yes":"No",
          branchLoc:camBranchLocController.text.toString(),
          prodTypeInt: camSelectedProdType.value.toString(),
          /// connection name mob and percent are not sent
          loanApplNo: loanApplicationNumber.toString(),

          name: camFullNameController.text.toString(),
          mobileNumber: camPhoneController.text.toString(),
          packageId: selectedPackage.value.toString(),
          packageAmount: camPackageAmtController.text.toString(),
          receivableAmount:camReceivableAmtController.text.toString(),
          receivableDate:camReceivableDateController.text.toString(),
          transactionDetails:camTransactionDetailsController.text.toString(),
          remark:camRemarkController.text.toString(),
          leadSegment:camSelectedProdSegment.value.toString(),

          GeoLocationOfProperty:camGeoLocationPropertyLatController.text.trim().toString()+"-"+camGeoLocationPropertyLongController.text.trim().toString(),
          GeoLocationOfResidence:camGeoLocationResidenceLatController.text.trim().toString()+"-"+camGeoLocationResidenceLongController.text.trim().toString(),
          GeoLocationOfOffice:camGeoLocationOfficeLatController.text.trim().toString()+"-"+camGeoLocationOfficeLongController.text.trim().toString(),
          PhotosOfProperty: propertyPhotos,
          PhotosOfResidence: residencePhotos,
          PhotosOfOffice: officePhotos,
          fromWhere: "camnote",
          WhatsappNumber:camWhatsappController.text.toString(),
        ).then((_){
          nextStep(currentStep.value);
        });
      }

  }




  List<GlobalKey<FormState>> stepFormKeys = List.generate(3, (_) => GlobalKey<FormState>());
  var selectedCamIncomeTypeList = Rxn<String>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void forBankDetailSubmit(){
    getProductDetailsByFilterApi(
        cibil: double.tryParse(camCibilController .text.trim())
            ?.toInt()
            .toString()
            ?? "0",//camCibilController.text.trim().toString(),
        segmentVertical: camSelectedProdSegment.value.toString(),
        customerCategory: "",
        collateralSecurityCategory: "",
        collateralSecurityExcluded: "",
        incomeTypes:(selectedCamIncomeTypeList.value==null||selectedCamIncomeTypeList.value=="null")?"":selectedCamIncomeTypeList.value,
        ageEarningApplicants: camEarningCustomerAgeController.text,
        ageNonEarningCoApplicant:camEarningCustomerAgeController.text,
        applicantMonthlySalary:camTotalFamilyIncomeController.text,
        loanAmount:camLoanAmtReqController.text.trim().toString(),
        tenor: double.tryParse(camLoanTenorRequestedController .text.trim())
            ?.toInt()
            .toString()
            ?? "0",//camLoanTenorRequestedController.text.trim().toString(),
        roi:camRateOfInterestController.text.trim().toString(),
        maximumTenorEligibilityCriteria:"",
        customerAddress:camStreetAddController.text.trim().toString(),

        totalOverdueCases:double.tryParse(camTotalOverdueCasesController.text.trim())
            ?.toInt()
            .toString()
            ?? "0",//camTotalOverdueCasesController.text.trim().toString(),
        totalOverdueAmount:camTotalOverdueAmountController.text.trim().toString(),
        totalEnquiries:double.tryParse(camTotalEnquiriesController.text.trim())
            ?.toInt()
            .toString()
            ?? "0",//camTotalEnquiriesController.text.trim().toString(),
        kSDPLProductId:camSelectedProdType.value.toString(),

    );
  }

  void validateAndSubmit() {

/*
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
    }*/


  }

  @override
  void onClose() {
    // TODO: implement onClose

    leadDController.selectedStateCurr.value=null;
    leadDController.selectedDistrictCurr.value=null;
    leadDController.selectedCityCurr.value=null;
    leadDController. selectedStatePerm.value=null;
    leadDController.selectedDistrictPerm.value=null;
    leadDController.selectedCityPerm.value=null;




    // Clear Rx variables

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

    addLoanApplicationModel = Rxn<AddLoanApplicationModel>(); //
    addAdSrcIncomModel = Rxn<AddAdSrcIncomModel>(); //

    addLoanApplicationModel.value = null;
    addAdSrcIncomModel.value = null;

    infoFilledBankers.clear();
    selectedBankers.clear();
    uniqueLeadNUmber="";
    loanApplicationNumber="";
    clearStep1();
    clearStep2();
    clearBankDetails();
    super.onClose();
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

    // Reset reactive values
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
    chipTextController.clear();
    chipText2Controller.clear();
    chipText3Controller.clear();
  }

/*  void mergeBankerDetails() {
    final products = getProductDetailsByFilterModel.value?.data ?? [];
    final leads = getCamNoteLeadIdModel.value?.data ?? [];

    for (var product in products) {

      final lead = leads.firstWhere(
            (l) => l.bankId.toString() == product.bankId.toString(),
        orElse: () => null as dynamic, // hacky
      );

      if (lead != null) {
        product.bankersName = lead.bankersName;
        product.bankersMobileNumber = lead.bankersMobileNumber;
        product.bankersWhatsAppNumber = lead.bankersWhatsAppNumber;
        product.bankersEmailID = lead.bankersEmailID;
      }
    }

    // Force update observable
    getProductDetailsByFilterModel.refresh();
  }*/

  void mergeBankerDetails() {
    final products = getProductDetailsByFilterModel.value?.data ?? [];
    final leads = getCamNoteLeadIdModel.value?.data ?? [];

    for (var product in products) {
      final lead = leads.firstWhereOrNull(
            (l) => l.bankId.toString() == product.bankId.toString(),
      );

      if (lead != null) {
        product.bankersName = lead.bankersName;
        product.bankersMobileNumber = lead.bankersMobileNumber;
        product.bankersWhatsAppNumber = lead.bankersWhatsAppNumber;
        product.bankersEmailID = lead.bankersEmailID;
      }
    }

    getProductDetailsByFilterModel.refresh();
  }


  void  getProductDetailsByFilterApi({
    String? cibil,
    String? segmentVertical,
    String? customerCategory,
    String? collateralSecurityCategory,
    String? collateralSecurityExcluded,
    String? incomeTypes,
    String? ageEarningApplicants,
    String? ageNonEarningCoApplicant,
    String? applicantMonthlySalary,
    String? loanAmount,
    String? tenor,
    String? roi,
    String? maximumTenorEligibilityCriteria,
    String? customerAddress,


    String? totalOverdueCases,
    String? totalOverdueAmount,
    String? totalEnquiries,
    String? kSDPLProductId,
  }) async {
    try {
      isBankerLoading(true);


      var data = await CamNoteService.getProductDetailsByFilterApi(
        cibil: cibil,
        segmentVertical:segmentVertical,
        customerCategory: customerCategory,
        collateralSecurityCategory:collateralSecurityCategory,
        collateralSecurityExcluded:collateralSecurityExcluded,
        incomeTypes:incomeTypes,
        ageEarningApplicants:ageEarningApplicants,
        ageNonEarningCoApplicant:ageNonEarningCoApplicant,
        applicantMonthlySalary:applicantMonthlySalary,
        loanAmount:loanAmount,
        tenor:tenor,
        roi:roi,
        maximumTenorEligibilityCriteria:maximumTenorEligibilityCriteria,
        customerAddress:customerAddress,

        totalOverdueCases:totalOverdueCases,
        totalOverdueAmount:totalOverdueAmount,
        totalEnquiries:totalEnquiries,
        kSDPLProductId:kSDPLProductId,
      );

      print("print 1");
      if (data['success'] == true && (data['data'] as List).isEmpty) {
        print("print 5");
        ToastMessage.msg("No data found");
        getProductDetailsByFilterModel.value = null;

      } else if(data['success'] == true){
        print("print 2");

        getProductDetailsByFilterModel.value= pdFModel.GetProductDetailsByFilterModel.fromJson(data);

        print("print 2.1");

        getProductDetailsByFilterModel.value?.data?.forEach((item) {
          item.autoindividual = "1";
        });
        print("print 2.2");
     //   print("here data for auto=========>${getProductDetailsByFilterModel.value?.data?.first.autoindividual.toString()}");
        mergeBankerDetails(); ///on 1sep remove this
        isBankerLoading(false);

        print("print 3");
        print("print ${data['success']} and ${data['data']}}");


      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
        print("print 4");

        getProductDetailsByFilterModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }

      print("print 6");
    } catch (e) {
      print("Error getProductDetailsByFilterModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isBankerLoading(false);
    } finally {

      isBankerLoading(false);
    }
  }


  Future<void>addAdditionalSourceIncomeApi({
    required List<Map<String, dynamic>> aiPayload,
  }) async {
    try {
      isLoading(true);

      var data = await CamNoteService.addAdditionalSourceIncomeApi(
          body:aiPayload
      );



      if(data['success'] == true){

        addAdSrcIncomModel.value= AddAdSrcIncomModel.fromJson(data);
        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addAdditionalSourceIncomeApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }


  }

  Future<void>  getAllPackageMasterApi() async {
    try {
      isPackageLoading(true);


      var data = await CamNoteService.getAllPackageMasterApi();


      if(data['success'] == true){


        getAllPackageMasterModel.value= pkg.GetAllPackageMasterModel.fromJson(data);



        final List<pkg.Data> packages = getAllPackageMasterModel.value?.data ?? [];

        final List<pkg.Data> activeNegProfile = packages.where((pk) => pk.active == true).toList();

        packageList.value = activeNegProfile;

        isPackageLoading(false);




      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAllPackageMasterModel.value=null;
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


  Future<void>  getBankerDetailsByIdApi({
    String? bankerId,
  }) async {
    try {

      isBankerSuperiorLoading(true);


      var data = await NewDDService.getBankerDetailsByIdApi(
          bankerId: bankerId
      );


      if(data['success'] == true){
        print("This changed should be in effect");
        print("superiorMobile==>${getBankerDetailsByIdModel.value?.data?.superiorMobile??""}");

        getBankerDetailsByIdModel.value= GetBankerDetailsByIdModel.fromJson(data);

        camBankerMobileNoController.text=getBankerDetailsByIdModel.value?.data?.bankersMobileNumber??"";
        camBankerNameController.text=getBankerDetailsByIdModel.value?.data?.bankersName??"";
        camBankerWhatsappController.text=getBankerDetailsByIdModel.value?.data?.bankersWhatsAppNumber??"";
        camBankerEmailController.text=getBankerDetailsByIdModel.value?.data?.bankersEmailId??"";
        camBankerSuperiorNameController.text=getBankerDetailsByIdModel.value?.data?.superiorName??"";
        camBankerSuperiorMobController.text=getBankerDetailsByIdModel.value?.data?.superiorMobile??"";
        camBankerSuperiorWhatsappController.text=getBankerDetailsByIdModel.value?.data?.superiorWhatsApp??"";
        camBankerSuperiorEmailController.text=getBankerDetailsByIdModel.value?.data?.superiorEmail??"";
        print("camBankerSuperiorMobController.text==>${camBankerSuperiorMobController.text}");
        isBankerSuperiorLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getBankerDetailsByIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getBankerDetailsByIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isBankerSuperiorLoading(false);
    } finally {


      isBankerSuperiorLoading(false);
    }
  }


  Future<void>  updateBankerDetailApi({
    String? bankId,
    String? branchId,
    String? bankersName,
    String? bankersMobileNumber,
    String? bankersWhatsAppNumber,
    String? bankersEmailId,
    String? city,
    String? superiorName,
    String? superiorMobile,
    String? superiorWhatsApp,
    String? superiorEmail,
    String? createdBy,
    required String whichScreen,
  }) async {
    try {

      isLoading(true);
      String? empId = StorageService.get(StorageService.EMPLOYEE_ID);


      var data = await CamNoteService.updateBankerDetailApi(
        bankId:bankId,
        branchId:branchId,
        bankersName:bankersName,
        bankersMobileNumber:bankersMobileNumber,
        bankersWhatsAppNumber:bankersWhatsAppNumber,
        bankersEmailId:bankersEmailId,
        city:city,
        superiorName:superiorName,
        superiorMobile:superiorMobile,
        superiorWhatsApp:superiorWhatsApp,
        superiorEmail:superiorEmail,
        createdBy:empId.toString(),
      );


      if(data['success'] == true){

        updateBankerDetailModel.value= UpdateBankerDetailModel.fromJson(data);


        onFormSubmit(
            updateBankerDetailModel.value!.data!.bankId.toString(), {
          'bankersName': updateBankerDetailModel.value!.data!.bankersName.toString(),
          'bankersMobileNumber': updateBankerDetailModel.value!.data!.bankersMobileNumber.toString(),
          'bankersWhatsAppNumber': updateBankerDetailModel.value!.data!.bankersWhatsAppNumber.toString(),
          'bankersEmailID': updateBankerDetailModel.value!.data!.bankersEmailId.toString(),
        },whichScreen
        );


        Get.back();
        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getBankerDetailsByIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getBankerDetailsByIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoading(false);
    } finally {


      isLoading(false);
    }
  }


  Future<void>  addBankerDetailApi({
    String? bankId,
    String? branchId,
    String? bankersName,
    String? bankersMobileNumber,
    String? bankersWhatsAppNumber,
    String? bankersEmailId,
    String? city,
    String? superiorName,
    String? superiorMobile,
    String? superiorWhatsApp,
    String? superiorEmail,
    String? createdBy,
    required String whichScreen,
  }) async {
    try {

      isLoading(true);
      String? empId = StorageService.get(StorageService.EMPLOYEE_ID);

      var data = await CamNoteService.addBankerDetailApi(
        bankId:bankId,
        branchId:branchId,
        bankersName:bankersName,
        bankersMobileNumber:bankersMobileNumber,
        bankersWhatsAppNumber:bankersWhatsAppNumber,
        bankersEmailId:bankersEmailId,
        city:city,
        superiorName:superiorName,
        superiorMobile:superiorMobile,
        superiorWhatsApp:superiorWhatsApp,
        superiorEmail:superiorEmail,
        createdBy:empId.toString(),
      );


      if(data['success'] == true){

        addBankerDetail.value= AddBankerDetail.fromJson(data);


        isLoading(false);


        onFormSubmit(
            addBankerDetail.value!.data!.bankId.toString(), {
          'bankersName': addBankerDetail.value!.data!.bankersName.toString(),
          'bankersMobileNumber': addBankerDetail.value!.data!.bankersMobileNumber.toString(),
          'bankersWhatsAppNumber': addBankerDetail.value!.data!.bankersWhatsAppNumber.toString(),
          'bankersEmailID': addBankerDetail.value!.data!.bankersEmailId.toString(),
        },whichScreen
        );
        Get.back();

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        addBankerDetail.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getBankerDetailsByIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoading(false);
    } finally {


      isLoading(false);
    }
  }


  Future<void>  getBankerDetaillApi({
    String? bankId,
    String? branchId,
    String? bankersName,
    required String bankersMobileNumber,
    String? bankersWhatsAppNumber,
    String? bankersEmailId,
    String? city,
    String? superiorName,
    String? superiorMobile,
    String? superiorWhatsApp,
    String? superiorEmail,
    String? createdBy,
    required String whichScreen,
  }) async {
    try {

      isLoading(true);


      var data = await CamNoteService.getBankerDetaillApi(
        phoneNo:bankersMobileNumber,
      );


      if(data['success'] == true){

        getBankerDetailModelForCheck.value= GetBankerDetailModelForCheck.fromJson(data);
        updateBankerDetailApi(
          bankId:bankId,
          branchId:branchId,
          bankersName:bankersName,
          bankersMobileNumber:bankersMobileNumber,
          bankersWhatsAppNumber:bankersWhatsAppNumber,
          bankersEmailId:bankersEmailId,
          city:city,
          superiorName:superiorName,
          superiorMobile:superiorMobile,
          superiorWhatsApp:superiorWhatsApp,
          superiorEmail:superiorEmail,
          whichScreen: whichScreen

        );


        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        addBankerDetailApi(
          bankId:bankId,
          branchId:branchId,
          bankersName:bankersName,
          bankersMobileNumber:bankersMobileNumber,
          bankersWhatsAppNumber:bankersWhatsAppNumber,
          bankersEmailId:bankersEmailId,
          city:city,
          superiorName:superiorName,
          superiorMobile:superiorMobile,
          superiorWhatsApp:superiorWhatsApp,
          superiorEmail:superiorEmail,
          whichScreen: whichScreen

        );


       // getBankerDetailModelForCheck.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getBankerDetailModelForCheck: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoading(false);
    } finally {


      isLoading(false);
    }
  }


  void onFormSubmit(String bankId, Map<String, dynamic> updatedFields,  String whichScreen,) {
    print("onFormSubmit===>");
    var index=-1;
    if(whichScreen=="fresh_camnote"){
       index = getProductDetailsByFilterModel.value!.data!
          .indexWhere((element) => element.bankId.toString() == bankId);
       print("index===>${index.toString()}");

       if (index != -1) {
         final old = getProductDetailsByFilterModel.value!.data![index];

         // Update relevant fields
         final updatedBanker =  getProductDetailsByFilterModel.value!.data![index] = old.copyWith(
           bankersName: updatedFields['bankersName'],
           bankersMobileNumber: updatedFields['bankersMobileNumber'],
           bankersWhatsAppNumber: updatedFields['bankersWhatsAppNumber'],
           bankersEmailID: updatedFields['bankersEmailID'],
         );
         getProductDetailsByFilterModel.value!.data![index] = updatedBanker;
         // Refresh the list
         getProductDetailsByFilterModel.refresh();


       }
    }else if(whichScreen=="update_camnote"){

      index = getCamNoteLeadIdModel.value!.data!
          .indexWhere((element) => element.bankId.toString() == bankId);

      print("index===>${index.toString()} and $whichScreen{}");


      if (index != -1) {
        print("here ===>1");
        final old = getCamNoteLeadIdModel.value!.data![index];
        print("here ===>2");
        // Update relevant fields
        final updatedBanker =  getCamNoteLeadIdModel.value!.data![index] = old.copyWith(
          bankersName: updatedFields['bankersName'],
          bankersMobileNumber: updatedFields['bankersMobileNumber'],
          bankersWhatsAppNumber: updatedFields['bankersWhatsAppNumber'],
          bankersEmailID: updatedFields['bankersEmailID'],
        );
        print("here ===>3");
        getCamNoteLeadIdModel.value!.data![index] = updatedBanker;
        print("here ===>4");
        // Refresh the list
        getCamNoteLeadIdModel.refresh();
        print("here ===>5");
        var dataNew=getCamNoteLeadIdModel.value!.data![index];
        print("leadid on tap edit--->${dataNew.leadID}");
        print("dataNew autoindividual on tap edit--->${dataNew.autoindividual.toString()}");
        editCamNoteDetailApi(
          Id:dataNew.id.toString(),
          LeadID:dataNew.leadID.toString(),
          Cibil: dataNew.cibil.toString(),
          TotalLoanAvailedOnCibil: dataNew.totalLoanAvailedOnCibil.toString(),
          TotalLiveLoan: dataNew.totalLiveLoan.toString(),
          TotalEMI:dataNew.totalEMI.toString(),
          EMIStoppedOnBeforeThisLoan:dataNew.emiStoppedOnBeforeThisLoan.toString(),
          EMIWillContinue:dataNew.emiWillContinue.toString(),
          TotalOverdueCasesAsPerCibil:dataNew.totalOverdueCasesAsPerCibil.toString(),
          TotalOverdueAmountAsPerCibil:dataNew.totalOverdueAmountAsPerCibil.toString(),
          TotalEnquiriesMadeAsPerCibil:dataNew.totalEnquiriesMadeAsPerCibil.toString(),
          IncomeType: (dataNew.incomeType==null||dataNew.incomeType=="null")?"":dataNew.incomeType,
          EarningCustomerAge: dataNew.earningCustomerAge.toString(),
          NonEarningCustomerAge: dataNew.nonEarningCustomerAge.toString(),
          TotalFamilyIncome: dataNew.totalFamilyIncome.toString(),
          IncomeCanBeConsidered: dataNew.incomeCanBeConsidered.toString(),
          LoanAmountRequested: dataNew.loanAmountRequested.toString(),
          LoanTenorRequested: dataNew.loanTenorRequested.toString(),
          ROI: dataNew.roi.toString(),
          ProposedEMI: dataNew.proposedEMI.toString(),
          PropertyValueAsPerCustomer: dataNew.propertyValueAsPerCustomer.toString(),
          FOIR: dataNew.foir.toString(),
          LTV:dataNew.ltv.toString(),
          OfferedSecurityType: dataNew.offeredSecurityType.toString(),
          LoanProduct:dataNew.loanProduct.toString(),
          LoanSegment:dataNew.loanSegment.toString(),
          BankersName: dataNew.bankersName.toString(),
          BankersMobileNumber: dataNew.bankersMobileNumber.toString(),
          BankersEmailID: dataNew.bankersEmailID.toString(),
          BankersWhatsAppNumber: dataNew.bankersWhatsAppNumber.toString(),
          BankId: dataNew.bankId.toString(),
          BranchOfBank: dataNew.branchId.toString(),
          SanctionProcessingCharges:dataNew.sanctionProcessingFees.toString(),
          Autoindividual: dataNew.autoindividual.toString(),


        );

      }
    }else{
      print("error in model===>");
    }

  }

  Future<void>  getAddIncUniqueLeadApi({
    required String uniqueLeadNumber,

  }) async {
    try {

      isLoading(true);

      var data = await CamNoteService.getAddIncUniqueLeadApi(uniqueLeadNumber:uniqueLeadNumber);


      if(data['success'] == true){


        getAddIncUniqueLeadModel.value= GetAddIncUniqueLeadModel.fromJson(data);




        ///code for populatinf add inc
        if(getAddIncUniqueLeadModel.value!.data!=null && getAddIncUniqueLeadModel.value!.data!.isNotEmpty){

          addIncomeList.clear();
          final jsonStr =  getAddIncUniqueLeadModel.value!.data;

          if (jsonStr != null) {

            // final decoded = jsonDecode(jsonStr);
            final decoded = jsonStr;

            // Check if it's actually a List of Maps
            if (decoded is List) {

              for (var item in decoded) {
                final aiController = AddIncomeModelController();

                aiController.aiSourceController.text= item.description ?? '';
                aiController.aiIncomeController.text= item.amount.toString() ?? '';
                addIncomeList.add(aiController);
              }
            } else {
              print("Expected a List but got: ${decoded.runtimeType}");
            }
          }
        }

        ///end
        isLoading(false);
      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getAddIncUniqueLeadModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAddIncUniqueLeadModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoading(false);
    } finally {


      isLoading(false);
    }
  }

  Future<void>  addCamNoteDetailApi({
    String? Id,
    String? LeadID,
    String? BankId,
    String? BankersName,
    String? BankersMobileNumber,
    String? BankersWhatsAppNumber,
    String? BankersEmailID,
    String? Cibil,
    String? TotalLoanAvailedOnCibil,
    String? TotalLiveLoan,
    String? TotalEMI,
    String? EMIStoppedOnBeforeThisLoan,
    String? EMIWillContinue,
    String? TotalOverdueCasesAsPerCibil,
    String? TotalOverdueAmountAsPerCibil,
    String? TotalEnquiriesMadeAsPerCibil,
    String? LoanSegment,
    String? LoanProduct,
    String? OfferedSecurityType,
    String? IncomeType,
    String? EarningCustomerAge,
    String? NonEarningCustomerAge,
    String? TotalFamilyIncome,
    String? IncomeCanBeConsidered,
    String? LoanAmountRequested,
    String? LoanTenorRequested,
    String? ROI,
    String? ProposedEMI,
    String? PropertyValueAsPerCustomer,
    String? FOIR,
    String? LTV,
    String? BranchOfBank,
    String? SanctionProcessingCharges,
    String? Autoindividual,

    ///Newly Added on 26 Sep
    String? ClosedCases,
    String? WrittenOffCases,
    String? SettlementCases,
    String? Suit_Filed_Willful_Default_Cases,
    String? TotalSanctionedAmount,
    String? CurrentBalance,
    String? ClosedAmount,
    String? WrittenOffAmount,
    String? SettlementAmount,
    String? Suit_Filed_Willful_Default_Amount,
    String? Standard_Count,
    String? Number_of_days_past_due_Count,
    String? Loss_Count,
    String? Substandard_Count,
    String? Doubtful_Count,
    String? Special_Mention_account_Count,
    String? NPT,
    String? TotalCounts,
    String? CurrentlyCasesBeingServed,
    String? CasesToBeForeclosedOnOrBeforeDisb,
    String? CasesToBeContenued,
    String? EMIsOfExistingLiabilities,
    String? IIR,


  }) async {
    try {
      print("addCamNoteDetailApi-->1");
      isLoading(true);

      var data = await CamNoteService.addCamNoteDetailApi(
        Id: Id,
        LeadID: LeadID,
        BankId: BankId,
        BankersName: BankersName,
        BankersMobileNumber: BankersMobileNumber,
        BankersWhatsAppNumber: BankersWhatsAppNumber,
        BankersEmailID: BankersEmailID,
        Cibil: Cibil,
        TotalLoanAvailedOnCibil: TotalLoanAvailedOnCibil,
        TotalLiveLoan: TotalLiveLoan,
        TotalEMI: TotalEMI,
        EMIStoppedOnBeforeThisLoan: EMIStoppedOnBeforeThisLoan,
        EMIWillContinue: EMIWillContinue,
        TotalOverdueCasesAsPerCibil: TotalOverdueCasesAsPerCibil,
        TotalOverdueAmountAsPerCibil: TotalOverdueAmountAsPerCibil,
        TotalEnquiriesMadeAsPerCibil: TotalEnquiriesMadeAsPerCibil,
        LoanSegment: LoanSegment,
        LoanProduct: LoanProduct,
        OfferedSecurityType: OfferedSecurityType,
        IncomeType: IncomeType,
        EarningCustomerAge: EarningCustomerAge,
        NonEarningCustomerAge: NonEarningCustomerAge,
        TotalFamilyIncome: TotalFamilyIncome,
        IncomeCanBeConsidered: IncomeCanBeConsidered,
        LoanAmountRequested: LoanAmountRequested,
        LoanTenorRequested: LoanTenorRequested,
        ROI: ROI,
        ProposedEMI: ProposedEMI,
        PropertyValueAsPerCustomer: PropertyValueAsPerCustomer,
        FOIR: FOIR,
        LTV: LTV,
        BranchOfBank: BranchOfBank,
        SanctionProcessingCharges: SanctionProcessingCharges,
        Autoindividual: Autoindividual,

        ///Newly Added on 26 Sep
        ClosedCases: ClosedCases,
        WrittenOffCases: WrittenOffCases,
        SettlementCases: SettlementCases,
        Suit_Filed_Willful_Default_Cases: Suit_Filed_Willful_Default_Cases,
        TotalSanctionedAmount: TotalSanctionedAmount,
        CurrentBalance: CurrentBalance,
        ClosedAmount: ClosedAmount,
        WrittenOffAmount: WrittenOffAmount,
        SettlementAmount: SettlementAmount,
        Suit_Filed_Willful_Default_Amount: Suit_Filed_Willful_Default_Amount,
        Standard_Count: Standard_Count,
        Number_of_days_past_due_Count: Number_of_days_past_due_Count,
        Loss_Count: Loss_Count,
        Substandard_Count: Substandard_Count,
        Doubtful_Count: Doubtful_Count,
        Special_Mention_account_Count: Special_Mention_account_Count,
        NPT: NPT,
        TotalCounts: TotalCounts,
        CurrentlyCasesBeingServed: CurrentlyCasesBeingServed,
        CasesToBeForeclosedOnOrBeforeDisb: CasesToBeForeclosedOnOrBeforeDisb,
        CasesToBeContenued: CasesToBeContenued,
        EMIsOfExistingLiabilities: EMIsOfExistingLiabilities,
        IIR: IIR,

      );


      if(data['success'] == true){

        addCamNoteDetail.value= AddCamNoteDetail.fromJson(data);

        bankerBranchMap.clear();
        ToastMessage.msg(addCamNoteDetail.value!.message!);

        sendMailToBankerAfterGenerateCamNoteApi(id: addCamNoteDetail.value!.data!.id.toString());

        toggleBankerSelection(BankId.toString());
        clearBankDetails();
        //exp
        infoFilledBankers.remove(BankId);

        bankerBranchMap.clear();
        //exp
        forBankDetailSubmit();



        DashboardController dashboardController = Get.find();
        LeadListController leadListController = Get.find();
        leadListController.fromWhereLeads.value=="dashboard"?
        leadListController.getDetailsListOfLeadsForDashboardApi(
            applyDateFilter: dashboardController.isLeadCountYearly.toString(), //changeit
            stageId: leadListController.leadCode.value,
            isLoadMore: true
        ):

        leadListController.getAllLeadsApi(
          employeeId: leadListController.eId.value.toString(),
          leadStage:leadListController.leadCode.value.toString(),
          stateId: leadListController.stateIdMain.value.toString(),
          distId: leadListController.distIdMain.value.toString(),
          cityId:leadListController.cityIdMain.value.toString(),
          campaign: leadListController.campaignMain.value.toString(),
          fromDate: leadListController.fromDateMain.value,
          toDate: leadListController.toDateMain.value,
          branch: leadListController.branchMain.value.toString(),
          uniqueLeadNumber:leadListController.uniqueLeadNumberMain.value.toString(),
          leadMobileNumber:leadListController.leadMobileNumberMain.value.toString(),
          leadName:leadListController.leadNameMain.value.toString(),
          isLoadMore: true,
        );
        ///new code end
        getCamNoteDetailByLeadIdApi(leadId: LeadID.toString());
        isAllCamnoteSubmit(false);
        isLoading(false);



      }else if(data['success'] == false && (data['data'] as List).isEmpty ){

        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);


        infoFilledBankers.remove(BankId);
        bankerBranchMap.clear();
        addCamNoteDetail.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addCamNoteDetail: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoading(false);
      isAllCamnoteSubmit(false);
    } finally {


      isLoading(false);
      isAllCamnoteSubmit(false);
    }
  }


  void clearStep1(){
    camFullNameController.clear();
    camDobController.clear();
    camPhoneController.clear();
    camLoanAmtReqController.clear();
    camEmailController.clear();
    camAadharController.clear();
    camPanController.clear();
    camStreetAddController.clear();
    camZipController.clear();
    camNationalityController.clear();
    camEmployerNameController.clear();
    camMonthlyIncomeController.clear();
    camBranchLocController.clear();
    camPackageNameController.clear();
    camPackageAmtController.clear();
    camReceivableAmtController.clear();
    camReceivableDateController.clear();
    camTransactionDetailsController.clear();
    camRemarkController.clear();



    selectedGender.value=null;
    camSelectedState.value=null;
    camSelectedDistrict.value=null;
    camSelectedCity.value=null;
    camCurrEmpStatus.value=null;
    camSelectedBank.value=null;
    camSelectedProdSegment.value=null;
    camSelectedProdType.value=null;

    selectedPackage.value=null;
    camSelectedIndexRelBank.value=-1;
    camSelectedIndexRelBank.value=-1;
    addIncomeList.clear();
    Addleadcontroller addLeadController =Get.find();
    addLeadController.addIncomeList.clear();
    isGenerateCibilVisible.value=false;
    isRequiredVisibleSecure.value=false;
  }

  void clearStep2(){

    camCibilController.clear();
    camTotalLoanAvailedController.clear();
    camTotalLiveLoanController.clear();
    camTotalEmiController.clear();
    camEmiStoppedBeforeController.clear();
    camEmiWillContinueController.clear();
    camTotalOverdueCasesController.clear();
    camTotalOverdueAmountController.clear();
    camTotalEnquiriesController.clear();
    camGeoLocationPropertyLatController.clear();
    camGeoLocationPropertyLongController.clear();
    camGeoLocationResidenceLatController.clear();
    camGeoLocationResidenceLongController.clear();
    camGeoLocationOfficeLongController.clear();
    camGeoLocationOfficeLongController.clear();
    camEarningCustomerAgeController.clear();
    camNonEarningCustomerAgeController.clear();
    camTotalFamilyIncomeController.clear();
    camIncomeCanBeConsideredController.clear();
    camLoanAmtReqController.clear();
    camLoanTenorRequestedController.clear();
    camRateOfInterestController.clear();
    camProposedEmiController.clear();
    camPropertyValueController.clear();
    camFoirController.clear();
    camLtvController.clear();
    camLtvController.clear();
    camOfferedSecurityTypeController.clear();
    camCibilMobController.clear();
    selectedCamIncomeTypeList.value=null;
  }


  Future<void>  sendMailToBankerAfterGenerateCamNoteApi({
   required String id,
  }) async {
    try {

      isLoading(true);


      var data = await CamNoteService.sendMailToBankerAfterGenerateCamNoteApi(
          id: id
      );


      if(data['success'] == true){

        // ✅ No need to parse the whole model if only 'message' matters
        String message = data['message'] ?? AppText.somethingWentWrong;
        ToastMessage.msg(message);
        sendMailToBankerCamNoteModel = SendMailToBankerCamNoteModel(message: message);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error sendMailToBankerAfterGenerateCamNoteApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoading(false);
    } finally {


      isLoading(false);
    }
  }



  Future<void>  generateCibilScoreByAadharApi({
    required String fullName,
    required String idNumber,
    required String mobile,
    required String gender,
  }) async {
    try {

      isLoadingCibil(true);

      var data = await CamNoteService.generateCibilScoreByAadharApi(
        fullName: fullName,
        idNumber: idNumber,
        mobile: mobile,
        gender: gender,

      );


      if(data['success'] == true){

        generateCibilAadharModel.value= GenerateCibilAadharModel.fromMap(data);
        final cibilValues = calculateCibilData(generateCibilAadharModel.value!.data.data);
        print("TotalLoanAvailedOnCibil: ₹${cibilValues.totalLoanAvailedOnCibil}");
        print("TotalLiveLoan: ${cibilValues.totalLiveLoan}");
        print("TotalEMI: ₹${cibilValues.totalEMI.toStringAsFixed(2)}");
        print("EMIWillContinue: ${cibilValues.emiWillContinue}");
        print("TotalOverdueCasesAsPerCibil: ${cibilValues.totalOverdueCasesAsPerCibil}");
        print("TotalOverdueAmountAsPerCibil: ₹${cibilValues.totalOverdueAmountAsPerCibil}");
        print("TotalEnquiriesMadeAsPerCibil: ${cibilValues.totalEnquiriesMadeAsPerCibil}");

        var date = DateTime.now().toIso8601String();


        addCibilDetailsApi(
          phoneNo: mobile,
          aadhar: idNumber,
          pan: "",
          uniqueLeadNo: uniqueLeadNUmber.toString(),
          paymentTransactionId: "",
          cibilTransactionId: generateCibilAadharModel.value!.data!.transactionId.toString()??"0",
          pdf: generateCibilAadharModel.value!.data!.data.pdfUrl.toString()??"",
          date:date
        );

        camTotalLoanAvailedController.text=cibilValues.totalLoanAvailedOnCibil.toString();
        camTotalLiveLoanController.text=cibilValues.totalLiveLoan.toString();
        camTotalEmiController.text=cibilValues.totalEMI.toStringAsFixed(2);
        camEmiWillContinueController.text=cibilValues.emiWillContinue.toString();
        camTotalOverdueCasesController.text=cibilValues.totalOverdueCasesAsPerCibil.toString();
        camTotalOverdueAmountController.text=cibilValues.totalOverdueAmountAsPerCibil.toString();
        camTotalEnquiriesController.text=cibilValues.totalEnquiriesMadeAsPerCibil.toString();
        enableAllCibilFields.value=false;

        isLoadingCibil(false);

        Get.back();

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        generateCibilAadharModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error generateCibilScoreByAadharApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoadingCibil(false);
    } finally {


      isLoadingCibil(false);
    }
  }


  Future<void>  generateCibilScoreByPANApi({
    required String fullName,
    required String pan,
    required String mobile,
  }) async {
    try {

      isLoadingCibil(true);

      var data = await CamNoteService.generateCibilScoreByPANApi(
        fullName: fullName,
        pan: pan,
        mobile: mobile,
      );


      if(data['success'] == true){

        generateCibilAadharModel.value= GenerateCibilAadharModel.fromMap(data);
        final cibilValues = calculateCibilData(generateCibilAadharModel.value!.data.data);
        print("TotalLoanAvailedOnCibil: ₹${cibilValues.totalLoanAvailedOnCibil}");
        print("TotalLiveLoan: ${cibilValues.totalLiveLoan}");
        print("TotalEMI: ₹${cibilValues.totalEMI.toStringAsFixed(2)}");
        print("EMIWillContinue: ${cibilValues.emiWillContinue}");
        print("TotalOverdueCasesAsPerCibil: ${cibilValues.totalOverdueCasesAsPerCibil}");
        print("TotalOverdueAmountAsPerCibil: ₹${cibilValues.totalOverdueAmountAsPerCibil}");
        print("TotalEnquiriesMadeAsPerCibil: ${cibilValues.totalEnquiriesMadeAsPerCibil}");

        var date = DateTime.now().toIso8601String();
        addCibilDetailsApi(
            phoneNo: mobile,
            aadhar: "",
            pan: pan,
            uniqueLeadNo: uniqueLeadNUmber.toString(),
            paymentTransactionId: "",
            cibilTransactionId: generateCibilAadharModel.value!.data!.transactionId.toString()??"0",
            pdf: generateCibilAadharModel.value!.data!.data.pdfUrl.toString()??"",
            date:date
        );

        camTotalLoanAvailedController.text=cibilValues.totalLoanAvailedOnCibil.toString();
        camTotalLiveLoanController.text=cibilValues.totalLiveLoan.toString();
        camTotalEmiController.text=cibilValues.totalEMI.toStringAsFixed(2);
        camEmiWillContinueController.text=cibilValues.emiWillContinue.toString();
        camTotalOverdueCasesController.text=cibilValues.totalOverdueCasesAsPerCibil.toString();
        camTotalOverdueAmountController.text=cibilValues.totalOverdueAmountAsPerCibil.toString();
        camTotalEnquiriesController.text=cibilValues.totalEnquiriesMadeAsPerCibil.toString();
        enableAllCibilFields.value=false;

        isLoadingCibil(false);

        Get.back();

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
        ToastMessage.msg(AppText.somethingWentWrong);


        generateCibilAadharModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error generateCibilScoreByAadharApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoadingCibil(false);
    } finally {


      isLoadingCibil(false);
    }
  }



  Future<void>  addCibilDetailsApi({
    required String phoneNo,
    required String aadhar,
    required String pan,
    required String uniqueLeadNo,
    required String paymentTransactionId,
    required String cibilTransactionId,
    required String pdf,
    required String date,
  }) async {
    try {

      isLoadingCibil(true);

      var data = await CamNoteService.addCibilDetailsApi(
        phoneNo: phoneNo,
        aadhar: aadhar,
        pan: pan,
        uniqueLeadNo: uniqueLeadNo,
        paymentTransactionId: paymentTransactionId,
        cibilTransactionId: cibilTransactionId,
        pdf: pdf,
        date: date,
      );


      if(data['success'] == true){

        addCibilDetailsModel.value= AddCibilDetailsModel.fromJson(data);

        isLoadingCibil(false);


      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
        ToastMessage.msg(AppText.somethingWentWrong);


        addCibilDetailsModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addCibilDetailsModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoadingCibil(false);
    } finally {


      isLoadingCibil(false);
    }
  }



  Future<void>  getCamNoteDetailByLeadIdApi({
    required String leadId,

  }) async {
    try {

      isLoadingMainScreen(true);

      var data = await CamNoteService.getCamNoteDetailByLeadIdApi(
        leadId: leadId,

      );


      if(data['success'] == true){

        getCamNoteLeadIdModel.value= GetCamNoteLeadIdModel.fromJson(data);

        // Extract bankIds and update observable set
        final ids = getCamNoteLeadIdModel.value!.data?.map((e) => e.bankId.toString()).toSet() ?? {};

        camNoteLeadBankIds.value = ids;


        isLoadingMainScreen(false);


      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
        ToastMessage.msg(AppText.somethingWentWrong);


        getCamNoteLeadIdModel.value=null;
        camNoteLeadBankIds.clear();
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCamNoteLeadIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoadingMainScreen(false);
    } finally {


      isLoadingMainScreen(false);
    }
  }



  Future<void> getCamNoteDetailByIdApi({
    required String id,

  }) async {
    try {

      isLoadingMainScreen(true);

      var data = await CamNoteService.getCamNoteDetailByIdApi(
        id: id,

      );


      if(data['success'] == true){

        getCamNoteDetailByIdModel.value= GetCamNoteDetailByIdModel.fromJson(data);

        isLoadingMainScreen(false);


      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
        ToastMessage.msg(AppText.somethingWentWrong);


        getCamNoteDetailByIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCamNoteDetailByIdModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoadingMainScreen(false);
    } finally {


      isLoadingMainScreen(false);
    }
  }



  Future<void>  editCamNoteDetailApi({
    String? Id,
    String? LeadID,
    String? BankId,
    String? BankersName,
    String? BankersMobileNumber,
    String? BankersWhatsAppNumber,
    String? BankersEmailID,
    String? Cibil,
    String? TotalLoanAvailedOnCibil,
    String? TotalLiveLoan,
    String? TotalEMI,
    String? EMIStoppedOnBeforeThisLoan,
    String? EMIWillContinue,
    String? TotalOverdueCasesAsPerCibil,
    String? TotalOverdueAmountAsPerCibil,
    String? TotalEnquiriesMadeAsPerCibil,
    String? LoanSegment,
    String? LoanProduct,
    String? OfferedSecurityType,
    String? IncomeType,
    String? EarningCustomerAge,
    String? NonEarningCustomerAge,
    String? TotalFamilyIncome,
    String? IncomeCanBeConsidered,
    String? LoanAmountRequested,
    String? LoanTenorRequested,
    String? ROI,
    String? ProposedEMI,
    String? PropertyValueAsPerCustomer,
    String? FOIR,
    String? LTV,
    String? BranchOfBank,
    String? SanctionProcessingCharges,
    String? Autoindividual,
  }) async {
    try {

      isLoading(true);

      var data = await CamNoteService.editCamNoteDetailApi(
        Id: Id,
        LeadID: LeadID,
        BankId: BankId,
        BankersName: BankersName,
        BankersMobileNumber: BankersMobileNumber,
        BankersWhatsAppNumber: BankersWhatsAppNumber,
        BankersEmailID: BankersEmailID,
        Cibil: Cibil,
        TotalLoanAvailedOnCibil: TotalLoanAvailedOnCibil,
        TotalLiveLoan: TotalLiveLoan,
        TotalEMI: TotalEMI,
        EMIStoppedOnBeforeThisLoan: EMIStoppedOnBeforeThisLoan,
        EMIWillContinue: EMIWillContinue,
        TotalOverdueCasesAsPerCibil: TotalOverdueCasesAsPerCibil,
        TotalOverdueAmountAsPerCibil: TotalOverdueAmountAsPerCibil,
        TotalEnquiriesMadeAsPerCibil: TotalEnquiriesMadeAsPerCibil,
        LoanSegment: LoanSegment,
        LoanProduct: LoanProduct,
        OfferedSecurityType: OfferedSecurityType,

        IncomeType: IncomeType,
        EarningCustomerAge: EarningCustomerAge,
        NonEarningCustomerAge: NonEarningCustomerAge,
        TotalFamilyIncome: TotalFamilyIncome,
        IncomeCanBeConsidered: IncomeCanBeConsidered,
        LoanAmountRequested: LoanAmountRequested,
        LoanTenorRequested: LoanTenorRequested,
        ROI: ROI,
        ProposedEMI: ProposedEMI,
        PropertyValueAsPerCustomer: PropertyValueAsPerCustomer,
        FOIR: FOIR,
        LTV: LTV,
        BranchOfBank: BranchOfBank,
        SanctionProcessingCharges: SanctionProcessingCharges,
        Autoindividual: Autoindividual,
      );


      if(data['success'] == true){

        editCamNoteDetail.value= AddCamNoteDetail.fromJson(data);

        bankerBranchMap.clear();
        ToastMessage.msg(editCamNoteDetail.value!.message!);

        sendMailToBankerAfterGenerateCamNoteApi(id: editCamNoteDetail.value!.data!.id.toString());

        clearBankDetails();
        getCamNoteDetailByLeadIdApi(leadId: LeadID.toString());
        isLoading(false);



      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        addCamNoteDetail.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addCamNoteDetail: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoading(false);
    } finally {


      isLoading(false);
    }
  }

  Future<void>  getPackageDetailsByIdApi({
    required String packageId,
  }) async {
    try {

      isBankerSuperiorLoading(true);


      var data = await CamNoteService.getPackageDetailsByIdApi(
          packageId: packageId
      );


      if(data['success'] == true){

        getPackageDetailsByIdModel.value= GetPackageDetailsByIdModel.fromJson(data);
        final cibilPackages = getPackageDetailsByIdModel.value!.data?.where((d) => d.isCibilService).toList();
        print("cibilPackages====>${cibilPackages}");

        if(cibilPackages!.isEmpty){

          isGenerateCibilVisible.value=false;
        }else{

          isGenerateCibilVisible.value=true;
        }



        isBankerSuperiorLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getPackageDetailsByIdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getPackageDetailsByIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isBankerSuperiorLoading(false);
    } finally {


      isBankerSuperiorLoading(false);
    }
  }


  int? getMaxBankSelection(String packageName, String? amount) {
    if (packageName.contains("CIBIL") && amount == "236") {
      return 1;
    } else if (packageName.contains("Secured Combo") && amount == "1180") {
      return 3;
    }
    return null; // no limit
  }


  Future<void>  fetchBankDetailBySegmentIdAndKSDPLProductIdApi({
    required String segmentVerticalId,
    required String KSDPLProductId,
  }) async {
    try {

      isOtherBankLoading(true);


      var data = await CamNoteService.fetchBankDetailBySegmentIdAndKSDPLProductIdApi(
          segmentVerticalId: segmentVerticalId,
          KSDPLProductId:KSDPLProductId
      );


      if(data['success'] == true){

        fetchBankDetailSegKSDPLProdModel.value= otherBank.FetchBankDetailSegKSDPLProdModel.fromJson(data);

        /*final List<otherBank.Data> allBk = fetchBankDetailSegKSDPLProdModel.value?.data ?? [];

        final List<otherBank.Data> bks = allBk;

        getOtherBankList.value = bks;*/

        final List<otherBank.Data> allBk =
            fetchBankDetailSegKSDPLProdModel.value?.data ?? [];

        /// Get bankIds from API 1 (getProductDetailsByFilterApi)
        final Set<dynamic> existingBankIds = getProductDetailsByFilterModel.value?.data
            ?.map((bank) => bank.bankId)
            .toSet() ??
            {};

        /// 👉 Filter only banks NOT present in existing bankIds
        final List<otherBank.Data> filteredNewBanks = allBk
            .where((bank) => !existingBankIds.contains(bank.bankId))
            .toList();

        getOtherBankList.value = filteredNewBanks;



        isOtherBankLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        fetchBankDetailSegKSDPLProdModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getPackageDetailsByIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isOtherBankLoading(false);
    } finally {


      isOtherBankLoading(false);
    }
  }




  Future<void> getProductDetailBySegmentAndProductApiApi({
    required String segmentVerticalId,
    required String kSDPLProductId,
    required String bankId,
  }) async {
    try {

      isOtherBankBrLoading(true);


      var data = await CamNoteService.getProductDetailBySegmentAndProductApi(
          segmentVerticalId: segmentVerticalId,
          kSDPLProductId:kSDPLProductId,
          bankId:bankId
      );


      if(data['success'] == true){

          getProductDetailBySegmentAndProductModel.value =
              otherBankBranch.GetProductDetailBySegmentAndProductModel.fromJson(
                  data);


          final List<otherBankBranch
              .Data> allBr = getProductDetailBySegmentAndProductModel.value
              ?.data ?? [];

          final List<otherBankBranch.Data> brs = allBr;

          getOtherBankBranchList.value = brs;

          isOtherBankBrLoading(false);


      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getProductDetailBySegmentAndProductModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getPackageDetailsByIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isOtherBankBrLoading(false);
    } finally {


      isOtherBankBrLoading(false);
    }
  }


  void  getProductListByIdApi({
    required String id
  }) async {
    try {
      isLoading(true);

      var data = await ProductService.getProductListByIdApi(id: id);

      if(data['success'] == true){




        getProductListById.value= gpli.GetProductListById.fromJson(data);

        CamNoteController camNoteController=Get.put(CamNoteController());

          final existingList = camNoteController.getProductDetailsByFilterModel.value?.data ?? [];

          final productData = getProductListById.value!.data;
        print("productData ==>${productData.toString()}");
          if (productData != null) {
            existingList.forEach((ele){
              print("existingList bankName--->${ele.bankName}");
            });



            existingList.add(productData.toFilterData("2"));

            camNoteController.getProductDetailsByFilterModel.value = pdFModel.GetProductDetailsByFilterModel(
              status: getProductListById.value!.status,
              success: getProductListById.value!.success,
              message: getProductListById.value!.message,
              data: existingList,
            );
            print("getProductListById in other bank API after assign 2==>${getProductListById.value!.data.toString()}");


            camNoteController.getProductDetailsByFilterModel.value!.data!.forEach((ele){
              print("ChangedList bankName--->${ele.bankName}");
            });
          }



        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  Future<void>  sendMailForLocationOfCustomerApi({
    required String locationType,
    required String leadId,
    required String email,
  }) async {
    try {
      isLoading(true);

      var data = await CamNoteService.sendMailForLocationOfCustomerApi(
          locationType: locationType,
        leadId: leadId,
        email: email
      );

      if(data['success'] == true){

        sendMailForLocationOfCustomerModel.value= SendMailForLocationOfCustomerModel.fromJson(data);


        Addleadcontroller addLeadController =Get.find();
// Now call API with extracted values

        /*List<File> propertyPhotos = getImages("property_photo");
        List<File> residencePhotos = getImages("residence_photo");
        List<File> officePhotos = getImages("office_photo");*/

        List<File> propertyPhotos = getImages("property_photo")
            .where((img) => img.isLocal)
            .map((img) => img.file!)
            .toList();

        List<File> residencePhotos = getImages("residence_photo")
            .where((img) => img.isLocal)
            .map((img) => img.file!)
            .toList();

        List<File> officePhotos = getImages("office_photo")
            .where((img) => img.isLocal)
            .map((img) => img.file!)
            .toList();

        await addLeadController.fillLeadFormApi(
          id: getLeadId.value.toString(),
          dob: camDobController.text.toString(),
          gender: selectedGender.toString(),
          loanAmtReq:camLoanAmtReqController.text.toString(),
          email: camEmailController.text.toString(),
          aadhar: camAadharController.text.toString(),
          pan: camPanController.text.toString(),
          streetAdd: camStreetAddController.text.toString(),
          state:  camSelectedState.value.toString(),
          district: camSelectedDistrict.value.toString(),
          city: camSelectedCity.value.toString(),
          zip: camZipController.text.toString(),
          nationality: camNationalityController.text.toString(),
          currEmpSt: camCurrEmpStatus.value,
          employerName: camEmployerNameController.text.toString(),
          monthlyIncome:camMonthlyIncomeController.text.toString(),
          ///Now this is not working, Have different API for Additional source of income
          addSrcIncome: "",
          prefBank: camSelectedBank.value.toString(),
          exRelBank:camSelectedIndexRelBank.value==-1?"":camSelectedIndexRelBank.value==0?"Yes":"No",
          branchLoc:camBranchLocController.text.toString(),
          prodTypeInt: camSelectedProdType.value.toString(),
          /// connection name mob and percent are not sent
          loanApplNo: loanApplicationNumber.toString(),

          name: camFullNameController.text.toString(),
          mobileNumber: camPhoneController.text.toString(),
          packageId: selectedPackage.value.toString(),
          packageAmount: camPackageAmtController.text.toString(),
          receivableAmount:camReceivableAmtController.text.toString(),
          receivableDate:camReceivableDateController.text.toString(),
          transactionDetails:camTransactionDetailsController.text.toString(),
          remark:camRemarkController.text.toString(),
          leadSegment:camSelectedProdSegment.value.toString(),

          GeoLocationOfProperty:camGeoLocationPropertyLatController.text.trim().toString()+"-"+camGeoLocationPropertyLongController.text.trim().toString(),
          GeoLocationOfResidence:camGeoLocationResidenceLatController.text.trim().toString()+"-"+camGeoLocationResidenceLongController.text.trim().toString(),
          GeoLocationOfOffice:camGeoLocationOfficeLatController.text.trim().toString()+"-"+camGeoLocationOfficeLongController.text.trim().toString(),
          PhotosOfProperty: propertyPhotos,
          PhotosOfResidence: residencePhotos,
          PhotosOfOffice: officePhotos,
          WhatsappNumber: camWhatsappController.text.toString(),
        );

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  void  requestForFinancialServicesApi({
    required String leadId
  }) async {
    try {
      isLoading(true);

      var data = await CamNoteService.requestForFinancialServicesApi(leadID: leadId);

      if(data['success'] == true){

        requestForFinancialServicesModel.value= RequestForFinancialServicesModel.fromJson(data);

        ToastMessage.msg(requestForFinancialServicesModel.value!.message.toString());
        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error requestForFinancialServicesApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
  void setAgeFromDob(TextEditingController dobController, TextEditingController ageController) {

    if (dobController.text.isNotEmpty) {
      try {
        DateTime dob = DateFormat("yyyy-MM-dd").parse(dobController.text);
        int age = calculateAge(dob);
        ageController.text = "$age";
      } catch (e) {
        print("Invalid DOB format: ${dobController.text}");
      }
    }
  }

  Future<void> getLeadDetailByCustomerNumberApi(String phone) async {

    try {
      isLoading(true);

      var data = await CamNoteService.requestForgetLeadDetailByCustomerNumberApi(mobileNumber: phone);

      if(data['success'] == true){

        getLeadDetailByCustomerNumberModel.value= GetLeadDetailByCustomerNumberModel.fromJson(data);

        if(getLeadDetailByCustomerNumberModel.value?.data?.mobileNumber==null || getLeadDetailByCustomerNumberModel.value?.data?.mobileNumber=="null"){

          isaddedMobileNumber.value = false;
        }else {
          print("addleadcontroller.getLeadDetailModel.value?.data?.mobileNumber==${addleadcontroller.getLeadDetailModel.value?.data?.mobileNumber}");
          print("getLeadDetailByCustomerNumberModel.value?.data?.mobileNumberr==${getLeadDetailByCustomerNumberModel.value?.data?.mobileNumber}");

          if( addleadcontroller.getLeadDetailModel.value?.data?.mobileNumber==getLeadDetailByCustomerNumberModel.value?.data?.mobileNumber){

            isaddedMobileNumber.value = false;
            print("if-->");
          }else{
            isaddedMobileNumber.value = true;
            SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "This Number already added ");
            print("else-->");
          }

        }

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error requestForFinancialServicesApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  Future<void> getCamNoteDetailsByLeadIdForUpdateApi(String leadId) async {

    try {
      isLoading(true);

      var data = await CamNoteService.getCamNoteDetailsByLeadIdForUpdateApi(leadId: leadId);

      if(data['success'] == true){

        getCamNoteDetailsModel.value= GetCamNoteDetailsByLeadIdForUpdateModel.fromJson(data);

        ///newly added on 22 sep
        // camCibilController.text=(getCamNoteDetailsModel.value?.data?.cibil??"0").toString();
        camCibilController.text=(getCamNoteDetailsModel.value?.data?.cibil == null ||
            getCamNoteDetailsModel.value?.data?.cibil?.toString().toLowerCase() == "na")
            ? "0"
            : getCamNoteDetailsModel.value?.data?.cibil.toString()??"0";
        camTotalLoanAvailedController.text=(getCamNoteDetailsModel.value?.data?.totalLoanAvailedOnCibil??"").toString();
        camTotalLiveLoanController.text=(getCamNoteDetailsModel.value?.data?.totalLiveLoan??"").toString();
        camTotalEmiController.text=(getCamNoteDetailsModel.value?.data?.totalEMI??"").toString();
        camEmiWillContinueController.text=(getCamNoteDetailsModel.value?.data?.emiWillContinue??"").toString();
        camTotalOverdueCasesController.text=(getCamNoteDetailsModel.value?.data?.totalOverdueCasesAsPerCibil??"").toString();
        camTotalOverdueAmountController.text=(getCamNoteDetailsModel.value?.data?.totalOverdueAmountAsPerCibil??"").toString();
        camTotalEnquiriesController.text=(getCamNoteDetailsModel.value?.data?.totalEnquiriesMadeAsPerCibil??"").toString();
        enableAllCibilFields.value=false;
        // end

        camIncomeCanBeConsideredController.text=(getCamNoteDetailsModel.value?.data?.incomeCanBeConsidered??"").toString();
        camLoanTenorRequestedController.text=(getCamNoteDetailsModel.value?.data?.loanTenorRequested??"").toString();
        camLoanTenorRequestedController.text=(getCamNoteDetailsModel.value?.data?.loanTenorRequested??"").toString();
        camRateOfInterestController.text=(getCamNoteDetailsModel.value?.data?.roi??"").toString();
        camProposedEmiController.text=(getCamNoteDetailsModel.value?.data?.proposedEMI??"").toString();
        camPropertyValueController.text=(getCamNoteDetailsModel.value?.data?.propertyValueAsPerCustomer??"").toString();
        camFoirController.text=(getCamNoteDetailsModel.value?.data?.foir??"").toString();
        camLtvController.text=(getCamNoteDetailsModel.value?.data?.ltv??"").toString();

        NewDDController newDDController=Get.find();
        newDDController.getAllPrimeSecurityMasterApi();
        camOfferedSecurityTypeController.text=getCamNoteDetailsModel.value?.data?.offeredSecurityType??"";


        ///30 Sep
        camNonEarningCustomerAgeController.text=(getCamNoteDetailsModel.value?.data?.nonEarningCustomerAge??"").toString();
        camTotalFamilyIncomeController.text=(getCamNoteDetailsModel.value?.data?.totalFamilyIncome??"").toString();
        camIncomeCanBeConsideredController.text=(getCamNoteDetailsModel.value?.data?.incomeCanBeConsidered??"").toString();
        camIncomeCanBeConsideredController.text=(getCamNoteDetailsModel.value?.data?.incomeCanBeConsidered??"").toString();
        camLoanTenorRequestedController.text=(getCamNoteDetailsModel.value?.data?.loanTenorRequested??"").toString();
        camRateOfInterestController.text=(getCamNoteDetailsModel.value?.data?.roi??"").toString();
        camProposedEmiController.text=(getCamNoteDetailsModel.value?.data?.proposedEMI??"").toString();
        camPropertyValueController.text=(getCamNoteDetailsModel.value?.data?.propertyValueAsPerCustomer??"").toString();
        camFoirController.text=(getCamNoteDetailsModel.value?.data?.foir??"").toString();
        camLtvController.text=(getCamNoteDetailsModel.value?.data?.ltv??"").toString();
        camLtvController.text=(getCamNoteDetailsModel.value?.data?.ltv??"").toString();
        camEmiStoppedBeforeController.text=(getCamNoteDetailsModel.value?.data?.emiStoppedOnBeforeThisLoan??"").toString();
        selectedCamIncomeTypeList.value=(getCamNoteDetailsModel.value?.data?.incomeType??"").toString();




        isLoading(false);

      }else{
        //ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error requestForFinancialServicesApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void calculateLoanDetails() {
    // Parse safely with fallbacks
    final double P = double.tryParse(camLoanAmtReqController.text) ?? 0.0; // Loan Amount
    final int n = int.tryParse(camLoanTenorRequestedController.text) ?? 0; // Tenor
    final double annualROI = double.tryParse(camRateOfInterestController.text) ?? 0.0; // ROI
    final double r = annualROI / 12 / 100; // Monthly ROI

    double emi = 0.0;
    if (P > 0 && r > 0 && n > 0) {
      emi = (P * r * (pow(1 + r, n))) / (pow(1 + r, n) - 1);
    }

    final double existingEMI = double.tryParse(camEmiWillContinueController.text) ?? 0.0;
    final double income = double.tryParse(camIncomeCanBeConsideredController.text) ?? 0.0;
    final double proposedEMI = emi;
    final double foir = income > 0 ? ((existingEMI + proposedEMI) / income) * 100 : 0;

    final double propertyValue = double.tryParse(camPropertyValueController.text) ?? 0.0;
    final double ltv = propertyValue > 0 ? (P / propertyValue) * 100 : 0;

    // Populate results in target controllers
    camProposedEmiController.text = emi > 0 ? emi.toStringAsFixed(2) : "";
    camFoirController.text = foir > 0 ? foir.toStringAsFixed(2) : "";
    camLtvController.text = ltv > 0 ? ltv.toStringAsFixed(2) : "";
  }

  void calculateEmilWillContinue() {
    // Get values safely (default to 0 if empty or invalid)
    final totalEmi = num.tryParse(camTotalEmiController.text) ?? 0;
    final stoppedBefore = num.tryParse(camEmiStoppedBeforeController.text) ?? 0;


    print("camTotalEmiController.text--->${camTotalEmiController.text}");
    print("totalEmi--->${totalEmi}");
    print("stoppedBefore--->${stoppedBefore}");

    // Perform calculation
    final willContinue = (totalEmi - stoppedBefore).clamp(0, totalEmi);
    print("willContinue--->${willContinue}");

    // Update controller
    camEmiWillContinueController.text = willContinue.toString();
  }

  Future<void> addCustomerDetailsApi({
    String? Id,
    String? CustomerName,
    String? MobileNumber,
    String? Email,
    String? Gender,
    String? AdharCard,
    String? PanCard,
    String? StreetAddress,
    String? State,
    String? District,
    String? City,
    String? Nationality,
  }) async {
    try {
      print("addCamNoteDetailApi-->1");
      isLoading(true);

      var data = await CamNoteService.addCustomerDetailsApi(
        Id: Id,
        CustomerName: CustomerName,
        MobileNumber: MobileNumber,
        Email: Email,
        Gender: Gender,
        AdharCard: AdharCard,
        PanCard: PanCard,
        StreetAddress: StreetAddress,
        State: State,
        District: District,
        City: City,
        Nationality: Nationality,
      );


      if(data['success'] == true){

        addCustomerDetailsModel.value= AddCustomerDetailsModel.fromJson(data);




        isLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        addCamNoteDetail.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addCamNoteDetail: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isLoading(false);
      isAllCamnoteSubmit(false);
    } finally {


      isLoading(false);
      isAllCamnoteSubmit(false);
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


extension ParseStringToDoubleExtension on String? {
  double toDoubleOrZero() {
    if (this != null && this!.isNotEmpty) {
      return double.tryParse(this!.trim()) ?? 0.0;
    }
    return 0.0;
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
String cleanText(String text) {
  return text.trim().isEmpty ? "" : text.trim();
}


extension ProductDataMapper on gpli.Data {
  pdFModel.Data toFilterData(String autoindividual) {
    return pdFModel.Data(
      id: id,
      bankId: bankId,
      bankersName: bankersName,
      bankersMobileNumber: bankersMobileNumber,
      bankersWhatsAppNumber: bankersWhatsAppNumber,
      bankersEmailID: bankersEmailID,
      minCIBIL: minCIBIL,
      segmentVertical: segmentVertical,
      product: product,
      productDescription: productDescription,
      customerCategory: customerCategory,
      collateralSecurityCategory: collateralSecurityCategory,
      collateralSecurityExcluded: collateralSecurityExcluded,
      incomeTypes: incomeTypes,
      profileExcluded: profileExcluded,
      ageLimitEarningApplicants: ageLimitEarningApplicants,
      ageLimitNonEarningCoApplicant: ageLimitNonEarningCoApplicant,
      minimumAgeEarningApplicants: minimumAgeEarningApplicants,
      minimumAgeNonEarningApplicants: minimumAgeNonEarningApplicants,
      minimumIncomeCriteria: minimumIncomeCriteria,
      minimumLoanAmount: minimumLoanAmount,
      maximumLoanAmount: maximumLoanAmount,
      minTenor: minTenor,
      maximumTenor: maximumTenor,
      minimumROI: minimumROI,
      maximumROI: maximumROI,
      maximumTenorEligibilityCriteria: maximumTenorEligibilityCriteria,
      geoLimit: geoLimit,
      negativeProfiles: negativeProfiles,
      negativeAreas: negativeAreas,
      maximumTAT: maximumTAT,
      minimumPropertyValue: minimumPropertyValue,
      maximumIIR: maximumIIR,
      maximumFOIR: maximumFOIR,
      maximumLTV: maximumLTV,
      processingFee: processingFee,
      legalFee: legalFee,
      technicalFee: technicalInspectionFee, // careful: different name
      adminFee: adminFee,
      foreclosureCharges: foreclosureCharges,
      otherCharges: otherCharges,
      stampDuty: stampDuty,
      tsRYears: tsRYears,
      tsRCharges: tsRCharges,
      valuationCharges: valuationCharges,
      noOfDocument: noOfDocument,
      productValidateFromDate: productValidateFromDate,
      productValidateToDate: productValidateToDate,
      ksdplProductId: ksdplProductId,
      profitPercentage: profitPercentage,
      bankName: bankName,
      ksdplProduct: ksdplProductName,
      productSegment: productCategoryName,
      specialBranchId: null, // You can map this if needed later
      autoindividual: autoindividual, // You can map this if needed later
    );
  }



}
