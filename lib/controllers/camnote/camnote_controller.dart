import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/addLeadController.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import 'package:ksdpl/controllers/product/view_product_controller.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
import 'package:ksdpl/services/camnote_service.dart';
import 'package:ksdpl/services/product_service.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/ImagePickerMixin.dart';
import '../../models/camnote/AddAdSrcIncomModel.dart';
import '../../models/camnote/AddBankerDetail.dart';
import '../../models/camnote/AddCamNoteDetail.dart';
import '../../models/camnote/AddCibilDetailsModel.dart';
import '../../models/camnote/GenerateCibilAadharModel.dart';
import '../../models/camnote/GetAddIncUniqueLeadModel.dart';
import '../../models/camnote/GetAllPackageMasterModel.dart' as pkg;
import '../../models/camnote/GetBankerDetailModelForCheck.dart';
import '../../models/camnote/GetBankerDetailsByIdModel.dart';
import '../../models/camnote/GetCamNoteDetailByIdModeli.dart';
import '../../models/camnote/GetCamNoteLeadIdModel.dart';
import '../../models/camnote/GetPackageDetailsByIdModel.dart';
import '../../models/camnote/GetProductDetailsByFilterModel.dart';
import '../../models/camnote/SendMailToBankerCamNoteModel.dart';
import '../../models/camnote/UpdateBankerDetailModel.dart';
import '../../models/camnote/special_model/IncomeModel.dart';
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
import '../../services/new_dd_service.dart';
import '../leads/add_income_model_controller.dart';
import '../loan_appl_controller/co_applicant_detail_mode_controllerl.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../loan_appl_controller/credit_cards_model_controller.dart';
import '../loan_appl_controller/reference_model_controller.dart';
import 'calculateCibilData.dart';
var getBankerDetailsByIdModel = Rxn<GetBankerDetailsByIdModel>(); //
var getPackageDetailsByIdModel = Rxn<GetPackageDetailsByIdModel>(); //

class CamNoteController extends GetxController with ImagePickerMixin{

  var getLoanApplIdModel = Rxn<GetLoanApplIdModel>();
  var leadId="".obs;
  var firstName="".obs;
  var email="".obs;
  var isLoading = false.obs;
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
  var generateCibilAadharModel = Rxn<GenerateCibilAadharModel>(); //
  var addCibilDetailsModel = Rxn<AddCibilDetailsModel>(); //
  var editCamNoteDetail = Rxn<AddCamNoteDetail>(); //
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
  var getProductDetailsByFilterModel = Rxn<GetProductDetailsByFilterModel>(); //
  var getCamNoteLeadIdModel = Rxn<GetCamNoteLeadIdModel>(); //
  var getCamNoteDetailByIdModel = Rxn<GetCamNoteDetailByIdModel>(); //
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

  final TextEditingController camCibilMobController = TextEditingController();
  var camSelectedState = Rxn<String>();
  var camSelectedDistrict = Rxn<String>();
  var camSelectedCity = Rxn<String>();
  var camCurrEmpStatus = Rxn<String>();
  var camSelectedBank = Rxn<String>();
  var camSelectedProdSegment = Rxn<int>();
  var camSelectedProdType = Rxn<String>();
  var camSelectedIndexRelBank = (-1).obs;
  ///end
  var uniqueLeadNUmber="";
  var loanApplicationNumber="";

  final Map<String, RxList<File>> imageMap = {};
  var isPackageLoading = false.obs;
  var selectedPackage = Rxn<int>();
  var selectedBankBranch = Rxn<int>();
  var selectedBankerBranch = Rxn<int>();
  var selectedIndexGenCibil = (-1).obs;
  var enableAllCibilFields = true.obs;

  void selectCheckboxCibil(int index) {
    selectedIndexGenCibil.value = index;

    print("selectedIndexGenCibil===>${selectedIndexGenCibil}");
   /* if( selectedIndex.value==0){
      isLeadCountYearly.value="false";

    } else if( selectedIndex.value==1){
      isLeadCountYearly.value="true";


    }else{

    }*/
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
  Map<String, String> bankerBranchMap = {};
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

    print("selectedBankers===>${selectedBankers.toString()}");
  }

  bool isBankerSelected(String bankId) => selectedBankers.contains(bankId);

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
      print("🧯 Invalid index passed to removeCoApplicant: $index");
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

