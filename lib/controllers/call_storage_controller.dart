import 'package:get/get.dart';
import 'package:ksdpl/controllers/registration_dd_controller.dart';
import 'package:ksdpl/models/GetAllBranchByBankIdModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';


class CallStorageController extends GetxController{
  var isLoading=false.obs;
  var snToggle=true.obs;
  var brNameToggle=true.obs;
  var ifscToggle=true.obs;
  var phNoToggle=true.obs;
  var emailToggle=true.obs;
  var stateToggle=true.obs;
  var distToggle=true.obs;
  var cityToggle=true.obs;
  var micrToggle=true.obs;
  var zipToggle=true.obs;
  var addressToggle=true.obs;
  var brCodeToggle=true.obs;

  RxList<Data> branchData = <Data>[].obs;

  var selectionViewCLearAll="".obs;
  final RegistrationDDController regDDController = Get.put(RegistrationDDController(),);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  //  _loadBranches();
  }
  void _loadBranches() async {
    var bankId = StorageService.get(StorageService.BANK_ID).toString();
    await regDDController.getAllBranchByBankIdApi(bankId);
    // Assuming regDDController.getAllBranchByBankIdModel!.data returns List<Data>
    branchData.assignAll(regDDController.getAllBranchByBankIdModel!.data ?? []);
    print("Loaded branches: ${branchData.toString()}");
  }

  changeListToggle(String whichValue, bool val){

    if(whichValue==AppText.sNo){
      snToggle.value=val;
    }else if(whichValue==AppText.branchName){
      brNameToggle.value=val;
    }else if(whichValue==AppText.IFSC){
      ifscToggle.value=val;
    }else if(whichValue==AppText.phoneNo){
      phNoToggle.value=val;
    }else if(whichValue==AppText.eml){
      emailToggle.value=val;
    }else if(whichValue==AppText.state){
      stateToggle.value=val;
    }else if(whichValue==AppText.district){
      distToggle.value=val;
    }else if(whichValue==AppText.city){
      cityToggle.value=val;
    }else if(whichValue==AppText.mICRCode){
      micrToggle.value=val;
    }else if(whichValue==AppText.zipCode){
      zipToggle.value=val;
    }else if(whichValue==AppText.address){
      addressToggle.value=val;
    }else if(whichValue==AppText.branchCode){
      brCodeToggle.value=val;
    }

  }

  void checkToggleSelection() {
    bool allOff =
        !snToggle.value &&
            !cityToggle.value &&
            !micrToggle.value &&
            !zipToggle.value &&
            !addressToggle.value &&
            !brCodeToggle.value &&
            !emailToggle.value &&
            !distToggle.value &&
            !brNameToggle.value &&
            !phNoToggle.value &&
            !ifscToggle.value &&
            !stateToggle.value;

    bool allOn =
        snToggle.value &&
            cityToggle.value &&
            micrToggle.value &&
            zipToggle.value &&
            addressToggle.value &&
            brCodeToggle.value &&
            emailToggle.value &&
            distToggle.value &&
            brNameToggle.value &&
            phNoToggle.value &&
            ifscToggle.value &&
            stateToggle.value;

    if (allOff) {
      selectionViewCLearAll.value = 'clear_all';
    } else if (allOn) {
      selectionViewCLearAll.value = 'select_all';
    } else {
      // Optional: Reset to a neutral state if needed
    }
  }

  void showAllColumns(){
    selectionViewCLearAll.value="select_all";
    snToggle.value=true;
    cityToggle.value=true;
    micrToggle.value=true;
    zipToggle.value=true;
    addressToggle.value=true;
    brCodeToggle.value=true;
    emailToggle.value=true;
    distToggle.value=true;
    brNameToggle.value=true;
    zipToggle.value=true;
    phNoToggle.value=true;
    ifscToggle.value=true;
    stateToggle.value=true;
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $callUri';
    }
  }



}