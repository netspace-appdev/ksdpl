import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/common/helper.dart';

import '../../common/storage_service.dart';
import '../../services/home_service.dart';
import '../custom_widgets/CustomDialog.dart';
import '../models/AddUserModel.dart';
import '../models/BankersRegistrationModel.dart';
import '../models/LoginModel.dart';
import '../models/SendMailForVerificationModel.dart';
import '../models/SendMailToBankerAfterRegModel.dart';
import '../models/ValidateBankerRegRoleModel.dart';

class RegistrationController extends GetxController {

  var isLoading = false.obs;
  var obscurePassword = true.obs;
  var isTermsChecked = false.obs;
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController lenderNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController whatsappNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController functionalSupervisorMobileController = TextEditingController();
  final TextEditingController functionalSupervisorEmailController = TextEditingController();

  final TextEditingController adminSupervisorMobileController = TextEditingController();
  final TextEditingController adminSupervisorEmailController = TextEditingController();

  var bankNameDD=Rxn<String>();
  var branchNameDD=Rxn<String>();
  var roleLevelDD=Rxn<String>();

  ValidateBankerRegRoleModel? validateBankerRegRoleModel;
  AddUserModel? addUserModel;
  BankersRegistrationModel? bankersRegistrationModel;
  SendMailForVerificationModel? sendMailForVerificationModel;
  SendMailToBankerAfterRegModel? sendMailToBankerAfterRegModel;

