

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/controllers/loan_appl_controller/family_member_model_controller.dart';
import 'package:ksdpl/controllers/product/view_product_controller.dart';
import 'package:ksdpl/custom_widgets/SnackBarHelper.dart';
import 'package:ksdpl/services/product_service.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/CustomOptionalChipTextField.dart';
import '../../models/GetVacancyListModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/loan_application/AddLoanApplicationModel.dart';
import '../../models/loan_application/GetLoanApplIdModel.dart';
import '../../models/loan_application/special_model/CoApplicantModel.dart';
import '../../models/loan_application/special_model/CreditCardModel.dart';
import '../../models/loan_application/special_model/FamilyMemberModel.dart';
import '../../models/loan_application/special_model/ReferenceModel.dart';
import '../../models/product/AddProductListModel.dart';
import '../../models/product/GetAllCommonDocumentModel.dart' as commanDoc;
import '../../models/product/GetAllNegativeProfileModel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import '../../models/product/GetAllNegativeProfileModel.dart' as negProfile;
import '../../models/product/GetAllProductCategoryModel.dart';
import '../../models/product/GetDocumentProductIdModel.dart' as getDoc;
import '../../models/product/GetProductListById.dart';
import '../../models/product/AddProductDocumentModel.dart';
import '../../services/loan_appl_service.dart';
import '../loan_appl_controller/co_applicant_detail_mode_controllerl.dart';
import '../../services/drawer_api_service.dart';
import 'package:flutter/material.dart';

import '../loan_appl_controller/credit_cards_model_controller.dart';
import '../loan_appl_controller/reference_model_controller.dart';
import '../../models/product/GetProductListById.dart';

class Vacancylistcontroller extends GetxController{
  var isLoadingMainScreen = false.obs;
 // var getProductListById = Rxn<GetProductListById>(); //

  var getDocumentProductIdModel = Rxn<GetVacancyListModel>();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getAllVacancyApi();
  }

  void  getAllVacancyApi() async {
    try {
      isLoadingMainScreen(true);

      var data = await ProductService.getAllVacancyRequestApi();

      if(data['success'] == true){

        getDocumentProductIdModel.value= GetVacancyListModel.fromJson(data);

       /* List<> allDocuments = getDocumentProductIdModel.value!.data!;

        /// Now split
        List<commanDoc.Data> commonDocument = allDocuments
            .where((doc) => doc.documentCategoryId == 1)
            .map((doc) => commanDoc.Data(
          commonDocument1: doc.documentName ?? '',
          documentType: doc.documentType?.trim() ?? '',
        ))
            .toList();

        List<ChipData> additionalDocs = allDocuments
            .where((doc) => doc?.documentCategoryId == 2)
            .map((doc) => ChipData(
          text: doc.documentName ?? '',
          isMandatory: (doc.documentType?.trim().toLowerCase() ?? '') == 'm',
        ))
            .toList();

       selectedCommonDoc.value=commonDocument;
        selectedAdditionalDocs=additionalDocs;
*/

        isLoadingMainScreen(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoadingMainScreen(false);
    } finally {

      isLoadingMainScreen(false);
    }
  }

}