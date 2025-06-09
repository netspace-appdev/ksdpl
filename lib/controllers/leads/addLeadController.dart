import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';

import '../../common/helper.dart';
import '../../models/IndividualLeadUploadModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
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

  void  getLeadDetailByIdApi({
    required String leadId,
  }) async {
    try {
      isLoading(true);


      var data = await DrawerApiService.getLeadDetailByIdApi(
        leadId:leadId,
      );


      if(data['success'] == true){

        print("here 1");


        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);
        print("here 1");
        LeadDDController leadDDController=Get.put(LeadDDController());
        print("here 2");
        getLeadId.value=getLeadDetailModel.value!.data!.id!.toString();
        print("here 3");
        fullNameController.text=getLeadDetailModel.value!.data!.name!.toString();
        print("here 4");
        dobController.text=getLeadDetailModel.value!.data!.dateOfBirth==null?"":Helper.birthdayFormat(getLeadDetailModel.value!.data!.dateOfBirth!.toString());
        print("here 5");
        phoneController.text=getLeadDetailModel.value?.data?.mobileNumber??"";
        print("here 6");
        selectedGender.value=getLeadDetailModel.value?.data?.gender??"";
        print("here 7");
        loanAmtReqController.text=getLeadDetailModel.value?.data?.loanAmountRequested??"";
        print("here 8");

        print("here 9");
        emailController.text=getLeadDetailModel.value?.data?.email??"";

        print("email==>${ emailController.text.toString()}");

        aadharController.text=getLeadDetailModel.value?.data?.adharCard??"";
        print("here 10");
        panController.text=getLeadDetailModel.value?.data?.panCard??"";
        print("here 11");

        streetAddController.text=getLeadDetailModel.value?.data?.streetAddress??"";
        print("here 12");
        leadDDController.selectedState.value=getLeadDetailModel.value!.data!.state!.toString();
        print("here 13");
        leadDDController.selectedDistrict.value=getLeadDetailModel.value!.data!.district!.toString();
        print("here 14");
        leadDDController.selectedCity.value=getLeadDetailModel.value!.data!.city!.toString();
        print("here 15");
        zipController.text=getLeadDetailModel.value?.data?.pincode??"";
        print("here 16");
        nationalityController.text=getLeadDetailModel.value?.data?.nationality??"";
        print("here 17");
        leadDDController.currEmpStatus.value=getLeadDetailModel.value?.data?.currentEmploymentStatus??"";
        print("here 18");
        employerNameController.text=getLeadDetailModel.value?.data?.employerName??"";
        print("here 19");
        monthlyIncomeController.text=getLeadDetailModel.value?.data?.monthlyIncome??"";
        print("here 20");
        addSourceIncomeController.text=getLeadDetailModel.value?.data?.additionalSourceOfIncome??"";
        print("here 21");
        leadDDController.selectedBank.value=getLeadDetailModel.value?.data?.prefferedBank??"";
        print("here 22");
        branchLocController.text=getLeadDetailModel.value?.data?.branch??"";
        print("here 23");
        leadDDController.selectedProdType.value=getLeadDetailModel.value?.data?.productType??"";
        print("here 24");
        connNameController.text=getLeadDetailModel.value?.data?.connectorName??"";
        print("here 25");
        connMobController.text=getLeadDetailModel.value?.data?.connectorMobileNo??"";
        print("here 26");
        connShareController.text=getLeadDetailModel.value?.data?.connectorPercentage.toString()??"";
        print("here 27");

        createdByWhichEmployee.value=getLeadDetailModel.value?.data?.assignedEmployeeId.toString()??"";
        print("here 28");
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
    String? loanApplNo,
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

      );


      if(data['success'] == true){

        individualLeadUploadModel.value= IndividualLeadUploadModel.fromJson(data);
        ToastMessage.msg( individualLeadUploadModel.value!.message!.toString());


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