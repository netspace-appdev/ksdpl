import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/workExperienceController.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/employmentFormController .dart';
import 'package:ksdpl/models/more/ChangeEmailResponseModel.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../models/getUserByIdModel/getEducationDetailById.dart';
import '../../models/getUserByIdModel/getUserByIdModel.dart';
import '../../models/getUserByIdModel/getWorkExperience.dart';
import '../../services/moreService.dart';
import '../addDocumentControler/addDocumentModel/addDocumentModel.dart';
import '../lead_dd_controller.dart';
import 'profileMultiFormController/ademicsController.dart';

class ProfileController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LeadDDController leadDDController=Get.put(LeadDDController());

  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController profileEmailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController whatsappNoController = TextEditingController();
  final TextEditingController educationTypeController = TextEditingController();
  final TextEditingController JobRoleController = TextEditingController();
  final TextEditingController WorkPlaceController = TextEditingController();
  final TextEditingController atStartDateController = TextEditingController();
  final TextEditingController atEndDateController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController managerNameController = TextEditingController();
  final TextEditingController adharCardController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController institutionNameController = TextEditingController();
  final TextEditingController universityNameController = TextEditingController();
  final TextEditingController yearOfPassingController = TextEditingController();
  final TextEditingController gradeOrPercentageController = TextEditingController();
  final TextEditingController educationtypeController = TextEditingController();
  final TextEditingController nameOfCompanyController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController employmentTypeController = TextEditingController();
  final TextEditingController companyAddressController = TextEditingController();
  final TextEditingController reasonForLeavingController = TextEditingController();
  final TextEditingController lastDrawnSalaryController = TextEditingController();
  final TextEditingController responsibilitiesController = TextEditingController();


  var selectedGender = Rxn<String>();


  var isLoading=false.obs;
  var acadmicsFormApplList = <AcademicFormController>[].obs;
  var employmentFormList = <WorkExperienceController>[].obs;



  var obscurePassword = true.obs;
  String? phone = StorageService.get(StorageService.PHONE);
  var getUserByIdModel = Rxn<GetUserByIdModel>();
  var getEducationDetailModel = Rxn<GetEducationDetail>();
  var getProfessionalDetailModel = Rxn<GetProfessionalDetailModel>();









  @override
  void onInit() {
    super.onInit();
    if (phone != null) {
     // mobileController.text = phone.toString();
    }
  }

  void addFamilyMember() {
    acadmicsFormApplList.add(AcademicFormController());
  }

  // void addWorkExperienceDetails() {
  //   employmentFormList.add(WorkExperienceController());
  // }

  void addEmploymentDetail() {
    employmentFormList.add(WorkExperienceController());
  }

  void removeEmploymentDetail(int index) {
    if (employmentFormList.length <= 1) {
      ToastMessage.msg("You must have at least one employment detail");
      return;
    }

    final removed = employmentFormList[index];
    employmentFormList.removeAt(index);
    employmentFormList.refresh();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      removed.dispose();
    });
  }


