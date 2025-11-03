import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/workExperienceController.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/employmentFormController .dart';
import 'package:ksdpl/models/loan_application/special_model/CoApplicantModel.dart';
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
  final TextEditingController addressAdharCardController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController institutionNameController = TextEditingController();
  final TextEditingController universityNameController = TextEditingController();
  final TextEditingController yearOfPassingController = TextEditingController();
  final TextEditingController gradeOrPercentageController = TextEditingController();
  final TextEditingController educationtypeController = TextEditingController();
  final TextEditingController hireDate = TextEditingController();
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
  final TextEditingController postalCodeController = TextEditingController();


  var selectedGender = Rxn<String>();
  var isLoading=false.obs;
  var acadmicsFormApplList = <AcademicFormController>[].obs;
  var employmentFormList = <WorkExperienceController>[].obs;


  DateTime now = DateTime.now();

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
        addressAdharCardController.text = userData?.addressAsPerAddhar.toString() ?? '';
        selectedGender.value = userData?.gender ?? '';
        print('gender data   ${userData?.gender}');
        hireDate.text = userData?.hireDate ?? '';
        postalCodeController.text = userData?.postalCode.toString() ?? '';

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

  Future<void> fetchUserEducationDetail() async {
    try {
      isLoading(true);

      var data = await MoreServices.getUserEducationDetailRequestApi();
      getEducationDetailModel.value = GetEducationDetail.fromJson(data);

      if (getEducationDetailModel.value?.status == '200') {
        acadmicsFormApplList.clear(); // clear old data before adding new

        final userDataList = getEducationDetailModel.value?.data ?? [];
        for (var edu in userDataList) {
          final form = AcademicFormController();

          form.qualificationController.text = edu.qualification ?? '';
          form.specializationController.text = edu.specialization ?? '';
          form.institutionNameController.text = edu.institutionName ?? '';
          form.universityNameController.text = edu.universityName ?? '';
          form.yearOfPassingController.text = edu.yearOfPassing?.toString() ?? '';
          form.gradeOrPercentageController.text = edu.gradeOrPercentage ?? '';
          form.educationtypeController.text = edu.educationType ?? '';

          // if API gives file details
          if (edu.documents != null) {
            form.selectedFileName.value = edu.documents!;
          }
          if (edu.documents != null) {
            form.selectedFilePath.value = edu.documents!;
          }

          acadmicsFormApplList.add(form);
        }

        acadmicsFormApplList.refresh();
      } else if (data['success'] == false &&
          (data['data'] as List).isEmpty) {
        // ✅ no education records found
        acadmicsFormApplList.clear();
      } else {
        ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("❌ Error in fetchUserEducationDetail: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserProfessionalDetail() async {
    try {
      isLoading(true);

      var data = await MoreServices.getUserProfessionDetailRequestApi();
      getProfessionalDetailModel.value = GetProfessionalDetailModel.fromJson(data);

      if (getProfessionalDetailModel.value?.status == '200') {
        employmentFormList.clear(); // clear old records

        final userDataList = getProfessionalDetailModel.value?.data ?? [];
        print('here data is ${userDataList.length}');

        for (var exp in userDataList) {
          final workController = WorkExperienceController();

          workController.companyNameController.text = exp.companyName ?? '';
          workController.jobTitleController.text = exp.jobTitle ?? '';
          workController.departmentController.text = exp.department ?? '';
          workController.startDateController.text = exp.startDate ?? '';
          workController.endDateController.text = exp.endDate ?? '';
          workController.employmentTypeController.text = exp.employmentType ?? '';
          workController.companyAddressController.text = exp.companyAddress ?? '';
          workController.reasonForLeavingController.text = exp.reasonForLeaving ?? '';
          workController.lastDrawnSalaryController.text = exp.lastDrawnSalary?.toString() ?? '';
          workController.responsibilitiesController.text = exp.responsibilities ?? '';

          // If file info is available
          if (exp.documents != null) {
            workController.selectedFileName.value = exp.documents!;
          }
          // if (exp.documentFilePath != null) {
          //   workController.selectedFilePath.value = exp.documentFilePath!;
          // }

          employmentFormList.add(workController);
        }

        employmentFormList.refresh();
      } else if (data['success'] == false &&
          (data['data'] as List).isEmpty) {
        // No records
        employmentFormList.clear();
      } else {
        ToastMessage.msg(data['data'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("❌ Error in fetchUserProfessionalDetail: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

  Future<void> editEmployeeDetailRequest() async {
    try {
      isLoading(true);

      final payload = {
        "Id": getUserByIdModel.value?.data?.id.toString(), // your example Id
        "BranchId": getUserByIdModel.value?.data?.branchId.toString(), // example branch
        "EmployeeName": employeeNameController.text.trim(),
        "Gender": selectedGender.value ?? "",
        "DateOfBirth": dateOfBirthController.text.trim(),
        "Email": profileEmailController.text.trim(),
        "PhoneNumber": phoneNumberController.text.trim(),
        "WhatsappNumber": whatsappNoController.text.trim(),
        "HireDate": atStartDateController.text.trim(),
        "JobRole": JobRoleController.text.trim(),
        "WorkPlace": WorkPlaceController.text.trim(),
        "ManagerID": getUserByIdModel.value?.data?.managerID.toString(),// set dynamically if needed
        "Address": addressController.text.trim(),
        "State": leadDDController.selectedState.value ?? "",
        "District": leadDDController.selectedDistrict.value ?? "",
        "City": leadDDController.selectedCity.value ?? "",
        "PostalCode": postalCodeController.text.trim(), // add if available
        "CreatedBy": "", // set if needed
        "IsEmployeeHeadOfTheBranch": "0",
        "Image": "", // pass image path if updated
        "Aadharnumber": adharCardController.text.trim(),
        "AddressAsPerAadhar": addressAdharCardController.text.trim() // set if needed
      };

      var data = await MoreServices.editEmployeeDetailRequestApi(payload: payload);

      // If you have a model, parse it; otherwise check data map directly
      if (data['status'] == "200") {
        ToastMessage.msg("Employee detail updated successfully");
      } else if (data['success'] == false) {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("❌ Error in editEmployeeDetailRequest: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

// ================== Update Education ==================
  Future<void> updateEmployeeEducationDetailsRequest() async {
    try {
      isLoading(true);

      final payload = {
        "Id": "", // pass if available
        "EmployeeId": employeeController.text.trim(),
        "Qualification": qualificationController.text.trim(),
        "Specialization": specializationController.text.trim(),
        "InstitutionName": institutionNameController.text.trim(),
        "UniversityName": universityNameController.text.trim(),
        "YearOfPassing": yearOfPassingController.text.trim(),
        "GradeOrPercentage": gradeOrPercentageController.text.trim(),
        "EducationType": educationtypeController.text.trim(),
        "Documents": "", // set file path or name if uploaded
      };

      var data = await MoreServices.updateEmployeeEducationDetailsRequestApi(payload: payload);
      final response = getProfessionalDetailModel.value;

      if (response?.status == "200") {
        ToastMessage.msg("Education details updated successfully");
      } else if (data['success'] == false) {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      } else {
        ToastMessage.msg(response?.message ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("❌ Error in updateEmployeeEducationDetailsRequest: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }

// ================== Update Professional ==================
  Future<void> updateEmployeeProfessionalDetailRequest() async {
    try {
      isLoading(true);

      final payload = {
        "Id": "", // pass if available
        "EmployeeId": employeeController.text.trim(),
        "CompanyName": companyNameController.text.trim(),
        "JobTitle": jobTitleController.text.trim(),
        "Department": departmentController.text.trim(),
        "StartDate": startDateController.text.trim(),
        "EndDate": endDateController.text.trim(),
        "EmploymentType": employmentTypeController.text.trim(),
        "CompanyAddress": companyAddressController.text.trim(),
        "Responsibilities": responsibilitiesController.text.trim(),
        "LastDrawnSalary": lastDrawnSalaryController.text.trim(),
        "ReasonForLeaving": reasonForLeavingController.text.trim(),
        "Documents": "", // set file path/name if uploaded
        "IsFresher": "", // true/false if available
      };

      var data = await MoreServices.updateEmployeeProfessionalDetailRequestApi(payload: payload);
      final response = getProfessionalDetailModel.value;

      if (response?.status == "200") {
        ToastMessage.msg("Professional details updated successfully");
      } else if (data['success'] == false) {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      } else {
        ToastMessage.msg(response?.message ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("❌ Error in updateEmployeeProfessionalDetailRequest: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }



}
