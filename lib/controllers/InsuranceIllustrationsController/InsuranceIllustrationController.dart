import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksdpl/models/getAllInsuranceIllustrationsModel/GetAllInsuranceIllustrationsModel.dart';

import '../../common/helper.dart';
import '../../services/insuranceIllustrationService.dart';
import '../../services/product_service.dart';

class InsuranceIllustrationController extends GetxController {


  var isLoadingMainScreen = false.obs;
  // var getProductListById = Rxn<GetProductListById>(); //

  var getInsuranceLeadsModel = Rxn<GetAllInsuranceIllustrationsModel>();



  void  getInsuranceIllustrationApi() async {
    try {
      isLoadingMainScreen(true);

      var data = await Insuranceillustrationservice.getInsuranceLeadsApi();

      if(data['success'] == true){

        getInsuranceLeadsModel.value= GetAllInsuranceIllustrationsModel.fromJson(data);

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