/*
  Future<void>  changeEmailRequestApi() async {
    //ChangePassword
    try {
      isLoading(true);

      var data = await MoreServices.changeEmailRequestApi(
          Email: emailController.text.trim().toString(),
          PhoneNumber: phone.toString()
      );

      if (data['success'] == true) {
        _changeEmailResponseModel.value = ChangeEmailResponseModel.fromJson(data);
        //  StorageService.put(StorageService.EMAIL, _changeEmailResponseModel!.data!.email.toString());

        ToastMessage.msg(data['data']?.toString() ?? '');

        clearFormFields();
        StorageService.clear();
        Get.offAllNamed("/login");

      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        // Handle empty case
      } else {
        ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in changeEmailResponse: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }
*/

  void clearFormFields() {
  //  emailController.clear();
  }

  void removeAdditionalSrcDocument(int index) {
    if (acadmicsFormApplList.length <= 1) {
      ToastMessage.msg("You must have at least one academic detail");
      return;
    }

    if (index >= 0 && index < acadmicsFormApplList.length) {
      // Keep reference of the removed item
      final removed = acadmicsFormApplList[index];

      // Remove immediately so UI rebuilds without it
      acadmicsFormApplList.removeAt(index);

      // Refresh UI if using RxList
      acadmicsFormApplList.refresh();

      // Dispose controllers safely after rebuild
    /*  WidgetsBinding.instance.addPostFrameCallback((_) {
        removed.qualification.dispose();
        removed.specialization.dispose();
        removed.institution.dispose();
        removed.university.dispose();
        removed.year.dispose();
        removed.grade.dispose();
        removed.educationType.dispose();
      });*/
    } else {
      debugPrint("🧯 Invalid index passed to removeAcademicDetail: $index");
    }
  }



  Future<void>  fetchUserDetail() async {
    //getUserDetailRequestApi
    try {
      isLoading(true);

      var data = await MoreServices.getUserDetailRequestApi();
      getUserByIdModel.value = GetUserByIdModel.fromJson(data);

      if (getUserByIdModel.value?.status == '200') {

        print('here data is ${getUserByIdModel.value?.data?.employeeName}');
        final userData = getUserByIdModel.value?.data;

        // ✅ Map API response → form controllers
        employeeNameController.text = userData?.employeeName ?? '';
        dateOfBirthController.text = userData?.dateOfBirth ?? '';
        profileEmailController.text = userData?.email ?? '';
        phoneNumberController.text = userData?.phoneNumber ?? '';
        whatsappNoController.text = userData?.whatsappNumber ?? '';
        JobRoleController.text = userData?.jobRole ?? '';
        WorkPlaceController.text = userData?.workPlace ?? '';
        managerNameController.text = userData?.managerName ?? '';
        addressController.text = userData?.address ?? '';
        adharCardController.text = userData?.aadharNumber ?? '';
        //companyNameController.text=userData.

        // For dropdowns
        leadDDController.selectedState.value = userData?.state?.toString() ?? '';
        leadDDController.getDistrictByStateIdApi(stateId: leadDDController.selectedState.value);

        leadDDController.selectedDistrict.value = userData?.district?.toString() ?? '';
        leadDDController.getCityByDistrictIdApi(districtId: leadDDController.selectedDistrict.value);

        leadDDController.selectedCity.value = userData?.city?.toString() ?? '';


      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        // Handle empty case
      } else {
        ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in changeEmailResponse: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

/*
  Future<void> generateOptByAdharNo()async {
    try {
      isLoading(true);

      var data = await MoreServices.getUserEducationDetailRequestApi();
      getUserByIdModel.value = GetUserByIdModel.fromJson(data);

      if (getUserByIdModel.value?.status == '200') {

        print('here data is ${getUserByIdModel.value?.data?.employeeName}');
        final userData = getUserByIdModel.value?.data;

        // ✅ Map API response → form controllers
        employeeNameController.text = userData?.employeeName ?? '';
        dateOfBirthController.text = userData?.dateOfBirth ?? '';
        profileEmailController.text = userData?.email ?? '';
        phoneNumberController.text = userData?.phoneNumber ?? '';
        whatsappNoController.text = userData?.whatsappNumber ?? '';
        JobRoleController.text = userData?.jobRole ?? '';
        WorkPlaceController.text = userData?.workPlace ?? '';
        managerNameController.text = userData?.managerName ?? '';
        addressController.text = userData?.address ?? '';
        adharCardController.text = userData?.aadharNumber ?? '';
        //companyNameController.text=userData.

        // For dropdowns
        leadDDController.selectedState.value = userData?.state?.toString() ?? '';
        leadDDController.getDistrictByStateIdApi(stateId: leadDDController.selectedState.value);

        leadDDController.selectedDistrict.value = userData?.district?.toString() ?? '';
        leadDDController.getCityByDistrictIdApi(districtId: leadDDController.selectedDistrict.value);

        leadDDController.selectedCity.value = userData?.city?.toString() ?? '';


      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        // Handle empty case
      } else {
        ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in changeEmailResponse: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }
*/

 Future<void>fetchUserEducationDetail() async {

   try {
     isLoading(true);

     var data = await MoreServices.getUserEducationDetailRequestApi();
     getEducationDetailModel.value = GetEducationDetail.fromJson(data);

     if (getEducationDetailModel.value?.status == '200') {

       print('here data is ${getEducationDetailModel.value?.data?.length}');
       final userData = getEducationDetailModel.value?.data;

        qualificationController.text = userData?[0].qualification??'';
        specializationController.text = userData?.first.specialization??'';
        institutionNameController.text =userData?.first.institutionName??'';
        universityNameController.text = userData?.first.universityName??'';
        yearOfPassingController.text = userData?.first.yearOfPassing.toString()??'';
        gradeOrPercentageController.text = userData?.first.gradeOrPercentage??'';
        educationtypeController.text = userData?.first.educationType??'';


     } else if (data['success'] == false && (data['data'] as List).isEmpty) {
       // Handle empty case
     } else {
       ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
     }
   } catch (e) {
     print("Error in changeEmailResponse: $e");
     ToastMessage.msg(AppText.somethingWentWrong);
   } finally {
     isLoading(false);
   }

 }

  Future<void>fetchUserProfessionalDetail() async {
    try {
      isLoading(true);

      var data = await MoreServices.getUserProfessionDetailRequestApi();
      getProfessionalDetailModel.value = GetProfessionalDetailModel.fromJson(data);

      if (getProfessionalDetailModel.value?.status == '200') {

        print('here data is ${getProfessionalDetailModel.value?.data?.length}');
        final userData = getProfessionalDetailModel.value?.data;

        // ✅ Map API response → form controllers
        nameOfCompanyController.text = userData?.first.companyName ?? '';
        jobTitleController.text = userData?.first.jobTitle ?? '';
        departmentController.text = userData?.first.department ?? '';
        startDateController.text = userData?.first.startDate ?? '';
        endDateController.text = userData?.first.endDate ?? '';
        employmentTypeController.text = userData?.first.employmentType ?? '';
        companyAddressController.text = userData?.first.companyAddress ?? '';
        reasonForLeavingController.text = userData?.first.reasonForLeaving ?? '';
        lastDrawnSalaryController.text = userData?.first.lastDrawnSalary.toString() ?? '';
        responsibilitiesController.text = userData?.first.responsibilities.toString() ?? '';



      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        // Handle empty case
      } else {
        ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in changeEmailResponse: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }


  }



}
