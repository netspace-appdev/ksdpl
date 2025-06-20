import 'dart:ffi';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';

import '../../common/helper.dart';
import '../../models/IndividualLeadUploadModel.dart';
import '../../models/camnote/special_model/IncomeModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/leads/special_model/AddIncModel.dart';
import '../../services/drawer_api_service.dart';
import '../../services/lead_api_service.dart';
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

  void  getLeadDetailByIdApi({
    required String leadId,
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getLeadDetailByIdApi(
        leadId:leadId,
      );


      if(data['success'] == true){

        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);

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

        leadDDController.selectedProdType.value=getLeadDetailModel.value?.data?.productType??"";
        camNoteController.camSelectedProdType.value=getLeadDetailModel.value?.data?.productType??"";


        camNoteController.camSelectedProdSegment.value=int.parse(getLeadDetailModel.value?.data?.leadsegment.toString()??"0")??0;

        print("relb--->${getLeadDetailModel.value?.data?.existinRelaationshipWithBank}");

        camNoteController.camSelectedIndexRelBank.value=getLeadDetailModel.value?.data?.existinRelaationshipWithBank==""?-1:getLeadDetailModel.value?.data?.existinRelaationshipWithBank=="Yes"?0:1;
        connNameController.text=getLeadDetailModel.value?.data?.connectorName??"";

        connMobController.text=getLeadDetailModel.value?.data?.connectorMobileNo??"";

        connShareController.text=getLeadDetailModel.value?.data?.connectorPercentage.toString()??"";

        createdByWhichEmployee.value=getLeadDetailModel.value?.data?.assignedEmployeeId.toString()??"";


        camNoteController.getAddIncUniqueLeadApi(uniqueLeadNumber:getLeadDetailModel.value!.data!.uniqueLeadNumber?.toString()??"0");
        //camNoteController.selectedPackage.value=getLeadDetailModel.value?.data?.assignedEmployeeId.toString()??"";

        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {


      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
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
  }) async {
    try {
      isLoading(true);


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
      );


      if(data['success'] == true){

        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);
        ToastMessage.msg( getLeadDetailModel.value!.message!.toString());


        clearControllers();
        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {  print("Error getLeadDetailByIdApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }





  void clearControllers(){
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