  void  validateBankerRegistrationRoleApi({
    required String bankId,
    required String branchId,
    required String shortName,
    required String firstName,
    required String lastName,
    required String emailId ,
    required String phoneNumber,
    required String password,
    required String role,
    required String userName,

    required String id,
    required String bankerCode,
    required String bankerName,
    required String contactNo,
    required String whatsappNo,
    required String email,
    required String supervisorName,
    required String supervisorMobileNo,
    required String supervisorEmail,
    required String levelId,
    required String admSupervisorName,
    required String admSupervisorMobileNo,
    required String admSupervisorEmail,
    required String supervisorId,
    required String admSupervisorId,
    required String roleAsShortRole,

}) async {
    try {
      isLoading(true);


      var data = await ApiService. validateBankerRegistrationRoleApi(bankId, branchId,shortName);


      if(data['success'] == true){

        validateBankerRegRoleModel= ValidateBankerRegRoleModel.fromJson(data);
        



        ToastMessage.msg(validateBankerRegRoleModel!.message!);
        addUserApi(
          bankId: bankId,
          branchId: branchId,
          shortName: shortName,
          firstName: firstName,
          lastName: lastName,
          emailId: emailId,
          password: password,
          phoneNumber: phoneNumber,
          role: role,
          userName: userName,

          id:id,
          bankerCode:bankerCode,
          bankerName:bankerName,
          contactNo:contactNo,
          whatsappNo:whatsappNo,
          email:email,
          supervisorName:supervisorName,
          supervisorMobileNo:supervisorMobileNo,
          supervisorEmail:supervisorEmail,
          levelId:levelId,
          admSupervisorName:admSupervisorName,
          admSupervisorMobileNo:admSupervisorMobileNo,
          admSupervisorEmail:admSupervisorEmail,
          supervisorId:supervisorId,
          admSupervisorId:admSupervisorId,
          roleAsShortRole:roleAsShortRole,

        );
        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error validateBankerRegistrationRoleApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  void  addUserApi({
    required String bankId,
    required String branchId,
    required String shortName,
    required String firstName,
    required String lastName,
    required String emailId ,
    required String phoneNumber,
    required String password,
    required String role,
    required String userName,

    required String id,
    required String bankerCode,
    required String bankerName,
    required String contactNo,
    required String whatsappNo,
    required String email,
    required String supervisorName,
    required String supervisorMobileNo,
    required String supervisorEmail,
    required String levelId,
    required String admSupervisorName,
    required String admSupervisorMobileNo,
    required String admSupervisorEmail,
    required String supervisorId,
    required String admSupervisorId,
    required String roleAsShortRole,
  }) async {
    try {
      isLoading(true);


      var data = await ApiService. addUserApi(
        role: roleAsShortRole,
        phoneNumber: phoneNumber,
        password: password,
        lastName: lastName,
        firstName: firstName,
        emailId: emailId,
        userName: userName
      );


      if(data['success'] == true){

        addUserModel= AddUserModel.fromJson(data);
        
        ToastMessage.msg(addUserModel!.message!);
        isLoading(false);
        bankersRegistrationApi(
          bankId: bankId,
          branchId: branchId,
          shortName: shortName,
          firstName: firstName,
          lastName: lastName,
          emailId: emailId,
          password: password,
          phoneNumber: phoneNumber,
          role: role,
          userName: userName,

          id:id,
          bankerCode:bankerCode,
          bankerName:bankerName,
          contactNo:contactNo,
          whatsappNo:whatsappNo,
          email:email,
          supervisorName:supervisorName,
          supervisorMobileNo:supervisorMobileNo,
          supervisorEmail:supervisorEmail,
          levelId:levelId,
          admSupervisorName:admSupervisorName,
          admSupervisorMobileNo:admSupervisorMobileNo,
          admSupervisorEmail:admSupervisorEmail,
          supervisorId:supervisorId,
          admSupervisorId:admSupervisorId,
          roleAsShortRole:roleAsShortRole,
        );

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addUserApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }



  void  bankersRegistrationApi({
    required String bankId,
    required String branchId,
    required String shortName,
    required String firstName,
    required String lastName,
    required String emailId ,
    required String phoneNumber,
    required String password,
    required String role,
    required String userName,

    required String id,
    required String bankerCode,
    required String bankerName,
    required String contactNo,
    required String whatsappNo,
    required String email,
    required String supervisorName,
    required String supervisorMobileNo,
    required String supervisorEmail,
    required String levelId,
    required String admSupervisorName,
    required String admSupervisorMobileNo,
    required String admSupervisorEmail,
    required String supervisorId,
    required String admSupervisorId,
    required String roleAsShortRole,
  }) async {
    try {
      isLoading(true);


      var data = await ApiService. bankersRegistrationApi(
        bankId: bankId,
        branchId: branchId,
        role: role,
        shortRole: shortName,

        id:id,
        bankerCode:bankerCode,
        bankerName:bankerName,
        contactNo:contactNo,
        whatsappNo:whatsappNo,
        email:email,
        supervisorName:supervisorName,
        supervisorMobileNo:supervisorMobileNo,
        supervisorEmail:supervisorEmail,
        levelId:levelId,
        admSupervisorName:admSupervisorName,
        admSupervisorMobileNo:admSupervisorMobileNo,
        admSupervisorEmail:admSupervisorEmail,
        supervisorId:supervisorId,
        admSupervisorId:admSupervisorId,
      );


      if(data['success'] == true){

        bankersRegistrationModel= BankersRegistrationModel.fromJson(data);

        ToastMessage.msg(bankersRegistrationModel!.message!);
        isLoading(false);
        sendMailForVerificationApi(
          bankerId:bankersRegistrationModel!.data![0].id.toString()
        );

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error bankersRegistrationApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  void  sendMailForVerificationApi({
    required String bankerId,

  }) async {
    try {
      isLoading(true);


      var data = await ApiService.sendMailForVerificationApi(bankerId: bankerId,);


      if(data['success'] == true){

        sendMailForVerificationModel= SendMailForVerificationModel.fromJson(data);

        ToastMessage.msg(sendMailForVerificationModel!.message!);
        isLoading(false);
        sendMailToBankerAfterRegistrationApi(
          bankerId: bankerId
        );

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error sendMailForVerificationApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  void  sendMailToBankerAfterRegistrationApi({
    required String bankerId,

  }) async {
    try {
      isLoading(true);


      var data = await ApiService.sendMailToBankerAfterRegistrationApi(bankerId: bankerId,);


      if(data['success'] == true){

        sendMailToBankerAfterRegModel= SendMailToBankerAfterRegModel.fromJson(data);

        ToastMessage.msg(sendMailToBankerAfterRegModel!.message!);
        isLoading(false);
        CustomDialog.show(
            customIcon: Icons.check_circle,
            iconColor: Colors.green,
            message: AppText.registrationsuccessfulMsg,
            okButtonText: AppText.ok,
            title: AppText.message,
            onOkPressed: (){
              Get.offAllNamed("/login");
            }
        );

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error sendMailToBankerAfterRegistrationApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }
}
