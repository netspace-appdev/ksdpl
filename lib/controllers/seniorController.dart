import 'package:get/get.dart';
import 'package:ksdpl/models/GetChannelDetailsByProductIdModel.dart';


import '../common/helper.dart';
import '../models/GetSeniorListModel.dart' as senorList;
import '../models/JobRoleModelResponse.dart';
import '../services/product_service.dart';

class SeniorScreenController extends GetxController{

  final isLoadingMainScreen = false.obs;

  final Rxn<senorList.GetSeniorListModel> seniorListModel = Rxn<senorList.GetSeniorListModel>();
  final Rxn<GetChannelDetailsByProductIdModel> getChannelDetailsByProduct = Rxn<GetChannelDetailsByProductIdModel>();

  final Set<String> excludedRoles = {
    "INDEPENDENT BUSINESS MANAGER",
    "CHANNEL BUSINESS MANAGER",
  };
  RxList<senorList.Data> seniorFilteredList = <senorList.Data>[].obs;

 /*
  List<Data> get seniorFilteredList {
    final list = seniorListModel.value?.data ?? [];

    return list.where((item) {
      final role = item.jobRole?.trim();
      return role == null || !excludedRoles.contains(role);
    }).toList();
  }*/


  final selectedState = Rxn<String>();
  final selectedDistrict = Rxn<String>();
  final selectedCity = Rxn<String>();

  var selectedChannel = Rxn<int>();
  var isChannelDisable =Rxn<bool>();
  var selectedJobroleId = Rxn<String>();
  final isLoadingProductCategory = false.obs;

  var selectedProductCategory = Rxn<int>();

  Future<void> getAllSeniorListApi({
    String? stateId,
    String? districtId,
    String? cityId,
    String? pincode,
    String? jobrole,
    String? channelId,
}) async {
    try {
      isLoadingMainScreen.value = true;
      final data = await ProductService.getAllSeniorListRequestApi(
        stateId:stateId,
        districtId:districtId,
        cityId:cityId,
        pincode:pincode,
        jobrole:jobrole,
        channelId:channelId,
      );

      if (data['success'] == true) {
        seniorListModel.value = senorList.GetSeniorListModel.fromJson(data);

        final List<senorList.Data> li = seniorListModel.value?.data ?? [];


        seniorFilteredList.value = li.where((item) {
          final role = item.jobRole?.trim();

          return item.active == true &&
              (role == null || !excludedRoles.contains(role));
        }).toList();



      } else {
        seniorListModel.value?.data?.clear();
        seniorFilteredList.clear();
        ToastMessage.msg(
          data['message'] ?? AppText.somethingWentWrong,
        );
      }
    } catch (e) {
      print("Error getAllSeniorListApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoadingMainScreen.value = false;
    }
  }



  void filterSubmit() {

    getAllSeniorListApi(
      stateId:selectedState.value.toString(),
      districtId:selectedDistrict.value.toString(),
      cityId:selectedCity.value.toString(),
      channelId: selectedChannel.value.toString(),
      jobrole: selectedJobroleId.value.toString(),
      pincode:""

    );
  }


  Future<bool> getChannelDetailsByProductIdApiRequest({
    String? ProductId,
  }) async {
    try {
      isLoadingMainScreen.value = true;
      final data = await ProductService.getChannelDetailsByProductIdRequest(
        ProductId:ProductId,
      );

      print('data is here ${data.toString()}');
      if (data['success'] == true) {
        getChannelDetailsByProduct.value = GetChannelDetailsByProductIdModel.fromJson(data);
        final channelId = getChannelDetailsByProduct.value?.data?.first.channelId;


        if (channelId != null) {

          selectedChannel.value = channelId;

        }else{
          selectedChannel.value = 0;
        }

        print("Selected channel in API: ${selectedChannel.value}");
        isChannelDisable.value =true;
        return true; // 🎉 success
      } else {
        selectedChannel.value = 0;
        isChannelDisable.value =true;
        ToastMessage.msg(
          data['message'] ?? AppText.somethingWentWrong,
        );
        return false; // 🎉 success
      }
    } catch (e) {
      print("Error getAllSeniorListApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
      return false; // 🎉 success
    } finally {
      isLoadingMainScreen.value = false;
    }
  }

  void filterClear() {

    selectedDistrict.value="0";
    selectedCity.value="0";
    selectedState.value="0";
    selectedChannel.value=0;
    isChannelDisable.value=false;
    selectedJobroleId.value="";
    selectedProductCategory.value=0;

    filterSubmit();
  }
}