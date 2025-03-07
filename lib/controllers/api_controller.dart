
import 'package:get/get.dart';

import '../../services/home_service.dart';

import '../models/CategoryListModel.dart';
import '../models/ProductListModel.dart';
import '../models/SliderModel.dart';


class ApiController extends GetxController {
  var isLoading = true.obs;
  SliderModel? sliderModel;
  CategoryListModel? categoryListModel;
  ProductListModel? productListModel;
  @override
  void onInit() {
   /* fetchItems();
    fetchCategory();*/

    super.onInit();
  }

  void fetchItems() async {
    try {
      isLoading(true);

      // Fetch data from API
      var itemList = await ApiService.fetchSliderItems();
      print("Fetched Data: $itemList");
      sliderModel= SliderModel.fromJson(itemList);
      print(" sliderModel: ${sliderModel!.data!.first.sliderImage}");

    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to fetch data');
    } finally {
      isLoading(false);
    }
  }

  void fetchCategory() async {
    try {
      isLoading(true);

      // Fetch data from API
      var itemList = await ApiService.fetchCategory();
      print("Fetched Data: $itemList");
      categoryListModel= CategoryListModel.fromJson(itemList);
      print(" sliderModel: ${categoryListModel!.data!.first.categoryThumimage}");

    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to fetch data');

    } finally {
      isLoading(false);
    }
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
}
