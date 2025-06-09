import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';
import 'package:ksdpl/services/product_service.dart';

import '../../common/helper.dart';
import '../../models/IndividualLeadUploadModel.dart';
import '../../models/drawer/GetLeadDetailModel.dart';
import '../../models/product/GetAllProductListModel.dart' as prod;
import '../../services/drawer_api_service.dart';
import '../../services/lead_api_service.dart';
import '../registration_dd_controller.dart';

class ViewProductController extends GetxController{

  var isLoading = false.obs;
  var getAllProductListModel = Rxn<prod.GetAllProductListModel>(); //
  var isMainListMoreLoading = false.obs;
  RxBool hasMore = true.obs;
  RxInt currentPage = 1.obs;
  final int pageSize = 20;
  RxString searchQuery = "".obs;
  RxList<prod.Data> loanProductList = <prod.Data>[].obs;
  final TextEditingController vpProductNameController = TextEditingController();
  final TextEditingController vpMinCibilController = TextEditingController();
  var selectedBank = Rxn<int>();
  var selectedProdSegment = Rxn<int>();
  var selectedKsdplProduct = Rxn<int>();
  var isLoadingProductSegment = false.obs;

  List<prod.Data> get filteredProducts {
    final query = searchQuery.value.toLowerCase();
    final allProducts = getAllProductListModel.value?.data ?? [];
    if (query.isEmpty) return allProducts;

    return allProducts.where((product) {
      return (product.product?.toLowerCase().contains(query) ?? false) ||
          (product.bankName?.toLowerCase().contains(query) ?? false) ||
          (product.minCIBIL?.toString().contains(query) ?? false) ||
          (product.productCategoryName?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  void submitFilter() {
    print("vpProductNameController.text===>${vpProductNameController.text}");
    getAllProductListApi(
        bankId: selectedBank.value.toString(),
        minCibil:  vpMinCibilController.text,
        product: vpProductNameController.text,
        KsdplProductId: selectedProdSegment.value.toString(),
        segment: selectedProdSegment.value.toString()
    );
  }
  void clearForm() {
    // Clear text fields
    vpMinCibilController.clear();
    vpProductNameController.clear();
    selectedBank.value=null;
    selectedProdSegment.value=null;
    selectedKsdplProduct.value=null;
  }


  clearFilter(){

    selectedBank.value=0;
    selectedProdSegment.value=0;
    selectedProdSegment.value=0;
    vpMinCibilController.text="";
    vpProductNameController.text="";


    getAllProductListApi(
        bankId: selectedBank.value.toString(),
        minCibil:  vpMinCibilController.text,
        product: vpProductNameController.text,
        KsdplProductId: selectedProdSegment.value.toString(),
        segment: selectedProdSegment.value.toString()
    );
  }
  void  getAllProductListApi({
    bool isLoadMore = false,
    String? bankId,
    String? minCibil,
    String? segment,
    String? product,
    String? KsdplProductId,
}) async {
    try {

      if (isMainListMoreLoading.value || (!hasMore.value && isLoadMore)) return;

      isMainListMoreLoading(true);

      if (!isLoadMore) {
        currentPage.value = 1; // Reset to first page on fresh load
        hasMore.value = true;
      }
      var data = await ProductService.getAllProductListApi(
        pageNumber: currentPage.value,
        pageSize: pageSize,
        product: product,
        segment: segment,
        KsdplProductId: KsdplProductId,
        minCibil: minCibil,
        bankId: bankId
      );

      if (data['success'] == true) {
        var newLeads = prod.GetAllProductListModel.fromJson(data);

        if (isLoadMore) {
          getAllProductListModel.value!.data!.addAll(newLeads.data!);
        } else {
          getAllProductListModel.value = newLeads;
        }

        ///only for dropdown data
        final List<prod.Data> allLoanProd =  getAllProductListModel.value?.data ?? [];

        final List<prod.Data> loanProds = allLoanProd.where((cat) => cat.active == true).toList();

        loanProductList.value = loanProds;
        ///dd end


        if (newLeads.data!.length < pageSize) {
          hasMore.value = false;
        } else {
          currentPage.value++; // Ready for next page
        }

        clearForm();
       // leadListLength.value=getAllLeadsModel.value!.data!.length;
      } else if (data['success'] == false && (data['data'] as List).isEmpty) {
        clearForm();
        getAllProductListModel.value = null;
        hasMore.value = false;
      } else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getAllProductListModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);
      isMainListMoreLoading(false);
    } finally {

      isMainListMoreLoading(false);
    }
  }

}