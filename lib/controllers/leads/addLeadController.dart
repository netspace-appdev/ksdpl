import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';

import '../../common/helper.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../services/drawer_api_service.dart';
import '../../services/lead_api_service.dart';
import '../registration_dd_controller.dart';

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

  var fromWhere="".obs;

  var getLeadDetailModel = Rxn<GetLeadDetailModel>();
  var getLeadId = Rxn<String>();



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

        getLeadDetailModel.value= GetLeadDetailModel.fromJson(data);

        LeadDDController leadDDController=Get.put(LeadDDController());
        getLeadId.value=getLeadDetailModel.value!.data!.id!.toString();

        fullNameController.text=getLeadDetailModel.value!.data!.name!.toString();
        dobController.text=Helper.birthdayFormat(getLeadDetailModel.value!.data!.dateOfBirth!.toString());
        phoneController.text=getLeadDetailModel.value!.data!.mobileNumber!.toString();
        selectedGender.value=getLeadDetailModel.value!.data!.gender!.toString();
        loanAmtReqController.text=getLeadDetailModel.value!.data!.loanAmountRequested!.toString();
        loanAmtReqController.text=getLeadDetailModel.value!.data!.loanAmountRequested!.toString();
        emailController.text=getLeadDetailModel.value!.data!.email!.toString();
        aadharController.text=getLeadDetailModel.value!.data!.adharCard!.toString();
        panController.text=getLeadDetailModel.value!.data!.panCard!.toString();
        streetAddController.text=getLeadDetailModel.value!.data!.streetAddress!.toString();
        leadDDController.selectedState.value=getLeadDetailModel.value!.data!.state!.toString();
        leadDDController.selectedDistrict.value=getLeadDetailModel.value!.data!.district!.toString();
        leadDDController.selectedCity.value=getLeadDetailModel.value!.data!.city!.toString();
        zipController.text=getLeadDetailModel.value!.data!.pincode!.toString();
        nationalityController.text=getLeadDetailModel.value!.data!.nationality!.toString();
        leadDDController.currEmpStatus.value=getLeadDetailModel.value!.data!.currentEmploymentStatus!.toString();
        employerNameController.text=getLeadDetailModel.value!.data!.employerName!.toString();
        monthlyIncomeController.text=getLeadDetailModel.value!.data!.monthlyIncome!.toString();
        addSourceIncomeController.text=getLeadDetailModel.value!.data!.additionalSourceOfIncome!.toString();
        leadDDController.selectedBank.value=getLeadDetailModel.value!.data!.prefferedBank!.toString();
        branchLocController.text=getLeadDetailModel.value!.data!.branchName!.toString();
        leadDDController.selectedProdType.value=getLeadDetailModel.value!.data!.productType!.toString();
        connNameController.text=getLeadDetailModel.value!.data!.connectorName!.toString();
        connMobController.text=getLeadDetailModel.value!.data!.connectorMobileNo!.toString();
        connShareController.text=getLeadDetailModel.value!.data!.connectorPercentage!.toString();


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


    } catch (e) {
      print("Error getLeadDetailByIdApi: $e");

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
    selectedGender.value="";
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("all close");
  }

}