import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/IndividualLeadUploadModel.dart';
import '../../models/camnote/special_model/IncomeModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/leads/special_model/AddIncModel.dart';
import '../../services/drawer_api_service.dart';
import '../../services/lead_api_service.dart';
import '../camnote/calculateCibilData.dart';
import '../product/add_product_controller.dart';
import '../registration_dd_controller.dart';
import 'add_income_model_controller.dart';
import 'loan_appl_controller.dart';

class Addleadcontroller extends GetxController{

  var isLoading = false.obs;
  var isConnectorChecked = false.obs;
  var selectedGender = Rxn<String>();
  //final RegistrationDDController regDDController= Get.put(RegistrationDDController());
  List<String> optionsRelBank = ["Yes", "No"];
  var selectedIndexRelBank = (-1).obs;
  var selectedIndexExistingLoan = (-1).obs;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController loanAmtReqController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController streetAddController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController currEmpStController = TextEditingController();
  final TextEditingController employerNameController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();
  final TextEditingController addSourceIncomeController = TextEditingController();
  final TextEditingController branchLocController = TextEditingController();
  final TextEditingController productTypeController = TextEditingController();
  final TextEditingController connNameController = TextEditingController();
  final TextEditingController connMobController = TextEditingController();
  final TextEditingController connShareController = TextEditingController();

  final TextEditingController existingLoansController = TextEditingController();
  final TextEditingController noOfExistingLoansController = TextEditingController();
  final TextEditingController addLeadwhatsappController = TextEditingController();
  var fromWhere="".obs;
  var isSameAsPhone = false.obs;
  var getLeadDetailModel = Rxn<GetLeadDetailModel>();
  var individualLeadUploadModel = Rxn<IndividualLeadUploadModel>();
  var getLeadId = Rxn<String>();
  var createdByWhichEmployee = Rxn<String>();

  var selectedProductCategory = Rxn<int>();

  var addIncomeList = <AddIncomeModelController>[].obs;
  var isLoadingProductSegment = false.obs;
  var selectedProdSegment = Rxn<int>();
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

  void toggleConnectorCheckbox(bool? value) {
    isConnectorChecked.value = value ?? false;
  }

  void selectCheckboxRelBank(int index) {

    selectedIndexRelBank.value = index;
  }
  void selectCheckboxExistingLoan(int index) {

    selectedIndexExistingLoan.value = index;
  }

