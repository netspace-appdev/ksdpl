
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:ksdpl/controllers/registration_dd_controller.dart';
import '../../models/drawer/AddCompanyProfileModel.dart';
import '../../models/drawer/EditBankerRegistrationModel.dart';
import '../../models/drawer/GetBankerByIdModel.dart';
import '../../models/drawer/GetCompanyProfileModel.dart';
import '../../services/drawer_api_service.dart';


class EditProfileController extends GetxController {

  var isLoading = false.obs;

  final RegistrationDDController regDDController= Get.put(RegistrationDDController());


  final TextEditingController lenderCodeController = TextEditingController();
  final TextEditingController lenderNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  //final TextEditingController whatsappNoController = TextEditingController();
  //final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  final TextEditingController functionalSupervisorMobileController = TextEditingController();
  final TextEditingController functionalSupervisorEmailController = TextEditingController();

  final TextEditingController adminSupervisorMobileController = TextEditingController();
  final TextEditingController adminSupervisorEmailController = TextEditingController();

  ///KSDPL
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController founderNameController = TextEditingController();
  final TextEditingController ceoNameController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();
  final TextEditingController foundingDateController = TextEditingController();
  final TextEditingController headquartLocationController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phNoController = TextEditingController();
  final TextEditingController whatsappNoController = TextEditingController();
  final TextEditingController faxController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController companyAddressController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController panNumberController = TextEditingController();
  final TextEditingController cinNumberController = TextEditingController();
  final TextEditingController mapIntegrationEmbedCodeController = TextEditingController();
  final TextEditingController privacyPolicyController = TextEditingController();
  final TextEditingController tncController = TextEditingController();


  final TextEditingController createdDateController = TextEditingController();
  final TextEditingController createdByController = TextEditingController();
  final TextEditingController updateDateController = TextEditingController();
  final TextEditingController updatedByController = TextEditingController();


  var levelId = Rxn<String>();
  var shortRole = Rxn<String>();

  var bankNameDD = Rxn<String>();
  var branchNameDD = Rxn<String>();
  var roleLevelDD = Rxn<String>();


  EditBankerRegistrationModel? editBankerRegistrationModel;


  GetBankerByIdModel? getBankerByIdModel;

