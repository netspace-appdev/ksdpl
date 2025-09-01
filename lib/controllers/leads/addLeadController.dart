import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/IndividualLeadUploadModel.dart';
import '../../models/camnote/special_model/IncomeModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/leads/special_model/AddIncModel.dart';
import '../../services/drawer_api_service.dart';
import '../../services/lead_api_service.dart';
import '../product/add_product_controller.dart';
import '../registration_dd_controller.dart';
import 'add_income_model_controller.dart';

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

  var fromWhere="".obs;

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
      isLoading(true);


      var data = await DrawerApiService.getLeadDetailByIdApi(
        leadId:leadId,
      );


      if(data['success'] == true){

        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);
       // print("camnotecount in API====>${getLeadDetailModel.value!.data!.camNoteCount!.toString()}");

        LeadDDController leadDDController=Get.put(LeadDDController());
        CamNoteController camNoteController=Get.put(CamNoteController());

        getLeadId.value=getLeadDetailModel.value!.data!.id!.toString();
        camNoteController.getLeadId.value=getLeadDetailModel.value!.data!.id!.toString();
        camNoteController.loanApplicationNumber=getLeadDetailModel.value!.data!.loanApplicationNo?.toString()??"";
        camNoteController.uniqueLeadNUmber=getLeadDetailModel.value!.data!.uniqueLeadNumber?.toString()??"";

        fullNameController.text=getLeadDetailModel.value!.data!.name!.toString();
        camNoteController.camFullNameController.text = getLeadDetailModel.value!.data!.name!.toString();

        dobController.text=getLeadDetailModel.value!.data!.dateOfBirth==""?"": Helper.convertFromIso8601(getLeadDetailModel.value!.data!.dateOfBirth) ?? '';
        camNoteController.camDobController.text =getLeadDetailModel.value!.data!.dateOfBirth==""?"": Helper.convertFromIso8601(getLeadDetailModel.value!.data!.dateOfBirth) ?? '';

        phoneController.text=getLeadDetailModel.value?.data?.mobileNumber??"";
        camNoteController.camPhoneController.text = getLeadDetailModel.value?.data?.mobileNumber ?? "";



        selectedGender.value=getLeadDetailModel.value?.data?.gender??"";
        camNoteController.selectedGender.value = getLeadDetailModel.value?.data?.gender ?? "";

        loanAmtReqController.text=getLeadDetailModel.value?.data?.loanAmountRequested??"";
        camNoteController.camLoanAmtReqController.text = getLeadDetailModel.value?.data?.loanAmountRequested ?? "";


        emailController.text=getLeadDetailModel.value?.data?.email??"";
        camNoteController.camEmailController.text = getLeadDetailModel.value?.data?.email ?? "";

        aadharController.text=getLeadDetailModel.value?.data?.adharCard??"";
        camNoteController.camAadharController.text = getLeadDetailModel.value?.data?.adharCard ?? "";

        panController.text=getLeadDetailModel.value?.data?.panCard??"";
        camNoteController.camPanController.text = getLeadDetailModel.value?.data?.panCard ?? "";

        streetAddController.text=getLeadDetailModel.value?.data?.streetAddress??"";
        camNoteController.camStreetAddController.text = getLeadDetailModel.value?.data?.streetAddress ?? "";

        await leadDDController.getAllStateApi();

        leadDDController.selectedState.value=getLeadDetailModel.value!.data!.state!.toString();
        camNoteController.camSelectedState.value = getLeadDetailModel.value!.data!.state!.toString();

        leadDDController.getDistrictByStateIdApi(stateId: camNoteController.camSelectedState.value);
        leadDDController.getDistrictByStateIdApi(stateId: leadDDController.selectedState.value);

        leadDDController.selectedDistrict.value=getLeadDetailModel.value!.data!.district!.toString();
        camNoteController.camSelectedDistrict.value = getLeadDetailModel.value!.data!.district!.toString();

        leadDDController.getCityByDistrictIdApi(districtId: camNoteController.camSelectedDistrict.value);
        leadDDController.getCityByDistrictIdApi(districtId: leadDDController.selectedDistrict.value);

        leadDDController.selectedCity.value=getLeadDetailModel.value!.data!.city!.toString();
        camNoteController.camSelectedCity.value = getLeadDetailModel.value!.data!.city!.toString();

        zipController.text=getLeadDetailModel.value?.data?.pincode??"";
        camNoteController.camZipController.text = getLeadDetailModel.value?.data?.pincode ?? "";

        nationalityController.text=getLeadDetailModel.value?.data?.nationality??"";
        camNoteController.camNationalityController.text = getLeadDetailModel.value?.data?.nationality ?? "";

        leadDDController.currEmpStatus.value=getLeadDetailModel.value?.data?.currentEmploymentStatus??"";
        camNoteController.camCurrEmpStatus.value = getLeadDetailModel.value?.data?.currentEmploymentStatus ?? "";

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

        print("prod seg--->${camNoteController.camSelectedProdSegment.value}");

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

        final geoLocationProp = getLeadDetailModel.value!.data!.geoLocationOfProperty;
        print("geoLocationProp--->${geoLocationProp}");

        var rawRole = StorageService.get(StorageService.ROLE).toString();
        var role = rawRole.replaceAll('[', '').replaceAll(']', '');
        print("role--->${role}");
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
        print("geoLocationRes--->${geoLocationRes}");

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

        print("geoLocationOff--->${geoLocationOff}");
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


        /*var tempCibil ="{\"code\":200,\"timestamp\":1752489745728,\"transaction_id\":\"53e80005b82b4d2c8c8546952df3d693\",\"sub_code\":\"SUCCESS\",\"message\":\"Credit report fetched successfully.\",\"data\":{\"pan\":null,\"mobile\":\"9522517237\",\"name\":\"ABHAY SOLANKI \",\"credit_score\":\"790\",\"pdf_url\":\"https://deepvue.s3.ap-south-1.amazonaws.com/credit-reports/equifax/report-pdf/ABHAY_SOLANKI__20250714104225.pdf\",\"credit_report\":{\"InquiryResponseHeader\":{\"ClientID\":\"007FP17166\",\"CustRefField\":null,\"ReportOrderNO\":\"2033124256\",\"ProductCode\":[\"IDCCR\"],\"SuccessCode\":\"1\",\"Date\":\"2025-07-14\",\"Time\":\"16:12:25\",\"HitCode\":null,\"CustomerName\":null},\"InquiryRequestInfo\":{\"InquiryPurpose\":\"05\",\"TransactionAmount\":null,\"FirstName\":\"ABHAY\",\"InquiryAddresses\":[{\"seq\":\"1\",\"AddressType\":null,\"AddressLine1\":\"Deepvue Technologies Private Limited, Garuda Behive Workspace, BTM 2nd Stage, BLR\",\"City\":null,\"State\":\"KA\",\"Postal\":\"560076\"}],\"InquiryPhones\":[{\"seq\":\"1\",\"PhoneType\":[\"M\"],\"Number\":\"9522517237\"}],\"IDDetails\":[{\"seq\":\"1\",\"IDType\":\"T\",\"IDValue\":\"OAMPS6745G\"}],\"DOB\":\"2001-04-28\",\"Gender\":null},\"Score\":[{\"Type\":\"ERS\",\"Version\":\"4.0\"}],\"CCRResponse\":{\"Status\":\"1\",\"CIRReportDataLst\":[{\"InquiryResponseHeader\":{\"ClientID\":null,\"CustRefField\":null,\"ReportOrderNO\":\"2033124256\",\"ProductCode\":[\"ICCRR\"],\"SuccessCode\":\"1\",\"Date\":\"2025-07-14\",\"Time\":\"16:12:25\",\"HitCode\":\"10\",\"CustomerName\":\"NYLV\"},\"InquiryRequestInfo\":{\"InquiryPurpose\":\"Personal Loan\",\"TransactionAmount\":null,\"FirstName\":\"ABHAY\",\"InquiryAddresses\":[{\"seq\":\"1\",\"AddressType\":null,\"AddressLine1\":\"Deepvue Technologies Private Limited, Garuda Behive Workspace, BTM 2nd Stage, BLR\",\"City\":null,\"State\":\"KA\",\"Postal\":\"560076\"}],\"InquiryPhones\":[{\"seq\":\"1\",\"PhoneType\":[\"M\"],\"Number\":\"9522517237\"}],\"IDDetails\":[{\"seq\":\"1\",\"IDType\":\"T\",\"IDValue\":\"OAMPS6745G\"}],\"DOB\":\"2001-04-28\",\"Gender\":null},\"Score\":[{\"Type\":\"ERS\",\"Version\":\"4.0\"}],\"CIRReportData\":{\"IDAndContactInfo\":{\"PersonalInfo\":{\"Name\":{\"FullName\":\"ABHAY SOLANKI \",\"FirstName\":\"ABHAY \",\"MiddleName\":\"SOLANKI \",\"LastName\":null},\"AliasName\":null,\"DateOfBirth\":\"2001-04-28\",\"Gender\":\"Male\",\"Age\":{\"Age\":\"24\"},\"PlaceOfBirthInfo\":{},\"TotalIncome\":null,\"Occupation\":null},\"IdentityInfo\":{\"PANId\":[{\"seq\":\"1\",\"ReportedDate\":\"2025-06-30\",\"IdNumber\":\"OAMPS6745G\"}],\"NationalIDCard\":null},\"AddressInfo\":[{\"Seq\":\"1\",\"ReportedDate\":\"2025-06-30\",\"Address\":\"112 MAHAVEER NAGAR  PIPLINAKA UJJAIN PIPLINAKA UJJAIN MADHYA PRADESH\",\"State\":\"MP\",\"Postal\":\"456006\",\"Type\":\"Rents,Primary\"},{\"Seq\":\"2\",\"ReportedDate\":\"2025-03-05\",\"Address\":\"S/O DEVENDRA SOLANKI 112 MAHAVEER NAGAR  UJJAIN GHATIYA UJJAIN UJJAIN CITY  1823 MADHYA PRADESH\",\"State\":\"MP\",\"Postal\":\"456006\",\"Type\":null},{\"Seq\":\"3\",\"ReportedDate\":\"2025-01-04\",\"Address\":\"S/O DEVENDRA SOLANKI 112 MAHAVEER NAGAR  UJJAIN GHATIYA UJJAIN UJJAIN CITY  1823 MADHYA PRADESH\",\"State\":\"MP\",\"Postal\":\"456006\",\"Type\":null},{\"Seq\":\"4\",\"ReportedDate\":\"2024-12-15\",\"Address\":\"112 MAHAVEER NAGAR  PIPLINAKA UJJAIN PIPLINAKA UJJAIN MADHYA PRADESH\",\"State\":\"MP\",\"Postal\":\"456006\",\"Type\":\"Rents,Primary\"}],\"PhoneInfo\":[{\"seq\":\"1\",\"typeCode\":\"H\",\"ReportedDate\":\"2025-03-05\",\"Number\":\"9522517237\"},{\"seq\":\"2\",\"typeCode\":\"M\",\"ReportedDate\":\"2025-06-30\",\"Number\":\"9522517237\"}],\"EmailAddressInfo\":null},\"RetailAccountDetails\":[{\"seq\":\"1\",\"AccountNumber\":\"XXXXXXXXXXX6599\",\"Institution\":\"CapFloat Financial Services Private Limited\",\"AccountType\":\"Consumer Loan\",\"OwnershipType\":\"Individual\",\"Balance\":\"0\",\"PastDueAmount\":\"0\",\"Open\":\"Yes\",\"SanctionAmount\":\"3000\",\"LastPaymentDate\":\"2025-06-02\",\"DateReported\":\"2025-06-30\",\"DateOpened\":\"2023-12-18\",\"DateClosed\":null,\"Reason\":null,\"TermFrequency\":\"Monthly\",\"AccountStatus\":\"Current Account\",\"AssetClassification\":\"Standard\",\"source\":\"INDIVIDUAL\",\"History48Months\":[{\"Key\":\"06-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"05-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"04-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"03-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"02-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"01-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"12-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"11-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"10-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"09-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"08-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"07-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"06-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"05-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"04-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"03-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"02-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"01-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"12-23\",\"PaymentStatus\":\"NEW\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"}]},{\"seq\":\"2\",\"AccountNumber\":\"XXXXXXXXXXX6599\",\"Institution\":\"Karur Vysya Bank\",\"AccountType\":\"Consumer Loan\",\"OwnershipType\":\"Individual\",\"Balance\":\"0\",\"PastDueAmount\":\"0\",\"Open\":\"Yes\",\"SanctionAmount\":\"12000\",\"LastPaymentDate\":\"2025-06-02\",\"DateReported\":\"2025-06-30\",\"DateOpened\":\"2023-12-18\",\"DateClosed\":null,\"Reason\":null,\"TermFrequency\":\"Monthly\",\"AccountStatus\":\"Current Account\",\"AssetClassification\":\"Standard\",\"source\":\"INDIVIDUAL\",\"History48Months\":[{\"Key\":\"06-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"05-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"04-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"03-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"02-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"01-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"12-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"11-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"10-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"09-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"08-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"07-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"06-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"05-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"04-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"03-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"02-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"01-24\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"},{\"Key\":\"12-23\",\"PaymentStatus\":\"NEW\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"STD\"}]},{\"seq\":\"3\",\"AccountNumber\":\"XXXXXXXXXXXXXX2054\",\"Institution\":\"IDFC First Bank Ltd\",\"AccountType\":\"Consumer Loan\",\"OwnershipType\":\"Individual\",\"Balance\":\"11363\",\"PastDueAmount\":\"0\",\"Open\":\"Yes\",\"SanctionAmount\":\"22028\",\"LastPaymentDate\":\"2025-06-08\",\"DateReported\":\"2025-06-16\",\"DateOpened\":\"2025-03-04\",\"DateClosed\":null,\"Reason\":null,\"TermFrequency\":\"Monthly\",\"AccountStatus\":\"Current Account\",\"AssetClassification\":null,\"source\":\"INDIVIDUAL\",\"History48Months\":[{\"Key\":\"06-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"05-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"04-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"03-25\",\"PaymentStatus\":\"NEW\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"}]},{\"seq\":\"4\",\"AccountNumber\":\"XXXXXXXXXXXXXX5133\",\"Institution\":\"IDFC First Bank Ltd\",\"AccountType\":\"Consumer Loan\",\"OwnershipType\":\"Individual\",\"Balance\":\"0\",\"PastDueAmount\":\"0\",\"Open\":\"No\",\"SanctionAmount\":\"30000\",\"LastPaymentDate\":\"2025-04-01\",\"DateReported\":\"2025-05-26\",\"DateOpened\":\"2025-01-03\",\"DateClosed\":\"2025-05-26\",\"Reason\":null,\"TermFrequency\":\"Monthly\",\"AccountStatus\":\"Closed Account\",\"AssetClassification\":null,\"source\":\"INDIVIDUAL\",\"History48Months\":[{\"Key\":\"05-25\",\"PaymentStatus\":\"CLSD\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"04-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"03-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"02-25\",\"PaymentStatus\":\"000\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"},{\"Key\":\"01-25\",\"PaymentStatus\":\"NEW\",\"SuitFiledStatus\":\"*\",\"AssetClassificationStatus\":\"*\"}]}]}},{\"InquiryResponseHeader\":{\"ClientID\":\"007FP17166\",\"CustRefField\":null,\"ReportOrderNO\":\"2033124256\",\"ProductCode\":[\"ICCRM\"],\"SuccessCode\":\"0\",\"Date\":\"2025-07-14\",\"Time\":\"16:12:25\",\"HitCode\":\"00\",\"CustomerName\":null},\"InquiryRequestInfo\":{\"InquiryPurpose\":\"05\",\"TransactionAmount\":null,\"FirstName\":\"ABHAY\",\"InquiryAddresses\":[{\"seq\":\"1\",\"AddressType\":null,\"AddressLine1\":\"Deepvue Technologies Private Limited, Garuda Behive Workspace, BTM 2nd Stage, BLR\",\"City\":null,\"State\":\"KA\",\"Postal\":\"560076\"}],\"InquiryPhones\":[{\"seq\":\"1\",\"PhoneType\":[\"M\"],\"Number\":\"9522517237\"}],\"IDDetails\":[{\"seq\":\"1\",\"IDType\":\"T\",\"IDValue\":\"OAMPS6745G\"}],\"DOB\":\"2001-04-28\",\"Gender\":null},\"Score\":null,\"CIRReportData\":null}]}}}}";
        print("cibilJSON===>${tempCibil}");
        if (tempCibil!=null) {
          final result = await parseCibilData(
            cibilJson: tempCibil,
            annualInterestRate: 12.0,
            tenureMonths: 12,
          );*/


        if (getLeadDetailModel.value?.data?.cibilJSON!=null) {
          final result = await parseCibilData(
            cibilJson: getLeadDetailModel.value?.data?.cibilJSON,
            annualInterestRate: 12.0,
            tenureMonths: 12,
          );




         /* print("CIBIL Score: ${result['Cibil']}");
          print("TotalLoanAvailedOnCibil: ${result['TotalLoanAvailedOnCibil']}");
          print("TotalLiveLoan: ${result['TotalLiveLoan']}");
          print("TotalEMI: ${result['TotalEMI'].toStringAsFixed(2)}");
          print("EMIWillContinue: ${result['EMIWillContinue']}");
          print("TotalOverdueCasesAsPerCibil: ${result['TotalOverdueCasesAsPerCibil']}");
          print("TotalOverdueAmountAsPerCibil: ${result['TotalOverdueAmountAsPerCibil']}");
          print("TotalEnquiriesMadeAsPerCibil: ${result['TotalEnquiriesMadeAsPerCibil']}");
*/
          camNoteController.camCibilController.text=result['Cibil'].toString();
          camNoteController.camTotalLoanAvailedController.text=result['TotalLoanAvailedOnCibil'].toString();
          camNoteController.camTotalLiveLoanController.text=result['TotalLiveLoan'].toString();
          camNoteController.camTotalEmiController.text=result['TotalEMI'].toStringAsFixed(2).toString();
          camNoteController.camEmiWillContinueController.text=result['EMIWillContinue'].toString();
          camNoteController.camTotalOverdueCasesController.text=result['TotalOverdueCasesAsPerCibil'].toString();
          camNoteController.camTotalOverdueAmountController.text=result['TotalOverdueAmountAsPerCibil'].toString();
          camNoteController.camTotalEnquiriesController.text=result['TotalEnquiriesMadeAsPerCibil'].toString();
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



  Future<void>fillLeadFormApi({
   required String id,
   required String dob,
   required String gender,
   required String loanAmtReq,
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
      );


      if(data['success'] == true){

        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);
        ToastMessage.msg( getLeadDetailModel.value!.message!.toString());

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

/*

        if ((addIncomeListTemp?.any((e) =>
        e.aiIncomeController.text.trim().isNotEmpty ||
            e.aiSourceController.text.trim().isNotEmpty) ?? false)) {


          final List<AddIncModel> addIncModel = [];

          for (var ai in addIncomeListTemp!) {
            if (ai.aiIncomeController.text.trim().isEmpty &&
                ai.aiSourceController.text.trim().isEmpty) {
              continue; // skip blank entries
            }


            final acModel = AddIncModel(
              amount: int.parse(ai.aiIncomeController.text),
              description: Helper.cleanText(ai.aiSourceController.text),
              uniqueLeadNumber: uln,
            );
            addIncModel.add(acModel);
          }
        }
*/


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
    noOfExistingLoansController.clear();

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
    noOfExistingLoansController.dispose();
    addIncomeList.clear();

  }


}

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
