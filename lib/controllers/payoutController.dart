import 'package:get/get.dart';


import '../common/helper.dart';
import '../models/GetSeniorListModel.dart' as senorList;
import '../models/InterestedPayoutModel.dart';
import '../models/JobRoleModelResponse.dart';
import '../services/product_service.dart';

class PayoutController extends GetxController{

  /// Loader
  final isLoadingMainScreen = false.obs;

  final Rxn<InterestedPayoutModel> interestedPayoutModel = Rxn<InterestedPayoutModel>();


  Future<void> getPayoutListApi({
    String? LeadId,
  }) async {
    try {
      isLoadingMainScreen.value = true;

      final data = await ProductService.getPayoutListApiRequest(LeadId: LeadId

      );

      if (data['success'] == true) {
        interestedPayoutModel.value = InterestedPayoutModel.fromJson(data);

      } else {
        ToastMessage.msg(
          data['message'] ?? AppText.somethingWentWrong,
        );
      }
    } catch (e) {
      print("Error : $e");
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


}