  void nextStep(int tappedIndex) {
    if (currentStep.value < 2) {
      currentStep.value++;
      if(currentStep.value==2){

        forBankDetailSubmit();
      }
      scrollToStep(currentStep.value);
    }

    if(currentStep.value==1 || currentStep.value==2){
      setAgeFromDob(camDobController, camEarningCustomerAgeController);
    }

    if(tappedIndex==2){
      saveForm();
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

    currentStep.value = step;

    if(currentStep.value==2){
      forBankDetailSubmit();
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

  void saveForm() async {
    print("Form Saved!");

    if(selectedBankers.isEmpty){
      SnackbarHelper.showSnackbar(title: "Incomplete Data", message: "Please select a bank first");
    }else{
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

        );
      }

      final productList = getProductDetailsByFilterModel.value?.data ?? [];

      if(productList.isNotEmpty){
        for (var bankerId in selectedBankers) {


          final matchingProducts = productList.where((product) => product.id.toString() == bankerId);
          for (var product in matchingProducts) {

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
// Now call API with extracted values

            List<File> propertyPhotos = getImages("property_photo");
            List<File> residencePhotos = getImages("residence_photo");
            List<File> officePhotos = getImages("office_photo");



            addCamNoteDetailApi(
              Id:"0",
              LeadID:getLeadId.value.toString(),
              Cibil: camCibilController.text.trim().toString(),
              TotalLoanAvailedOnCibil: camTotalLoanAvailedController.text.trim().toString(),
              TotalLiveLoan: camTotalLiveLoanController.text.trim().toString(),
              TotalEMI:camTotalEmiController.text.trim().toString(),
              EMIStoppedOnBeforeThisLoan:camEmiStoppedBeforeController.text.trim().toString(),
              EMIWillContinue:camEmiWillContinueController.text.trim().toString(),
              TotalOverdueCasesAsPerCibil:camTotalOverdueCasesController.text.trim().toString(),
              TotalOverdueAmountAsPerCibil:camTotalOverdueAmountController.text.trim().toString(),
              TotalEnquiriesMadeAsPerCibil:camTotalEnquiriesController.text.trim().toString(),
              GeoLocationOfProperty:camGeoLocationPropertyLatController.text.trim().toString()+"-"+camGeoLocationPropertyLongController.text.trim().toString(),
              GeoLocationOfResidence:camGeoLocationResidenceLatController.text.trim().toString()+"-"+camGeoLocationResidenceLongController.text.trim().toString(),
              GeoLocationOfOffice:camGeoLocationOfficeLatController.text.trim().toString()+"-"+camGeoLocationOfficeLongController.text.trim().toString(),
              PhotosOfProperty: propertyPhotos??[],
              PhotosOfResidence: residencePhotos??[],
              PhotosOfOffice: officePhotos??[],
              IncomeType: selectedCamIncomeTypeList.value.toString(),
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
              OfferedSecurityType: camOfferedSecurityTypeController.text.trim().toString(),
              LoanProduct:camSelectedProdType.value.toString(),
              LoanSegment:camSelectedProdSegment.value.toString(),
              BankersName: bankersName,
              BankersMobileNumber: bankersMobileNumber,
              BankersEmailID: bankersEmailID,
              BankersWhatsAppNumber: bankersWhatsAppNumber,
              BankId: bankId.toString(),
              BranchOfBank: branchId.toString(),
              SanctionProcessingCharges:"",

            );

          }
        }
      }else{
        SnackbarHelper.showSnackbar(title: "Incomplete Data", message: "Please select a bank first");
      }
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
        cibil: camCibilController.text.trim().toString(),
        segmentVertical: camSelectedProdSegment.value.toString(),
        customerCategory: "",
        collateralSecurityCategory: "",
        collateralSecurityExcluded: "",
        incomeTypes:selectedCamIncomeTypeList.value,
        ageEarningApplicants: camEarningCustomerAgeController.text,
        ageNonEarningCoApplicant:camEarningCustomerAgeController.text,
        applicantMonthlySalary:camTotalFamilyIncomeController.text,
        loanAmount:camLoanAmtReqController.text.trim().toString(),
        tenor: camLoanTenorRequestedController.text.trim().toString(),
        roi:camRateOfInterestController.text.trim().toString(),
        maximumTenorEligibilityCriteria:"",
        customerAddress:camStreetAddController.text.trim().toString(),

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
      );


      if(data['success'] == true){


        getProductDetailsByFilterModel.value= GetProductDetailsByFilterModel.fromJson(data);



        isBankerLoading(false);




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
        ToastMessage.msg( addAdSrcIncomModel.value!.message!.toString());

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

        getBankerDetailsByIdModel.value= GetBankerDetailsByIdModel.fromJson(data);

        camBankerMobileNoController.text=getBankerDetailsByIdModel.value!.data!.bankersMobileNumber.toString();
        camBankerNameController.text=getBankerDetailsByIdModel.value!.data!.bankersName.toString();
        camBankerWhatsappController.text=getBankerDetailsByIdModel.value!.data!.bankersWhatsAppNumber.toString();
        camBankerEmailController.text=getBankerDetailsByIdModel.value!.data!.bankersEmailId.toString();
        camBankerSuperiorNameController.text=getBankerDetailsByIdModel.value!.data!.superiorName.toString();
        camBankerSuperiorMobController.text=getBankerDetailsByIdModel.value!.data!.superiorMobile.toString();
        camBankerSuperiorWhatsappController.text=getBankerDetailsByIdModel.value!.data!.superiorWhatsApp.toString();
        camBankerSuperiorEmailController.text=getBankerDetailsByIdModel.value!.data!.superiorEmail.toString();

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

      print("index===>${index.toString()}");

      if (index != -1) {
        final old = getCamNoteLeadIdModel.value!.data![index];

        // Update relevant fields
        final updatedBanker =  getCamNoteLeadIdModel.value!.data![index] = old.copyWith(
          bankersName: updatedFields['bankersName'],
          bankersMobileNumber: updatedFields['bankersMobileNumber'],
          bankersWhatsAppNumber: updatedFields['bankersWhatsAppNumber'],
          bankersEmailID: updatedFields['bankersEmailID'],
        );
        getCamNoteLeadIdModel.value!.data![index] = updatedBanker;
        // Refresh the list
        getCamNoteLeadIdModel.refresh();
        var dataNew=getCamNoteLeadIdModel.value!.data![index];
        print("leadid on tap edit--->${dataNew.leadID}");
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
          GeoLocationOfProperty:dataNew.geoLocationOfProperty,
          GeoLocationOfResidence:dataNew.geoLocationOfResidence,
          GeoLocationOfOffice:dataNew.geoLocationOfOffice.toString(),
          PhotosOfProperty: dataNew.photosOfProperty.toString(),
          PhotosOfResidence: dataNew.photosOfResidence.toString(),
          PhotosOfOffice: dataNew.photosOfOffice.toString(),
          IncomeType: dataNew.incomeType.toString(),
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
    String? GeoLocationOfProperty,
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
    String? GeoLocationOfResidence,
    String? GeoLocationOfOffice,
    String? SanctionProcessingCharges,
    List<File>? PhotosOfProperty,
    List<File>? PhotosOfResidence,
    List<File>? PhotosOfOffice,

  }) async {
    try {

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
        GeoLocationOfProperty: GeoLocationOfProperty,
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
        GeoLocationOfResidence: GeoLocationOfResidence,
        GeoLocationOfOffice: GeoLocationOfOffice,
        PhotosOfProperty: PhotosOfProperty,
        PhotosOfResidence: PhotosOfResidence,
        PhotosOfOffice: PhotosOfOffice,
        SanctionProcessingCharges: SanctionProcessingCharges,
      );


      if(data['success'] == true){

        addCamNoteDetail.value= AddCamNoteDetail.fromJson(data);

        bankerBranchMap.clear();
        ToastMessage.msg(addCamNoteDetail.value!.message!);

        sendMailToBankerAfterGenerateCamNoteApi(id: addCamNoteDetail.value!.data!.id.toString());
        clearStep1();
        clearStep2();
        clearBankDetails();
        Get.back();
        isAllCamnoteSubmit(false);
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

        isLoadingMainScreen(false);


      }else if(data['success'] == false && (data['data'] as List).isEmpty ){
        ToastMessage.msg(AppText.somethingWentWrong);


        getCamNoteLeadIdModel.value=null;
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
    String? GeoLocationOfProperty,
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
    String? GeoLocationOfResidence,
    String? GeoLocationOfOffice,
    String? SanctionProcessingCharges,
    String? PhotosOfProperty,
    String? PhotosOfResidence,
    String? PhotosOfOffice,

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
        GeoLocationOfProperty: GeoLocationOfProperty,
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
        GeoLocationOfResidence: GeoLocationOfResidence,
        GeoLocationOfOffice: GeoLocationOfOffice,
        PhotosOfProperty: PhotosOfProperty,
        PhotosOfResidence: PhotosOfResidence,
        PhotosOfOffice: PhotosOfOffice,
        SanctionProcessingCharges: SanctionProcessingCharges,
      );


      if(data['success'] == true){

        editCamNoteDetail.value= AddCamNoteDetail.fromJson(data);

        bankerBranchMap.clear();
        ToastMessage.msg(editCamNoteDetail.value!.message!);

        sendMailToBankerAfterGenerateCamNoteApi(id: editCamNoteDetail.value!.data!.id.toString());

        clearBankDetails();
        Get.back();
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

        if(cibilPackages!.isEmpty){
          print("cibil not exist--.");
          isGenerateCibilVisible.value=false;
        }else{
          print("cibil  exist--.");
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


