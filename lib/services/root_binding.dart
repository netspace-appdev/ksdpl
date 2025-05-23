import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ksdpl/controllers/lead_dd_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LeadDDController>(LeadDDController(), permanent: true);

  }
}