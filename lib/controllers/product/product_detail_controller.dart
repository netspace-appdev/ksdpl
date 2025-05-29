import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/services/product_service.dart';

import '../../common/helper.dart';
import '../../models/IndividualLeadUploadModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/product/GetAllProductListModel.dart';
import '../../models/product/GetProductListById.dart';
import '../../services/drawer_api_service.dart';
import '../../services/lead_api_service.dart';
import '../registration_dd_controller.dart';

class ProductDetailsController extends GetxController{

  var isLoading = false.obs;
  var getProductListById = Rxn<GetProductListById>(); //

  void  getProductListByIdApi({
    required String id
}) async {
    try {
      isLoading(true);

      var data = await ProductService.getProductListByIdApi(id: id);

      if(data['success'] == true){



        getProductListById.value= GetProductListById.fromJson(data);

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