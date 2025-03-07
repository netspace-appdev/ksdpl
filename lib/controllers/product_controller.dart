import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../services/home_service.dart';
import '../models/ProductListModel.dart';

class ProductController extends GetxController{
  var isLoading=true.obs;
  ProductListModel? productListModel;
  @override
  void onInit() {
   dynamic arg= Get.arguments;
   fetchProduct(arg["productId"]);
   //Helper.isConnected(fetchProduct(arg["productId"]));
    super.onInit();
  }
  void fetchProduct(String catId) async {
    try {
      isLoading(true);

      // Fetch data from API
      var itemList = await ApiService.fetchProduct(catId);
      print("Fetched Data: $itemList");
      productListModel= ProductListModel.fromJson(itemList);
      print(" productTitle: ${productListModel!.data!.first.productTitle}");

    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to fetch data');

    } finally {
      isLoading(false);
    }
  }
  Future<bool> _isConnected() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) return false;

      // Further check if the internet is actually working
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}