  GetCompanyProfileModel? getCompanyProfileModel;
  AddCompanyProfileModel? addCompanyProfileModel;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCompanyProfileApi();
  }



  void  getBankerByIdApi({
    required String bankerId,

  }) async {

    try {
      isLoading(true);
      var data = await DrawerApiService.getBankerByIdApi(bankerId: bankerId,);
      if(data['success'] == true){

        getBankerByIdModel= GetBankerByIdModel.fromJson(data);
        lenderCodeController.text=getBankerByIdModel!.data![0].bankerCode.toString();
        isLoading(false);

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

  void  editBankerRegistrationApi({
    required String id,
    required String bankId,
    required String branchId,
    required String bankerCode,
    required String bankerName,
    required String contactNo,
    required String whatsappNo,
    required String email,
    required String supervisorId,
    required String admSupervisorId,
    required String supervisorName,
    required String supervisorMobileNo,
    required String supervisorEmail,
    required String admSupervisorName,
    required String admSupervisorMobileNo,
    required String admSupervisorEmail,
    required String role,
    required String shortRole,
    required String levelId,

  }) async {

    try {
      isLoading(true);


      var data = await DrawerApiService.editBankerRegistrationApi(
          id:id,
          bankId:bankId,
          branchId:branchId,
          bankerCode:bankerCode,
          bankerName:bankerName,
          contactNo:contactNo,
          whatsappNo:whatsappNo,
          email:email,
          supervisorId:supervisorId,
          admSupervisorId:admSupervisorId,
          supervisorName:supervisorName,
          supervisorMobileNo:supervisorMobileNo,
          supervisorEmail:supervisorEmail,
          admSupervisorName:admSupervisorName,
          admSupervisorMobileNo:admSupervisorMobileNo,
          admSupervisorEmail:admSupervisorEmail,
          role:role,
          shortRole:shortRole,
          levelId:levelId,
      );


      if(data['success'] == true){

        editBankerRegistrationModel= EditBankerRegistrationModel.fromJson(data);


        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error editBankerRegistrationApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

  ///KSDPL


  void  getCompanyProfileApi() async {

    try {
      isLoading(true);


      var data = await DrawerApiService.getCompanyProfileApi();


      if(data['success'] == true){

        getCompanyProfileModel= GetCompanyProfileModel.fromJson(data);


        companyNameController.text=getCompanyProfileModel!.data![0].companyName.toString();
        founderNameController.text=getCompanyProfileModel!.data![0].founderName.toString();
        ceoNameController.text=getCompanyProfileModel!.data![0].ceoname.toString();
        taglineController.text=getCompanyProfileModel!.data![0].tagline.toString();
        foundingDateController.text=getCompanyProfileModel!.data![0].foundingDate.toString();
        headquartLocationController.text=getCompanyProfileModel!.data![0].headquartersLocation.toString();
        emailController.text=getCompanyProfileModel!.data![0].email.toString();
        phNoController.text=getCompanyProfileModel!.data![0].phoneNo.toString();
        whatsappNoController.text=getCompanyProfileModel!.data![0].whatsAppNo.toString();
        faxController.text=getCompanyProfileModel!.data![0].fax.toString();
        websiteController.text=getCompanyProfileModel!.data![0].websiteUrl.toString();
        linkedInController.text=getCompanyProfileModel!.data![0].linkedIn.toString();
        facebookController.text=getCompanyProfileModel!.data![0].facebook.toString();
        twitterController.text=getCompanyProfileModel!.data![0].twitter.toString();
        companyAddressController.text=getCompanyProfileModel!.data![0].companyAddress.toString();
        gstNumberController.text=getCompanyProfileModel!.data![0].gstnumber.toString();
        panNumberController.text=getCompanyProfileModel!.data![0].pannumber.toString();
        cinNumberController.text=getCompanyProfileModel!.data![0].cinnumber.toString();
        mapIntegrationEmbedCodeController.text=getCompanyProfileModel!.data![0].mapIntegration.toString();
        privacyPolicyController.text=getCompanyProfileModel!.data![0].privacyPolicy.toString();
        tncController.text=getCompanyProfileModel!.data![0].termsAndConditions.toString();


        createdDateController.text=getCompanyProfileModel!.data![0].createdDate.toString();
        createdByController.text=getCompanyProfileModel!.data![0].createdBy.toString();
        updateDateController.text=getCompanyProfileModel!.data![0].updateDate.toString();
        updateDateController.text=getCompanyProfileModel!.data![0].updateDate.toString();
        updatedByController.text=getCompanyProfileModel!.data![0].updatedBy.toString();


        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getCompanyProfileApi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }


  void  addCompanyProfileApi({
    required String id,
    required String companyName,
    required String founderName,
    required String ceoName,
    required String tagline,
    required String foundingDate,
    required String headquartersLocation,
    required String email,
    required String phoneNo,
    required String whatsAppNo,
    required String fax,
    required String websiteURL,
    required String linkedIn,
    required String facebook,
    required String twitter,
    required String companyAddress,
    required String mapIntegration,
    required String privacyPolicy,
    required String termsAndConditions,
    required String gstNumber,
    required String panNumber,
    required String cinNumber,
    required String createdDate,
    required String createdBy,
    required String updateDate,
    required String updatedBy,

  }) async {

    try {
      isLoading(true);


      var data = await DrawerApiService.addCompanyProfileApi(
          id : id,
          companyName : companyName,
          founderName : founderName,
          ceoName : ceoName,
          tagline : tagline,
          foundingDate : foundingDate,
          headquartersLocation : headquartersLocation,
          email : email,
        phoneNo : phoneNo,
        whatsAppNo : whatsAppNo,
        fax : fax,
        websiteURL: websiteURL,
        linkedIn : linkedIn,
        facebook : facebook,
        twitter : twitter,
        companyAddress : companyAddress,
        mapIntegration : mapIntegration,
        privacyPolicy : privacyPolicy,
        termsAndConditions : termsAndConditions,
        gstNumber : gstNumber,
        panNumber : panNumber,
        cinNumber : cinNumber,
        createdDate : createdDate,
        createdBy : createdBy,
        updateDate : updateDate,
        updatedBy : updatedBy,

      );


      if(data['success'] == true){

        addCompanyProfileModel= AddCompanyProfileModel.fromJson(data);


        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error addCompanyProfileAPi: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }

}
