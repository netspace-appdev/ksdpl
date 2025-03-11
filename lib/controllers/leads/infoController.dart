import 'package:get/get.dart';

import '../../common/storage_service.dart';

class InfoController extends GetxController{
  var firstName="".obs;
  var email="".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();

  }
  loadData(){
    firstName.value=StorageService.get(StorageService.FIRST_NAME).toString();
    email.value=StorageService.get(StorageService.EMAIL).toString();
  }
}