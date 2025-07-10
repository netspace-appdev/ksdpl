import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/models/camnote/GetProductDetailsByFilterModel.dart' as pdFModel;
import 'package:ksdpl/services/product_service.dart';

import '../../common/helper.dart';
import '../../models/IndividualLeadUploadModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/product/GetAllProductListModel.dart';
import '../../models/product/GetProductListById.dart'as gpli;
import '../../services/drawer_api_service.dart';
import '../../services/lead_api_service.dart';
import '../registration_dd_controller.dart';

class ProductDetailsController extends GetxController{

  var isLoading = false.obs;
  var getProductListById = Rxn<gpli.GetProductListById>(); //

  void  getProductListByIdApi({
    required String id
}) async {
    try {
      isLoading(true);

      var data = await ProductService.getProductListByIdApi(id: id);

      if(data['success'] == true){
        print("hello 11=======>");



        getProductListById.value= gpli.GetProductListById.fromJson(data);
        /*print("hello 12=======>");
        CamNoteController camNoteController=Get.put(CamNoteController());
        print("hello 0=======>${camNoteController.getProductDetailsByFilterModel.value.toString()}");
        if(camNoteController.getProductDetailsByFilterModel.value!=null){
          print("hello 1=======>${camNoteController.getProductDetailsByFilterModel.value!}");
          final existingList = camNoteController.getProductDetailsByFilterModel.value!.data ?? [];
          print("hello 2=======>${existingList}");
          final productData = getProductListById.value!.data;
          print("hello 3=======>${productData}");
          if (productData != null) {
            print("hello 4=======>${productData}");
            existingList.add(productData.toFilterData());
            print("hello 5=======>${existingList}");
            camNoteController.getProductDetailsByFilterModel.value = pdFModel.GetProductDetailsByFilterModel(
              status: getProductListById.value!.status,
              success: getProductListById.value!.success,
              message: getProductListById.value!.message,
              data: existingList,
            );
          }
        }*/


        isLoading(false);

      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isLoading(false);
    } finally {

      isLoading(false);
    }
  }



}



/*extension ProductDataMapper on gpli.Data {
  pdFModel.Data toFilterData() {
    return pdFModel.Data(
      id: id,
      bankId: bankId,
      bankersName: bankersName,
      bankersMobileNumber: bankersMobileNumber,
      bankersWhatsAppNumber: bankersWhatsAppNumber,
      bankersEmailID: bankersEmailID,
      minCIBIL: minCIBIL,
      segmentVertical: segmentVertical,
      product: product,
      productDescription: productDescription,
      customerCategory: customerCategory,
      collateralSecurityCategory: collateralSecurityCategory,
      collateralSecurityExcluded: collateralSecurityExcluded,
      incomeTypes: incomeTypes,
      profileExcluded: profileExcluded,
      ageLimitEarningApplicants: ageLimitEarningApplicants,
      ageLimitNonEarningCoApplicant: ageLimitNonEarningCoApplicant,
      minimumAgeEarningApplicants: minimumAgeEarningApplicants,
      minimumAgeNonEarningApplicants: minimumAgeNonEarningApplicants,
      minimumIncomeCriteria: minimumIncomeCriteria,
      minimumLoanAmount: minimumLoanAmount,
      maximumLoanAmount: maximumLoanAmount,
      minTenor: minTenor,
      maximumTenor: maximumTenor,
      minimumROI: minimumROI,
      maximumROI: maximumROI,
      maximumTenorEligibilityCriteria: maximumTenorEligibilityCriteria,
      geoLimit: geoLimit,
      negativeProfiles: negativeProfiles,
      negativeAreas: negativeAreas,
      maximumTAT: maximumTAT,
      minimumPropertyValue: minimumPropertyValue,
      maximumIIR: maximumIIR,
      maximumFOIR: maximumFOIR,
      maximumLTV: maximumLTV,
      processingFee: processingFee,
      legalFee: legalFee,
      technicalFee: technicalInspectionFee, // careful: different name
      adminFee: adminFee,
      foreclosureCharges: foreclosureCharges,
      otherCharges: otherCharges,
      stampDuty: stampDuty,
      tsRYears: tsRYears,
      tsRCharges: tsRCharges,
      valuationCharges: valuationCharges,
      noOfDocument: noOfDocument,
      productValidateFromDate: productValidateFromDate,
      productValidateToDate: productValidateToDate,
      ksdplProductId: ksdplProductId,
      profitPercentage: profitPercentage,
      bankName: bankName,
      ksdplProduct: ksdplProductName,
      productSegment: productCategoryName,
      specialBranchId: null, // You can map this if needed later
    );
  }
}*/
