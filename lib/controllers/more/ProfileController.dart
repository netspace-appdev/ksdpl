import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/workExperienceController.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/employmentFormController .dart';
import 'package:ksdpl/models/more/ChangeEmailResponseModel.dart';
import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../addDocumentControler/addDocumentModel/addDocumentModel.dart';
import 'profileMultiFormController/ademicsController.dart';

class ProfileController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  var selectedGender = Rxn<String>();


  var isLoading=false.obs;
  var acadmicsFormApplList = <AcademicFormController>[].obs;
  var employmentFormList = <WorkExperienceController>[].obs;



  var obscurePassword = true.obs;
  String? phone = StorageService.get(StorageService.PHONE);



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


}
