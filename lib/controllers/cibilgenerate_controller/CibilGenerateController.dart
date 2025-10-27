import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
import 'package:ksdpl/services/generate_cibil_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../home/RestrictedWebView.dart';
import '../../models/GenerateCibilResponseModel.dart';
import '../../models/camnote/GetAllPackageMasterModel.dart' as cibilPackagrList;

class CibilGenerateController extends GetxController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController camReceivableDateController = TextEditingController();
  final TextEditingController camFullNameController = TextEditingController();
  final TextEditingController camCibilMobController = TextEditingController();
  final TextEditingController camTotalOverdueAmountController = TextEditingController(); // it will be replace by camAmountRecoveredController
  final TextEditingController camAmountRecoveredController = TextEditingController();
  final TextEditingController camTransactionDetailsController = TextEditingController();

  final TextEditingController qrCBCustomerNameController = TextEditingController();
  final TextEditingController qrCBWhatsappController = TextEditingController();
  var isLoading=false.obs;
  var generateCibilResponseModel = Rxn<GenerateCibilResponseModel>(); //
  var getAllPackageMasterModel = Rxn<cibilPackagrList.GetAllPackageMasterModel>(); //
  var isPackageMasterLoading=false.obs;
  RxList<cibilPackagrList.Data> packageMasterList = <cibilPackagrList.Data>[].obs;
  var selectedCibilPackage = Rxn<int>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPackageMasterApi();
  }

  Future<void> addCustomerCibilRequestApi() async {
    print('data is here');

    try {
      isLoading(true);

      String? empId = StorageService.get(StorageService.EMPLOYEE_ID);

      var data = await GenerateCibilServices.addCustomerCibilRequestApi(
        Id: '0', // If there's no ID at creation time, leave it blank or pass null
        Name: camFullNameController.text.trim(),
        Mobile: camCibilMobController.text.trim(),
        Amount: camAmountRecoveredController.text.trim(),// camTotalOverdueAmountController
        ReceiveDate: camReceivableDateController.text.trim(),
        Utr: camTransactionDetailsController.text.trim(),
        User_ID: empId ?? '',
        PackageId: (selectedCibilPackage.value??0).toString(),

      );

      if (data['success'] == true) {
        generateCibilResponseModel.value = GenerateCibilResponseModel.fromJson(data);
        //ToastMessage.msg(data['message']);
        await _launchURL(generateCibilResponseModel.value?.data?.cibilData?.redirectUrl??'');
        isLoading(false);
      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        // Handle empty case
        ToastMessage.msgRed(data['message'] ?? AppText.somethingWentWrong);

      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in updateBankerDetailApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }



  void  getAllPackageMasterApi() async {
    try {
      isPackageMasterLoading(true);

      var data = await GenerateCibilServices.getAllPackageMasterApi();

      if(data['success'] == true){


        getAllPackageMasterModel.value= cibilPackagrList.GetAllPackageMasterModel.fromJson(data);

        final List<cibilPackagrList.Data> allComDoc = getAllPackageMasterModel.value?.data ?? [];

        final List<cibilPackagrList.Data> activeAllPackage = allComDoc.where((cat) => cat.active == true && cat.id==(BaseUrl.devVersion=="UAT"?2:9)).toList();

        packageMasterList.value = activeAllPackage;

        isPackageMasterLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isPackageMasterLoading(false);
    } finally {

      isPackageMasterLoading(false);
    }
  }
  _launchURL(String url) async {

    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

