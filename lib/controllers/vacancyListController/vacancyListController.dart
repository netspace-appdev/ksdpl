

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:get/get.dart';

import 'package:ksdpl/services/product_service.dart';
import '../../common/helper.dart';
import '../../models/GetVacancyListModel.dart';


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