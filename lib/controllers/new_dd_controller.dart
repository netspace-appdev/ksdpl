import 'package:get/get.dart';
import 'package:ksdpl/services/new_dd_service.dart';
import '../../common/helper.dart';
import '../models/GetBranchDistrictByZipBankModel.dart' as branchList;
import '../models/camnote/GetBankerDetailsByBranchIdModel.dart' as banker;
import '../models/camnote/GetBankerDetailsByIdModel.dart';

class NewDDController extends GetxController{

  var isLoading = false.obs;
  var getBranchDistrictByZipBankModel = Rxn<branchList.GetBranchDistrictByZipBankModel>(); //
  var getBankerDetailsByBranchIdModel = Rxn<banker.GetBankerDetailsByBranchIdModel>(); //

  var isBranchLoading = false.obs;
  var isBankerLoading = false.obs;
  RxList<branchList.Data> branchByZipList = <branchList.Data>[].obs;
  RxList<banker.Data> bankerByBranchList = <banker.Data>[].obs;

  Future<void>  getBranchListOfDistrictByZipAndBankApi({
    required bankId,
    required zipcode
  }) async {
    try {

      isBranchLoading(true);


      var data = await NewDDService.getBranchListOfDistrictByZipAndBankApi(
          bankId: bankId,
          zipcode: zipcode
      );


      if(data['success'] == true){

        getBranchDistrictByZipBankModel.value= branchList.GetBranchDistrictByZipBankModel.fromJson(data);

        final List<branchList.Data> allBr = getBranchDistrictByZipBankModel.value?.data ?? [];

        final List<branchList.Data> branches = allBr.where((cat) => cat.active == true).toList();

        branchByZipList.value = branches;


        isBranchLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getBranchDistrictByZipBankModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getBranchDistrictByZipBankModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isBranchLoading(false);
    } finally {


      isBranchLoading(false);
    }
  }

  Future<void>  getBankerDetailsByBranchIdApi({
    String? branchId,
  }) async {
    try {

      isBankerLoading(true);


      var data = await NewDDService.getBankerDetailsByBranchIdApi(
        branchId: branchId
      );


      if(data['success'] == true){

        getBankerDetailsByBranchIdModel.value= banker.GetBankerDetailsByBranchIdModel.fromJson(data);

        final List<banker.Data> allBr = getBankerDetailsByBranchIdModel.value?.data ?? [];

        //final List<banker.Data> branches = allBr.toList();

        bankerByBranchList.value = allBr;


        isBankerLoading(false);

      }else if(data['success'] == false && (data['data'] as List).isEmpty ){


        getBranchDistrictByZipBankModel.value=null;
      }else{
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }


    } catch (e) {
      print("Error getBranchDistrictByZipBankModel: $e");

      ToastMessage.msg(AppText.somethingWentWrong);

      isBankerLoading(false);
    } finally {


      isBankerLoading(false);
    }
  }




}