  Future<void>  getLeadDetailByIdApi({
    required String leadId,
  }) async {
    try {
      print("getLeadDetailByIdApi===>");
      isLoading(true);


      var data = await DrawerApiService.getLeadDetailByIdApi(
        leadId:leadId,
      );


      if(data['success'] == true){

        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);

        LeadDDController leadDDController=Get.put(LeadDDController());
        CamNoteController camNoteController=Get.put(CamNoteController());
        LeadListController leadListController =Get.put(LeadListController());
        final LoanApplicationController loanApplicationController =Get.put(LoanApplicationController());

        getLeadId.value=getLeadDetailModel.value!.data!.id!.toString();
        camNoteController.getLeadId.value=getLeadDetailModel.value!.data!.id!.toString();
        camNoteController.loanApplicationNumber=getLeadDetailModel.value!.data!.loanApplicationNo?.toString()??"";
        camNoteController.uniqueLeadNUmber=getLeadDetailModel.value!.data!.uniqueLeadNumber?.toString()??"";
        loanApplicationController.ulnController.text=getLeadDetailModel.value!.data!.uniqueLeadNumber?.toString()??"";

        fullNameController.text=getLeadDetailModel.value!.data!.name!.toString();
        camNoteController.camFullNameController.text = getLeadDetailModel.value!.data!.name!.toString();
        loanApplicationController.applFullNameController.text = getLeadDetailModel.value!.data!.name!.toString();

        dobController.text=getLeadDetailModel.value!.data!.dateOfBirth==""?"": Helper.convertFromIso8601(getLeadDetailModel.value!.data!.dateOfBirth) ?? '';
        camNoteController.camDobController.text =getLeadDetailModel.value!.data!.dateOfBirth==""?"": Helper.convertFromIso8601(getLeadDetailModel.value!.data!.dateOfBirth) ?? '';
        loanApplicationController.dobController.text =getLeadDetailModel.value!.data!.dateOfBirth==""?"": Helper.convertFromIso8601(getLeadDetailModel.value!.data!.dateOfBirth) ?? '';

        phoneController.text=getLeadDetailModel.value?.data?.mobileNumber??"";
        camNoteController.camPhoneController.text = getLeadDetailModel.value?.data?.mobileNumber ?? "";
        loanApplicationController.applMobController.text = getLeadDetailModel.value?.data?.mobileNumber ?? "";

        print("here addlead applMobController==${getLeadDetailModel.value?.data?.mobileNumber ?? ""}");
        print("here addlead applMobController==${loanApplicationController.applMobController.text}");

        phoneController.text=getLeadDetailModel.value?.data?.mobileNumber??"";
        camNoteController.camWhatsappController.text = getLeadDetailModel.value?.data?.whatsappNumber ?? "";

        if( camNoteController.camPhoneController.text== camNoteController.camWhatsappController.text){
          camNoteController.isSameAsPhone.value=true;
        }else{
          camNoteController.isSameAsPhone.value=false;
        }


        selectedGender.value=getLeadDetailModel.value?.data?.gender??"";
        camNoteController.selectedGender.value = getLeadDetailModel.value?.data?.gender ?? "";
        loanApplicationController.selectedGender.value = getLeadDetailModel.value?.data?.gender ?? "";

        loanAmtReqController.text=getLeadDetailModel.value?.data?.loanAmountRequested??"";
        camNoteController.camLoanAmtReqController.text = getLeadDetailModel.value?.data?.loanAmountRequested ?? "";

        loanApplicationController.laAppliedController.text = getLeadDetailModel.value?.data?.loanAmountRequested ?? "";

        emailController.text=getLeadDetailModel.value?.data?.email??"";
        camNoteController.camEmailController.text = getLeadDetailModel.value?.data?.email ?? "";
        loanApplicationController.applEmailController.text = getLeadDetailModel.value?.data?.email ?? "";

        aadharController.text=getLeadDetailModel.value?.data?.adharCard??"";
        camNoteController.camAadharController.text = getLeadDetailModel.value?.data?.adharCard ?? "";
        loanApplicationController.aadharController.text =getLeadDetailModel.value?.data?.adharCard ?? "";

        panController.text=getLeadDetailModel.value?.data?.panCard??"";
        camNoteController.camPanController.text = getLeadDetailModel.value?.data?.panCard ?? "";

        streetAddController.text=getLeadDetailModel.value?.data?.streetAddress??"";
        camNoteController.camStreetAddController.text = getLeadDetailModel.value?.data?.streetAddress ?? "";

        await leadDDController.getAllStateApi();

        leadDDController.selectedState.value=getLeadDetailModel.value!.data!.state!.toString();
        camNoteController.camSelectedState.value = getLeadDetailModel.value!.data!.state!.toString();
        leadListController.lehSelectedState.value = getLeadDetailModel.value!.data!.state!.toString(); ///new

        leadDDController.getDistrictByStateIdApi(stateId: camNoteController.camSelectedState.value);
        leadDDController.getDistrictByStateIdApi(stateId: leadDDController.selectedState.value);
        leadDDController.getDistrictByStateIdApi(stateId: leadListController.lehSelectedState.value); ///new

        leadDDController.selectedDistrict.value=getLeadDetailModel.value!.data!.district!.toString();
        camNoteController.camSelectedDistrict.value = getLeadDetailModel.value!.data!.district!.toString();
        leadListController.lehSelectedDistrict.value = getLeadDetailModel.value!.data!.district!.toString(); ///new

        leadDDController.getCityByDistrictIdApi(districtId: camNoteController.camSelectedDistrict.value);
        leadDDController.getCityByDistrictIdApi(districtId: leadDDController.selectedDistrict.value);
        leadDDController.getCityByDistrictIdApi(districtId: leadListController.lehSelectedDistrict.value); ///new

        leadDDController.selectedCity.value=getLeadDetailModel.value!.data!.city!.toString();
        camNoteController.camSelectedCity.value = getLeadDetailModel.value!.data!.city!.toString();
        leadListController.lehSelectedCity.value = getLeadDetailModel.value!.data!.city!.toString(); ///new

        zipController.text=getLeadDetailModel.value?.data?.pincode??"";
        camNoteController.camZipController.text = (getLeadDetailModel.value?.data?.pincode=="undefined" ||  getLeadDetailModel.value?.data?.pincode=="Undefined") ?"": getLeadDetailModel.value?.data?.pincode?? "";
        leadListController.lehZipController.text = (getLeadDetailModel.value?.data?.pincode=="undefined" ||  getLeadDetailModel.value?.data?.pincode=="Undefined") ?"": getLeadDetailModel.value?.data?.pincode?? "";///new

        nationalityController.text=getLeadDetailModel.value?.data?.nationality??"";
        camNoteController.camNationalityController.text = getLeadDetailModel.value?.data?.nationality ?? "";

        leadDDController.currEmpStatus.value=getLeadDetailModel.value?.data?.currentEmploymentStatus??"";
        camNoteController.camCurrEmpStatus.value = getLeadDetailModel.value?.data?.currentEmploymentStatus ?? "";
        loanApplicationController.emplStatusController.text = getLeadDetailModel.value?.data?.currentEmploymentStatus ?? "";

        employerNameController.text=getLeadDetailModel.value?.data?.employerName??"";
        camNoteController.camEmployerNameController.text = getLeadDetailModel.value?.data?.employerName ?? "";

        monthlyIncomeController.text=getLeadDetailModel.value?.data?.monthlyIncome??"";
        camNoteController.camMonthlyIncomeController.text = getLeadDetailModel.value?.data?.monthlyIncome ?? "";

        addSourceIncomeController.text="";

        await leadDDController.getAllBankApi();
        leadDDController.selectedBank.value=getLeadDetailModel.value?.data?.prefferedBank??"";
        camNoteController.camSelectedBank.value = getLeadDetailModel.value?.data?.prefferedBank ?? "";

        branchLocController.text=getLeadDetailModel.value?.data?.branch??"";
        camNoteController.camBranchLocController.text = getLeadDetailModel.value?.data?.branch ?? "";


        await leadDDController.getAllKsdplProductApi();

        leadDDController.selectedProdType.value=getLeadDetailModel.value?.data?.productType??"";
        camNoteController.camSelectedProdType.value=getLeadDetailModel.value?.data?.productType??"";

        AddProductController addProductController = Get.put(AddProductController()); //change on 31 july
        await addProductController.getAllProductCategoryApi();
        camNoteController.camSelectedProdSegment.value=int.parse(getLeadDetailModel.value?.data?.leadsegment.toString()??"0")??0;
        camNoteController.camSelectedProdSegment.value==1?camNoteController.isOfferedSecurityMandatory.value=true:camNoteController.isOfferedSecurityMandatory.value=false;


        if(camNoteController.camSelectedProdSegment.value==1){
          camNoteController.isRequiredVisibleSecure.value=true;
        }else{
          camNoteController.isRequiredVisibleSecure.value=false;
        }

        camNoteController.camSelectedIndexRelBank.value=getLeadDetailModel.value?.data?.existinRelaationshipWithBank==""?-1:getLeadDetailModel.value?.data?.existinRelaationshipWithBank=="Yes"?0:1;
        connNameController.text=getLeadDetailModel.value?.data?.connectorName??"";

        connMobController.text=getLeadDetailModel.value?.data?.connectorMobileNo??"";

        connShareController.text=getLeadDetailModel.value?.data?.connectorPercentage.toString()??"";

        createdByWhichEmployee.value=getLeadDetailModel.value?.data?.assignedEmployeeId.toString()??"";


        await camNoteController.getAllPackageMasterApi();
        camNoteController.selectedPackage.value=getLeadDetailModel.value?.data?.packageId??0;

        if(camNoteController.selectedPackage.value!=null){
          camNoteController.getPackageDetailsByIdApi(packageId: camNoteController.selectedPackage.toString());
        }


        camNoteController.camPackageAmtController.text=getLeadDetailModel.value?.data?.packageAmount.toString()??"0";

        camNoteController.camReceivableDateController.text=getLeadDetailModel.value!.data!.receiveableDate==""?"": Helper.convertFromIso8601(getLeadDetailModel.value!.data!.receiveableDate) ?? '';

        camNoteController.camReceivableAmtController.text=getLeadDetailModel.value?.data?.receiveableAmount.toString()??"0";
        camNoteController.camTransactionDetailsController.text=getLeadDetailModel.value?.data?.transactionDetails.toString()??"0";
        camNoteController.camRemarkController.text=getLeadDetailModel.value?.data?.remark.toString()??"0";

        camNoteController.getAddIncUniqueLeadApi(uniqueLeadNumber:getLeadDetailModel.value!.data!.uniqueLeadNumber?.toString()??"0");

        print("checkReceiptStatusForCamNoteApi before--->");

         /*camNoteController.checkReceiptStatusForCamNoteApi(
            Mobile: getLeadDetailModel.value?.data?.transactionDetails.toString()??"0",
            Utr: getLeadDetailModel.value?.data?.mobileNumber ?? ""
        );*/

        final geoLocationProp = getLeadDetailModel.value!.data!.geoLocationOfProperty;


        var rawRole = StorageService.get(StorageService.ROLE).toString();
        var role = rawRole.replaceAll('[', '').replaceAll(']', '');

        if(role=="INDEPENDENT AREA HEAD"){
          camNoteController.isUserAIC.value=true;
        }
        else{
          camNoteController.isUserAIC.value=false;
        }


        if (geoLocationProp != null && geoLocationProp.contains('-')) {
          final parts = geoLocationProp.split('-');
          if (parts.length == 2) {
            camNoteController.camGeoLocationPropertyLatController.text = parts[0]; // 23.1802024
            camNoteController.camGeoLocationPropertyLongController.text = parts[1]; // 75.7926982
            if(camNoteController.camGeoLocationPropertyLatController.text.isNotEmpty){
              camNoteController.geoLocPropLatEnabled.value=false;
            }else{
              camNoteController.geoLocPropLatEnabled.value=true;
            }
            if( camNoteController.camGeoLocationPropertyLongController.text.isNotEmpty){
              camNoteController.geoLocPropLongEnabled.value=false;
            }else{
              camNoteController.geoLocPropLatEnabled.value=true;
            }

          }
        }else {
          if (camNoteController.camGeoLocationPropertyLatController.text
              .isEmpty ) {
            camNoteController.geoLocPropLatEnabled.value = true;
          }
          if (camNoteController.camGeoLocationPropertyLongController.text
              .isEmpty) {
            camNoteController.geoLocPropLongEnabled.value = true;
          }
        }


        final geoLocationRes = getLeadDetailModel.value!.data!.geoLocationOfResidence;


        if (geoLocationRes != null && geoLocationRes.contains('-')) {
          final parts = geoLocationRes.split('-');
          if (parts.length == 2) {
            camNoteController.camGeoLocationResidenceLatController.text = parts[0]; // 23.1802024
            camNoteController.camGeoLocationResidenceLongController.text = parts[1]; // 75.7926982

            if(camNoteController.camGeoLocationResidenceLatController.text.isNotEmpty){
              camNoteController.geoLocResLatEnabled.value=false;
            }else{
              camNoteController.geoLocResLatEnabled.value=true;
            }
            if( camNoteController.camGeoLocationResidenceLongController.text.isNotEmpty){
              camNoteController.geoLocResLongEnabled.value=false;
            }else{
              camNoteController.geoLocResLongEnabled.value=true;
            }
          }
        }else{

          if (camNoteController.camGeoLocationResidenceLatController.text
              .isEmpty) {
            camNoteController.geoLocResLatEnabled.value = true;
          }
          if (camNoteController.camGeoLocationResidenceLongController.text
              .isEmpty) {
            camNoteController.geoLocResLongEnabled.value = true;
          }
        }


        final geoLocationOff = getLeadDetailModel.value!.data!.geoLocationOfOffice;


        if (geoLocationOff != null && geoLocationOff.contains('-')) {
          final parts = geoLocationOff.split('-');
          if (parts.length == 2) {
            camNoteController.camGeoLocationOfficeLatController.text = parts[0]; // 23.1802024
            camNoteController.camGeoLocationOfficeLongController.text = parts[1]; // 75.7926982

            if(camNoteController.camGeoLocationOfficeLatController.text.isNotEmpty){
              camNoteController.geoLocOffLatEnabled.value=false;
            }else{
              camNoteController.geoLocOffLatEnabled.value=true;
            }
            if( camNoteController.camGeoLocationOfficeLongController.text.isNotEmpty){
              camNoteController.geoLocOffLongEnabled.value=false;
            }else{
              camNoteController.geoLocOffLongEnabled.value=true;
            }
          }
        }else{

          if (camNoteController.camGeoLocationOfficeLatController.text
              .isEmpty) {
            camNoteController.geoLocOffLatEnabled.value = true;
          }
          if (camNoteController.camGeoLocationOfficeLongController.text
              .isEmpty) {
            camNoteController.geoLocOffLongEnabled.value = true;
          }
        }

        camNoteController.clearImages('property_photo');
        camNoteController.clearImages('residence_photo');
        camNoteController.clearImages('office_photo');


        final photoProp = getLeadDetailModel.value?.data?.photosOfProperty;

        if (photoProp != null && photoProp.isNotEmpty) {
          camNoteController.loadApiImagesForKey('property_photo', photoProp);
          camNoteController.photosPropEnabled.value=false;
        }else{

          camNoteController.photosPropEnabled.value=true;
        }

        final photoRes = getLeadDetailModel.value?.data?.photosOfResidence;
        if (photoRes != null && photoRes.isNotEmpty) {
          camNoteController.loadApiImagesForKey('residence_photo', photoRes);
          camNoteController.photosResEnabled.value=false;
        }else{
          camNoteController.photosResEnabled.value=true;
        }

        final photoOff = getLeadDetailModel.value?.data?.photosOfOffice;
        if (photoOff != null && photoOff.isNotEmpty) {
          camNoteController.loadApiImagesForKey('office_photo', photoOff);
          camNoteController.photosOffEnabled.value=false;
        }else{
          camNoteController.photosOffEnabled.value=true;
        }


        if (getLeadDetailModel.value?.data?.cibilJSON!=null) {
          final result = await parseCibilData(
            cibilJson: getLeadDetailModel.value?.data?.cibilJSON,
            annualInterestRate: 12.0,
            tenureMonths: 12,
          );

          ///6 oct 2025
          camNoteController.camCibilController.text=(result['Cibil']=="NA" || result['Cibil']=="NA")?"0": result['Cibil'].toString();
          camNoteController.camTotalLoanAvailedController.text=result['TotalLoanAvailedOnCibil'].toString();
          camNoteController.camTotalLiveLoanController.text=result['TotalLiveLoan'].toString();
          camNoteController.camTotalEmiController.text= (result['TotalEMI'] ?? 0).toDouble().toStringAsFixed(2);
          camNoteController.camEmiWillContinueController.text=result['EMIWillContinue'].toString();
          camNoteController.camTotalOverdueCasesController.text=result['TotalOverdueCasesAsPerCibil'].toString();
          camNoteController.camTotalOverdueAmountController.text=result['TotalOverdueAmountAsPerCibil'].toString();
          camNoteController.camTotalEnquiriesController.text=result['TotalEnquiriesMadeAsPerCibil'].toString();

          ///
          camNoteController.camClosedCasesController.text=result['ClosedCases'].toString();
          camNoteController.camWrittenOffCasesController.text=result['WrittenOffCases'].toString();
          camNoteController.camSettlementCasesController.text=result['SettlementCases'].toString();
          camNoteController.camSuitFiledWillfulDefaultCasesController.text=result['SuitFiledWillfulDefaultCases'].toString();
          camNoteController.camTotalSanctionedAmountController.text=result['TotalSanctionedAmount'].toString();
          camNoteController.camCurrentBalanceController.text=result['CurrentBalance'].toString();
          camNoteController.camClosedAmountController.text=result['ClosedAmount'].toString();
          camNoteController.camWrittenOffAmountController.text=result['WrittenOffAmount'].toString();
          camNoteController.camSettlementAmountController.text=result['SettlementAmount'].toString();
          camNoteController.camSuitFiledWillfulDefaultAmountController.text=result['SuitFiledWillfulDefaultAmount'].toString();
          camNoteController.camStandardCountController.text=result['StandardCount'].toString();
          camNoteController.camNumberOfDaysPastDueCountController.text=result['SettlementCases'].toString();
          camNoteController.camLossCountController.text=result['LossCount'].toString();
          camNoteController.camSubstandardCountController.text=result['SubstandardCount'].toString();
          camNoteController.camDoubtfulCountController.text=result['DoubtfulCount'].toString();
          camNoteController.camSpecialMentionAccountCountController.text=result['SpecialMentionAccountCount'].toString();
          camNoteController.camNptController.text=result['Npt'].toString();
          camNoteController.camTotalCountsController.text=result['TotalCounts'].toString();
          camNoteController.camCurrentlyCasesBeingServedController.text=result['CurrentlyCasesBeingServed'].toString();
          camNoteController.camCasesToBeForeclosedOnOrBeforeDisbController.text=result['CasesToBeForeclosedOnOrBeforeDisb'].toString();
          camNoteController.camCasesToBeContenuedController.text=result['CasesToBeContenued'].toString();
          camNoteController.camEmisOfExistingLiabilitiesController.text=result['EmisOfExistingLiabilities'].toString();
          camNoteController.camIirController.text=result['Iir'].toString();

          print("Iir======>${result['Iir'].toString()}");
          print("Iir======>${camNoteController.camIirController.text}");


          camNoteController.enableAllCibilFields.value=false;




        }

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("exception--->${e}");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }
  double calculateEMI(double principal, double annualInterestRate, int months) {
    double monthlyInterest = annualInterestRate / 12 / 100;
    return (principal * monthlyInterest * pow(1 + monthlyInterest, months)) /
        (pow(1 + monthlyInterest, months) - 1);
  }

/*
  Future<Map<String, dynamic>> parseCibilData({
    required String? cibilJson,
    required double annualInterestRate,
    required int tenureMonths,
  }) async {
    if (cibilJson == null) return {};

    final parsedData = json.decode(cibilJson);
    final cibilData = parsedData['data'];
    final addressList = cibilData?['credit_report']?['CCRResponse']?['CIRReportDataLst']?[0]?['CIRReportData']?['RetailAccountDetails'];

    if (addressList == null || addressList is! List) return {};

    final accounts = addressList.map<CibilAccount>((e) => CibilAccount.fromJson(e)).toList();

    double totalLoanAvailed = 0;
    int totalLiveLoan = 0;
    double totalEMI = 0;
    int emiWillContinue = 0;
    int overdueCases = 0;
    double totalOverdueAmount = 0;

    for (var account in accounts) {
      final amount = double.tryParse(account.sanctionAmount ?? '0') ?? 0;
      totalLoanAvailed += amount;

      if (account.open == "Yes") {
        totalLiveLoan += 1;

        if (account.sanctionAmount != null) {
          totalEMI += calculateEMI(amount, annualInterestRate, tenureMonths);
        }

        if (account.dateClosed == null) {
          emiWillContinue += 1;
        }
      }

      final overdueAmount = double.tryParse(account.pastDueAmount ?? '0') ?? 0;
      if (overdueAmount > 0) {
        totalOverdueAmount += overdueAmount;
        overdueCases += 1;
      } else if (account.history48Months != null) {
        bool hasOverdueHistory = account.history48Months!.any((entry) =>
            ['30+', '60+', '90+', '120+', 'SUB', 'SPM']
                .contains(entry.paymentStatus));
        if (hasOverdueHistory) overdueCases += 1;
      }
    }

    return {
      'Cibil': cibilData?['credit_score'] ?? '0',
      'TotalLoanAvailedOnCibil': totalLoanAvailed,
      'TotalLiveLoan': totalLiveLoan,
      'TotalEMI': totalEMI,
      'EMIWillContinue': emiWillContinue,
      'TotalOverdueCasesAsPerCibil': overdueCases,
      'TotalOverdueAmountAsPerCibil': totalOverdueAmount,
      'TotalEnquiriesMadeAsPerCibil':
      cibilData?['credit_report']?['CCRResponse']?['CIRReportDataLst']?.length ?? 0,
    };
  }
*/

  Future<Map<String, dynamic>> parseCibilData({
    required String? cibilJson,
    required double annualInterestRate,
    required int tenureMonths,
  }) async {
    if (cibilJson == null) return {};

    final parsedData = json.decode(cibilJson);
    final cibilData = parsedData['data'];
    final addressList = cibilData?['credit_report']?['CCRResponse']?['CIRReportDataLst']?[0]?['CIRReportData']?['RetailAccountDetails'];

    if (addressList == null || addressList is! List) return {};

    final accounts = addressList.map<CibilAccount>((e) => CibilAccount.fromJson(e)).toList();

    double totalLoanAvailed = 0;
    int totalLiveLoan = 0;
    double totalEMI = 0;
    int emiWillContinue = 0;
    int overdueCases = 0;
    double totalOverdueAmount = 0;

    // New fields added 👇
    int closedCases = 0;
    int writtenOffCases = 0;
    int settlementCases = 0;
    int suitFiledWillfulDefaultCases = 0;
    double totalSanctionedAmount = 0;
    double currentBalance = 0;
    double closedAmount = 0;
    double writtenOffAmount = 0;
    double settlementAmount = 0;
    double suitFiledWillfulDefaultAmount = 0;
    int standardCount = 0;
    int substandardCount = 0;
    int doubtfulCount = 0;
    int lossCount = 0;
    int specialMentionAccountCount = 0;

    for (var account in accounts) {
      final sanctionAmount = double.tryParse(account.sanctionAmount ?? '0') ?? 0;
      final balance = double.tryParse(account.balance ?? '0') ?? 0;
      final overdueAmount = double.tryParse(account.pastDueAmount ?? '0') ?? 0;

      totalLoanAvailed += sanctionAmount;
      totalSanctionedAmount += sanctionAmount;
      currentBalance += balance;

      if (account.open == "Yes") {
        totalLiveLoan += 1;
        if (account.sanctionAmount != null) {
          totalEMI += calculateEMI(sanctionAmount, annualInterestRate, tenureMonths);
        }
        if (account.dateClosed == null) {
          emiWillContinue += 1;
        }
      }

      // Overdue calculation
      if (overdueAmount > 0) {
        totalOverdueAmount += overdueAmount;
        overdueCases += 1;
      } else if (account.history48Months != null) {
        bool hasOverdueHistory = account.history48Months!.any((entry) =>
            ['30+', '60+', '90+', '120+', 'SUB', 'SPM'].contains(entry.paymentStatus));
        if (hasOverdueHistory) overdueCases += 1;
      }

      // Account status checks
      final status = account.accountStatus?.toLowerCase() ?? '';

      if (status.contains("closed")) {
        closedCases++;
        closedAmount += sanctionAmount;
      }
      if (status.contains("write-off")) {
        writtenOffCases++;
        writtenOffAmount += sanctionAmount;
      }
      if (status.contains("settlement")) {
        settlementCases++;
        settlementAmount += sanctionAmount;
      }
      if (status.contains("suit filed") || status.contains("willful default")) {
        suitFiledWillfulDefaultCases++;
        suitFiledWillfulDefaultAmount += sanctionAmount;
      }

      // Asset classification
      switch (account.assetClassification) {
        case "STD":
          standardCount++;
          break;
        case "SUB":
          substandardCount++;
          break;
        case "DBT":
          doubtfulCount++;
          break;
        case "LOSS":
          lossCount++;
          break;
        case "SMA":
          specialMentionAccountCount++;
          break;
      }
    }

    return {
      'Cibil': cibilData?['credit_score'] ?? '0',
      'TotalLoanAvailedOnCibil': totalLoanAvailed,
      'TotalLiveLoan': totalLiveLoan,
      'TotalEMI': totalEMI,
      'EMIWillContinue': emiWillContinue,
      'TotalOverdueCasesAsPerCibil': overdueCases,
      'TotalOverdueAmountAsPerCibil': totalOverdueAmount,
      'TotalEnquiriesMadeAsPerCibil':
      cibilData?['credit_report']?['CCRResponse']?['CIRReportDataLst']?.length ?? 0,

      // 🆕 Newly added stats
      'ClosedCases': closedCases,
      'WrittenOffCases': writtenOffCases,
      'SettlementCases': settlementCases,
      'SuitFiledWillfulDefaultCases': suitFiledWillfulDefaultCases,
      'TotalSanctionedAmount': totalSanctionedAmount,
      'CurrentBalance': currentBalance,
      'ClosedAmount': closedAmount,
      'WrittenOffAmount': writtenOffAmount,
      'SettlementAmount': settlementAmount,
      'SuitFiledWillfulDefaultAmount': suitFiledWillfulDefaultAmount,
      'StandardCount': standardCount,
      'SubstandardCount': substandardCount,
      'DoubtfulCount': doubtfulCount,
      'LossCount': lossCount,
      'SpecialMentionAccountCount': specialMentionAccountCount,

      'Npt': "0",
      'TotalCounts': "0",
      'CurrentlyCasesBeingServed': "0",
      'CasesToBeForeclosedOnOrBeforeDisb': "0",
      'CasesToBeContenued': "0",
      'EmisOfExistingLiabilities': "0",
      'Iir': "0",
    };
  }



  Future<void>fillLeadFormApi({
   required String id,
   required String dob,
   required String gender,
   required String loanAmtReq,
   required String WhatsappNumber,
   String? email,
   String? aadhar,
   String? pan,
   String? streetAdd,
   String? state,
   String? district,
   String? city,
   String? zip,
   String? nationality,
   String? currEmpSt,
   String? employerName,
   String? monthlyIncome,
   String? addSrcIncome,
   String? prefBank,
   String? exRelBank,
   String? branchLoc,
   String? prodTypeInt,
   String? connName,
   String? connMob,
   String? connShare,
   String? loanApplNo,

   String? name,
   String? mobileNumber,
   String? packageId,
   String? packageAmount,
   String? receivableAmount,
   String? receivableDate,
   String? transactionDetails,
   String? remark,
   String? leadSegment,

    String? GeoLocationOfResidence,
    String? GeoLocationOfOffice,
    String? GeoLocationOfProperty,
    List<File>? PhotosOfProperty,
    List<File>? PhotosOfResidence,
    List<File>? PhotosOfOffice,
    String? fromWhere,
  }) async {
   CamNoteController camNoteController=Get.find();
    try {
      isLoading(true);
      camNoteController.isAllCamnoteSubmit(true);

      var data = await LeadApiService.fillLeadFormApi(
        id: id,
        dob: dob,
        gender: gender,
        loanAmtReq: loanAmtReq,
        email: email,
        aadhar: aadhar,
        pan: pan,
        streetAdd: streetAdd,
        state: state,
        district: district,
        city: city,
        zip: zip,
        nationality: nationality,
        currEmpSt: currEmpSt,
        employerName: employerName,
        monthlyIncome: monthlyIncome,
        addSrcIncome: addSrcIncome,
        prefBank: prefBank,
        exRelBank: exRelBank,
        branchLoc: branchLoc,
        prodTypeInt: prodTypeInt,
        connName: connName,
        connMob: connMob,
        connShare: connShare,
        loanApplNo: loanApplNo,

        name:name,
        mobileNumber:mobileNumber,
        packageId:packageId,
        packageAmount:packageAmount,
        receivableAmount:receivableAmount,
        receivableDate:receivableDate,
        transactionDetails:transactionDetails,
        remark:remark,
        leadSegment:leadSegment,


        GeoLocationOfProperty: GeoLocationOfProperty,
        GeoLocationOfResidence: GeoLocationOfResidence,
        GeoLocationOfOffice: GeoLocationOfOffice,
        PhotosOfProperty: PhotosOfProperty,
        PhotosOfResidence: PhotosOfResidence,
        PhotosOfOffice: PhotosOfOffice,
        WhatsappNumber: WhatsappNumber,
      );


      if(data['success'] == true){

        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);
        ToastMessage.msg( getLeadDetailModel.value!.message!.toString());

    /*    if(fromWhere=="camnote"){
          camNoteController.addCustomerDetailsApi(
            Id:"0",
            CustomerName:name,
            MobileNumber:mobileNumber,
            Email:email,
            Gender:gender,
            AdharCard:aadhar,
            PanCard:pan,
            StreetAddress:streetAdd,
            State:state,
            District:district,
            City:city,
            Nationality:nationality,

          );
        }*/

        if(fromWhere!="camnote"){
          clearControllers();
        }

        isLoading(false);
        camNoteController.isAllCamnoteSubmit(false);
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {  print("Error getLeadDetailByIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
      camNoteController.isAllCamnoteSubmit(false);
    } finally {

      isLoading(false);
      camNoteController.isAllCamnoteSubmit(false);
    }
  }





  void clearControllers(){
    print("clearControllers=====>");
    LeadDDController leadDDController=Get.find();
    fullNameController.clear();
    dobController.clear();
    phoneController.clear();
    genderController.clear();
    loanAmtReqController.clear();
    emailController.clear();
    aadharController.clear();
    panController.clear();
    streetAddController.clear();
    zipController.clear();
    nationalityController.clear();
    currEmpStController.clear();
    employerNameController.clear();
    monthlyIncomeController.clear();
    addSourceIncomeController.clear();
    branchLocController.clear();
    productTypeController.clear();
    connNameController.clear();
    connMobController.clear();
    connShareController.clear();
    existingLoansController.clear();
    noOfExistingLoansController.clear();
    selectedGender.value="";

    ///=====
    isLoading.value = false;
    isConnectorChecked.value = false;
    selectedGender.value = null;
    selectedIndexRelBank.value = -1;
    //fromWhere.value = "";
    getLeadId.value = null;
    createdByWhichEmployee.value = null;
    selectedProductCategory.value = null;

    // Rx Models
    getLeadDetailModel.value = null;
    individualLeadUploadModel.value = null;
    selectedProductCategory.value = null;
    // TextEditingControllers
    fullNameController.clear();
    dobController.clear();
    phoneController.clear();
    genderController.clear();
    loanAmtReqController.clear();
    emailController.clear();
    aadharController.clear();
    panController.clear();
    streetAddController.clear();
    zipController.clear();
    nationalityController.clear();
    currEmpStController.clear();
    employerNameController.clear();
    monthlyIncomeController.clear();
    addSourceIncomeController.clear();
    branchLocController.clear();
    productTypeController.clear();
    connNameController.clear();
    connMobController.clear();
    connShareController.clear();
    existingLoansController.clear();
    noOfExistingLoansController.clear();
    addIncomeList.clear();
    leadDDController.selectedState.value=null;
    leadDDController.selectedDistrict.value=null;
    leadDDController.selectedCity.value=null;
    leadDDController.currEmpStatus.value=null;
    leadDDController.selectedBank.value=null;
    leadDDController.selectedProdType.value=null;
    selectedIndexRelBank.value=-1;
    selectedIndexExistingLoan.value=-1;
    selectedProdSegment.value=null;
  }




  Future<void>individualLeadUploadApi({

    required String name,
    required String mobileNo,
    required String createdBy,

    String? gender,
    String? dob,
    String? loanAmtReq,
    String? email,
    String? aadhar,
    String? pan,
    String? streetAdd,
    String state = "0",
    String district = "0",
    String city = "0",
    String? zip,
    String? nationality,
    String currEmpSt = "0",
    String? employerName,
    String? monthlyIncome,
    String? addSrcIncome,
    String prefBank = "0",
    String? exRelBank,
    String? branchLoc,
    String prodTypeInt = "0",
    String? connName,
    String? connMob,
    String? connShare,
    String? existingLoans,
    String? noOfExistingLoans,
    String? uniqueLeadNumber,
    String leadSegment = "0",
    List<AddIncomeModelController>? addIncomeListTemp
  }) async {
    try {
      isLoading(true);



      var data = await LeadApiService.individualLeadUploadApi(
          name: name,
          mobileNo: mobileNo,
          createdBy: createdBy,
          gender: gender,
          dob: dob,
          loanAmtReq: loanAmtReq,
          email: email,
          aadhar: aadhar,
          pan: pan,
          streetAdd: streetAdd,
          state: state,
          district: district,
          city: city,
          zip: zip,
          nationality: nationality,
          currEmpSt: currEmpSt,
          employerName: employerName,
          monthlyIncome: monthlyIncome,
          addSrcIncome: addSrcIncome,
          prefBank: prefBank,
          exRelBank: exRelBank,
          branchLoc: branchLoc,
          prodTypeInt: prodTypeInt,
          connName: connName,
          connMob: connMob,
          connShare: connShare,
          existingLoans: existingLoans,
          noOfExistingLoans: noOfExistingLoans,
        uniqueLeadNumber: uniqueLeadNumber,
        leadSegment: leadSegment

      );


      if(data['success'] == true){



        individualLeadUploadModel.value= IndividualLeadUploadModel.fromJson(data);

        ToastMessage.msg( individualLeadUploadModel.value!.message!.toString());

        var uln=individualLeadUploadModel.value!.data!.uniqueLeadNumber.toString();


        final List<IncomeModel> addIncomeSrcModels = [];

        for (var ai in addIncomeList) {
          final aiModel = IncomeModel(
            uniqueLeadNumber: uln,
            description: cleanText(ai.aiSourceController.text),
            amount: ai.aiIncomeController.text.toDoubleOrZero(),
          );

          addIncomeSrcModels.add(aiModel);
        }

        List<Map<String, dynamic>> aiPayload = addIncomeSrcModels.map((e) => e.toMap()).toList();
        CamNoteController camNoteController=Get.find();

        if(aiPayload.isNotEmpty){
          await camNoteController.addAdditionalSourceIncomeApi(aiPayload:aiPayload);
        }



        clearControllers();
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



  @override
  void onClose() {
    super.onClose();
    if (Get.isRegistered<CamNoteController>()) {
      Get.delete<CamNoteController>(); // This triggers onClose() in CamNoteController
    }
    // RxBools and Strings
    isLoading.value = false;
    isConnectorChecked.value = false;
    selectedGender.value = null;
    selectedIndexRelBank.value = -1;
    fromWhere.value = "";
    getLeadId.value = null;
    createdByWhichEmployee.value = null;
    selectedProductCategory.value = null;

    // Rx Models
    getLeadDetailModel.value = null;
    individualLeadUploadModel.value = null;
    selectedProductCategory.value = null;
    // TextEditingControllers
    fullNameController.clear();
    dobController.clear();
    phoneController.clear();
    genderController.clear();
    loanAmtReqController.clear();
    emailController.clear();
    aadharController.clear();
    panController.clear();
    streetAddController.clear();
    zipController.clear();
    nationalityController.clear();
    currEmpStController.clear();
    employerNameController.clear();
    monthlyIncomeController.clear();
    addSourceIncomeController.clear();
    branchLocController.clear();
    productTypeController.clear();
    connNameController.clear();
    connMobController.clear();
    connShareController.clear();
    existingLoansController.clear();
   // noOfExistingLoansController.clear();

    // Dispose controllers to prevent memory leaks
    fullNameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    genderController.dispose();
    loanAmtReqController.dispose();
    emailController.dispose();
    aadharController.dispose();
    panController.dispose();
    streetAddController.dispose();
    zipController.dispose();
    nationalityController.dispose();
    currEmpStController.dispose();
    employerNameController.dispose();
    monthlyIncomeController.dispose();
    addSourceIncomeController.dispose();
    branchLocController.dispose();
    productTypeController.dispose();
    connNameController.dispose();
    connMobController.dispose();
    connShareController.dispose();
    existingLoansController.dispose();
  //  noOfExistingLoansController.dispose();
    addIncomeList.clear();


  }


}
/*

class CibilAccount {
  final String? open;
  final String? sanctionAmount;
  final String? dateClosed;
  final String? pastDueAmount;
  final List<HistoryEntry>? history48Months;

  CibilAccount({
    this.open,
    this.sanctionAmount,
    this.dateClosed,
    this.pastDueAmount,
    this.history48Months,
  });

  factory CibilAccount.fromJson(Map<String, dynamic> json) {
    return CibilAccount(
      open: json['Open'],
      sanctionAmount: json['SanctionAmount'],
      dateClosed: json['DateClosed'],
      pastDueAmount: json['PastDueAmount'],
      history48Months: (json['History48Months'] as List?)
          ?.map((e) => HistoryEntry.fromJson(e))
          .toList(),
    );
  }
}

class HistoryEntry {
  final String? paymentStatus;

  HistoryEntry({this.paymentStatus});

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(paymentStatus: json['PaymentStatus']);
  }
}
*/

class CibilAccount {
  final String? seq;
  final String? accountNumber;
  final String? institution;
  final String? accountType;
  final String? ownershipType;
  final String? balance;
  final String? pastDueAmount;
  final String? open;
  final String? sanctionAmount;
  final String? lastPaymentDate;
  final String? dateReported;
  final String? dateOpened;
  final String? dateClosed;
  final String? reason;
  final String? termFrequency;
  final String? accountStatus;
  final String? assetClassification;
  final String? source;
  final List<HistoryEntry>? history48Months;

  CibilAccount({
    this.seq,
    this.accountNumber,
    this.institution,
    this.accountType,
    this.ownershipType,
    this.balance,
    this.pastDueAmount,
    this.open,
    this.sanctionAmount,
    this.lastPaymentDate,
    this.dateReported,
    this.dateOpened,
    this.dateClosed,
    this.reason,
    this.termFrequency,
    this.accountStatus,
    this.assetClassification,
    this.source,
    this.history48Months,
  });

  factory CibilAccount.fromJson(Map<String, dynamic> json) {
    return CibilAccount(
      seq: json['seq'],
      accountNumber: json['AccountNumber'],
      institution: json['Institution'],
      accountType: json['AccountType'],
      ownershipType: json['OwnershipType'],
      balance: json['Balance'],
      pastDueAmount: json['PastDueAmount'],
      open: json['Open'],
      sanctionAmount: json['SanctionAmount'],
      lastPaymentDate: json['LastPaymentDate'],
      dateReported: json['DateReported'],
      dateOpened: json['DateOpened'],
      dateClosed: json['DateClosed'],
      reason: json['Reason'],
      termFrequency: json['TermFrequency'],
      accountStatus: json['AccountStatus'],
      assetClassification: json['AssetClassification'],
      source: json['source'],
      history48Months: (json['History48Months'] as List?)
          ?.map((e) => HistoryEntry.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seq': seq,
      'AccountNumber': accountNumber,
      'Institution': institution,
      'AccountType': accountType,
      'OwnershipType': ownershipType,
      'Balance': balance,
      'PastDueAmount': pastDueAmount,
      'Open': open,
      'SanctionAmount': sanctionAmount,
      'LastPaymentDate': lastPaymentDate,
      'DateReported': dateReported,
      'DateOpened': dateOpened,
      'DateClosed': dateClosed,
      'Reason': reason,
      'TermFrequency': termFrequency,
      'AccountStatus': accountStatus,
      'AssetClassification': assetClassification,
      'source': source,
      'History48Months': history48Months?.map((e) => e.toJson()).toList(),
    };
  }
}
class HistoryEntry {
  final String? key;
  final String? paymentStatus;

  HistoryEntry({this.key, this.paymentStatus});

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      key: json['Key'],
      paymentStatus: json['PaymentStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Key': key,
      'PaymentStatus': paymentStatus,
    };
  }
}
