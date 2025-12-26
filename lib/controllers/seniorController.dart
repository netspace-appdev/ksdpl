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
       // seniorFilteredList.value = List<senorList.Data>.from(li);


        seniorFilteredList.value = li .where((item) {
          final role = item.jobRole?.trim();
          return role == null || !excludedRoles.contains(role);
        }).toList();

        filterClear();

      } else {
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

/*  Future<void> getAllSeniorListApi() async {
    try {
      isLoadingMainScreen.value = true;

      final data = await ProductService.getAllSeniorListRequestApi();

      if (data['success'] == true) {
        seniorListModel.value = senorList.GetSeniorListModel.fromJson(data);

        final List<senorList.Data> li = seniorListModel.value?.data ?? [];
        // seniorFilteredList.value = List<senorList.Data>.from(li);


        seniorFilteredList.value = li .where((item) {
          final role = item.jobRole?.trim();
          return role == null || !excludedRoles.contains(role);
        }).toList();



      } else {
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
  }*/

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


  Future<void> getChannelDetailsByProductIdApiRequest({
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
        //selectedChannel.value = null;
        await Future.delayed(const Duration(milliseconds: 10));

        selectedChannel.value = channelId;
        isChannelDisable.value =true;
      } else {
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

  void filterClear() {
   /* final selectedState = Rxn<String>();
    final selectedDistrict = Rxn<String>();
    final selectedCity = Rxn<String>();

    var selectedChannel = Rxn<int>();
    var isChannelDisable =Rxn<bool>();
    var selectedJobroleId = Rxn<String>();*/
    selectedDistrict.value=null;
    selectedCity.value=null;
    selectedState.value=null;
    selectedChannel.value=0;
    isChannelDisable.value=false;
    selectedJobroleId.value=null;
    selectedProductCategory.value=0;
  }
}